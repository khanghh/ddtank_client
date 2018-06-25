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
         var cloud:Image = StarlingMain.instance.createImage("demon_chi_you_scene_bg_cloud");
         cloud.x = 1824;
         cloud.y = 576;
         cloud.touchable = false;
         addChild(cloud);
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
         var senceLayer:SpriteLayer = LayerManager.Instance.getLayerByType(5);
         senceLayer.addChild(_mouseClickLayer);
         _bossClickSp = new flash.display.Sprite();
         _bossClickSp.buttonMode = true;
         drawBossClickLayer();
         senceLayer.addChild(_bossClickSp);
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
      
      private function onOtherEnter(evt:CEvent) : void
      {
         var pkg:PackageIn = evt.data as PackageIn;
         var playerVo:DemonChiYouPlayerVO = readPlayerInfoPkg(pkg);
         if(playerVo.playerInfo.ID != PlayerManager.Instance.Self.ID)
         {
            setPlayerInfo(playerVo);
         }
      }
      
      private function onOtherLeave(evt:CEvent) : void
      {
         var leavePlayerId:int = evt.data as int;
         removePlayerByID(leavePlayerId);
      }
      
      private function onBossEnd(evt:flash.events.Event) : void
      {
         if(DemonChiYouManager.instance.model.bossState == 4)
         {
            _boss.removeFromParent(true);
            ObjectUtils.disposeObject(_bossClickSp);
         }
      }
      
      private function onFightState(evt:PkgEvent) : void
      {
         var player:* = null;
         var pkg:PackageIn = evt.pkg;
         var playerId:int = pkg.readInt();
         var isFight:Boolean = pkg.readBoolean();
         if(playerId != PlayerManager.Instance.Self.ID)
         {
            player = _friendPlayerDic[playerId];
            player && player.showFightState(isFight);
         }
      }
      
      private function onBossClick(evt:MouseEvent) : void
      {
         var _clickBossInterval:int = 3000;
         var nowTime:int = getTimer();
         if(nowTime - _lastClickBoss > _clickBossInterval)
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
            _lastClickBoss = nowTime;
         }
      }
      
      private function onStageResize(evt:ResizeEvent) : void
      {
         drawMouseClickLayer();
      }
      
      protected function __onShowPets(event:NewHallEvent) : void
      {
         if(!_selfPlayer)
         {
         }
      }
      
      protected function __onFriendPlayerInfo(event:PkgEvent) : void
      {
         var i:int = 0;
         var playerVo:* = null;
         var pkg:PackageIn = event.pkg;
         var playerNum:int = pkg.readInt();
         _loadPkg = pkg;
         _loadPlayerDic = new Dictionary();
         _unLoadPlayerDic = new Dictionary();
         removePlayerByID();
         var bytePos:int = pkg.position;
         playerNum = playerNum < 50?playerNum:50;
         for(i = 0; i < playerNum; )
         {
            playerVo = readPlayerInfoPkg(_loadPkg);
            playerVo.isFight = _loadPkg.readBoolean();
            if(playerVo.playerInfo.ID != PlayerManager.Instance.Self.ID)
            {
               _unLoadPlayerDic[playerVo.playerInfo.ID] = playerVo;
            }
            i++;
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
      
      private function startLoadOtherPlayer(flag:Boolean = true) : void
      {
         if(flag && !this.hasEventListener("enterFrame"))
         {
            addEventListener("enterFrame",__updateFrame);
         }
         if(_loadTimer && !_loadTimer.running)
         {
            _loadTimer.start();
         }
      }
      
      protected function __onloadPlayerRes(event:TimerEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _loadPlayerDic;
         for(var id in _loadPlayerDic)
         {
            if(_loadPlayerDic[id])
            {
               setPlayerInfo(_loadPlayerDic[id]);
               delete _loadPlayerDic[id];
            }
         }
         if(id == null)
         {
            _loadTimer.stop();
            _loadTimer.reset();
         }
      }
      
      private function getRandNum(a:int, b:int) : int
      {
         var ranNum:int = a + (b - a) * Math.random();
         return ranNum;
      }
      
      protected function __onPlayerHid(event:PkgEvent) : void
      {
      }
      
      protected function __updateTitle(event:NewHallEvent) : void
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
      
      protected function __updatePlayerDressInfo(event:PlayerDressEvent) : void
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
         var selfPlayerVO:PlayerVO = new PlayerVO();
         selfPlayerVO.playerInfo = PlayerManager.Instance.Self;
         _selfPlayer = new DemonChiYouHallPlayer(selfPlayerVO);
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
      
      private function readPlayerInfoPkg(pkg:PackageIn) : DemonChiYouPlayerVO
      {
         var friendVo:DemonChiYouPlayerVO = new DemonChiYouPlayerVO();
         friendVo.playerInfo = new PlayerInfo();
         friendVo.playerInfo.ID = pkg.readInt();
         friendVo.playerInfo.NickName = pkg.readUTF();
         friendVo.playerInfo.VIPLevel = pkg.readInt();
         friendVo.playerInfo.typeVIP = pkg.readInt();
         friendVo.playerInfo.Sex = pkg.readBoolean();
         friendVo.playerInfo.Style = pkg.readUTF();
         friendVo.playerInfo.Colors = pkg.readUTF();
         friendVo.playerInfo.Skin = pkg.readUTF();
         friendVo.playerInfo.MountsType = pkg.readInt();
         friendVo.playerInfo.PetsID = pkg.readInt();
         initFriendVo(friendVo);
         pkg.position = pkg.position + 8;
         friendVo.playerInfo.ConsortiaID = pkg.readInt();
         friendVo.playerInfo.badgeID = pkg.readInt();
         friendVo.playerInfo.ConsortiaName = pkg.readUTF();
         friendVo.playerInfo.honor = pkg.readUTF();
         friendVo.playerInfo.honorId = pkg.readInt();
         friendVo.playerInfo.isAttest = pkg.readBoolean();
         friendVo.playerInfo.ImagePath = pkg.readUTF();
         friendVo.playerInfo.IsShow = pkg.readBoolean();
         return friendVo;
      }
      
      private function initFriendVo(friendVo:PlayerVO) : void
      {
         var startPointIndex:int = 2 * 1 * Math.random();
         var endPointIndex:int = getEndPointIndex(startPointIndex);
         friendVo.randomStartPointIndex = startPointIndex;
         friendVo.randomEndPointIndex = endPointIndex;
         var walkPath:Array = getPointPath(startPointIndex,endPointIndex);
         friendVo.currentWalkStartPoint = walkPath[0];
         walkPath.unshift();
         friendVo.walkPath = walkPath;
      }
      
      private function getEndPointIndex(startPointIndex:int) : int
      {
         var dir:int = 0;
         var col:int = startPointIndex / 1;
         if(col == 2 - 1)
         {
            dir = -1;
         }
         else if(col == 0)
         {
            dir = 1;
         }
         else
         {
            dir = Math.random() > 0.5?1:-1;
         }
         var newEndPointIndex:int = (col + dir) * 1 + int(Math.random() * 1);
         return newEndPointIndex;
      }
      
      private function getPointPath(newStartPointIndex:int, newEndPointIndex:int) : Array
      {
         var path:* = null;
         var i:int = 0;
         var pointPath:Array = [];
         if(newStartPointIndex < newEndPointIndex)
         {
            path = randomPathMap[newStartPointIndex + "_" + newEndPointIndex];
            for(i = 0; i < path.length / 2; )
            {
               pointPath.push(new Point(path[i * 2],path[i * 2 + 1]));
               i++;
            }
         }
         else
         {
            path = randomPathMap[newEndPointIndex + "_" + newStartPointIndex];
            for(i = path.length / 2 - 1; i > -1; )
            {
               pointPath.push(new Point(path[i * 2],path[i * 2 + 1]));
               i--;
            }
         }
         return pointPath;
      }
      
      private function setPlayerInfo(friendVo:DemonChiYouPlayerVO, deleteFlag:Boolean = false) : void
      {
         if(deleteFlag)
         {
            removePlayerByID(friendVo.playerInfo.ID);
         }
         var friendPlayer:DemonChiYouHallPlayer = new DemonChiYouHallPlayer(friendVo);
         friendPlayer.playerPoint = friendPlayer.playerVO.currentWalkStartPoint;
         if(!_hidFlag)
         {
            friendPlayer.showFightState(friendVo.isFight);
         }
         if(getPlayerIndexById(friendPlayer.playerVO.playerInfo.ID) == -1)
         {
            _playerSprite.addChild(friendPlayer);
            _playerArray.push(friendPlayer);
         }
         friendPlayer.isHideTitle = true;
         _friendPlayerDic[friendPlayer.playerVO.playerInfo.ID] = friendPlayer;
      }
      
      private function removePlayerByID(id:int = 0) : void
      {
         var hallPlayer:* = null;
         var index:int = 0;
         if(id != 0)
         {
            if(_friendPlayerDic[id])
            {
               hallPlayer = _friendPlayerDic[id];
               if(_playerSprite.contains(hallPlayer))
               {
                  _playerSprite.removeChild(hallPlayer);
               }
               index = getPlayerIndexById(hallPlayer.playerVO.playerInfo.ID);
               if(index != -1)
               {
                  _playerArray.splice(index,1);
               }
               delete _friendPlayerDic[id];
               hallPlayer.dispose();
               hallPlayer = null;
            }
         }
         else
         {
            var _loc6_:int = 0;
            var _loc5_:* = _friendPlayerDic;
            for(var key in _friendPlayerDic)
            {
               hallPlayer = _friendPlayerDic[key];
               if(_playerSprite.contains(hallPlayer))
               {
                  _playerSprite.removeChild(hallPlayer);
               }
               hallPlayer.dispose();
               hallPlayer = null;
            }
            _playerArray.splice(0,_playerArray.length);
            if(_selfPlayer)
            {
               _playerArray.push(_selfPlayer);
            }
            _friendPlayerDic = new Dictionary();
         }
      }
      
      private function addPlayerCallBack(hallPlayer:DemonChiYouHallPlayer) : void
      {
         if(!hallPlayer)
         {
            return;
         }
         if(hallPlayer.playerVO.playerInfo.ID == PlayerManager.Instance.Self.ID)
         {
            _selfPlayer = hallPlayer;
            _selfPlayer.playerPoint = _playerPos;
            if(NewTitleManager.instance.ShowTitle)
            {
               hallPlayer.isHideTitle = true;
            }
            else
            {
               hallPlayer.isHideTitle = false;
            }
            _playerSprite.addChild(_selfPlayer);
            ajustScreen();
            setCenter();
            _selfPlayer.addEventListener("characterActionChange",playerActionChange);
            startLoadOtherPlayer();
         }
      }
      
      public function set type(value:String) : void
      {
         _selfPlayer.sceneCharacterActionState = value;
      }
      
      private function playerActionChange(evt:SceneCharacterEvent) : void
      {
         var type:String = evt.data.toString();
         if(type == "standFront" || type == "standBack")
         {
         }
      }
      
      protected function __updateFrame(event:starling.events.Event) : void
      {
         var i:int = 0;
         var dis:Number = NaN;
         if(!_playerArray)
         {
            removeEventListener("enterFrame",__updateFrame);
            return;
         }
         _playerArray.sortOn("playerY",16);
         for(i = 0; i < _playerArray.length; )
         {
            if(_playerArray[i])
            {
               if(_playerArray[i].parent == null)
               {
                  _playerSprite.addChild(_playerArray[i]);
               }
               _playerSprite.setChildIndex(_playerArray[i],i);
               _playerArray[i].updatePlayer();
               dis = Point.distance(_selfPlayer.playerPoint,_playerArray[i].playerPoint);
               if(_playerArray[i].playerY > _selfPlayer.playerY && dis < 100)
               {
                  _playerArray[i].alpha = 0.5;
               }
               else
               {
                  _playerArray[i].alpha = 1;
               }
            }
            i++;
         }
      }
      
      protected function __onPlayerClick(event:MouseEvent) : void
      {
         var clickInterval:Number = NaN;
         var targetPoint:* = null;
         if(!this.touchable)
         {
            return;
         }
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("newhallsetplayertippos",[null]));
         if(_selfPlayer)
         {
            clickInterval = 200;
            targetPoint = this.globalToLocal(new Point(event.stageX,event.stageY));
            if(getTimer() - _lastClick > clickInterval)
            {
               _lastClick = getTimer();
               if(setSelfPlayerPos(targetPoint))
               {
                  MapClickFlag = true;
               }
            }
         }
      }
      
      protected function __onSetSelfPlayerPos(event:NewHallEvent) : void
      {
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("newhallsetplayertippos",[null]));
         var targetPoint:Point = this.globalToLocal(new Point(event.data[0].stageX,event.data[0].stageY));
         if(setSelfPlayerPos(targetPoint,true))
         {
            MapClickFlag = true;
         }
      }
      
      public function setSelfPlayerPos(pos:Point, mouseFlag:Boolean = true) : Boolean
      {
         var currClickTime:int = 0;
         if(_aStarPathFinder && !_aStarPathFinder.hit(pos))
         {
            pos = setPlayerBorderPos(pos);
            _mouseMovie.visible = mouseFlag;
            _mouseMovie.x = pos.x;
            _mouseMovie.y = pos.y;
            _mouseMovie.play("stand");
            _playerPos = pos;
            _selfPlayer.playerVO.walkPath = _aStarPathFinder.searchPath(_selfPlayer.playerPoint,pos);
            _selfPlayer.playerVO.currentWalkStartPoint = _selfPlayer.currentWalkStartPoint;
            currClickTime = getTimer();
            if(currClickTime - _lastClickTime > 1000)
            {
               _lastClickTime = currClickTime;
            }
            return true;
         }
         return false;
      }
      
      public function setPlayerBorderPos(pos:Point) : Point
      {
         if(pos.x < 73)
         {
            pos.x = 73;
         }
         if(pos.x > _sceneMapGridData.bgImageW - 73)
         {
            pos.x = _sceneMapGridData.bgImageW - 73;
         }
         return pos;
      }
      
      protected function __onFishWalk(event:NewHallEventStarling) : void
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
         var result:Boolean = true;
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.showAlert();
            result = false;
         }
         return result;
      }
      
      protected function ajustScreen() : void
      {
         _selfPlayer.addEventListener("characterMovement",setCenter);
      }
      
      public function setCenter(event:SceneCharacterEvent = null) : void
      {
         var xf:int = 0;
         var yf:int = 0;
         var width:int = StageReferance.stageWidth;
         var height:int = StageReferance.defaultHeight;
         if(_selfPlayer)
         {
            xf = -(_selfPlayer.x - width / 2);
            yf = -(_selfPlayer.y - height / 2) + 50;
         }
         if(xf > 0)
         {
            xf = 0;
         }
         if(xf < width - _sceneMapGridData.bgImageW)
         {
            xf = width - _sceneMapGridData.bgImageW;
         }
         if(yf > 0)
         {
            yf = 0;
         }
         if(yf < height - _sceneMapGridData.bgImageH)
         {
            yf = height - _sceneMapGridData.bgImageH;
         }
         this.x = xf;
         this.y = yf;
         _bossClickSp.x = xf + 1800;
         _bossClickSp.y = yf + 310;
         if(!_hidFlag)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _unLoadPlayerDic;
            for(var id1 in _unLoadPlayerDic)
            {
               if(_unLoadPlayerDic[id1] && _unLoadPlayerDic[id1].currentWalkStartPoint)
               {
                  _loadPlayerDic[_unLoadPlayerDic[id1].playerInfo.ID] = _unLoadPlayerDic[id1];
                  delete _unLoadPlayerDic[id1];
               }
            }
         }
         var _loc11_:int = 0;
         var _loc10_:* = _loadPlayerDic;
         for(var id2 in _loadPlayerDic)
         {
            if(_loadPlayerDic[id2])
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
      
      private function getPlayerIndexById(id:int) : int
      {
         var i:int = 0;
         var index:* = -1;
         for(i = 0; i < _playerArray.length; )
         {
            if(_playerArray[i].playerVO.playerInfo.ID == id)
            {
               index = i;
               break;
            }
            i++;
         }
         return index;
      }
      
      public function getRomdonPos() : Point
      {
         var node:* = null;
         var row:int = 0;
         var col:int = 0;
         var grid:Grid = _aStarPathFinder.grid;
         var numRows:int = grid.numRows;
         var numCols:int = grid.numCols;
         var nodeArr:Array = [];
         for(row = 0; row < numRows; )
         {
            for(col = 0; col < numCols; )
            {
               node = grid.getNode(col,row);
               if(node.walkable)
               {
                  nodeArr.push(node);
               }
               col++;
            }
            row++;
         }
         var randomIndex:int = Math.random() * nodeArr.length;
         node = nodeArr[randomIndex];
         return new Point(node.x * grid.nodeW,node.y * grid.nodeH);
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
      
      public function set mapID(value:int) : void
      {
         _mapID = value;
         if(_mapID == 1)
         {
            setCenter();
         }
      }
   }
}
