package starling.scene.consortiaDomain
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.ConsortiaDomainPlayerVo;
   import consortiaDomain.EachMonsterInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.chat.ChatView;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import hall.event.NewHallEvent;
   import hall.player.vo.PlayerVO;
   import newTitle.NewTitleManager;
   import road7th.comm.PackageIn;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.display.sceneCharacter.event.SceneCharacterEvent;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.scene.common.DisplayObjectSortView;
   import starling.scene.common.NativeStageClickFilter;
   import starling.scene.consortiaDomain.buildView.BuildView;
   import starling.scene.hall.event.NewHallEventStarling;
   
   public class PlayerView extends Sprite
   {
       
      
      private var _selfPlayer:ConsortiaDomainHallPlayer;
      
      private var _friendPlayerDic:Dictionary;
      
      private var _disObjSortView:DisplayObjectSortView;
      
      private var _hidFlag:Boolean;
      
      private var _loadPlayerDic:Dictionary;
      
      private var _unLoadPlayerDic:Dictionary;
      
      private var _loadPkg:PackageIn;
      
      private var _loadTimer:Timer;
      
      private var _lastClick:Number = 0;
      
      private var _mouseMovie:BoneMovieFastStarling;
      
      private var _staticLayer:StaticLayer;
      
      private var _nativeStageClickFilter:NativeStageClickFilter;
      
      private const buildImageScale:Number = 1.06667;
      
      private const monsterSecretBornBuildPos:Array = [1529,461,1110,1321,2160,1300];
      
      private const monsterNormalBornBuildPos:Array = [700,543,480,969,645,1618,1589,1775,2504,440,2774,995,2499,1558];
      
      private const MAX_PLAYER_NUM:int = 10;
      
      public function PlayerView()
      {
         super();
         _staticLayer = new StaticLayer();
         addChild(_staticLayer);
         _disObjSortView = new DisplayObjectSortView();
         addChild(_disObjSortView);
         addBuildsAndEffs();
         _nativeStageClickFilter = new NativeStageClickFilter();
         _friendPlayerDic = new Dictionary();
         _loadTimer = new Timer(1500);
         _loadTimer.addEventListener("timer",__onloadPlayerRes);
         _loadPlayerDic = new Dictionary();
         _unLoadPlayerDic = new Dictionary();
         initEvent();
         SocketManager.Instance.out.getConsortiaDomainOtherPlayerInfo();
         ConsortiaDomainManager.instance.getInfoOnEnterScene();
      }
      
      private function initEvent() : void
      {
         Starling.current.stage.addEventListener("touch",__onPlayerClick);
         PlayerManager.Instance.addEventListener("setselfplayerpos",__onSetSelfPlayerPos);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,3),__onFriendPlayerInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,2),onOtherEnter);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,14),onFightState);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,18),onPlayerRepairChange);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,4),onPlayerMove);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,8),onPlayerRepair);
         ConsortiaDomainManager.instance.addEventListener("event_monster_state_change",onMonsterStateChange);
         ConsortiaDomainManager.instance.addEventListener("event_remove_other_player",onOtherLeave);
         ConsortiaDomainManager.instance.addEventListener("event_monster_info_single",onMonsterInfoSingle);
         ConsortiaDomainManager.instance.addEventListener("event_remove_child_monster",onRemoveChildMonster);
         ConsortiaDomainManager.instance.addEventListener("event_active_state_change",onActiveStateChange);
      }
      
      private function removeEvent() : void
      {
         Starling.current.stage.removeEventListener("touch",__onPlayerClick);
         removeEventListener("enterFrame",__updateFrame);
         PlayerManager.Instance.removeEventListener("setselfplayerpos",__onSetSelfPlayerPos);
         SocketManager.Instance.removeEventListener(PkgEvent.format(371,3),__onFriendPlayerInfo);
         SocketManager.Instance.removeEventListener(PkgEvent.format(371,2),onOtherEnter);
         SocketManager.Instance.removeEventListener(PkgEvent.format(371,14),onFightState);
         SocketManager.Instance.removeEventListener(PkgEvent.format(371,18),onPlayerRepairChange);
         SocketManager.Instance.removeEventListener(PkgEvent.format(371,4),onPlayerMove);
         SocketManager.Instance.removeEventListener(PkgEvent.format(371,8),onPlayerRepair);
         ConsortiaDomainManager.instance.removeEventListener("event_monster_state_change",onMonsterStateChange);
         ConsortiaDomainManager.instance.removeEventListener("event_remove_other_player",onOtherLeave);
         ConsortiaDomainManager.instance.removeEventListener("event_monster_info_single",onMonsterInfoSingle);
         ConsortiaDomainManager.instance.removeEventListener("event_remove_child_monster",onRemoveChildMonster);
         ConsortiaDomainManager.instance.removeEventListener("event_active_state_change",onActiveStateChange);
      }
      
      private function onActiveStateChange(evt:flash.events.Event) : void
      {
         var activeState:int = ConsortiaDomainManager.instance.activeState;
         if(activeState == 100)
         {
            _disObjSortView.removeDisplayObjectByType(MonsterBone,true);
         }
      }
      
      private function onOtherEnter(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var position:int = pkg.position;
         var playerVo:ConsortiaDomainPlayerVo = readPlayerInfoPkg(pkg);
         if(playerVo.playerInfo.ID != PlayerManager.Instance.Self.ID && getPlayerNum() < 10)
         {
            _unLoadPlayerDic[playerVo.playerInfo.ID] = playerVo;
         }
      }
      
      private function getPlayerNum() : int
      {
         var playerVo:* = null;
         var num:int = 0;
         if(_unLoadPlayerDic)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _unLoadPlayerDic;
            for each(playerVo in _unLoadPlayerDic)
            {
               num++;
            }
         }
         if(_loadPlayerDic)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _loadPlayerDic;
            for each(playerVo in _loadPlayerDic)
            {
               num++;
            }
         }
         return num;
      }
      
      private function onOtherLeave(evt:CEvent) : void
      {
         var leavePlayerId:int = evt.data as int;
         var hallPlayer:ConsortiaDomainHallPlayer = _friendPlayerDic[leavePlayerId];
         if(hallPlayer)
         {
            _disObjSortView.removeDisplayObject(hallPlayer,true);
            delete _friendPlayerDic[leavePlayerId];
         }
      }
      
      private function onFightState(evt:PkgEvent) : void
      {
         var player:* = null;
         var pkg:PackageIn = evt.pkg;
         var playerId:int = pkg.readInt();
         var isFight:Boolean = pkg.readBoolean();
         if(playerId == PlayerManager.Instance.Self.ID)
         {
            player = _selfPlayer;
         }
         else
         {
            player = _friendPlayerDic[playerId];
         }
         if(player)
         {
            player.consortiaDomainPlayerVo.isFight = isFight;
            player.showFightState();
         }
      }
      
      private function onPlayerRepairChange(evt:PkgEvent) : void
      {
         var player:* = null;
         var pkg:PackageIn = evt.pkg;
         var playerId:int = pkg.readInt();
         var repairBuildId:int = pkg.readInt();
         if(playerId == PlayerManager.Instance.Self.ID)
         {
            player = _selfPlayer;
         }
         else
         {
            player = _friendPlayerDic[playerId];
         }
         if(player)
         {
            player.consortiaDomainPlayerVo.repairBuildId = repairBuildId;
            player.checkShowRepair();
         }
      }
      
      private function onPlayerRepair(evt:PkgEvent) : void
      {
         SocketManager.Instance.out.getConsortiaDomainConsortiaInfo();
      }
      
      private function onPlayerMove(evt:PkgEvent) : void
      {
         var i:int = 0;
         var point:* = null;
         var pkg:PackageIn = evt.pkg;
         var playerId:int = pkg.readInt();
         if(playerId == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         var xyCount:int = pkg.readInt();
         var path:Array = [];
         for(i = 0; i < xyCount; )
         {
            point = new Point(pkg.readInt(),pkg.readInt());
            path.push(point);
            i++;
         }
         var player:ConsortiaDomainHallPlayer = _friendPlayerDic[playerId];
         if(player)
         {
            player.playerVO.walkPath = path;
            player.playerVO.currentWalkStartPoint = player.currentWalkStartPoint;
         }
      }
      
      private function onMonsterStateChange(evt:flash.events.Event) : void
      {
         var allMonesterInfo:Object = ConsortiaDomainManager.instance.model.monsterInfo;
         var _loc5_:int = 0;
         var _loc4_:* = allMonesterInfo;
         for each(var eachInfo in allMonesterInfo)
         {
            updateMonsterInfoSingle(eachInfo);
         }
      }
      
      private function onMonsterInfoSingle(evt:CEvent) : void
      {
         var eachMonsterInfo:EachMonsterInfo = evt.data as EachMonsterInfo;
         updateMonsterInfoSingle(eachMonsterInfo);
      }
      
      private function updateMonsterInfoSingle(eachInfo:EachMonsterInfo) : void
      {
         var monsterBone:* = null;
         var buildCenterPos:* = null;
         var endPos:* = null;
         var monsterIndex:int = indexOfMonsterByLivingID(eachInfo.LivingID);
         if((eachInfo.state == 1 || eachInfo.state == 3 || eachInfo.state == 4 || eachInfo.state == 5) && monsterIndex == -1)
         {
            monsterBone = new MonsterBone(eachInfo);
            monsterBone.x = eachInfo.posX;
            monsterBone.y = eachInfo.posY;
            _disObjSortView.addDisplayObject(monsterBone);
         }
         else if(monsterIndex > -1)
         {
            monsterBone = _disObjSortView.getDisplayObjectByIndex(monsterIndex);
         }
         if(monsterBone)
         {
            if(eachInfo.state == 3 && eachInfo.TargetID > 0)
            {
               buildCenterPos = ConsortiaDomainManager.BUILD_CENTER_POS_ARR[eachInfo.TargetID];
               endPos = ConsortiaDomainManager.instance.getIntersectionPoint(buildCenterPos.x,buildCenterPos.y,ConsortiaDomainManager.BUILD_RADIUS_ARR[eachInfo.TargetID],monsterBone.x,monsterBone.y);
               if(endPos)
               {
                  monsterBone.pathArr = [endPos];
               }
            }
            monsterBone.moveEntityState = eachInfo.state;
         }
      }
      
      private function onRemoveChildMonster(evt:CEvent) : void
      {
         var monsterBone:MonsterBone = evt.data as MonsterBone;
         _disObjSortView.removeDisplayObject(monsterBone,true);
      }
      
      protected function __onFriendPlayerInfo(event:PkgEvent) : void
      {
         var i:int = 0;
         var playerVo:* = null;
         var pkg:PackageIn = event.pkg;
         var playerNum:int = pkg.readInt();
         var initPlayerCount:int = 0;
         for(i = 0; i < playerNum; )
         {
            playerVo = readPlayerInfoPkg(pkg);
            if(playerVo.playerInfo.ID == PlayerManager.Instance.Self.ID)
            {
               addSelfPlayer(playerVo);
            }
            else if(initPlayerCount < 10)
            {
               _unLoadPlayerDic[playerVo.playerInfo.ID] = playerVo;
            }
            initPlayerCount++;
            i++;
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
      
      private function addSelfPlayer(playerVo:PlayerVO) : void
      {
         var index:int = indexOfConsortiaDomainHallPlayerByID(playerVo.playerInfo.ID);
         if(index != -1)
         {
            _disObjSortView.removeDisplayObjectByIndex(index,true);
         }
         if(!_mouseMovie)
         {
            _mouseMovie = BoneMovieFactory.instance.creatBoneMovieFast("hallScene.MouseClickMovie");
            _mouseMovie.stop();
            _mouseMovie.visible = false;
            _mouseMovie.touchable = false;
            addChild(_mouseMovie);
         }
         _selfPlayer = new ConsortiaDomainHallPlayer(playerVo);
         _selfPlayer.playerPoint = playerVo.currentWalkStartPoint;
         if(NewTitleManager.instance.ShowTitle)
         {
            _selfPlayer.isHideTitle = true;
         }
         else
         {
            _selfPlayer.isHideTitle = false;
         }
         _disObjSortView.addDisplayObject(_selfPlayer);
         ajustScreen();
         setCenter();
         startLoadOtherPlayer();
         _selfPlayer.touchable = false;
         _selfPlayer.addEventListener("newhallbtnclick",onFinishWalk);
      }
      
      private function readPlayerInfoPkg(pkg:PackageIn) : ConsortiaDomainPlayerVo
      {
         var friendVo:ConsortiaDomainPlayerVo = new ConsortiaDomainPlayerVo();
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
         friendVo.currentWalkStartPoint = new Point(pkg.readInt(),pkg.readInt());
         friendVo.playerInfo.ConsortiaID = pkg.readInt();
         friendVo.playerInfo.badgeID = pkg.readInt();
         friendVo.playerInfo.ConsortiaName = pkg.readUTF();
         friendVo.playerInfo.honor = pkg.readUTF();
         friendVo.playerInfo.honorId = pkg.readInt();
         friendVo.playerInfo.isAttest = pkg.readBoolean();
         friendVo.playerInfo.ImagePath = pkg.readUTF();
         friendVo.playerInfo.IsShow = pkg.readBoolean();
         friendVo.isFight = pkg.readBoolean();
         friendVo.repairBuildId = pkg.readInt();
         return friendVo;
      }
      
      private function indexOfConsortiaDomainHallPlayerByID(ID:int) : int
      {
         ID = ID;
         return _disObjSortView.indexOfDisplayObjectByFun(function(entity:DisplayObject):Boolean
         {
            if(entity is ConsortiaDomainHallPlayer && ConsortiaDomainHallPlayer(entity).playerVO.playerInfo.ID == ID)
            {
               return true;
            }
            return false;
         });
      }
      
      private function indexOfMonsterByLivingID(LivingID:int) : int
      {
         LivingID = LivingID;
         return _disObjSortView.indexOfDisplayObjectByFun(function(entity:DisplayObject):Boolean
         {
            if(entity is MonsterBone && MonsterBone(entity).eachMonsterInfo.LivingID == LivingID)
            {
               return true;
            }
            return false;
         });
      }
      
      private function setPlayerInfo(friendVo:ConsortiaDomainPlayerVo) : void
      {
         var friendPlayerIndex:int = indexOfConsortiaDomainHallPlayerByID(friendVo.playerInfo.ID);
         if(friendPlayerIndex != -1)
         {
            _disObjSortView.removeDisplayObjectByIndex(friendPlayerIndex,true);
            delete _friendPlayerDic[friendVo.playerInfo.ID];
         }
         var friendPlayer:ConsortiaDomainHallPlayer = new ConsortiaDomainHallPlayer(friendVo);
         friendPlayer.playerPoint = friendPlayer.playerVO.currentWalkStartPoint;
         if(!_hidFlag)
         {
            friendPlayer.showFightState();
         }
         friendPlayer.isHideTitle = true;
         _disObjSortView.addDisplayObject(friendPlayer);
         _friendPlayerDic[friendVo.playerInfo.ID] = friendPlayer;
      }
      
      public function set type(value:String) : void
      {
         _selfPlayer.sceneCharacterActionState = value;
      }
      
      protected function __updateFrame(event:starling.events.Event) : void
      {
         var i:int = 0;
         var obj:* = undefined;
         var dis:Number = NaN;
         _disObjSortView.sortDisplayObjectLayer();
         var entityArr:Array = _disObjSortView.disObjArr;
         var isShowFightMonster:Boolean = ConsortiaDomainManager.instance.isShowFightMonster;
         for(i = 0; i < entityArr.length; )
         {
            obj = entityArr[i];
            if(obj)
            {
               if(obj is ConsortiaDomainHallPlayer)
               {
                  obj.updatePlayer();
               }
               else if(obj is MonsterBone)
               {
                  obj.visible = true;
                  if(!isShowFightMonster && MonsterBone(obj).moveEntityState == 5)
                  {
                     obj.visible = false;
                  }
               }
               if(obj != _selfPlayer)
               {
                  dis = (_selfPlayer.x - obj.x) * (_selfPlayer.x - obj.x) + (_selfPlayer.y - obj.y) * (_selfPlayer.y - obj.y);
                  if(obj.y > _selfPlayer.y && dis < 10000)
                  {
                     obj.alpha = 0.5;
                  }
                  else
                  {
                     obj.alpha = 1;
                  }
               }
            }
            i++;
         }
      }
      
      protected function __onPlayerClick(event:TouchEvent) : void
      {
         var clickInterval:Number = NaN;
         var touchDisplayObject:* = null;
         var touchDisplayObjectP:* = null;
         var targetPoint:* = null;
         var isMonster:* = false;
         var buildView:* = null;
         var touch:Touch = event.getTouch(Starling.current.stage,"ended");
         if(!touch || !this.touchable || LayerManager.Instance.backGroundInParent || _nativeStageClickFilter.isTypeOf([Bitmap,TextField,Component]) || ObjectUtils.getDisplayObjectSuperParent(_nativeStageClickFilter.nativeStageClickDisplayObj,ChatView,Starling.current.nativeStage) || ObjectUtils.getDisplayObjectSuperParentByName(_nativeStageClickFilter.nativeStageClickDisplayObj,"consortiaDomain.view::BuildsStateView",Starling.current.nativeStage))
         {
            return;
         }
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("newhallsetplayertippos",[null]));
         if(_selfPlayer)
         {
            if(_selfPlayer.consortiaDomainPlayerVo.isFight)
            {
               return;
            }
            clickInterval = 200;
            if(getTimer() - _lastClick > clickInterval)
            {
               touchDisplayObject = touch.target;
               touchDisplayObjectP = touchDisplayObject.parent;
               targetPoint = touch.getLocation(this);
               _lastClick = getTimer();
               isMonster = touchDisplayObject is MonsterBone;
               buildView = ObjectUtils.getDisplayObjectSuperParent(touchDisplayObject,BuildView,Starling.current.stage);
               if(isMonster)
               {
                  _selfPlayer.walkTarget = touchDisplayObject;
               }
               else if(buildView)
               {
                  if(_selfPlayer.consortiaDomainPlayerVo.repairBuildId > 0 && _selfPlayer.walkTarget != buildView)
                  {
                     _selfPlayer.alertUnRepairBuild();
                     return;
                  }
                  _selfPlayer.walkTarget = buildView;
               }
               else
               {
                  if(_selfPlayer.consortiaDomainPlayerVo.repairBuildId > 0)
                  {
                     _selfPlayer.alertUnRepairBuild();
                     return;
                  }
                  _selfPlayer.walkTarget = null;
               }
               if(!setSelfPlayerPos(targetPoint))
               {
                  if(isMonster)
                  {
                     _selfPlayer.checkAndFightWithMonster();
                  }
                  else if(buildView)
                  {
                     _selfPlayer.checkAndRepairBuild();
                  }
               }
            }
         }
      }
      
      protected function __onSetSelfPlayerPos(event:NewHallEvent) : void
      {
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("newhallsetplayertippos",[null]));
         var targetPoint:Point = this.globalToLocal(new Point(event.data[0].stageX,event.data[0].stageY));
         checkAndWalkToPoint(targetPoint);
      }
      
      private function setSelfPlayerPos(pos:Point, mouseFlag:Boolean = true) : Boolean
      {
         var endPos:* = null;
         var path:Array = ConsortiaDomainManager.instance.aStarPathFinder.searchPath(_selfPlayer.playerPoint,pos);
         if(path)
         {
            endPos = path[path.length - 1];
            _mouseMovie.visible = mouseFlag;
            _mouseMovie.x = endPos.x;
            _mouseMovie.y = endPos.y;
            _mouseMovie.play("stand");
            _selfPlayer.playerVO.walkPath = path;
            _selfPlayer.playerVO.currentWalkStartPoint = _selfPlayer.currentWalkStartPoint;
            SocketManager.Instance.out.sendConsortiaDomainMove(path);
            return true;
         }
         return false;
      }
      
      public function checkAndWalkToPoint(endPos:Point) : void
      {
         if(_selfPlayer.consortiaDomainPlayerVo.isFight)
         {
            return;
         }
         if(_selfPlayer.consortiaDomainPlayerVo.repairBuildId > 0)
         {
            _selfPlayer.alertUnRepairBuild();
            return;
         }
         _selfPlayer.walkTarget = null;
         setSelfPlayerPos(endPos);
      }
      
      protected function onFinishWalk(event:NewHallEventStarling) : void
      {
         _mouseMovie.stop();
         _mouseMovie.visible = false;
         var walkTarget:DisplayObject = _selfPlayer.walkTarget;
         if(walkTarget)
         {
            if(walkTarget is MonsterBone)
            {
               _selfPlayer.checkAndFightWithMonster();
            }
            else if(walkTarget is BuildView)
            {
               _selfPlayer.checkAndRepairBuild();
            }
         }
      }
      
      private function startGame() : void
      {
         CheckWeaponManager.instance.setFunction(this,startGame);
         if(checkCanStartGame())
         {
            GameInSocketOut.sendSingleRoomBegin(21);
         }
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
         var height:int = StageReferance.stageHeight;
         if(_selfPlayer)
         {
            xf = -(_selfPlayer.x - width / 2);
            yf = -(_selfPlayer.y - height / 2) + 50;
         }
         if(xf > 0)
         {
            xf = 0;
         }
         if(xf < width - ConsortiaDomainManager.instance.sceneMapGridData.bgImageW)
         {
            xf = width - ConsortiaDomainManager.instance.sceneMapGridData.bgImageW;
         }
         if(yf > 0)
         {
            yf = 0;
         }
         if(yf < height - ConsortiaDomainManager.instance.sceneMapGridData.bgImageH)
         {
            yf = height - ConsortiaDomainManager.instance.sceneMapGridData.bgImageH;
         }
         this.x = xf;
         this.y = yf;
         ConsortiaDomainManager.instance.bgLayerViewRect.x = -xf;
         ConsortiaDomainManager.instance.bgLayerViewRect.y = -yf;
         _staticLayer.setCenter();
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
      
      public function get selfPlayer() : ConsortiaDomainHallPlayer
      {
         return _selfPlayer;
      }
      
      private function addBuildsAndEffs() : void
      {
         var i:int = 0;
         var monsterSecretBornBuild:* = null;
         var monsterNormalBornBuild:* = null;
         for(i = 0; i < monsterSecretBornBuildPos.length / 2; )
         {
            monsterSecretBornBuild = new MonsterSecretBornPoint(i + 1,"consortiaDomainMonsterSecretBorn",1.06667);
            if(i > 1)
            {
               monsterSecretBornBuild.scaleX = -1;
            }
            monsterSecretBornBuild.touchable = false;
            monsterSecretBornBuild.setXY(monsterSecretBornBuildPos[i * 2],monsterSecretBornBuildPos[i * 2 + 1]);
            monsterSecretBornBuild.monsterBornBuildState = 1;
            _disObjSortView.addDisplayObject(monsterSecretBornBuild);
            i++;
         }
         for(i = 0; i < monsterNormalBornBuildPos.length / 2; )
         {
            monsterNormalBornBuild = new MonsterNormalBornPoint(i + 1,"consortiaDomainMonsterNormalBorn",1.06667);
            if(i > 2)
            {
               monsterNormalBornBuild.scaleX = -1;
            }
            monsterNormalBornBuild.laySortY = i;
            monsterNormalBornBuild.touchable = false;
            monsterNormalBornBuild.setXY(monsterNormalBornBuildPos[i * 2],monsterNormalBornBuildPos[i * 2 + 1]);
            monsterNormalBornBuild.monsterBornBuildState = 1;
            _disObjSortView.addDisplayObject(monsterNormalBornBuild);
            i++;
         }
         var buildView:BuildView = new BuildView(3,1.06667);
         buildView.x = 1181;
         buildView.y = 573;
         buildView.setBuildXY(-215,-246);
         buildView.createEff("consortiaDomainShopEff",-103,-164);
         _disObjSortView.addDisplayObject(buildView);
         buildView = new BuildView(4,1.06667);
         buildView.x = 1996;
         buildView.y = 477;
         buildView.setBuildXY(-160,-230);
         buildView.createEff("consortiaDomainBagStoreEff",162,-380,-2,2);
         _disObjSortView.addDisplayObject(buildView);
         buildView = new BuildView(1,1.06667);
         buildView.x = 886;
         buildView.y = 1016;
         buildView.setBuildXY(-93,-121);
         buildView.createEff("consortiaDomainHomeBankEff",-33,2);
         _disObjSortView.addDisplayObject(buildView);
         buildView = new BuildView(2,1.06667);
         buildView.x = 2250;
         buildView.y = 927;
         buildView.setBuildXY(-141,-284);
         buildView.createEff("consortiaDomainSkillEff",-141,-381);
         _disObjSortView.addDisplayObject(buildView);
         buildView = new BuildView(5,1.06667);
         buildView.x = 1599;
         buildView.y = 910;
         buildView.setBuildXY(-347,-346);
         buildView.createEff("consortiaDomainCityEff1",423,-53);
         buildView.createEff("consortiaDomainCityEff2",103,55);
         buildView.createEff("consortiaDomainCityEff3",391,216);
         _disObjSortView.addDisplayObject(buildView);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_selfPlayer)
         {
            _selfPlayer.removeEventListener("newhallbtnclick",onFinishWalk);
            _selfPlayer.removeEventListener("characterMovement",setCenter);
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
            StarlingObjectUtils.disposeObject(_mouseMovie);
            _mouseMovie = null;
         }
         _friendPlayerDic = null;
         _loadPlayerDic = null;
         _unLoadPlayerDic = null;
         _loadPkg = null;
         _staticLayer = null;
         _disObjSortView = null;
         _nativeStageClickFilter.dispose();
         _nativeStageClickFilter = null;
      }
   }
}
