package starling.scene.hall
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import com.greensock.TweenLite;
   import com.greensock.easing.Linear;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.SpriteLayer;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.DailyButtunBar;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import hall.HallStateView;
   import hall.aStar.AStarPathFinder;
   import hall.event.NewHallEvent;
   import hall.player.vo.PlayerVO;
   import newTitle.NewTitleManager;
   import playerDress.event.PlayerDressEvent;
   import road7th.comm.PackageIn;
   import starling.core.Starling;
   import starling.display.Sprite;
   import starling.display.sceneCharacter.event.SceneCharacterEvent;
   import starling.events.Event;
   import starling.events.ResizeEvent;
   import starling.scene.hall.event.NewHallEventStarling;
   import starling.scene.hall.player.HallPlayer;
   
   public class HallPlayerView extends starling.display.Sprite
   {
      
      private static var _playerPos:Point = new Point(1456,496);
       
      
      private const randomPathX:int = 4;
      
      private const randomPathY:int = 3;
      
      private const randomPathMap:Object = {
         "8_9":[545,532,1289,515],
         "7_10":[3601,341,3552,368,3360,368,3296,400,3232,432,3040,432,2976,464,2656,464,2609,471],
         "5_7":[1463,467,1504,432,3232,432,3296,400,3360,400,3424,368,3552,368,3601,341],
         "3_6":[3230,344,3168,368,2848,368,2784,414],
         "3_8":[3230,344,3168,368,2144,368,2080,400,1312,400,1248,432,1184,464,1120,496,1056,528,608,528,545,532],
         "6_11":[2784,414,3581,526],
         "2_4":[2411,415,52,469],
         "6_10":[2784,414,2609,471],
         "0_3":[771,430,864,432,2208,432,2272,400,2848,400,2912,368,3168,368,3230,344],
         "6_9":[2784,414,1289,515],
         "1_4":[1161,430,52,469],
         "0_4":[771,430,52,469],
         "5_6":[1463,467,2784,414],
         "2_5":[2411,415,1463,467],
         "8_10":[545,532,2609,471],
         "2_3":[2411,415,2464,400,3104,400,3168,368,3230,344],
         "1_5":[1161,430,1463,467],
         "3_7":[3230,344,3296,368,3552,368,3601,341],
         "7_9":[3601,341,3552,368,3488,368,3424,400,3360,432,3296,432,3232,464,3168,464,3104,496,3040,528,1376,528,1289,515],
         "4_7":[52,469,96,432,2080,432,2144,400,2208,368,3552,368,3601,341],
         "1_3":[1161,430,1248,432,2208,432,2272,400,2720,400,2784,368,3168,368,3230,344],
         "0_5":[771,430,1463,467],
         "7_11":[3601,341,3581,526],
         "4_8":[52,469,545,532],
         "4_6":[52,469,2784,414],
         "8_11":[545,532,3581,526],
         "5_8":[1463,467,545,532]
      };
      
      public var MapClickFlag:Boolean;
      
      private var _playerSprite:starling.display.Sprite;
      
      private var _selfPlayer:HallPlayer;
      
      private var _friendPlayerDic:Dictionary;
      
      private var _playerArray:Array;
      
      private var _lastClickTime:int = 0;
      
      private var _mapID:int;
      
      private var _hidFlag:Boolean;
      
      private var _loadPlayerDic:Dictionary;
      
      private var _unLoadPlayerDic:Dictionary;
      
      private var _loadPkg:PackageIn;
      
      private var _loadTimer:Timer;
      
      private var _judgePos:Point;
      
      private var _lastClick:Number = 0;
      
      private var _sceneMapGridData:SceneMapGridData;
      
      private var _aStarPathFinder:AStarPathFinder;
      
      private var _mouseMovie:BoneMovieFastStarling;
      
      private var _staticLayer:StaticLayer;
      
      private var _mouseClickLayer:flash.display.Sprite;
      
      public function HallPlayerView()
      {
         super();
         _staticLayer = new StaticLayer();
         _staticLayer.touchable = false;
         addChild(_staticLayer);
         _playerSprite = new starling.display.Sprite();
         _friendPlayerDic = new Dictionary();
         _playerArray = [];
         _loadTimer = new Timer(1500);
         _loadTimer.addEventListener("timer",__onloadPlayerRes);
         _sceneMapGridData = ComponentFactory.Instance.creatCustomObject("hall.map.SceneMapGridData");
         _aStarPathFinder = new AStarPathFinder();
         _aStarPathFinder.init(_sceneMapGridData);
         addChild(_playerSprite);
         _mouseClickLayer = new flash.display.Sprite();
         drawMouseClickLayer();
         var _loc1_:SpriteLayer = LayerManager.Instance.getLayerByType(5);
         _loc1_.addChild(_mouseClickLayer);
         mapID = PlayerManager.Instance.Self.Grade >= 10?0:1;
         initEvent();
         sendPkg();
      }
      
      private function drawMouseClickLayer() : void
      {
         _mouseClickLayer.graphics.clear();
         _mouseClickLayer.graphics.beginFill(0,0);
         _mouseClickLayer.graphics.drawRect(0,0,StageReferance.stage.stageWidth,StageReferance.stage.stageHeight);
         _mouseClickLayer.graphics.endFill();
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.sendOtherPlayerInfo();
      }
      
      private function initEvent() : void
      {
         _mouseClickLayer.addEventListener("click",__onPlayerClick);
         Starling.current.stage.addEventListener("resize",onStageResize);
         PlayerManager.Instance.addEventListener("setselfplayerpos",__onSetSelfPlayerPos);
         PlayerManager.Instance.addEventListener("showPets",__onShowPets);
         SocketManager.Instance.addEventListener("updatePlayerinfo",__updatePlayerDressInfo);
         SocketManager.Instance.addEventListener("newhallupdatetitle",__updateTitle);
         SocketManager.Instance.addEventListener(PkgEvent.format(262,0),__onFriendPlayerInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(262,7),__onPlayerHid);
      }
      
      private function onStageResize(param1:ResizeEvent) : void
      {
         drawMouseClickLayer();
      }
      
      protected function __onShowPets(param1:NewHallEvent) : void
      {
         if(!_selfPlayer)
         {
         }
      }
      
      protected function __onFriendPlayerInfo(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         _loc5_.readInt();
         _loc5_.readInt();
         var _loc2_:int = _loc5_.readInt();
         _loadPkg = _loc5_;
         _loadPlayerDic = new Dictionary();
         _unLoadPlayerDic = new Dictionary();
         removePlayerByID();
         var _loc4_:int = _loc5_.position;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc3_ = readPlayerInfoPkg(_loadPkg);
            _unLoadPlayerDic[_loc3_.playerInfo.ID] = _loc3_;
            _loc6_++;
         }
         if(!_selfPlayer)
         {
            addSelfPlayer();
         }
         else
         {
            startLoadOtherPlayer();
         }
      }
      
      private function startLoadOtherPlayer(param1:Boolean = true) : void
      {
         if(param1 && !this.hasEventListener("enterFrame"))
         {
            addEventListener("enterFrame",__updateFrame);
         }
         if(_loadTimer && !_loadTimer.running)
         {
            _loadTimer.start();
         }
      }
      
      private function judgePlayerShow(param1:int) : Boolean
      {
         _judgePos = PositionUtils.creatPoint("hall.playerInfoPos");
         var _loc2_:int = param1 + this.x;
         if(_loc2_ > _judgePos.x && _loc2_ < _judgePos.y)
         {
            return true;
         }
         return false;
      }
      
      protected function __onloadPlayerRes(param1:TimerEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _loadPlayerDic;
         for(var _loc2_ in _loadPlayerDic)
         {
            if(_loadPlayerDic[_loc2_])
            {
               setPlayerInfo(_loadPlayerDic[_loc2_]);
               delete _loadPlayerDic[_loc2_];
            }
         }
         if(_loc2_ == null)
         {
            _loadTimer.stop();
            _loadTimer.reset();
         }
      }
      
      private function getRandNum(param1:int, param2:int) : int
      {
         var _loc3_:int = param1 + (param2 - param1) * Math.random();
         return _loc3_;
      }
      
      protected function __onPlayerHid(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = 2;
         _hidFlag = _loc3_.readBoolean();
         if(_hidFlag)
         {
            removePlayerByID();
            _loadPlayerDic = new Dictionary();
            _unLoadPlayerDic = new Dictionary();
            _loc2_ = 1;
            if(_loadTimer != null)
            {
               _loadTimer.stop();
               _loadTimer.reset();
            }
         }
         DailyButtunBar.Insance.setEyeBtnFrame(_loc2_);
      }
      
      protected function __updateTitle(param1:NewHallEvent) : void
      {
         if(_selfPlayer)
         {
            if(NewTitleManager.instance.ShowTitle)
            {
               _selfPlayer.isHideTitle = true;
            }
            else
            {
               _selfPlayer.isHideTitle = false;
            }
         }
      }
      
      protected function __updatePlayerDressInfo(param1:PlayerDressEvent) : void
      {
      }
      
      private function addSelfPlayer() : void
      {
         if(!_mouseMovie)
         {
            _mouseMovie = BoneMovieFactory.instance.creatBoneMovieFast("hallScene.MouseClickMovie");
            _mouseMovie.touchable = false;
            _mouseMovie.stop();
            _mouseMovie.visible = false;
            addChild(_mouseMovie);
         }
         var _loc1_:PlayerVO = new PlayerVO();
         _loc1_.playerInfo = PlayerManager.Instance.Self;
         _selfPlayer = new HallPlayer(_loc1_);
         _selfPlayer.playerPoint = _playerPos;
         if(NewTitleManager.instance.ShowTitle)
         {
            _selfPlayer.isHideTitle = true;
         }
         else
         {
            _selfPlayer.isHideTitle = false;
         }
         _playerSprite.addChild(_selfPlayer);
         ajustScreen();
         setCenter();
         _selfPlayer.addEventListener("characterActionChange",playerActionChange);
         startLoadOtherPlayer();
         _selfPlayer.touchable = false;
         _selfPlayer.addEventListener("newhallbtnclick",__onFishWalk);
         _playerArray.push(_selfPlayer);
      }
      
      private function readPlayerInfoPkg(param1:PackageIn) : PlayerVO
      {
         var _loc2_:PlayerVO = new PlayerVO();
         _loc2_.playerInfo = new PlayerInfo();
         _loc2_.playerInfo.ID = param1.readInt();
         _loc2_.playerInfo.NickName = param1.readUTF();
         _loc2_.playerInfo.VIPLevel = param1.readInt();
         _loc2_.playerInfo.typeVIP = param1.readInt();
         _loc2_.playerInfo.Sex = param1.readBoolean();
         _loc2_.playerInfo.Style = param1.readUTF();
         _loc2_.playerInfo.Colors = param1.readUTF();
         _loc2_.playerInfo.MountsType = param1.readInt();
         _loc2_.playerInfo.PetsID = param1.readInt();
         initFriendVo(_loc2_);
         param1.position = param1.position + 8;
         _loc2_.playerInfo.ConsortiaID = param1.readInt();
         _loc2_.playerInfo.badgeID = param1.readInt();
         _loc2_.playerInfo.ConsortiaName = param1.readUTF();
         _loc2_.playerInfo.honor = param1.readUTF();
         _loc2_.playerInfo.honorId = param1.readInt();
         _loc2_.playerInfo.isAttest = param1.readBoolean();
         _loc2_.playerInfo.ImagePath = param1.readUTF();
         _loc2_.playerInfo.IsShow = param1.readBoolean();
         return _loc2_;
      }
      
      private function initFriendVo(param1:PlayerVO) : void
      {
         var _loc4_:int = 4 * 3 * Math.random();
         var _loc3_:int = getEndPointIndex(_loc4_);
         param1.randomStartPointIndex = _loc4_;
         param1.randomEndPointIndex = _loc3_;
         var _loc2_:Array = getPointPath(_loc4_,_loc3_);
         param1.currentWalkStartPoint = _loc2_[0];
         _loc2_.unshift();
         param1.walkPath = _loc2_;
      }
      
      private function getEndPointIndex(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1 / 3;
         if(_loc2_ == 4 - 1)
         {
            _loc3_ = -1;
         }
         else if(_loc2_ == 0)
         {
            _loc3_ = 1;
         }
         else
         {
            _loc3_ = Math.random() > 0.5?1:-1;
         }
         var _loc4_:int = (_loc2_ + _loc3_) * 3 + int(Math.random() * 3);
         return _loc4_;
      }
      
      private function getPointPath(param1:int, param2:int) : Array
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc3_:Array = [];
         if(param1 < param2)
         {
            _loc4_ = randomPathMap[param1 + "_" + param2];
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length / 2)
            {
               _loc3_.push(new Point(_loc4_[_loc5_ * 2],_loc4_[_loc5_ * 2 + 1]));
               _loc5_++;
            }
         }
         else
         {
            _loc4_ = randomPathMap[param2 + "_" + param1];
            _loc5_ = _loc4_.length / 2 - 1;
            while(_loc5_ > -1)
            {
               _loc3_.push(new Point(_loc4_[_loc5_ * 2],_loc4_[_loc5_ * 2 + 1]));
               _loc5_--;
            }
         }
         return _loc3_;
      }
      
      private function setPlayerInfo(param1:PlayerVO, param2:Boolean = false) : void
      {
         if(param2)
         {
            removePlayerByID(param1.playerInfo.ID);
         }
         var _loc3_:HallPlayer = new HallPlayer(param1);
         _loc3_.playerPoint = _loc3_.playerVO.currentWalkStartPoint;
         if(!_hidFlag)
         {
            _loc3_.startRandomWalk(4,3,randomPathMap);
         }
         if(getPlayerIndexById(_loc3_.playerVO.playerInfo.ID) == -1)
         {
            _playerSprite.addChild(_loc3_);
            _playerArray.push(_loc3_);
         }
         _loc3_.isHideTitle = true;
         _friendPlayerDic[_loc3_.playerVO.playerInfo.ID] = _loc3_;
      }
      
      private function removePlayerByID(param1:int = 0) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         if(param1 != 0)
         {
            if(_friendPlayerDic[param1])
            {
               _loc3_ = _friendPlayerDic[param1];
               if(_playerSprite.contains(_loc3_))
               {
                  _playerSprite.removeChild(_loc3_);
               }
               _loc2_ = getPlayerIndexById(_loc3_.playerVO.playerInfo.ID);
               if(_loc2_ != -1)
               {
                  _playerArray.splice(_loc2_,1);
               }
               delete _friendPlayerDic[param1];
               _loc3_.dispose();
               _loc3_ = null;
            }
         }
         else
         {
            var _loc6_:int = 0;
            var _loc5_:* = _friendPlayerDic;
            for(var _loc4_ in _friendPlayerDic)
            {
               _loc3_ = _friendPlayerDic[_loc4_];
               if(_playerSprite.contains(_loc3_))
               {
                  _playerSprite.removeChild(_loc3_);
               }
               StarlingObjectUtils.disposeObject(_loc3_);
               _loc3_ = null;
            }
            _playerArray.splice(0,_playerArray.length);
            if(_selfPlayer)
            {
               _playerArray.push(_selfPlayer);
            }
            _friendPlayerDic = new Dictionary();
         }
      }
      
      private function addPlayerCallBack(param1:HallPlayer) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1.playerVO.playerInfo.ID == PlayerManager.Instance.Self.ID)
         {
            _selfPlayer = param1;
            _selfPlayer.playerPoint = _playerPos;
            if(NewTitleManager.instance.ShowTitle)
            {
               param1.isHideTitle = true;
            }
            else
            {
               param1.isHideTitle = false;
            }
            _playerSprite.addChild(_selfPlayer);
            ajustScreen();
            setCenter();
            _selfPlayer.addEventListener("characterActionChange",playerActionChange);
            startLoadOtherPlayer();
         }
      }
      
      public function set type(param1:String) : void
      {
         _selfPlayer.sceneCharacterActionState = param1;
      }
      
      private function playerActionChange(param1:SceneCharacterEvent) : void
      {
         var _loc2_:String = param1.data.toString();
         if(_loc2_ == "standFront" || _loc2_ == "standBack")
         {
         }
      }
      
      protected function __updateFrame(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Number = NaN;
         if(!_playerArray)
         {
            removeEventListener("enterFrame",__updateFrame);
            return;
         }
         _playerArray.sortOn("playerY",16);
         _loc3_ = 0;
         while(_loc3_ < _playerArray.length)
         {
            if(_playerArray[_loc3_])
            {
               if(_playerArray[_loc3_].parent == null)
               {
                  _playerSprite.addChild(_playerArray[_loc3_]);
               }
               _playerSprite.setChildIndex(_playerArray[_loc3_],_loc3_);
               _playerArray[_loc3_].updatePlayer();
               _playerArray[_loc3_].visible = judgePlayerShow(_playerArray[_loc3_].playerPoint.x);
               _loc2_ = Point.distance(_selfPlayer.playerPoint,_playerArray[_loc3_].playerPoint);
               if(_playerArray[_loc3_].playerY > _selfPlayer.playerY && _loc2_ < 100)
               {
                  _playerArray[_loc3_].alpha = 0.5;
               }
               else
               {
                  _playerArray[_loc3_].alpha = 1;
               }
            }
            _loc3_++;
         }
      }
      
      protected function __onPlayerClick(param1:MouseEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:* = null;
         if(!this.touchable)
         {
            return;
         }
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("newhallsetplayertippos",[null]));
         if(_selfPlayer)
         {
            _loc3_ = 200;
            _loc2_ = this.globalToLocal(new Point(param1.stageX,param1.stageY));
            if(getTimer() - _lastClick > _loc3_)
            {
               _lastClick = getTimer();
               if(setSelfPlayerPos(_loc2_))
               {
                  MapClickFlag = true;
               }
            }
         }
      }
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void
      {
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("newhallsetplayertippos",[null]));
         var _loc2_:Point = this.globalToLocal(new Point(param1.data[0].stageX,param1.data[0].stageY));
         if(setSelfPlayerPos(_loc2_,true))
         {
            MapClickFlag = true;
         }
      }
      
      public function setSelfPlayerPos(param1:Point, param2:Boolean = true, param3:Boolean = false) : Boolean
      {
         if(_mouseMovie && _aStarPathFinder && !_aStarPathFinder.hit(param1))
         {
            param1 = setPlayerBorderPos(param1);
            _mouseMovie.visible = param2;
            _mouseMovie.x = param1.x;
            _mouseMovie.y = param1.y;
            _mouseMovie.play("stand");
            if(param3 && _selfPlayer.playerPoint && Point.distance(param1,_selfPlayer.playerPoint) < 50)
            {
               _selfPlayer.dispatchEvent(new NewHallEventStarling("newhallbtnclick"));
               return true;
            }
            _playerPos = param1;
            _selfPlayer.playerVO.walkPath = _aStarPathFinder.searchPath(_selfPlayer.playerPoint,param1);
            _selfPlayer.playerVO.currentWalkStartPoint = _selfPlayer.currentWalkStartPoint;
            return true;
         }
         return false;
      }
      
      public function setPlayerBorderPos(param1:Point) : Point
      {
         if(_mapID == 1 && _selfPlayer.playerVO.playerInfo.Grade <= 10)
         {
            if(param1.x < 1039)
            {
               param1.x = 1039;
            }
            if(param1.x > 2292)
            {
               param1.x = 2292;
            }
         }
         else
         {
            if(param1.x < 73)
            {
               param1.x = 73;
            }
            if(param1.x > _sceneMapGridData.bgImageW - 73)
            {
               param1.x = _sceneMapGridData.bgImageW - 73;
            }
         }
         return param1;
      }
      
      protected function __onFishWalk(param1:NewHallEventStarling) : void
      {
         var _loc2_:* = null;
         _mouseMovie.stop();
         _mouseMovie.visible = false;
         if(!MapClickFlag)
         {
            _loc2_ = StateManager.getState("main") as HallStateView;
            _loc2_.__onBtnClick();
         }
         MapClickFlag = false;
      }
      
      public function sendMyPosition(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         while(_loc3_ < param1.length)
         {
            _loc2_.push(int(param1[_loc3_].x),int(param1[_loc3_].y));
            _loc3_++;
         }
         SocketManager.Instance.out.sendPlayerPos(param1[param1.length - 1].x,param1[param1.length - 1].y);
      }
      
      protected function ajustScreen() : void
      {
         _selfPlayer.addEventListener("characterMovement",setCenter);
      }
      
      public function setCenter(param1:SceneCharacterEvent = null) : void
      {
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:HallStateView = StateManager.getState("main") as HallStateView;
         var _loc6_:int = StageReferance.stageWidth;
         var _loc2_:int = StageReferance.defaultHeight;
         if(_selfPlayer)
         {
            _loc7_ = -(_selfPlayer.x - _loc6_ / 2);
            _loc3_ = -(_selfPlayer.y - _loc2_ / 2) + 50;
         }
         if(_loc7_ > 0)
         {
            _loc7_ = 0;
         }
         if(_loc7_ < _loc6_ - _sceneMapGridData.bgImageW)
         {
            _loc7_ = _loc6_ - _sceneMapGridData.bgImageW;
         }
         if(_loc3_ > 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ < _loc2_ - _sceneMapGridData.bgImageH)
         {
            _loc3_ = _loc2_ - _sceneMapGridData.bgImageH;
         }
         if(_mapID == 1)
         {
            if(_loc7_ > -956)
            {
               _loc7_ = -956;
            }
            else if(_loc7_ < -1350)
            {
               _loc7_ = -1350;
            }
            this.x = _loc7_;
            return;
            §§push(_loc8_ && _loc8_.setBgSpriteCenter(this.x,this.y));
         }
         else
         {
            this.x = _loc7_;
            this.y = _loc3_;
            _loc8_ && _loc8_.setBgSpriteCenter(this.x,this.y);
            _staticLayer.checkAndPlay(-this.x,-this.x + _loc6_);
            if(!_hidFlag)
            {
               var _loc10_:int = 0;
               var _loc9_:* = _unLoadPlayerDic;
               for(var _loc5_ in _unLoadPlayerDic)
               {
                  if(_unLoadPlayerDic[_loc5_] && _unLoadPlayerDic[_loc5_].currentWalkStartPoint && judgePlayerShow(_unLoadPlayerDic[_loc5_].currentWalkStartPoint.x))
                  {
                     _loadPlayerDic[_unLoadPlayerDic[_loc5_].playerInfo.ID] = _unLoadPlayerDic[_loc5_];
                     delete _unLoadPlayerDic[_loc5_];
                  }
               }
            }
            var _loc12_:int = 0;
            var _loc11_:* = _loadPlayerDic;
            for(var _loc4_ in _loadPlayerDic)
            {
               if(_loadPlayerDic[_loc4_])
               {
                  startLoadOtherPlayer(false);
                  break;
               }
            }
            return;
         }
      }
      
      public function moveBgToTargetPos(param1:Number, param2:Number, param3:Number) : void
      {
         TweenLite.to(this,param3,{
            "x":param1,
            "y":param2,
            "ease":Linear.easeNone,
            "onUpdate":onMoveBgToTargetPosUpdate
         });
      }
      
      private function onMoveBgToTargetPosUpdate() : void
      {
         var _loc1_:HallStateView = StateManager.getState("main") as HallStateView;
      }
      
      public function getSelfPlayerPos() : Point
      {
         if(_selfPlayer)
         {
            return _selfPlayer.playerPoint;
         }
         return new Point(_playerPos.x,_playerPos.y);
      }
      
      private function getPlayerIndexById(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = -1;
         _loc3_ = 0;
         while(_loc3_ < _playerArray.length)
         {
            if(_playerArray[_loc3_].playerVO.playerInfo.ID == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__updateFrame);
         _mouseClickLayer.removeEventListener("click",__onPlayerClick);
         Starling.current.stage.removeEventListener("resize",onStageResize);
         PlayerManager.Instance.removeEventListener("setselfplayerpos",__onSetSelfPlayerPos);
         PlayerManager.Instance.removeEventListener("showPets",__onShowPets);
         SocketManager.Instance.removeEventListener("updatePlayerinfo",__updatePlayerDressInfo);
         SocketManager.Instance.removeEventListener("newhallupdatetitle",__updateTitle);
         SocketManager.Instance.removeEventListener(PkgEvent.format(262,0),__onFriendPlayerInfo);
         SocketManager.Instance.removeEventListener(PkgEvent.format(262,7),__onPlayerHid);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_selfPlayer)
         {
            _selfPlayer.removeEventListener("characterActionChange",playerActionChange);
            _selfPlayer.removeEventListener("newhallbtnclick",__onFishWalk);
            _selfPlayer = null;
         }
         if(_loadTimer)
         {
            _loadTimer.removeEventListener("timer",__onloadPlayerRes);
            _loadTimer.stop();
            _loadTimer.reset();
            _loadTimer = null;
         }
         if(_mouseMovie)
         {
            _mouseMovie.stop();
            _mouseMovie = null;
         }
         if(_mouseClickLayer)
         {
            ObjectUtils.disposeObject(_mouseClickLayer);
            _mouseClickLayer = null;
         }
         removePlayerByID();
         _friendPlayerDic = null;
         _playerArray = null;
         _loadPlayerDic = null;
         _unLoadPlayerDic = null;
         _loadPkg = null;
         _judgePos = null;
         _playerSprite = null;
         _sceneMapGridData = null;
         _aStarPathFinder.dispose();
         _aStarPathFinder = null;
         _staticLayer = null;
         super.dispose();
      }
      
      public function set mapID(param1:int) : void
      {
         _mapID = param1;
         if(_mapID == 1)
         {
            setCenter();
         }
      }
      
      public function get staticLayer() : StaticLayer
      {
         return _staticLayer;
      }
   }
}
