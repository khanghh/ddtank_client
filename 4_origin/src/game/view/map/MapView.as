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
   import com.pickgliss.utils.ObjectUtils;
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
   import gameCommon.model.SimpleBoxInfo;
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
      
      public var gamePlayerList:Vector.<GamePlayer>;
      
      private var expName:Vector.<String>;
      
      private var expDic:Dictionary;
      
      private var _backEffectView:BackEffectView;
      
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
      
      public function MapView(game:GameInfo, loader:MapLoader)
      {
         _objects = new Dictionary();
         gamePlayerList = new Vector.<GamePlayer>();
         expName = new Vector.<String>();
         expDic = new Dictionary();
         GameControl.Instance.Current.selfGamePlayer.currentMap = this;
         _game = game;
         var skyBitmap:Bitmap = new Bitmap(loader.backBmp.bitmapData);
         var f:Ground = !!loader.foreBmp?new Ground(loader.foreBmp.bitmapData.clone(),true):null;
         var s:Ground = !!loader.deadBmp?new Ground(loader.deadBmp.bitmapData.clone(),false):null;
         var info:MapInfo = loader.info;
         super(skyBitmap,f,s,loader.middle);
         airResistance = info.DragIndex;
         gravity = info.Weight;
         _info = info;
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
      
      public function set currentTurn(i:int) : void
      {
         _currentTurn = i;
         dispatchEvent(new GameEvent("turnChanged",_currentTurn));
      }
      
      public function get currentTurn() : int
      {
         return _currentTurn;
      }
      
      public function requestForFocus(target:GameLiving, level:int = 0) : void
      {
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         var x:int = GameControl.Instance.Current.selfGamePlayer.pos.x;
         if(_currentFocusedLiving)
         {
            if(Math.abs(target.pos.x - x) > Math.abs(_currentFocusedLiving.x - x))
            {
               return;
            }
         }
         if(level < _currentFocusLevel)
         {
            return;
         }
         _currentFocusedLiving = target;
         _currentFocusLevel = level;
         _currentFocusedLiving.needFocus(0,0,{
            "strategy":"directly",
            "priority":level
         });
      }
      
      public function cancelFocus(target:GameLiving = null) : void
      {
         if(target == null)
         {
            _currentFocusedLiving = null;
            _currentFocusLevel = 0;
         }
         if(target == _currentFocusedLiving)
         {
            _currentFocusedLiving = null;
            _currentFocusLevel = 0;
         }
      }
      
      public function get currentPlayer() : TurnedLiving
      {
         return _currentPlayer;
      }
      
      public function set currentPlayer(value:TurnedLiving) : void
      {
         _currentPlayer = value;
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
         var i:int = 0;
         var pos:* = null;
         var ballInfo:* = null;
         var bombAsset:* = null;
         var outBombs:DictionaryData = _game.outBombs;
         if(outBombs.length > 0)
         {
            for(i = 0; i < outBombs.length; )
            {
               pos = new Point(outBombs.list[i].X,outBombs.list[i].Y);
               ballInfo = BallManager.instance.findBall(outBombs.list[i].Id);
               bombAsset = BallManager.instance.gameInBombAssets[ballInfo.craterID];
               Dig(pos,bombAsset.crater,bombAsset.craterBrink);
               i++;
            }
            outBombs.clear();
         }
      }
      
      private function initBox() : void
      {
         var i:int = 0;
         var boxInfo:* = null;
         var model:* = null;
         var box:* = null;
         var outBoxs:DictionaryData = _game.outBoxs;
         if(outBoxs.length > 0)
         {
            for(i = 0; i < outBoxs.length; )
            {
               boxInfo = outBoxs.list[i];
               model = boxInfo.model;
               if(model == "")
               {
                  model = String(PathInfo.GAME_BOXPIC);
               }
               box = new SimpleBox(boxInfo.bid,model,boxInfo.subType);
               box.x = outBoxs.list[i].bx;
               box.y = outBoxs.list[i].by;
               this.addPhysical(box);
               i++;
            }
            outBoxs.clear();
         }
      }
      
      public function DigOutCrater(outBombs:DictionaryData) : void
      {
         var i:int = 0;
         var pos:* = null;
         var ballInfo:* = null;
         var bombAsset:* = null;
         if(outBombs.length > 0)
         {
            for(i = 0; i < outBombs.length; )
            {
               pos = new Point(outBombs.list[i].X,outBombs.list[i].Y);
               ballInfo = BallManager.instance.findBall(outBombs.list[i].Id);
               bombAsset = BallManager.instance.gameInBombAssets[ballInfo.craterID];
               Dig(pos,bombAsset.crater,bombAsset.craterBrink);
               i++;
            }
            outBombs.clear();
         }
      }
      
      private function __setFacecontainLoctionAction(e:Event) : void
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
      
      private function __mouseClick(event:MouseEvent) : void
      {
         stage.focus = this;
         if(ChatManager.Instance.input.parent && !NewHandGuideManager.Instance.isNewHandFB())
         {
            SoundManager.instance.play("008");
            ChatManager.Instance.switchVisible();
         }
      }
      
      public function spellKill(player:GamePlayer) : IAnimate
      {
         var skill:* = null;
         if(GameControl.Instance.Current.togetherShoot)
         {
            skill = new SpellSkillAnimation(player.x,player.y,PathInfo.GAME_WIDTH,PathInfo.GAME_HEIGHT,_info.ForegroundWidth - 100,_info.ForegroundHeight + 600,player,gameView);
         }
         else
         {
            skill = new SpellSkillAnimation(player.x,player.y,PathInfo.GAME_WIDTH,PathInfo.GAME_HEIGHT,_info.ForegroundWidth,_info.ForegroundHeight,player,gameView);
         }
         animateSet.addAnimation(skill);
         SoundManager.instance.play("097");
         return skill;
      }
      
      public function get isPlayingMovie() : Boolean
      {
         return _animateSet.current is SpellSkillAnimation;
      }
      
      override public function set x(value:Number) : void
      {
         value = value < minX?minX:Number(value > 0?0:Number(value));
         _x = value;
         .super.x = _x;
      }
      
      override public function set y(value:Number) : void
      {
         value = value < minY?minY:Number(value > 0?0:Number(value));
         _y = value;
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
      
      override public function set transform(value:Transform) : void
      {
         .super.transform = value;
      }
      
      override public function get transform() : Transform
      {
         return super.transform;
      }
      
      public function set scale(value:Number) : void
      {
         if(value > 1)
         {
            value = 1;
         }
         if(value < _minScale)
         {
            value = Number(_minScale);
         }
         _scale = value;
         var _matrix:Matrix = new Matrix();
         _matrix.scale(_scale,_scale);
         transform.matrix = _matrix;
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
      
      public function setCenter(px:Number, py:Number, isTween:Boolean) : void
      {
         if(GameManager.instance.isStopFocus)
         {
            return;
         }
         return;
         §§push(_animateSet && _animateSet.addAnimation(new BaseSetCenterAnimation(px,py,50,!isTween,1)));
      }
      
      public function scenarioSetCenter(px:Number, py:Number, type:int) : void
      {
         if(GameManager.instance.isStopFocus)
         {
            return;
         }
         switch(int(type) - 2)
         {
            case 0:
               _animateSet.addAnimation(new ShockingSetCenterAnimation(px,py,165,false,2,9));
               break;
            case 1:
               _animateSet.addAnimation(new ShockingSetCenterAnimation(px,py,50,false,2,9));
         }
      }
      
      public function livingSetCenter(px:Number, py:Number, isTween:Boolean, priority:int = 2, data:Object = null, player:GameLiving = null) : void
      {
         if(GameManager.instance.isStopFocus)
         {
            return;
         }
         if(_animateSet)
         {
            _animateSet.addAnimation(new BaseSetCenterAnimation(px,py,25,!isTween,priority,0,data));
         }
      }
      
      public function setSelfCenter(isTween:Boolean, priority:int = 2, data:Object = null) : void
      {
         var self:Living = _game.livings[_game.selfGamePlayer.LivingID];
         if(self == null)
         {
            return;
         }
         _animateSet.addAnimation(new BaseSetCenterAnimation(self.pos.x - 50,self.pos.y - 150,25,!isTween,priority,0,data));
      }
      
      public function act(action:BaseAction) : void
      {
         _actionManager.act(action);
      }
      
      public function showShoot(x:Number, y:Number) : void
      {
         _circle = new Shape();
         _circle.graphics.beginFill(16711680);
         _circle.graphics.drawCircle(x,y,3);
         _circle.graphics.drawCircle(x,y,1);
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
         var currentTime:int = getTimer();
         if(currentTime - _frameRateCounter > 46 && _frameRateCounter != 0)
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
         _frameRateCounter = currentTime;
      }
      
      private function __onRespose(event:FrameEvent) : void
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
         var bitData:BitmapData = new BitmapData(StageReferance.stageWidth,StageReferance.stageHeight);
         var pos:Point = globalToLocal(new Point(0,0));
         bitData.draw(this,new Matrix(1,0,0,1,-pos.x,-pos.y),null,null);
         return new Bitmap(bitData,"auto",true);
      }
      
      private function updateSky() : void
      {
         var _middleHScalePercent:Number = NaN;
         var _middleWScalePercent:Number = NaN;
         if(_scale < 1)
         {
         }
         var _skyHScalePercent:Number = (sky.height * _scale - PathInfo.GAME_HEIGHT) / (bound.height * _scale - PathInfo.GAME_HEIGHT);
         var _skyWScalePercent:Number = (sky.width * _scale - PathInfo.GAME_WIDTH) / (bound.width * _scale - PathInfo.GAME_WIDTH);
         _skyHScalePercent = isNaN(_skyHScalePercent) || _skyHScalePercent == -Infinity || _skyHScalePercent == Infinity?1:Number(_skyHScalePercent);
         _skyWScalePercent = isNaN(_skyWScalePercent) || _skyWScalePercent == -Infinity || _skyWScalePercent == Infinity?1:Number(_skyWScalePercent);
         _sky.y = y * (_skyHScalePercent - 1) / _scale;
         _sky.x = x * (_skyWScalePercent - 1) / _scale;
         if(_middle)
         {
            _middleHScalePercent = (_middle.height * _scale - PathInfo.GAME_HEIGHT) / (bound.height * _scale - PathInfo.GAME_HEIGHT);
            _middleWScalePercent = (_middle.width * _scale - PathInfo.GAME_WIDTH) / (bound.width * _scale - PathInfo.GAME_WIDTH);
            _middleHScalePercent = isNaN(_middleHScalePercent) || _middleHScalePercent == -Infinity || _middleHScalePercent == Infinity?1:Number(_middleHScalePercent);
            _middleWScalePercent = isNaN(_middleWScalePercent) || _middleWScalePercent == -Infinity || _middleWScalePercent == Infinity?1:Number(_middleWScalePercent);
            _middle.y = y * (_middleHScalePercent - 1) / _scale;
            _middle.x = x * (_middleWScalePercent - 1) / _scale;
         }
         _smallMap.setScreenPos(x,y);
      }
      
      public function getPhysical(id:int) : PhysicalObj
      {
         return _objects[id];
      }
      
      public function get objects() : Dictionary
      {
         return _objects;
      }
      
      public function get getOneSimpleBoss() : GameSimpleBoss
      {
         var _loc3_:int = 0;
         var _loc2_:* = _objects;
         for each(var tmp in _objects)
         {
            if(tmp is GameSimpleBoss)
            {
               return tmp as GameSimpleBoss;
            }
         }
         return null;
      }
      
      override public function addPhysical(phy:Physics) : void
      {
         var obj:* = null;
         super.addPhysical(phy);
         if(phy is PhysicalObj)
         {
            obj = phy as PhysicalObj;
            _objects[obj.Id] = obj;
            if(obj.smallView)
            {
               _smallMap.addObj(obj.smallView);
               _smallMap.updatePos(obj.smallView,obj.pos);
            }
            addToBackEffectView(obj);
         }
         if(phy is GamePlayer)
         {
            gamePlayerList.push(phy);
         }
      }
      
      private function controlExpNum(temp:GamePlayer) : void
      {
         var randomNum:int = 0;
         var randomExpnickname:* = null;
         var randomExpcontainer:* = null;
         if(expName.length < 2)
         {
            if(expName.indexOf(temp.facecontainer.nickName.text) < 0)
            {
               expName.push(temp.facecontainer.nickName.text);
               expDic[temp.facecontainer.nickName.text] = temp.facecontainer;
            }
         }
         else if(expName.indexOf(temp.facecontainer.nickName.text) < 0)
         {
            randomNum = Math.random() * 2;
            randomExpnickname = expName[randomNum];
            randomExpcontainer = expDic[randomExpnickname] as FaceContainer;
            if(randomExpcontainer.isActingExpression)
            {
               randomExpcontainer.doClearFace();
            }
            expName[randomNum] = temp.facecontainer.nickName.text;
            delete expDic[randomExpnickname];
            expDic[temp.facecontainer.nickName.text] = temp.facecontainer;
         }
      }
      
      private function resetDicAndVec(temp:GamePlayer) : void
      {
         var tempIndex:int = expName.indexOf(temp.facecontainer.nickName.text);
         if(tempIndex >= 0)
         {
            delete expDic[expName[tempIndex]];
            expName.splice(tempIndex,1);
         }
      }
      
      public function setExpressionLoction() : void
      {
         var i:int = 0;
         var temp:* = null;
         var pointAtStage:* = null;
         var tempFlg:int = 0;
         if(!gamePlayerList || gamePlayerList.length == 0)
         {
            return;
         }
         for(i = 0; i < gamePlayerList.length; )
         {
            temp = gamePlayerList[i];
            if(temp == null || !temp.isLiving || temp.facecontainer == null)
            {
               gamePlayerList.splice(i,1);
            }
            else if(temp.facecontainer.isActingExpression)
            {
               if(!(temp.facecontainer.expressionID >= 1073 || temp.facecontainer.expressionID <= 1001))
               {
                  pointAtStage = this.localToGlobal(new Point(temp.x,temp.y));
                  tempFlg = onStageFlg(pointAtStage);
                  if(tempFlg == 0)
                  {
                     temp.facecontainer.x = 0;
                     temp.facecontainer.y = -100;
                     resetDicAndVec(temp);
                     temp.facecontainer.isShowNickName = false;
                  }
                  else if(tempFlg == 1)
                  {
                     temp.facecontainer.x = temp.facecontainer.width / 2 + 30 - pointAtStage.x;
                     temp.facecontainer.y = 270 + temp.facecontainer.height / 2 - pointAtStage.y;
                     controlExpNum(temp);
                     temp.facecontainer.isShowNickName = true;
                  }
                  if(expName.length == 2)
                  {
                     (expDic[expName[1]] as FaceContainer).x = (expDic[expName[1]] as FaceContainer).x + 80;
                  }
               }
            }
            else
            {
               temp.facecontainer.x = 0;
               temp.facecontainer.y = -100;
               temp.facecontainer.isShowNickName = false;
               resetDicAndVec(temp);
            }
            i++;
         }
      }
      
      private function onStageFlg(tempPoint:Point) : int
      {
         if(tempPoint == null)
         {
            return 100;
         }
         if(tempPoint.x >= 0 && tempPoint.x <= 1000 && tempPoint.y >= 0 && tempPoint.y <= 600)
         {
            return 0;
         }
         return 1;
      }
      
      public function addObject(phy:Physics) : void
      {
         var obj:* = null;
         if(phy is PhysicalObj)
         {
            obj = phy as PhysicalObj;
            _objects[obj.Id] = obj;
         }
      }
      
      public function bringToFront($info:Living) : void
      {
         if(!$info)
         {
            return;
         }
         var phy:Physics = _objects[$info.LivingID] as Physics;
         if(phy)
         {
            super.addPhysical(phy);
         }
      }
      
      public function phyBringToFront(phy:PhysicalObj) : void
      {
         if(phy)
         {
            super.addChild(phy);
         }
      }
      
      override public function removePhysical(phy:Physics) : void
      {
         var obj:* = null;
         super.removePhysical(phy);
         if(phy is PhysicalObj)
         {
            obj = phy as PhysicalObj;
            if(_objects && _objects[obj.Id])
            {
               delete _objects[obj.Id];
            }
            if(_smallMap && obj.smallView)
            {
               _smallMap.removeObj(obj.smallView);
            }
            removeToBackEffectView(obj);
         }
      }
      
      override public function addMapThing(phy:Physics) : void
      {
         var obj:* = null;
         super.addMapThing(phy);
         if(phy is PhysicalObj)
         {
            obj = phy as PhysicalObj;
            _objects[obj.Id] = obj;
            if(obj.smallView)
            {
               _smallMap.addObj(obj.smallView);
               _smallMap.updatePos(obj.smallView,obj.pos);
            }
            addToBackEffectView(obj);
         }
      }
      
      override public function removeMapThing(phy:Physics) : void
      {
         var obj:* = null;
         super.removeMapThing(phy);
         if(phy is PhysicalObj)
         {
            obj = phy as PhysicalObj;
            if(_objects[obj.Id])
            {
               delete _objects[obj.Id];
            }
            if(obj.smallView)
            {
               _smallMap.removeObj(obj.smallView);
            }
            removeToBackEffectView(obj);
         }
      }
      
      public function createBackEffectView(gamePlayerRadius:Number = 400) : void
      {
         if(_backEffectView == null)
         {
            _backEffectView = new BackEffectView(this);
         }
         _backEffectView.gamePlayerRadius(gamePlayerRadius);
         _backEffectView.resetEffect();
         addChild(_backEffectView);
      }
      
      public function removeBackEffectView() : void
      {
         if(_backEffectView)
         {
            _backEffectView.removeBackEffectView();
         }
         _backEffectView = null;
      }
      
      public function hideBackEffectView() : void
      {
         if(_backEffectView)
         {
            _backEffectView.visible = false;
         }
      }
      
      public function showBackEffectView() : void
      {
         if(_backEffectView)
         {
            _backEffectView.visible = true;
         }
      }
      
      private function addToBackEffectView(phy:PhysicalObj) : void
      {
         if(_backEffectView)
         {
            _backEffectView.addObject(phy);
         }
      }
      
      private function updatePosBackEffectView(phy:PhysicalObj, pos:Point) : void
      {
         if(_backEffectView)
         {
            _backEffectView.updatePos(phy,pos);
         }
      }
      
      private function removeToBackEffectView(phy:PhysicalObj) : void
      {
         if(_backEffectView)
         {
            _backEffectView.removeObj(phy);
         }
      }
      
      public function updateObjectPos(phy:PhysicalObj, pos:Point) : void
      {
         updatePosBackEffectView(phy,pos);
      }
      
      public function get actionCount() : int
      {
         return _actionManager.actionCount;
      }
      
      public function lockFocusAt(pos:Point) : void
      {
         animateSet.addAnimation(new NewHandAnimation(pos.x,pos.y - 150,2147483647,false,4));
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
      
      public function bringToStageTop(living:PhysicalObj) : void
      {
         if(_currentTopLiving)
         {
            addPhysical(_currentTopLiving);
         }
         if(_container && _container.parent)
         {
            _container.parent.removeChild(_container);
         }
         _currentTopLiving = _objects[living.Id] as GameLiving;
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
      
      public function setMatrx(m:Matrix) : void
      {
         transform.matrix = m;
         if(_container)
         {
            _container.transform.matrix = m;
         }
      }
      
      public function dropOutBox(array:Array) : void
      {
         _picIdList = array;
         setSelfCenter(false);
         _isPickBigBox = false;
         _bigBox = new MovieClipWrapper(ClassUtils.CreatInstance("asset.game.dropOut.bigBox.red"),true);
         _livingLayer.addChild(_bigBox.movie);
         var tmpPoint:Point = getTwoHundredDisPoint(_game.selfGamePlayer.pos.x,_game.selfGamePlayer.pos.y,_bigBox.movie.width / 2,_bigBox.movie.height / 2,_game.selfGamePlayer.direction);
         _bigBox.movie.x = tmpPoint.x;
         _bigBox.movie.y = tmpPoint.y;
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
      
      protected function __openBox(event:TimerEvent) : void
      {
         if(_boxTimer)
         {
            _boxTimer.stop();
            _boxTimer.removeEventListener("timerComplete",__openBox);
            _boxTimer = null;
         }
         pickBigBoxSuccessHandler();
      }
      
      protected function __onBigBoxClick(event:MouseEvent) : void
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
      
      private function playPickBoxAwardMove(event:Event) : void
      {
         var len:int = 0;
         var tag:int = 0;
         var i:int = 0;
         var bg:* = null;
         var tmpPic:* = null;
         var tmpX:Number = NaN;
         if(_bigBox.movie.currentFrame == 37)
         {
            _picList = [];
            len = _picIdList.length;
            tag = -1;
            for(i = 0; i < len; )
            {
               bg = new Bitmap(new BitmapData(45,45,true,0));
               tmpPic = new BaseCell(bg,ItemManager.Instance.getTemplateById(_picIdList[i]));
               tmpPic.x = _picStartPoint.x;
               tmpPic.y = _picStartPoint.y;
               _picList.push(tmpPic);
               addChild(tmpPic);
               if(len % 2 == 0)
               {
                  tmpX = int(i / 2) * tag * 50 + 25 * tag + tmpPic.x;
               }
               else
               {
                  tmpX = int((i + 1) / 2) * tag * 50 + tmpPic.x;
               }
               TweenLite.to(tmpPic,0.2,{"x":tmpX});
               tag = tag * -1;
               i++;
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
      
      private function playPickBoxAwardMove2(event:Event) : void
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
      
      private function pickBigBoxSuccessHandler2(pic:BaseCell) : void
      {
         TweenLite.to(pic,0.5,{
            "y":pic.y - 60,
            "alpha":1,
            "scaleX":1,
            "scaleY":1,
            "onComplete":upMoveEndHandler,
            "onCompleteParams":[pic]
         });
      }
      
      private function upMoveEndHandler(pic:BaseCell) : void
      {
         lightCartoonPlayEndHandler(pic);
      }
      
      private function lightCartoonPlayEndHandler(pic:BaseCell) : void
      {
         if(!_game || !_game.selfGamePlayer || !_game.selfGamePlayer.pos)
         {
            return;
         }
         var arrivePos:Point = new Point(_game.selfGamePlayer.pos.x,_game.selfGamePlayer.pos.y);
         var tmpxx:Number = (pic.x + arrivePos.x) / 2;
         var tmpyy:Number = Math.min(pic.y,arrivePos.y) - 200;
         TweenMax.to(pic,1,{
            "scaleX":0.1,
            "scaleY":0.1,
            "bezier":[{
               "x":tmpxx,
               "y":tmpyy
            },{
               "x":arrivePos.x,
               "y":arrivePos.y
            }],
            "onComplete":pickBigBoxEndHandler,
            "onCompleteParams":[pic]
         });
      }
      
      private function pickBigBoxEndHandler(pic:BaseCell) : void
      {
         if(!pic)
         {
            return;
         }
         pic.dispose();
         pic = null;
      }
      
      private function playSoundEffect(evnet:Event) : void
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
      
      private function openBigBox(event:MouseEvent) : void
      {
         _bigBox.movie.buttonMode = false;
         _bigBox.movie.removeEventListener("click",openBigBox);
         _isPickBigBox = true;
      }
      
      private function dropEndHandler(event:Event) : void
      {
         _bigBox.removeEventListener("complete",dropEndHandler);
         _bigBox.gotoAndStop("stop");
      }
      
      private function getTwoHundredDisPoint(x:Number, y:Number, width:Number, height:Number, direction:int) : Point
      {
         var point1:* = null;
         y = 150;
         var tmp:Number = x + 200 * direction + width * direction;
         if(!this.IsOutMap(tmp,y) && this.IsEmpty(tmp,y))
         {
            point1 = findYLineNotEmptyPointDown(x + 200 * direction,y,this.bound.height);
            if(point1)
            {
               return point1;
            }
         }
         direction = direction * -1;
         tmp = x + 200 * direction + width * direction;
         var point2:Point = findYLineNotEmptyPointDown(x + 200 * direction,y,this.bound.height);
         return point2;
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
         for each(var p in _objects)
         {
            p.dispose();
            p = null;
         }
         _objects = null;
         _game = null;
         _info = null;
         ObjectUtils.disposeObject(_backEffectView);
         _backEffectView = null;
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
         gamePlayerList = null;
      }
   }
}
