package game.view.map
{
   import bagAndInfo.cell.BaseCell;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ClassUtils;
   import ddt.data.BallInfo;
   import ddt.data.PathInfo;
   import ddt.data.map.MapInfo;
   import ddt.events.GameEvent;
   import ddt.loader.MapLoader;
   import ddt.manager.BallManager;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMEManager;
   import ddt.manager.IMManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.FaceContainer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Transform;
   import flash.system.IME;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import game.GameManager;
   import game.actions.ActionManager;
   import game.animations.AnimationSet;
   import game.animations.BaseSetCenterAnimation;
   import game.animations.IAnimate;
   import game.animations.NewHandAnimation;
   import game.animations.ShockingSetCenterAnimation;
   import game.animations.SpellSkillAnimation;
   import game.objects.BombAsset;
   import game.objects.GameLiving;
   import game.objects.GamePlayer;
   import game.objects.GameSimpleBoss;
   import game.objects.SimpleBox;
   import game.view.GameViewBase;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.TurnedLiving;
   import gameCommon.view.smallMap.SmallMapView;
   import phy.maps.Ground;
   import phy.maps.Map;
   import phy.object.PhysicalObj;
   import phy.object.Physics;
   import road7th.data.DictionaryData;
   import road7th.utils.MovieClipWrapper;
   import trainer.controller.NewHandGuideManager;
   
   public class MapView extends Map
   {
      
      public static const ADD_BOX:String = "addBox";
      
      public static const FRAMERATE_OVER_COUNT:int = 25;
      
      public static const OVER_FRAME_GAPE:int = 46;
       
      
      private var _game:GameInfo;
      
      private var _info:MapInfo;
      
      private var _animateSet:AnimationSet;
      
      private var _minX:Number;
      
      private var _minY:Number;
      
      private var _minScaleX:Number;
      
      private var _minScaleY:Number;
      
      private var _minSkyScaleX:Number;
      
      private var _minScale:Number;
      
      private var _smallMap:SmallMapView;
      
      private var _actionManager:ActionManager;
      
      public var gameView:GameViewBase;
      
      public var currentFocusedLiving:GameLiving;
      
      private var _currentTurn:int;
      
      private var _circle:Shape;
      
      private var _y:Number;
      
      private var _x:Number;
      
      private var _currentFocusedLiving:GameLiving;
      
      private var _currentFocusLevel:int;
      
      private var _currentPlayer:TurnedLiving;
      
      private var _smallObjs:Array;
      
      private var _scale:Number = 1;
      
      private var _frameRateCounter:int;
      
      private var _currentFrameRateOverCount:int = 0;
      
      private var _frameRateAlert:BaseAlerFrame;
      
      private var _objects:Dictionary;
      
      private var _gamePlayerList:Vector.<GamePlayer>;
      
      private var expName:Vector.<String>;
      
      private var expDic:Dictionary;
      
      private var _currentTopLiving:GameLiving;
      
      private var _container:Sprite;
      
      private var _bigBox:MovieClipWrapper;
      
      private var _isPickBigBox:Boolean;
      
      private var _picIdList:Array;
      
      private var _picMoveDelay:int;
      
      private var _picList:Array;
      
      private var _picStartPoint:Point;
      
      private var _lastPic:BaseCell;
      
      private var _boxTimer:Timer;
      
      public function MapView(param1:GameInfo, param2:MapLoader)
      {
         _objects = new Dictionary();
         _gamePlayerList = new Vector.<GamePlayer>();
         expName = new Vector.<String>();
         expDic = new Dictionary();
         GameControl.Instance.Current.selfGamePlayer.currentMap = this;
         _game = param1;
         var _loc4_:Bitmap = new Bitmap(param2.backBmp.bitmapData);
         var _loc3_:Ground = !!param2.foreBmp?new Ground(param2.foreBmp.bitmapData.clone(),true):null;
         var _loc5_:Ground = !!param2.deadBmp?new Ground(param2.deadBmp.bitmapData.clone(),false):null;
         var _loc6_:MapInfo = param2.info;
         super(_loc4_,_loc3_,_loc5_,param2.middle);
         airResistance = _loc6_.DragIndex;
         gravity = _loc6_.Weight;
         _info = _loc6_;
         _animateSet = new AnimationSet(this,PathInfo.GAME_WIDTH,PathInfo.GAME_HEIGHT);
         _smallMap = new SmallMapView(this,GameControl.Instance.Current.missionInfo);
         _smallMap.update();
         _smallObjs = [];
         _minX = -bound.width + PathInfo.GAME_WIDTH;
         _minY = -bound.height + PathInfo.GAME_HEIGHT;
         _minScaleX = PathInfo.GAME_WIDTH / bound.width;
         _minScaleY = PathInfo.GAME_HEIGHT / bound.height;
         _minSkyScaleX = PathInfo.GAME_WIDTH / _sky.width;
         if(_minScaleX < _minScaleY)
         {
            _minScale = _minScaleY;
         }
         else
         {
            _minScale = _minScaleX;
         }
         if(_minScaleX < _minSkyScaleX)
         {
            _minScale = _minSkyScaleX;
         }
         else
         {
            _minScale = _minScaleX;
         }
         _actionManager = new ActionManager();
         setCenter(_info.ForegroundWidth / 2,_info.ForegroundHeight / 2,false);
         addEventListener("click",__mouseClick);
         ChatManager.Instance.addEventListener("setFacecontainerLoction",__setFacecontainLoctionAction);
         initOutCrater();
         initBox();
      }
      
      public function set currentTurn(param1:int) : void
      {
         _currentTurn = param1;
         dispatchEvent(new GameEvent("turnChanged",_currentTurn));
      }
      
      public function get currentTurn() : int
      {
         return _currentTurn;
      }
      
      public function requestForFocus(param1:GameLiving, param2:int = 0) : void
      {
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         var _loc3_:int = GameControl.Instance.Current.selfGamePlayer.pos.x;
         if(_currentFocusedLiving)
         {
            if(Math.abs(param1.pos.x - _loc3_) > Math.abs(_currentFocusedLiving.x - _loc3_))
            {
               return;
            }
         }
         if(param2 < _currentFocusLevel)
         {
            return;
         }
         _currentFocusedLiving = param1;
         _currentFocusLevel = param2;
         _currentFocusedLiving.needFocus(0,0,{
            "strategy":"directly",
            "priority":param2
         });
      }
      
      public function cancelFocus(param1:GameLiving = null) : void
      {
         if(param1 == null)
         {
            _currentFocusedLiving = null;
            _currentFocusLevel = 0;
         }
         if(param1 == _currentFocusedLiving)
         {
            _currentFocusedLiving = null;
            _currentFocusLevel = 0;
         }
      }
      
      public function get currentPlayer() : TurnedLiving
      {
         return _currentPlayer;
      }
      
      public function set currentPlayer(param1:TurnedLiving) : void
      {
         _currentPlayer = param1;
      }
      
      public function get gameInfo() : GameInfo
      {
         return _game;
      }
      
      public function get info() : MapInfo
      {
         return _info;
      }
      
      public function get smallMap() : SmallMapView
      {
         return _smallMap;
      }
      
      public function get animateSet() : AnimationSet
      {
         return _animateSet;
      }
      
      private function initOutCrater() : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:DictionaryData = _game.outBombs;
         if(_loc2_.length > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _loc4_ = new Point(_loc2_.list[_loc5_].X,_loc2_.list[_loc5_].Y);
               _loc3_ = BallManager.instance.findBall(_loc2_.list[_loc5_].Id);
               _loc1_ = BallManager.instance.gameInBombAssets[_loc3_.craterID];
               Dig(_loc4_,_loc1_.crater,_loc1_.craterBrink);
               _loc5_++;
            }
            _loc2_.clear();
         }
      }
      
      private function initBox() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:DictionaryData = _game.outBoxs;
         if(_loc1_.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _loc2_ = new SimpleBox(_loc1_.list[_loc3_].bid,String(PathInfo.GAME_BOXPIC),_loc1_.list[_loc3_].subType);
               _loc2_.x = _loc1_.list[_loc3_].bx;
               _loc2_.y = _loc1_.list[_loc3_].by;
               this.addPhysical(_loc2_);
               _loc3_++;
            }
            _loc1_.clear();
         }
      }
      
      public function DigOutCrater(param1:DictionaryData) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1.length > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               _loc4_ = new Point(param1.list[_loc5_].X,param1.list[_loc5_].Y);
               _loc3_ = BallManager.instance.findBall(param1.list[_loc5_].Id);
               _loc2_ = BallManager.instance.gameInBombAssets[_loc3_.craterID];
               Dig(_loc4_,_loc2_.crater,_loc2_.craterBrink);
               _loc5_++;
            }
            param1.clear();
         }
      }
      
      private function __setFacecontainLoctionAction(param1:Event) : void
      {
         setExpressionLoction();
      }
      
      private function get minX() : Number
      {
         return -bound.width * scale + PathInfo.GAME_WIDTH;
      }
      
      private function get minY() : Number
      {
         return -bound.height * scale + PathInfo.GAME_HEIGHT;
      }
      
      private function __mouseClick(param1:MouseEvent) : void
      {
         stage.focus = this;
         if(ChatManager.Instance.input.parent && !NewHandGuideManager.Instance.isNewHandFB())
         {
            SoundManager.instance.play("008");
            ChatManager.Instance.switchVisible();
         }
      }
      
      public function spellKill(param1:GamePlayer) : IAnimate
      {
         var _loc2_:* = null;
         if(GameControl.Instance.Current.togetherShoot)
         {
            _loc2_ = new SpellSkillAnimation(param1.x,param1.y,PathInfo.GAME_WIDTH,PathInfo.GAME_HEIGHT,_info.ForegroundWidth - 100,_info.ForegroundHeight + 600,param1,gameView);
         }
         else
         {
            _loc2_ = new SpellSkillAnimation(param1.x,param1.y,PathInfo.GAME_WIDTH,PathInfo.GAME_HEIGHT,_info.ForegroundWidth,_info.ForegroundHeight,param1,gameView);
         }
         animateSet.addAnimation(_loc2_);
         SoundManager.instance.play("097");
         return _loc2_;
      }
      
      public function get isPlayingMovie() : Boolean
      {
         return _animateSet.current is SpellSkillAnimation;
      }
      
      override public function set x(param1:Number) : void
      {
         param1 = param1 < minX?minX:Number(param1 > 0?0:Number(param1));
         _x = param1;
         .super.x = _x;
      }
      
      override public function set y(param1:Number) : void
      {
         param1 = param1 < minY?minY:Number(param1 > 0?0:Number(param1));
         _y = param1;
         .super.y = _y;
      }
      
      override public function get x() : Number
      {
         return _x;
      }
      
      override public function get y() : Number
      {
         return _y;
      }
      
      override public function set transform(param1:Transform) : void
      {
         .super.transform = param1;
      }
      
      override public function get transform() : Transform
      {
         return super.transform;
      }
      
      public function set scale(param1:Number) : void
      {
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < _minScale)
         {
            param1 = Number(_minScale);
         }
         _scale = param1;
         var _loc2_:Matrix = new Matrix();
         _loc2_.scale(_scale,_scale);
         transform.matrix = _loc2_;
         var _loc3_:* = Math.pow(_scale,-0.5);
         _sky.scaleY = _loc3_;
         _sky.scaleX = _loc3_;
         updateSky();
      }
      
      public function get minScale() : Number
      {
         return _minScale;
      }
      
      public function get scale() : Number
      {
         return _scale;
      }
      
      public function setCenter(param1:Number, param2:Number, param3:Boolean) : void
      {
         if(GameManager.instance.isStopFocus)
         {
            return;
         }
         return;
         §§push(_animateSet && _animateSet.addAnimation(new BaseSetCenterAnimation(param1,param2,50,!param3,1)));
      }
      
      public function scenarioSetCenter(param1:Number, param2:Number, param3:int) : void
      {
         if(GameManager.instance.isStopFocus)
         {
            return;
         }
         switch(int(param3) - 2)
         {
            case 0:
               _animateSet.addAnimation(new ShockingSetCenterAnimation(param1,param2,165,false,2,9));
               break;
            case 1:
               _animateSet.addAnimation(new ShockingSetCenterAnimation(param1,param2,50,false,2,9));
         }
      }
      
      public function livingSetCenter(param1:Number, param2:Number, param3:Boolean, param4:int = 2, param5:Object = null, param6:GameLiving = null) : void
      {
         if(GameManager.instance.isStopFocus)
         {
            return;
         }
         if(_animateSet)
         {
            _animateSet.addAnimation(new BaseSetCenterAnimation(param1,param2,25,!param3,param4,0,param5));
         }
      }
      
      public function setSelfCenter(param1:Boolean, param2:int = 2, param3:Object = null) : void
      {
         var _loc4_:Living = _game.livings[_game.selfGamePlayer.LivingID];
         if(_loc4_ == null)
         {
            return;
         }
         _animateSet.addAnimation(new BaseSetCenterAnimation(_loc4_.pos.x - 50,_loc4_.pos.y - 150,25,!param1,param2,0,param3));
      }
      
      public function act(param1:BaseAction) : void
      {
         _actionManager.act(param1);
      }
      
      public function showShoot(param1:Number, param2:Number) : void
      {
         _circle = new Shape();
         _circle.graphics.beginFill(16711680);
         _circle.graphics.drawCircle(param1,param2,3);
         _circle.graphics.drawCircle(param1,param2,1);
         _circle.graphics.endFill();
         addChild(_circle);
      }
      
      override protected function update() : void
      {
         super.update();
         if(!IMManager.Instance.privateChatFocus)
         {
            if(ChatManager.Instance.input.parent == null)
            {
               if(IME.enabled)
               {
                  IMEManager.disable();
               }
               if(stage && stage.focus == null)
               {
                  stage.focus = this;
               }
            }
            if(StageReferance.stage.focus is TextField && TextField(StageReferance.stage.focus).type == "input")
            {
               if(!IME.enabled)
               {
                  IMEManager.enable();
               }
            }
            else if(IME.enabled)
            {
               IMEManager.disable();
            }
         }
         else if(!IME.enabled)
         {
            IMEManager.enable();
         }
         if(_animateSet.update())
         {
            updateSky();
         }
         _actionManager.execute();
         checkOverFrameRate();
      }
      
      private function checkOverFrameRate() : void
      {
         if(_game.gameMode == 40 && StageReferance.stage.frameRate > 45)
         {
            SocketManager.Instance.socket.dispatchEvent(new ErrorEvent("error",false,false,LanguageMgr.GetTranslation("tank.manager.RoomManager.break")));
            return;
         }
         if(SharedManager.Instance.hasCheckedOverFrameRate)
         {
            return;
         }
         if(_game == null)
         {
            return;
         }
         if(_game.PlayerCount <= 4)
         {
            return;
         }
         if(_currentPlayer && _currentPlayer.LivingID == _game.selfGamePlayer.LivingID)
         {
            return;
         }
         var _loc1_:int = getTimer();
         if(_loc1_ - _frameRateCounter > 46 && _frameRateCounter != 0)
         {
            _currentFrameRateOverCount = Number(_currentFrameRateOverCount) + 1;
            if(_currentFrameRateOverCount > 25)
            {
               if(_frameRateAlert == null && SharedManager.Instance.showParticle)
               {
                  _frameRateAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.game.map.smallMapView.slow"),"",LanguageMgr.GetTranslation("cancel"),false,true,true,2);
                  _frameRateAlert.addEventListener("response",__onRespose);
                  SharedManager.Instance.hasCheckedOverFrameRate = true;
                  SharedManager.Instance.save();
               }
            }
         }
         else
         {
            _currentFrameRateOverCount = 0;
         }
         _frameRateCounter = _loc1_;
      }
      
      private function __onRespose(param1:FrameEvent) : void
      {
         _frameRateAlert.removeEventListener("response",__onRespose);
         _frameRateAlert.dispose();
         SharedManager.Instance.showParticle = false;
      }
      
      private function overFrameOk() : void
      {
         SharedManager.Instance.showParticle = false;
      }
      
      public function get mapBitmap() : Bitmap
      {
         var _loc1_:BitmapData = new BitmapData(StageReferance.stageWidth,StageReferance.stageHeight);
         var _loc2_:Point = globalToLocal(new Point(0,0));
         _loc1_.draw(this,new Matrix(1,0,0,1,-_loc2_.x,-_loc2_.y),null,null);
         return new Bitmap(_loc1_,"auto",true);
      }
      
      private function updateSky() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(_scale < 1)
         {
         }
         var _loc4_:Number = (sky.height * _scale - PathInfo.GAME_HEIGHT) / (bound.height * _scale - PathInfo.GAME_HEIGHT);
         var _loc3_:Number = (sky.width * _scale - PathInfo.GAME_WIDTH) / (bound.width * _scale - PathInfo.GAME_WIDTH);
         _loc4_ = isNaN(_loc4_) || _loc4_ == -Infinity || _loc4_ == Infinity?1:Number(_loc4_);
         _loc3_ = isNaN(_loc3_) || _loc3_ == -Infinity || _loc3_ == Infinity?1:Number(_loc3_);
         _sky.y = y * (_loc4_ - 1) / _scale;
         _sky.x = x * (_loc3_ - 1) / _scale;
         if(_middle)
         {
            _loc1_ = (_middle.height * _scale - PathInfo.GAME_HEIGHT) / (bound.height * _scale - PathInfo.GAME_HEIGHT);
            _loc2_ = (_middle.width * _scale - PathInfo.GAME_WIDTH) / (bound.width * _scale - PathInfo.GAME_WIDTH);
            _loc1_ = isNaN(_loc1_) || _loc1_ == -Infinity || _loc1_ == Infinity?1:Number(_loc1_);
            _loc2_ = isNaN(_loc2_) || _loc2_ == -Infinity || _loc2_ == Infinity?1:Number(_loc2_);
            _middle.y = y * (_loc1_ - 1) / _scale;
            _middle.x = x * (_loc2_ - 1) / _scale;
         }
         _smallMap.setScreenPos(x,y);
      }
      
      public function getPhysical(param1:int) : PhysicalObj
      {
         return _objects[param1];
      }
      
      public function get objects() : Dictionary
      {
         return _objects;
      }
      
      public function get getOneSimpleBoss() : GameSimpleBoss
      {
         var _loc3_:int = 0;
         var _loc2_:* = _objects;
         for each(var _loc1_ in _objects)
         {
            if(_loc1_ is GameSimpleBoss)
            {
               return _loc1_ as GameSimpleBoss;
            }
         }
         return null;
      }
      
      override public function addPhysical(param1:Physics) : void
      {
         var _loc2_:* = null;
         super.addPhysical(param1);
         if(param1 is PhysicalObj)
         {
            _loc2_ = param1 as PhysicalObj;
            _objects[_loc2_.Id] = _loc2_;
            if(_loc2_.smallView)
            {
               _smallMap.addObj(_loc2_.smallView);
               _smallMap.updatePos(_loc2_.smallView,_loc2_.pos);
            }
         }
         if(param1 is GamePlayer)
         {
            _gamePlayerList.push(param1);
         }
      }
      
      private function controlExpNum(param1:GamePlayer) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(expName.length < 2)
         {
            if(expName.indexOf(param1.facecontainer.nickName.text) < 0)
            {
               expName.push(param1.facecontainer.nickName.text);
               expDic[param1.facecontainer.nickName.text] = param1.facecontainer;
            }
         }
         else if(expName.indexOf(param1.facecontainer.nickName.text) < 0)
         {
            _loc4_ = Math.random() * 2;
            _loc2_ = expName[_loc4_];
            _loc3_ = expDic[_loc2_] as FaceContainer;
            if(_loc3_.isActingExpression)
            {
               _loc3_.doClearFace();
            }
            expName[_loc4_] = param1.facecontainer.nickName.text;
            delete expDic[_loc2_];
            expDic[param1.facecontainer.nickName.text] = param1.facecontainer;
         }
      }
      
      private function resetDicAndVec(param1:GamePlayer) : void
      {
         var _loc2_:int = expName.indexOf(param1.facecontainer.nickName.text);
         if(_loc2_ >= 0)
         {
            delete expDic[expName[_loc2_]];
            expName.splice(_loc2_,1);
         }
      }
      
      public function setExpressionLoction() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:int = 0;
         if(!_gamePlayerList || _gamePlayerList.length == 0)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _gamePlayerList.length)
         {
            _loc2_ = _gamePlayerList[_loc4_];
            if(_loc2_ == null || !_loc2_.isLiving || _loc2_.facecontainer == null)
            {
               _gamePlayerList.splice(_loc4_,1);
            }
            else if(_loc2_.facecontainer.isActingExpression)
            {
               if(!(_loc2_.facecontainer.expressionID >= 1073 || _loc2_.facecontainer.expressionID <= 1001))
               {
                  _loc3_ = this.localToGlobal(new Point(_loc2_.x,_loc2_.y));
                  _loc1_ = onStageFlg(_loc3_);
                  if(_loc1_ == 0)
                  {
                     _loc2_.facecontainer.x = 0;
                     _loc2_.facecontainer.y = -100;
                     resetDicAndVec(_loc2_);
                     _loc2_.facecontainer.isShowNickName = false;
                  }
                  else if(_loc1_ == 1)
                  {
                     _loc2_.facecontainer.x = _loc2_.facecontainer.width / 2 + 30 - _loc3_.x;
                     _loc2_.facecontainer.y = 270 + _loc2_.facecontainer.height / 2 - _loc3_.y;
                     controlExpNum(_loc2_);
                     _loc2_.facecontainer.isShowNickName = true;
                  }
                  if(expName.length == 2)
                  {
                     (expDic[expName[1]] as FaceContainer).x = (expDic[expName[1]] as FaceContainer).x + 80;
                  }
               }
            }
            else
            {
               _loc2_.facecontainer.x = 0;
               _loc2_.facecontainer.y = -100;
               _loc2_.facecontainer.isShowNickName = false;
               resetDicAndVec(_loc2_);
            }
            _loc4_++;
         }
      }
      
      private function onStageFlg(param1:Point) : int
      {
         if(param1 == null)
         {
            return 100;
         }
         if(param1.x >= 0 && param1.x <= 1000 && param1.y >= 0 && param1.y <= 600)
         {
            return 0;
         }
         return 1;
      }
      
      public function addObject(param1:Physics) : void
      {
         var _loc2_:* = null;
         if(param1 is PhysicalObj)
         {
            _loc2_ = param1 as PhysicalObj;
            _objects[_loc2_.Id] = _loc2_;
         }
      }
      
      public function bringToFront(param1:Living) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:Physics = _objects[param1.LivingID] as Physics;
         if(_loc2_)
         {
            super.addPhysical(_loc2_);
         }
      }
      
      public function phyBringToFront(param1:PhysicalObj) : void
      {
         if(param1)
         {
            super.addChild(param1);
         }
      }
      
      override public function removePhysical(param1:Physics) : void
      {
         var _loc2_:* = null;
         super.removePhysical(param1);
         if(param1 is PhysicalObj)
         {
            _loc2_ = param1 as PhysicalObj;
            if(_objects && _objects[_loc2_.Id])
            {
               delete _objects[_loc2_.Id];
            }
            if(_smallMap && _loc2_.smallView)
            {
               _smallMap.removeObj(_loc2_.smallView);
            }
         }
      }
      
      override public function addMapThing(param1:Physics) : void
      {
         var _loc2_:* = null;
         super.addMapThing(param1);
         if(param1 is PhysicalObj)
         {
            _loc2_ = param1 as PhysicalObj;
            _objects[_loc2_.Id] = _loc2_;
            if(_loc2_.smallView)
            {
               _smallMap.addObj(_loc2_.smallView);
               _smallMap.updatePos(_loc2_.smallView,_loc2_.pos);
            }
         }
      }
      
      override public function removeMapThing(param1:Physics) : void
      {
         var _loc2_:* = null;
         super.removeMapThing(param1);
         if(param1 is PhysicalObj)
         {
            _loc2_ = param1 as PhysicalObj;
            if(_objects[_loc2_.Id])
            {
               delete _objects[_loc2_.Id];
            }
            if(_loc2_.smallView)
            {
               _smallMap.removeObj(_loc2_.smallView);
            }
         }
      }
      
      public function get actionCount() : int
      {
         return _actionManager.actionCount;
      }
      
      public function lockFocusAt(param1:Point) : void
      {
         animateSet.addAnimation(new NewHandAnimation(param1.x,param1.y - 150,2147483647,false,4));
      }
      
      public function releaseFocus() : void
      {
         animateSet.clear();
      }
      
      public function executeAtOnce() : void
      {
         _actionManager.executeAtOnce();
         _animateSet.clear();
      }
      
      public function traceCurrentAction() : void
      {
         _actionManager.traceAllRemainAction(PlayerManager.Instance.Self.NickName);
      }
      
      public function bringToStageTop(param1:PhysicalObj) : void
      {
         if(_currentTopLiving)
         {
            addPhysical(_currentTopLiving);
         }
         if(_container && _container.parent)
         {
            _container.parent.removeChild(_container);
         }
         _currentTopLiving = _objects[param1.Id] as GameLiving;
         if(_container == null)
         {
            _container = new Sprite();
            _container.x = this.x;
            _container.y = this.y;
         }
         if(_currentTopLiving)
         {
            _container.addChild(_currentTopLiving);
         }
         LayerManager.Instance.addToLayer(_container,5,false,0,false);
      }
      
      public function restoreStageTopLiving() : void
      {
         if(_currentTopLiving && _currentTopLiving.isExist)
         {
            addPhysical(_currentTopLiving);
         }
         if(_container && _container.parent)
         {
            _container.parent.removeChild(_container);
         }
         _currentTopLiving = null;
      }
      
      public function setMatrx(param1:Matrix) : void
      {
         transform.matrix = param1;
         if(_container)
         {
            _container.transform.matrix = param1;
         }
      }
      
      public function dropOutBox(param1:Array) : void
      {
         _picIdList = param1;
         setSelfCenter(false);
         _isPickBigBox = false;
         _bigBox = new MovieClipWrapper(ClassUtils.CreatInstance("asset.game.dropOut.bigBox.red"),true);
         _livingLayer.addChild(_bigBox.movie);
         var _loc2_:Point = getTwoHundredDisPoint(_game.selfGamePlayer.pos.x,_game.selfGamePlayer.pos.y,_bigBox.movie.width / 2,_bigBox.movie.height / 2,_game.selfGamePlayer.direction);
         _bigBox.movie.x = _loc2_.x;
         _bigBox.movie.y = _loc2_.y;
         _bigBox.endFrame = 29;
         _bigBox.addEventListener("complete",dropEndHandler,false,0,true);
         _bigBox.movie.addEventListener("click",__onBigBoxClick);
         _bigBox.movie.buttonMode = true;
         _bigBox.gotoAndPlay(1);
         _bigBox.movie.addEventListener("enterFrame",playSoundEffect);
         _boxTimer = new Timer(1000,9);
         _boxTimer.addEventListener("timerComplete",__openBox);
         _boxTimer.start();
      }
      
      protected function __openBox(param1:TimerEvent) : void
      {
         if(_boxTimer)
         {
            _boxTimer.stop();
            _boxTimer.removeEventListener("timerComplete",__openBox);
            _boxTimer = null;
         }
         pickBigBoxSuccessHandler();
      }
      
      protected function __onBigBoxClick(param1:MouseEvent) : void
      {
         if(_boxTimer)
         {
            _boxTimer.stop();
            _boxTimer.removeEventListener("timerComplete",__openBox);
            _boxTimer = null;
         }
         _bigBox.movie.buttonMode = false;
         _bigBox.movie.removeEventListener("click",__onBigBoxClick);
         pickBigBoxSuccessHandler();
      }
      
      public function pickBigBoxSuccessHandler() : void
      {
         _bigBox.gotoAndPlay("open");
         _picStartPoint = new Point(_bigBox.movie.x - 22.5,_bigBox.movie.y - 120 - 22.5);
         _picMoveDelay = 4;
         _bigBox.movie.addEventListener("enterFrame",playPickBoxAwardMove,false,0,true);
         GameInSocketOut.sendGameSkipNext(0);
      }
      
      private function playPickBoxAwardMove(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:Number = NaN;
         if(_bigBox.movie.currentFrame == 37)
         {
            _picList = [];
            _loc6_ = _picIdList.length;
            _loc4_ = -1;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc5_ = new Bitmap(new BitmapData(45,45,true,0));
               _loc3_ = new BaseCell(_loc5_,ItemManager.Instance.getTemplateById(_picIdList[_loc7_]));
               _loc3_.x = _picStartPoint.x;
               _loc3_.y = _picStartPoint.y;
               _picList.push(_loc3_);
               addChild(_loc3_);
               if(_loc6_ % 2 == 0)
               {
                  _loc2_ = int(_loc7_ / 2) * _loc4_ * 50 + 25 * _loc4_ + _loc3_.x;
               }
               else
               {
                  _loc2_ = int((_loc7_ + 1) / 2) * _loc4_ * 50 + _loc3_.x;
               }
               TweenLite.to(_loc3_,0.2,{"x":_loc2_});
               _loc4_ = _loc4_ * -1;
               _loc7_++;
            }
         }
         else if(_bigBox.movie.currentFrame == 50)
         {
            _picList.sortOn("x",16);
            _lastPic = _picList[_picList.length - 1];
            addEventListener("enterFrame",playPickBoxAwardMove2);
         }
         else if(_bigBox.movie.currentFrame == 84)
         {
            _bigBox.gotoAndStop(84);
            _bigBox.movie.removeEventListener("enterFrame",playPickBoxAwardMove);
         }
      }
      
      private function playPickBoxAwardMove2(param1:Event) : void
      {
         _picMoveDelay = Number(_picMoveDelay) + 1;
         if(_picMoveDelay < 5)
         {
            return;
         }
         _picMoveDelay = 0;
         if(_picList.length == 0)
         {
            removeEventListener("enterFrame",playPickBoxAwardMove2);
         }
         else
         {
            pickBigBoxSuccessHandler2(_picList.shift());
         }
      }
      
      private function pickBigBoxSuccessHandler2(param1:BaseCell) : void
      {
         TweenLite.to(param1,0.5,{
            "y":param1.y - 60,
            "alpha":1,
            "scaleX":1,
            "scaleY":1,
            "onComplete":upMoveEndHandler,
            "onCompleteParams":[param1]
         });
      }
      
      private function upMoveEndHandler(param1:BaseCell) : void
      {
         lightCartoonPlayEndHandler(param1);
      }
      
      private function lightCartoonPlayEndHandler(param1:BaseCell) : void
      {
         if(!_game || !_game.selfGamePlayer || !_game.selfGamePlayer.pos)
         {
            return;
         }
         var _loc4_:Point = new Point(_game.selfGamePlayer.pos.x,_game.selfGamePlayer.pos.y);
         var _loc2_:Number = (param1.x + _loc4_.x) / 2;
         var _loc3_:Number = Math.min(param1.y,_loc4_.y) - 200;
         TweenMax.to(param1,1,{
            "scaleX":0.1,
            "scaleY":0.1,
            "bezier":[{
               "x":_loc2_,
               "y":_loc3_
            },{
               "x":_loc4_.x,
               "y":_loc4_.y
            }],
            "onComplete":pickBigBoxEndHandler,
            "onCompleteParams":[param1]
         });
      }
      
      private function pickBigBoxEndHandler(param1:BaseCell) : void
      {
         if(!param1)
         {
            return;
         }
         param1.dispose();
         param1 = null;
      }
      
      private function playSoundEffect(param1:Event) : void
      {
         if(_bigBox.movie.currentFrame == 13)
         {
            SoundManager.instance.play("164");
            _bigBox.movie.removeEventListener("enterFrame",playSoundEffect);
            _bigBox.movie.buttonMode = true;
            _bigBox.movie.mouseChildren = false;
            _bigBox.movie.addEventListener("click",openBigBox,false,0,true);
         }
      }
      
      private function openBigBox(param1:MouseEvent) : void
      {
         _bigBox.movie.buttonMode = false;
         _bigBox.movie.removeEventListener("click",openBigBox);
         _isPickBigBox = true;
      }
      
      private function dropEndHandler(param1:Event) : void
      {
         _bigBox.removeEventListener("complete",dropEndHandler);
         _bigBox.gotoAndStop("stop");
      }
      
      private function getTwoHundredDisPoint(param1:Number, param2:Number, param3:Number, param4:Number, param5:int) : Point
      {
         var _loc7_:* = null;
         param2 = 150;
         var _loc6_:Number = param1 + 200 * param5 + param3 * param5;
         if(!this.IsOutMap(_loc6_,param2) && this.IsEmpty(_loc6_,param2))
         {
            _loc7_ = findYLineNotEmptyPointDown(param1 + 200 * param5,param2,this.bound.height);
            if(_loc7_)
            {
               return _loc7_;
            }
         }
         param5 = param5 * -1;
         _loc6_ = param1 + 200 * param5 + param3 * param5;
         var _loc8_:Point = findYLineNotEmptyPointDown(param1 + 200 * param5,param2,this.bound.height);
         return _loc8_;
      }
      
      public function get disableFlyCD() : Boolean
      {
         return _info.ID == 1618;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _currentTopLiving = null;
         ChatManager.Instance.removeEventListener("setFacecontainerLoction",__setFacecontainLoctionAction);
         if(_boxTimer)
         {
            _boxTimer.stop();
            _boxTimer.removeEventListener("timerComplete",__openBox);
            _boxTimer = null;
         }
         if(_container && _container.parent)
         {
            _container.parent.removeChild(_container);
         }
         _container = null;
         if(_frameRateAlert != null)
         {
            _frameRateAlert.removeEventListener("response",__onRespose);
            _frameRateAlert.dispose();
            _frameRateAlert = null;
         }
         var _loc3_:int = 0;
         var _loc2_:* = _objects;
         for each(var _loc1_ in _objects)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _objects = null;
         _game = null;
         _info = null;
         _currentFocusedLiving = null;
         currentFocusedLiving = null;
         _currentPlayer = null;
         _smallMap.dispose();
         _smallMap = null;
         _animateSet.dispose();
         _animateSet = null;
         _actionManager.clear();
         _actionManager = null;
         gameView = null;
         _gamePlayerList = null;
      }
   }
}
