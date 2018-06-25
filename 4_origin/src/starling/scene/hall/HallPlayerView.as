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
         var senceLayer:SpriteLayer = LayerManager.Instance.getLayerByType(5);
         senceLayer.addChild(_mouseClickLayer);
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
         pkg.readInt();
         pkg.readInt();
         var playerNum:int = pkg.readInt();
         _loadPkg = pkg;
         _loadPlayerDic = new Dictionary();
         _unLoadPlayerDic = new Dictionary();
         removePlayerByID();
         var bytePos:int = pkg.position;
         for(i = 0; i < playerNum; )
         {
            playerVo = readPlayerInfoPkg(_loadPkg);
            _unLoadPlayerDic[playerVo.playerInfo.ID] = playerVo;
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
      
      private function judgePlayerShow(playerX:int) : Boolean
      {
         _judgePos = PositionUtils.creatPoint("hall.playerInfoPos");
         var offX:int = playerX + this.x;
         if(offX > _judgePos.x && offX < _judgePos.y)
         {
            return true;
         }
         return false;
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
         var pkg:PackageIn = event.pkg;
         var frameID:int = 2;
         _hidFlag = pkg.readBoolean();
         if(_hidFlag)
         {
            removePlayerByID();
            _loadPlayerDic = new Dictionary();
            _unLoadPlayerDic = new Dictionary();
            frameID = 1;
            if(_loadTimer != null)
            {
               _loadTimer.stop();
               _loadTimer.reset();
            }
         }
         DailyButtunBar.Insance.setEyeBtnFrame(frameID);
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
            _mouseMovie.touchable = false;
            _mouseMovie.stop();
            _mouseMovie.visible = false;
            addChild(_mouseMovie);
         }
         var selfPlayerVO:PlayerVO = new PlayerVO();
         selfPlayerVO.playerInfo = PlayerManager.Instance.Self;
         _selfPlayer = new HallPlayer(selfPlayerVO);
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
      
      private function readPlayerInfoPkg(pkg:PackageIn) : PlayerVO
      {
         var friendVo:PlayerVO = new PlayerVO();
         friendVo.playerInfo = new PlayerInfo();
         friendVo.playerInfo.ID = pkg.readInt();
         friendVo.playerInfo.NickName = pkg.readUTF();
         friendVo.playerInfo.VIPLevel = pkg.readInt();
         friendVo.playerInfo.typeVIP = pkg.readInt();
         friendVo.playerInfo.Sex = pkg.readBoolean();
         friendVo.playerInfo.Style = pkg.readUTF();
         friendVo.playerInfo.Colors = pkg.readUTF();
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
         var startPointIndex:int = 4 * 3 * Math.random();
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
         var col:int = startPointIndex / 3;
         if(col == 4 - 1)
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
         var newEndPointIndex:int = (col + dir) * 3 + int(Math.random() * 3);
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
      
      private function setPlayerInfo(friendVo:PlayerVO, deleteFlag:Boolean = false) : void
      {
         if(deleteFlag)
         {
            removePlayerByID(friendVo.playerInfo.ID);
         }
         var friendPlayer:HallPlayer = new HallPlayer(friendVo);
         friendPlayer.playerPoint = friendPlayer.playerVO.currentWalkStartPoint;
         if(!_hidFlag)
         {
            friendPlayer.startRandomWalk(4,3,randomPathMap);
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
               StarlingObjectUtils.disposeObject(hallPlayer);
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
      
      private function addPlayerCallBack(hallPlayer:HallPlayer) : void
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
      
      protected function __updateFrame(event:Event) : void
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
               _playerArray[i].visible = judgePlayerShow(_playerArray[i].playerPoint.x);
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
      
      public function setSelfPlayerPos(pos:Point, mouseFlag:Boolean = true, isNpcPos:Boolean = false) : Boolean
      {
         if(_mouseMovie && _aStarPathFinder && !_aStarPathFinder.hit(pos))
         {
            pos = setPlayerBorderPos(pos);
            _mouseMovie.visible = mouseFlag;
            _mouseMovie.x = pos.x;
            _mouseMovie.y = pos.y;
            _mouseMovie.play("stand");
            if(isNpcPos && _selfPlayer.playerPoint && Point.distance(pos,_selfPlayer.playerPoint) < 50)
            {
               _selfPlayer.dispatchEvent(new NewHallEventStarling("newhallbtnclick"));
               return true;
            }
            _playerPos = pos;
            _selfPlayer.playerVO.walkPath = _aStarPathFinder.searchPath(_selfPlayer.playerPoint,pos);
            _selfPlayer.playerVO.currentWalkStartPoint = _selfPlayer.currentWalkStartPoint;
            return true;
         }
         return false;
      }
      
      public function setPlayerBorderPos(pos:Point) : Point
      {
         if(_mapID == 1 && _selfPlayer.playerVO.playerInfo.Grade <= 10)
         {
            if(pos.x < 1039)
            {
               pos.x = 1039;
            }
            if(pos.x > 2292)
            {
               pos.x = 2292;
            }
         }
         else
         {
            if(pos.x < 73)
            {
               pos.x = 73;
            }
            if(pos.x > _sceneMapGridData.bgImageW - 73)
            {
               pos.x = _sceneMapGridData.bgImageW - 73;
            }
         }
         return pos;
      }
      
      protected function __onFishWalk(event:NewHallEventStarling) : void
      {
         var hallStateView:* = null;
         _mouseMovie.stop();
         _mouseMovie.visible = false;
         if(!MapClickFlag)
         {
            hallStateView = StateManager.getState("main") as HallStateView;
            hallStateView.__onBtnClick();
         }
         MapClickFlag = false;
      }
      
      public function sendMyPosition(p:Array) : void
      {
         var i:int = 0;
         var arr:Array = [];
         while(i < p.length)
         {
            arr.push(int(p[i].x),int(p[i].y));
            i++;
         }
         SocketManager.Instance.out.sendPlayerPos(p[p.length - 1].x,p[p.length - 1].y);
      }
      
      protected function ajustScreen() : void
      {
         _selfPlayer.addEventListener("characterMovement",setCenter);
      }
      
      public function setCenter(event:SceneCharacterEvent = null) : void
      {
         var xf:int = 0;
         var yf:int = 0;
         var hallStateView:HallStateView = StateManager.getState("main") as HallStateView;
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
         if(_mapID == 1)
         {
            if(xf > -956)
            {
               xf = -956;
            }
            else if(xf < -1350)
            {
               xf = -1350;
            }
            this.x = xf;
            hallStateView && hallStateView.setBgSpriteCenter(this.x,this.y);
            return;
         }
         this.x = xf;
         this.y = yf;
         hallStateView && hallStateView.setBgSpriteCenter(this.x,this.y);
         _staticLayer.checkAndPlay(-this.x,-this.x + width);
         if(!_hidFlag)
         {
            var _loc10_:int = 0;
            var _loc9_:* = _unLoadPlayerDic;
            for(var id1 in _unLoadPlayerDic)
            {
               if(_unLoadPlayerDic[id1] && _unLoadPlayerDic[id1].currentWalkStartPoint && judgePlayerShow(_unLoadPlayerDic[id1].currentWalkStartPoint.x))
               {
                  _loadPlayerDic[_unLoadPlayerDic[id1].playerInfo.ID] = _unLoadPlayerDic[id1];
                  delete _unLoadPlayerDic[id1];
               }
            }
         }
         var _loc12_:int = 0;
         var _loc11_:* = _loadPlayerDic;
         for(var id2 in _loadPlayerDic)
         {
            if(_loadPlayerDic[id2])
            {
               startLoadOtherPlayer(false);
               break;
            }
         }
      }
      
      public function moveBgToTargetPos(posX:Number, posY:Number, delay:Number) : void
      {
         TweenLite.to(this,delay,{
            "x":posX,
            "y":posY,
            "ease":Linear.easeNone,
            "onUpdate":onMoveBgToTargetPosUpdate
         });
      }
      
      private function onMoveBgToTargetPosUpdate() : void
      {
         var hallStateView:HallStateView = StateManager.getState("main") as HallStateView;
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
      
      public function set mapID(value:int) : void
      {
         _mapID = value;
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
