package starling.scene.demonChiYou
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.SpriteLayer;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import demonChiYou.DemonChiYouManager;
   import demonChiYou.DemonChiYouPlayerVO;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import hall.aStar.AStarPathFinder;
   import hall.event.NewHallEvent;
   import hall.player.aStar.Grid;
   import hall.player.aStar.Node;
   import hall.player.vo.PlayerVO;
   import newTitle.NewTitleManager;
   import playerDress.event.PlayerDressEvent;
   import road7th.StarlingMain;
   import road7th.comm.PackageIn;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.display.sceneCharacter.event.SceneCharacterEvent;
   import starling.events.ResizeEvent;
   import starling.scene.hall.SceneMapGridData;
   import starling.scene.hall.event.NewHallEventStarling;
   
   public class PlayerView extends starling.display.Sprite
   {
       
      
      private const randomPathX:int = 2;
      
      private const randomPathY:int = 1;
      
      private const randomPathMap:Object = {"0_1":[965,1038,1935,1247]};
      
      private const WALK_TO_BOSS_POS:Point = new Point(1659,700);
      
      public var MapClickFlag:Boolean;
      
      private var _playerSprite:starling.display.Sprite;
      
      private var _selfPlayer:DemonChiYouHallPlayer;
      
      private var _friendPlayerDic:Dictionary;
      
      private var _playerArray:Array;
      
      private var _lastClickTime:int = 0;
      
      private var _playerPos:Point;
      
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
      
      private var _mouseClickLayer:flash.display.Sprite;
      
      private var _staticLayer:StaticLayer;
      
      private var _boss:BoneMovieFastStarling;
      
      private var _bossClickSp:flash.display.Sprite;
      
      private var _lastClickBoss:int = 0;
      
      public function PlayerView()
      {
         super();
         _staticLayer = new StaticLayer();
         _staticLayer.touchable = false;
         addChild(_staticLayer);
         _playerSprite = new starling.display.Sprite();
         addChild(_playerSprite);
         _boss = BoneMovieFactory.instance.creatBoneMovieFast("demon_chi_you_boss");
         _boss.x = 2036;
         _boss.y = 653;
         _boss.touchable = false;
         addChild(_boss);
         var _loc2_:Image = StarlingMain.instance.createImage("demon_chi_you_scene_bg_cloud");
         _loc2_.x = 1824;
         _loc2_.y = 576;
         _loc2_.touchable = false;
         addChild(_loc2_);
         _friendPlayerDic = new Dictionary();
         _playerArray = [];
         _loadTimer = new Timer(1500);
         _loadTimer.addEventListener("timer",__onloadPlayerRes);
         _sceneMapGridData = ComponentFactory.Instance.creatCustomObject("demonChiYou.map.SceneMapGridData");
         _aStarPathFinder = new AStarPathFinder();
         _aStarPathFinder.init(_sceneMapGridData);
         _playerPos = getRomdonPos();
         _mouseClickLayer = new flash.display.Sprite();
         drawMouseClickLayer();
         var _loc1_:SpriteLayer = LayerManager.Instance.getLayerByType(5);
         _loc1_.addChild(_mouseClickLayer);
         _bossClickSp = new flash.display.Sprite();
         _bossClickSp.buttonMode = true;
         drawBossClickLayer();
         _loc1_.addChild(_bossClickSp);
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
      
      private function drawBossClickLayer() : void
      {
         _bossClickSp.graphics.clear();
         _bossClickSp.graphics.beginFill(0,0);
         _bossClickSp.graphics.drawRect(0,0,400,400);
         _bossClickSp.graphics.endFill();
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.getDemonChiYouOtherPlayerInfo();
      }
      
      private function initEvent() : void
      {
         _mouseClickLayer.addEventListener("click",__onPlayerClick);
         _bossClickSp.addEventListener("click",onBossClick);
         Starling.current.stage.addEventListener("resize",onStageResize);
         PlayerManager.Instance.addEventListener("setselfplayerpos",__onSetSelfPlayerPos);
         SocketManager.Instance.addEventListener(PkgEvent.format(314,1),__onFriendPlayerInfo);
         DemonChiYouManager.instance.addEventListener("event_other_player_enter",onOtherEnter);
         DemonChiYouManager.instance.addEventListener("event_other_player_leave",onOtherLeave);
         DemonChiYouManager.instance.addEventListener("event_boss_end",onBossEnd);
         SocketManager.Instance.addEventListener(PkgEvent.format(314,13),onFightState);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__updateFrame);
         _mouseClickLayer.removeEventListener("click",__onPlayerClick);
         _bossClickSp.removeEventListener("click",onBossClick);
         Starling.current.stage.removeEventListener("resize",onStageResize);
         PlayerManager.Instance.removeEventListener("setselfplayerpos",__onSetSelfPlayerPos);
         SocketManager.Instance.removeEventListener(PkgEvent.format(314,1),__onFriendPlayerInfo);
         DemonChiYouManager.instance.removeEventListener("event_other_player_enter",onOtherEnter);
         DemonChiYouManager.instance.removeEventListener("event_other_player_leave",onOtherLeave);
         DemonChiYouManager.instance.removeEventListener("event_boss_end",onBossEnd);
         SocketManager.Instance.removeEventListener(PkgEvent.format(314,13),onFightState);
      }
      
      private function onOtherEnter(param1:CEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DemonChiYouPlayerVO = readPlayerInfoPkg(_loc3_);
         if(_loc2_.playerInfo.ID != PlayerManager.Instance.Self.ID)
         {
            setPlayerInfo(_loc2_);
         }
      }
      
      private function onOtherLeave(param1:CEvent) : void
      {
         var _loc2_:int = param1.data as int;
         removePlayerByID(_loc2_);
      }
      
      private function onBossEnd(param1:flash.events.Event) : void
      {
         if(DemonChiYouManager.instance.model.bossState == 4)
         {
            _boss.removeFromParent(true);
            ObjectUtils.disposeObject(_bossClickSp);
         }
      }
      
      private function onFightState(param1:PkgEvent) : void
      {
         var _loc2_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         var _loc3_:int = _loc5_.readInt();
         var _loc4_:Boolean = _loc5_.readBoolean();
         if(_loc3_ != PlayerManager.Instance.Self.ID)
         {
            _loc2_ = _friendPlayerDic[_loc3_];
            _loc2_ && _loc2_.showFightState(_loc4_);
         }
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 3000;
         var _loc2_:int = getTimer();
         if(_loc2_ - _lastClickBoss > _loc3_)
         {
            if(checkDistance())
            {
               SoundManager.instance.play("008");
               startGame();
            }
            else
            {
               SoundManager.instance.play("047");
               MapClickFlag = false;
               setSelfPlayerPos(new Point(WALK_TO_BOSS_POS.x,WALK_TO_BOSS_POS.y),false);
            }
            _lastClickBoss = _loc2_;
         }
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
         var _loc2_:int = _loc5_.readInt();
         _loadPkg = _loc5_;
         _loadPlayerDic = new Dictionary();
         _unLoadPlayerDic = new Dictionary();
         removePlayerByID();
         var _loc4_:int = _loc5_.position;
         _loc2_ = _loc2_ < 50?_loc2_:50;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc3_ = readPlayerInfoPkg(_loadPkg);
            _loc3_.isFight = _loadPkg.readBoolean();
            if(_loc3_.playerInfo.ID != PlayerManager.Instance.Self.ID)
            {
               _unLoadPlayerDic[_loc3_.playerInfo.ID] = _loc3_;
            }
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
            _mouseMovie.stop();
            _mouseMovie.visible = false;
            _mouseMovie.touchable = false;
            addChild(_mouseMovie);
         }
         var _loc1_:PlayerVO = new PlayerVO();
         _loc1_.playerInfo = PlayerManager.Instance.Self;
         _selfPlayer = new DemonChiYouHallPlayer(_loc1_);
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
      
      private function readPlayerInfoPkg(param1:PackageIn) : DemonChiYouPlayerVO
      {
         var _loc2_:DemonChiYouPlayerVO = new DemonChiYouPlayerVO();
         _loc2_.playerInfo = new PlayerInfo();
         _loc2_.playerInfo.ID = param1.readInt();
         _loc2_.playerInfo.NickName = param1.readUTF();
         _loc2_.playerInfo.VIPLevel = param1.readInt();
         _loc2_.playerInfo.typeVIP = param1.readInt();
         _loc2_.playerInfo.Sex = param1.readBoolean();
         _loc2_.playerInfo.Style = param1.readUTF();
         _loc2_.playerInfo.Colors = param1.readUTF();
         _loc2_.playerInfo.Skin = param1.readUTF();
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
         var _loc4_:int = 2 * 1 * Math.random();
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
         var _loc2_:int = param1 / 1;
         if(_loc2_ == 2 - 1)
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
         var _loc4_:int = (_loc2_ + _loc3_) * 1 + int(Math.random() * 1);
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
      
      private function setPlayerInfo(param1:DemonChiYouPlayerVO, param2:Boolean = false) : void
      {
         if(param2)
         {
            removePlayerByID(param1.playerInfo.ID);
         }
         var _loc3_:DemonChiYouHallPlayer = new DemonChiYouHallPlayer(param1);
         _loc3_.playerPoint = _loc3_.playerVO.currentWalkStartPoint;
         if(!_hidFlag)
         {
            _loc3_.showFightState(param1.isFight);
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
               _loc3_.dispose();
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
      
      private function addPlayerCallBack(param1:DemonChiYouHallPlayer) : void
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
      
      protected function __updateFrame(param1:starling.events.Event) : void
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
      
      public function setSelfPlayerPos(param1:Point, param2:Boolean = true) : Boolean
      {
         var _loc3_:int = 0;
         if(_aStarPathFinder && !_aStarPathFinder.hit(param1))
         {
            param1 = setPlayerBorderPos(param1);
            _mouseMovie.visible = param2;
            _mouseMovie.x = param1.x;
            _mouseMovie.y = param1.y;
            _mouseMovie.play("stand");
            _playerPos = param1;
            _selfPlayer.playerVO.walkPath = _aStarPathFinder.searchPath(_selfPlayer.playerPoint,param1);
            _selfPlayer.playerVO.currentWalkStartPoint = _selfPlayer.currentWalkStartPoint;
            _loc3_ = getTimer();
            if(_loc3_ - _lastClickTime > 1000)
            {
               _lastClickTime = _loc3_;
            }
            return true;
         }
         return false;
      }
      
      public function setPlayerBorderPos(param1:Point) : Point
      {
         if(param1.x < 73)
         {
            param1.x = 73;
         }
         if(param1.x > _sceneMapGridData.bgImageW - 73)
         {
            param1.x = _sceneMapGridData.bgImageW - 73;
         }
         return param1;
      }
      
      protected function __onFishWalk(param1:NewHallEventStarling) : void
      {
         _mouseMovie.stop();
         _mouseMovie.visible = false;
         if(!MapClickFlag)
         {
            startGame();
         }
         MapClickFlag = false;
      }
      
      private function startGame() : void
      {
         CheckWeaponManager.instance.setFunction(this,startGame);
         if(checkCanStartGame())
         {
            GameInSocketOut.sendSingleRoomBegin(21);
         }
      }
      
      private function checkDistance() : Boolean
      {
         return (_selfPlayer.x - WALK_TO_BOSS_POS.x) * (_selfPlayer.x - WALK_TO_BOSS_POS.x) + (_selfPlayer.y - WALK_TO_BOSS_POS.y) * (_selfPlayer.y - WALK_TO_BOSS_POS.y) < 62500;
      }
      
      private function checkCanStartGame() : Boolean
      {
         var _loc1_:Boolean = true;
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.showAlert();
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      protected function ajustScreen() : void
      {
         _selfPlayer.addEventListener("characterMovement",setCenter);
      }
      
      public function setCenter(param1:SceneCharacterEvent = null) : void
      {
         var _loc7_:int = 0;
         var _loc3_:int = 0;
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
         this.x = _loc7_;
         this.y = _loc3_;
         _bossClickSp.x = _loc7_ + 1800;
         _bossClickSp.y = _loc3_ + 310;
         if(!_hidFlag)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _unLoadPlayerDic;
            for(var _loc5_ in _unLoadPlayerDic)
            {
               if(_unLoadPlayerDic[_loc5_] && _unLoadPlayerDic[_loc5_].currentWalkStartPoint)
               {
                  _loadPlayerDic[_unLoadPlayerDic[_loc5_].playerInfo.ID] = _unLoadPlayerDic[_loc5_];
                  delete _unLoadPlayerDic[_loc5_];
               }
            }
         }
         var _loc11_:int = 0;
         var _loc10_:* = _loadPlayerDic;
         for(var _loc4_ in _loadPlayerDic)
         {
            if(_loadPlayerDic[_loc4_])
            {
               startLoadOtherPlayer(false);
               break;
            }
         }
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
      
      public function getRomdonPos() : Point
      {
         var _loc2_:* = null;
         var _loc7_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:Grid = _aStarPathFinder.grid;
         var _loc5_:int = _loc4_.numRows;
         var _loc8_:int = _loc4_.numCols;
         var _loc3_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc8_)
            {
               _loc2_ = _loc4_.getNode(_loc1_,_loc7_);
               if(_loc2_.walkable)
               {
                  _loc3_.push(_loc2_);
               }
               _loc1_++;
            }
            _loc7_++;
         }
         var _loc6_:int = Math.random() * _loc3_.length;
         _loc2_ = _loc3_[_loc6_];
         return new Point(_loc2_.x * _loc4_.nodeW,_loc2_.y * _loc4_.nodeH);
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
            StarlingObjectUtils.disposeObject(_mouseMovie);
            _mouseMovie = null;
         }
         if(_mouseClickLayer)
         {
            ObjectUtils.disposeObject(_mouseClickLayer);
            _mouseClickLayer = null;
         }
         if(_bossClickSp)
         {
            ObjectUtils.disposeObject(_bossClickSp);
            _bossClickSp = null;
         }
         removePlayerByID();
         _friendPlayerDic = null;
         _playerArray = null;
         _loadPlayerDic = null;
         _unLoadPlayerDic = null;
         _playerPos = null;
         _loadPkg = null;
         _judgePos = null;
         _playerSprite = null;
         _sceneMapGridData = null;
         _aStarPathFinder.dispose();
         _aStarPathFinder = null;
         _staticLayer = null;
         _boss = null;
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
   }
}
