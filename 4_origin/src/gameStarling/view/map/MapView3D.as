package gameStarling.view.map
{
   import bagAndInfo.cell.BaseCell;
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.data.BallInfo;
   import ddt.data.PathInfo;
   import ddt.data.map.MapInfo;
   import ddt.eventsStarling.Game3DEvent;
   import ddt.loader.MapLoader;
   import ddt.manager.BallManager;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMEManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.chat.ChatEvent;
   import flash.display.BitmapData;
   import flash.events.ErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.system.IME;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import game.GameManager;
   import game.objects.BombAsset;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.TurnedLiving;
   import gameCommon.view.smallMap.SmallMapView3D;
   import gameStarling.actions.ActionManager;
   import gameStarling.animations.AnimationSet;
   import gameStarling.animations.BaseSetCenterAnimation;
   import gameStarling.animations.IAnimate;
   import gameStarling.animations.NewHandAnimation;
   import gameStarling.animations.ShockingSetCenterAnimation;
   import gameStarling.animations.SpellSkillAnimation;
   import gameStarling.objects.GameLiving3D;
   import gameStarling.objects.GamePlayer3D;
   import gameStarling.objects.GameSimpleBoss3D;
   import gameStarling.objects.SimpleBox3D;
   import gameStarling.view.FaceContainer3D;
   import gameStarling.view.GameView3D;
   import gameStarling.view.GameViewBase3D;
   import road7th.StarlingMain;
   import road7th.data.DictionaryData;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.RenderTexture;
   import starlingPhy.maps.Ground3D;
   import starlingPhy.maps.Map3D;
   import starlingPhy.maps.Tile3D;
   import starlingPhy.object.PhysicalObj3D;
   import starlingPhy.object.Physics3D;
   
   public class MapView3D extends Map3D
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
      
      private var _smallMap:SmallMapView3D;
      
      private var _actionManager:ActionManager;
      
      public var gameView:GameViewBase3D;
      
      public var currentFocusedLiving:GameLiving3D;
      
      private var _currentTurn:int;
      
      private var _y:Number;
      
      private var _x:Number;
      
      public var physicalChilds:Dictionary;
      
      private var _currentFocusedLiving:GameLiving3D;
      
      private var _currentFocusLevel:int;
      
      private var _currentPlayer:TurnedLiving;
      
      private var _scale:Number = 1;
      
      private var _frameRateCounter:int;
      
      private var _currentFrameRateOverCount:int = 0;
      
      private var _frameRateAlert:BaseAlerFrame;
      
      private var _objects:DictionaryData;
      
      private var _gamePlayerList:Vector.<GamePlayer3D>;
      
      private var expName:Vector.<String>;
      
      private var expDic:Dictionary;
      
      private var _currentTopLiving:GameLiving3D;
      
      private var _container:Sprite;
      
      private var _bigBox:BoneMovieStarling;
      
      private var _isPickBigBox:Boolean;
      
      private var _picIdList:Array;
      
      private var _picMoveDelay:int;
      
      private var _picList:Array;
      
      private var _picStartPoint:Point;
      
      private var _lastPic:BaseCell;
      
      private var _boxTimer:Timer;
      
      public function MapView3D(game:GameInfo, loader:MapLoader)
      {
         physicalChilds = new Dictionary();
         _objects = new DictionaryData();
         _gamePlayerList = new Vector.<GamePlayer3D>();
         expName = new Vector.<String>();
         expDic = new Dictionary();
         GameControl.Instance.Current.selfGamePlayer.currentMap3D = this;
         _game = game;
         var skyBitmap:Tile3D = new Tile3D(!!loader.backBmp?loader.backBmp.bitmapData:new BitmapData(1500,1000),false);
         var f:Ground3D = !!loader.foreBmp?new Ground3D(loader.foreBmp.bitmapData.clone(),true):null;
         var s:Ground3D = !!loader.deadBmp?new Ground3D(loader.deadBmp.bitmapData.clone(),false):null;
         var r:Ground3D = !!loader.realBmp?new Ground3D(loader.realBmp.bitmapData.clone(),false):null;
         var info:MapInfo = loader.info;
         super(skyBitmap,f,s,r);
         airResistance = info.DragIndex;
         gravity = info.Weight;
         _info = info;
         _animateSet = new AnimationSet(this,PathInfo.GAME_WIDTH,PathInfo.GAME_HEIGHT);
         _smallMap = new SmallMapView3D(this,GameControl.Instance.Current.missionInfo);
         _smallMap.update();
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
         ChatManager.Instance.addEventListener("setFacecontainerLoction",__setFacecontainLoctionAction);
         initOutCrater();
         initBox();
      }
      
      public function set currentTurn(i:int) : void
      {
         _currentTurn = i;
         dispatchEvent(new Game3DEvent("turnChanged",_currentTurn));
      }
      
      public function get currentTurn() : int
      {
         return _currentTurn;
      }
      
      public function requestForFocus(target:GameLiving3D, level:int = 0) : void
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
      
      public function cancelFocus(target:GameLiving3D = null) : void
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
      
      public function get smallMap() : SmallMapView3D
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
         var box:* = null;
         var outBoxs:DictionaryData = _game.outBoxs;
         if(outBoxs.length > 0)
         {
            for(i = 0; i < outBoxs.length; )
            {
               box = new SimpleBox3D(outBoxs.list[i].bid,String(PathInfo.GAME_BOXPIC),outBoxs.list[i].subType);
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
      
      private function __setFacecontainLoctionAction(e:ChatEvent) : void
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
      
      public function spellKill(player:GamePlayer3D) : IAnimate
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
         if(gameView.mapSprite)
         {
            gameView.mapSprite.x = _x;
         }
         .super.x = _x;
      }
      
      override public function set y(value:Number) : void
      {
         value = value < minY?minY:Number(value > 0?0:Number(value));
         _y = value;
         if(gameView.mapSprite)
         {
            gameView.mapSprite.y = _y;
         }
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
         transformationMatrix = _matrix;
         var _loc3_:* = Math.pow(_scale,-0.5);
         _sky.scaleY = _loc3_;
         _loc3_ = _loc3_;
         _sky.scaleX = _loc3_;
         _loc3_ = _loc3_;
         _bg.scaleY = _loc3_;
         _bg.scaleX = _loc3_;
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
      
      public function livingSetCenter(px:Number, py:Number, isTween:Boolean, priority:int = 2, data:Object = null) : void
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
               if(StageReferance.stage && StageReferance.stage.focus == null)
               {
                  StageReferance.stage.focus = GameControl.Instance.gameView as GameView3D;
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
      
      public function get drawMapView() : Image
      {
         var pos:Point = globalToLocal(new Point(0,0));
         var texture:RenderTexture = new RenderTexture(StageReferance.stageWidth,StageReferance.stageHeight);
         texture.draw(this,new Matrix(1,0,0,1,-pos.x,-pos.y));
         return new Image(texture);
      }
      
      private function updateSky() : void
      {
         if(_scale < 1)
         {
         }
         var _skyHScalePercent:Number = (sky.height * _scale - PathInfo.GAME_HEIGHT) / (bound.height * _scale - PathInfo.GAME_HEIGHT);
         var _skyWScalePercent:Number = (sky.width * _scale - PathInfo.GAME_WIDTH) / (bound.width * _scale - PathInfo.GAME_WIDTH);
         _skyHScalePercent = isNaN(_skyHScalePercent) || _skyHScalePercent == -Infinity || _skyHScalePercent == Infinity?1:Number(_skyHScalePercent);
         _skyWScalePercent = isNaN(_skyWScalePercent) || _skyWScalePercent == -Infinity || _skyWScalePercent == Infinity?1:Number(_skyWScalePercent);
         _sky.y = y * (_skyHScalePercent - 1) / _scale;
         _sky.x = x * (_skyWScalePercent - 1) / _scale;
         _smallMap.setScreenPos(x,y);
      }
      
      public function getPhysical(id:int) : PhysicalObj3D
      {
         return _objects[id];
      }
      
      public function get objects() : Dictionary
      {
         return _objects;
      }
      
      public function get getOneSimpleBoss() : GameSimpleBoss3D
      {
         var _loc3_:int = 0;
         var _loc2_:* = _objects;
         for each(var tmp in _objects)
         {
            if(tmp is GameSimpleBoss3D)
            {
               return tmp as GameSimpleBoss3D;
            }
         }
         return null;
      }
      
      override public function addPhysical(phy:Physics3D) : void
      {
         var obj:* = null;
         super.addPhysical(phy);
         if(phy is PhysicalObj3D)
         {
            obj = phy as PhysicalObj3D;
            _objects[obj.Id] = obj;
            if(obj.smallView)
            {
               _smallMap.addObj(obj.smallView);
               _smallMap.updatePos(obj.smallView,obj.pos);
            }
         }
         if(phy is GamePlayer3D)
         {
            _gamePlayerList.push(phy);
         }
      }
      
      private function controlExpNum(temp:GamePlayer3D) : void
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
            randomExpcontainer = expDic[randomExpnickname] as FaceContainer3D;
            if(randomExpcontainer.isActingExpression)
            {
               randomExpcontainer.doClearFace();
            }
            expName[randomNum] = temp.facecontainer.nickName.text;
            delete expDic[randomExpnickname];
            expDic[temp.facecontainer.nickName.text] = temp.facecontainer;
         }
      }
      
      private function resetDicAndVec(temp:GamePlayer3D) : void
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
         var x:Number = NaN;
         var y:Number = NaN;
         if(!_gamePlayerList || _gamePlayerList.length == 0)
         {
            return;
         }
         for(i = 0; i < _gamePlayerList.length; )
         {
            temp = _gamePlayerList[i];
            if(temp == null || !temp.isLiving || temp.facecontainer == null)
            {
               _gamePlayerList.splice(i,1);
            }
            else if(temp.facecontainer.isActingExpression)
            {
               if(!(temp.facecontainer.expressionID >= 1073 || temp.facecontainer.expressionID <= 1001))
               {
                  pointAtStage = this.localToGlobal(new Point(temp.x,temp.y));
                  tempFlg = onStageFlg(pointAtStage);
                  if(tempFlg == 0)
                  {
                     temp.facecontainer.setPos(0,-100);
                     resetDicAndVec(temp);
                     temp.facecontainer.isShowNickName = false;
                  }
                  else if(tempFlg == 1)
                  {
                     x = temp.facecontainer.width / 2 + 30 - pointAtStage.x;
                     y = 270 + temp.facecontainer.height / 2 - pointAtStage.y;
                     temp.facecontainer.setPos(x,y);
                     controlExpNum(temp);
                     temp.facecontainer.isShowNickName = true;
                  }
                  if(expName.length == 2)
                  {
                     (expDic[expName[1]] as FaceContainer3D).x = (expDic[expName[1]] as FaceContainer3D).x + 80;
                  }
               }
            }
            else
            {
               temp.facecontainer.setPos(0,-100);
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
      
      public function addObject(phy:Physics3D) : void
      {
         var obj:* = null;
         if(phy is PhysicalObj3D)
         {
            obj = phy as PhysicalObj3D;
            _objects[obj.Id] = obj;
         }
      }
      
      public function bringToFront($info:Living) : void
      {
         if(!$info)
         {
            return;
         }
         var phy:Physics3D = _objects[$info.LivingID] as Physics3D;
         if(phy)
         {
            super.addPhysical(phy);
         }
      }
      
      public function phyBringToFront(phy:PhysicalObj3D) : void
      {
         if(phy)
         {
            super.addChild(phy);
         }
      }
      
      override public function removePhysical(phy:Physics3D) : void
      {
         var obj:* = null;
         super.removePhysical(phy);
         if(phy is PhysicalObj3D)
         {
            obj = phy as PhysicalObj3D;
            trace("shilian--- removePhy by id: " + obj.Id);
            if(_objects && _objects[obj.Id])
            {
               delete _objects[obj.Id];
            }
            if(_smallMap && obj.smallView)
            {
               _smallMap.removeObj(obj.smallView);
            }
         }
      }
      
      override public function addMapThing(phy:Physics3D) : void
      {
         var obj:* = null;
         super.addMapThing(phy);
         if(phy is PhysicalObj3D)
         {
            obj = phy as PhysicalObj3D;
            _objects[obj.Id] = obj;
            if(obj.smallView)
            {
               _smallMap.addObj(obj.smallView);
               _smallMap.updatePos(obj.smallView,obj.pos);
            }
         }
      }
      
      override public function removeMapThing(phy:Physics3D) : void
      {
         var obj:* = null;
         if(phy is PhysicalObj3D)
         {
            obj = phy as PhysicalObj3D;
            trace("shilian--- removePhyThing by id: " + obj.Id);
            if(_objects[obj.Id])
            {
               delete _objects[obj.Id];
            }
            if(obj.smallView)
            {
               _smallMap.removeObj(obj.smallView);
            }
         }
         super.removeMapThing(phy);
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
      
      public function bringToStageTop(living:PhysicalObj3D) : void
      {
         if(_currentTopLiving)
         {
            addPhysical(_currentTopLiving);
         }
         StarlingObjectUtils.removeObject(_container);
         _currentTopLiving = _objects[living.Id] as GameLiving3D;
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
         StarlingMain.instance.currentScene.addChild(_container);
      }
      
      public function restoreStageTopLiving() : void
      {
         if(_currentTopLiving && _currentTopLiving.isExist)
         {
            addPhysical(_currentTopLiving);
         }
         StarlingObjectUtils.removeObject(_container);
         _currentTopLiving = null;
      }
      
      public function setMatrx(m:Matrix) : void
      {
         transformationMatrix = m;
         if(_container)
         {
            _container.transformationMatrix = m;
         }
      }
      
      public function dropOutBox(array:Array) : void
      {
         _picIdList = array;
         setSelfCenter(false);
         _isPickBigBox = false;
         _bigBox = BoneMovieFactory.instance.creatBoneMovie("MapView3D.as 785行资源没有。快解决后来一发");
         _livingLayer.addChild(_bigBox);
         var tmpPoint:Point = getTwoHundredDisPoint(_game.selfGamePlayer.pos.x,_game.selfGamePlayer.pos.y,_bigBox.width / 2,_bigBox.height / 2,_game.selfGamePlayer.direction);
         _bigBox.x = tmpPoint.x;
         _bigBox.y = tmpPoint.y;
         _bigBox.play("掉落动画播放low");
         picPlayActionComplete();
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
         _bigBox.removeEventListener("click",__onBigBoxClick);
         pickBigBoxSuccessHandler();
      }
      
      public function pickBigBoxSuccessHandler() : void
      {
         _bigBox.play("open");
         _picStartPoint = new Point(_bigBox.x - 22.5,_bigBox.y - 120 - 22.5);
         _picMoveDelay = 4;
         GameInSocketOut.sendGameSkipNext(0);
      }
      
      private function picPlayActionComplete() : void
      {
         SoundManager.instance.play("164");
         _bigBox.touchable = true;
      }
      
      private function openBigBox(event:MouseEvent) : void
      {
         _bigBox.touchable = false;
         _isPickBigBox = true;
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
         ChatManager.Instance.removeEventListener("setFacecontainerLoction",__setFacecontainLoctionAction);
         if(_boxTimer)
         {
            _boxTimer.stop();
            _boxTimer.removeEventListener("timerComplete",__openBox);
            _boxTimer = null;
         }
         if(_frameRateAlert)
         {
            _frameRateAlert.removeEventListener("response",__onRespose);
            _frameRateAlert.dispose();
            _frameRateAlert = null;
         }
         _currentTopLiving = null;
         StarlingObjectUtils.disposeObject(_container);
         _container = null;
         StarlingObjectUtils.disposeObject(_bigBox);
         _bigBox = null;
         var _loc3_:int = 0;
         var _loc2_:* = _objects;
         for each(var p in _objects)
         {
            StarlingObjectUtils.disposeObject(p);
         }
         _objects.clear();
         _objects = null;
         _smallMap.dispose();
         _smallMap = null;
         _animateSet.dispose();
         _animateSet = null;
         _actionManager.clear();
         _actionManager = null;
         _game = null;
         _info = null;
         _currentFocusedLiving = null;
         currentFocusedLiving = null;
         _currentPlayer = null;
         gameView = null;
         _gamePlayerList = null;
         super.dispose();
      }
   }
}
