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
      
      private function onActiveStateChange(param1:flash.events.Event) : void
      {
         var _loc2_:int = ConsortiaDomainManager.instance.activeState;
         if(_loc2_ == 100)
         {
            _disObjSortView.removeDisplayObjectByType(MonsterBone,true);
         }
      }
      
      private function onOtherEnter(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.position;
         var _loc3_:ConsortiaDomainPlayerVo = readPlayerInfoPkg(_loc4_);
         if(_loc3_.playerInfo.ID != PlayerManager.Instance.Self.ID && getPlayerNum() < 10)
         {
            _unLoadPlayerDic[_loc3_.playerInfo.ID] = _loc3_;
         }
      }
      
      private function getPlayerNum() : int
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         if(_unLoadPlayerDic)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _unLoadPlayerDic;
            for each(_loc2_ in _unLoadPlayerDic)
            {
               _loc1_++;
            }
         }
         if(_loadPlayerDic)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _loadPlayerDic;
            for each(_loc2_ in _loadPlayerDic)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      private function onOtherLeave(param1:CEvent) : void
      {
         var _loc2_:int = param1.data as int;
         var _loc3_:ConsortiaDomainHallPlayer = _friendPlayerDic[_loc2_];
         if(_loc3_)
         {
            _disObjSortView.removeDisplayObject(_loc3_,true);
            delete _friendPlayerDic[_loc2_];
         }
      }
      
      private function onFightState(param1:PkgEvent) : void
      {
         var _loc2_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         var _loc3_:int = _loc5_.readInt();
         var _loc4_:Boolean = _loc5_.readBoolean();
         if(_loc3_ == PlayerManager.Instance.Self.ID)
         {
            _loc2_ = _selfPlayer;
         }
         else
         {
            _loc2_ = _friendPlayerDic[_loc3_];
         }
         if(_loc2_)
         {
            _loc2_.consortiaDomainPlayerVo.isFight = _loc4_;
            _loc2_.showFightState();
         }
      }
      
      private function onPlayerRepairChange(param1:PkgEvent) : void
      {
         var _loc2_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         var _loc3_:int = _loc5_.readInt();
         var _loc4_:int = _loc5_.readInt();
         if(_loc3_ == PlayerManager.Instance.Self.ID)
         {
            _loc2_ = _selfPlayer;
         }
         else
         {
            _loc2_ = _friendPlayerDic[_loc3_];
         }
         if(_loc2_)
         {
            _loc2_.consortiaDomainPlayerVo.repairBuildId = _loc4_;
            _loc2_.checkShowRepair();
         }
      }
      
      private function onPlayerRepair(param1:PkgEvent) : void
      {
         SocketManager.Instance.out.getConsortiaDomainConsortiaInfo();
      }
      
      private function onPlayerMove(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc7_:PackageIn = param1.pkg;
         var _loc5_:int = _loc7_.readInt();
         if(_loc5_ == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         var _loc3_:int = _loc7_.readInt();
         var _loc6_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            _loc2_ = new Point(_loc7_.readInt(),_loc7_.readInt());
            _loc6_.push(_loc2_);
            _loc8_++;
         }
         var _loc4_:ConsortiaDomainHallPlayer = _friendPlayerDic[_loc5_];
         if(_loc4_)
         {
            _loc4_.playerVO.walkPath = _loc6_;
            _loc4_.playerVO.currentWalkStartPoint = _loc4_.currentWalkStartPoint;
         }
      }
      
      private function onMonsterStateChange(param1:flash.events.Event) : void
      {
         var _loc3_:Object = ConsortiaDomainManager.instance.model.monsterInfo;
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            updateMonsterInfoSingle(_loc2_);
         }
      }
      
      private function onMonsterInfoSingle(param1:CEvent) : void
      {
         var _loc2_:EachMonsterInfo = param1.data as EachMonsterInfo;
         updateMonsterInfoSingle(_loc2_);
      }
      
      private function updateMonsterInfoSingle(param1:EachMonsterInfo) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:int = indexOfMonsterByLivingID(param1.LivingID);
         if((param1.state == 1 || param1.state == 3 || param1.state == 4 || param1.state == 5) && _loc2_ == -1)
         {
            _loc5_ = new MonsterBone(param1);
            _loc5_.x = param1.posX;
            _loc5_.y = param1.posY;
            _disObjSortView.addDisplayObject(_loc5_);
         }
         else if(_loc2_ > -1)
         {
            _loc5_ = _disObjSortView.getDisplayObjectByIndex(_loc2_);
         }
         if(_loc5_)
         {
            if(param1.state == 3 && param1.TargetID > 0)
            {
               _loc4_ = ConsortiaDomainManager.BUILD_CENTER_POS_ARR[param1.TargetID];
               _loc3_ = ConsortiaDomainManager.instance.getIntersectionPoint(_loc4_.x,_loc4_.y,ConsortiaDomainManager.BUILD_RADIUS_ARR[param1.TargetID],_loc5_.x,_loc5_.y);
               if(_loc3_)
               {
                  _loc5_.pathArr = [_loc3_];
               }
            }
            _loc5_.moveEntityState = param1.state;
         }
      }
      
      private function onRemoveChildMonster(param1:CEvent) : void
      {
         var _loc2_:MonsterBone = param1.data as MonsterBone;
         _disObjSortView.removeDisplayObject(_loc2_,true);
      }
      
      protected function __onFriendPlayerInfo(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         var _loc5_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc3_ = readPlayerInfoPkg(_loc4_);
            if(_loc3_.playerInfo.ID == PlayerManager.Instance.Self.ID)
            {
               addSelfPlayer(_loc3_);
            }
            else if(_loc5_ < 10)
            {
               _unLoadPlayerDic[_loc3_.playerInfo.ID] = _loc3_;
            }
            _loc5_++;
            _loc6_++;
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
      
      private function addSelfPlayer(param1:PlayerVO) : void
      {
         var _loc2_:int = indexOfConsortiaDomainHallPlayerByID(param1.playerInfo.ID);
         if(_loc2_ != -1)
         {
            _disObjSortView.removeDisplayObjectByIndex(_loc2_,true);
         }
         if(!_mouseMovie)
         {
            _mouseMovie = BoneMovieFactory.instance.creatBoneMovieFast("hallScene.MouseClickMovie");
            _mouseMovie.stop();
            _mouseMovie.visible = false;
            _mouseMovie.touchable = false;
            addChild(_mouseMovie);
         }
         _selfPlayer = new ConsortiaDomainHallPlayer(param1);
         _selfPlayer.playerPoint = param1.currentWalkStartPoint;
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
      
      private function readPlayerInfoPkg(param1:PackageIn) : ConsortiaDomainPlayerVo
      {
         var _loc2_:ConsortiaDomainPlayerVo = new ConsortiaDomainPlayerVo();
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
         _loc2_.currentWalkStartPoint = new Point(param1.readInt(),param1.readInt());
         _loc2_.playerInfo.ConsortiaID = param1.readInt();
         _loc2_.playerInfo.badgeID = param1.readInt();
         _loc2_.playerInfo.ConsortiaName = param1.readUTF();
         _loc2_.playerInfo.honor = param1.readUTF();
         _loc2_.playerInfo.honorId = param1.readInt();
         _loc2_.playerInfo.isAttest = param1.readBoolean();
         _loc2_.playerInfo.ImagePath = param1.readUTF();
         _loc2_.playerInfo.IsShow = param1.readBoolean();
         _loc2_.isFight = param1.readBoolean();
         _loc2_.repairBuildId = param1.readInt();
         return _loc2_;
      }
      
      private function indexOfConsortiaDomainHallPlayerByID(param1:int) : int
      {
         ID = param1;
         return _disObjSortView.indexOfDisplayObjectByFun(function(param1:DisplayObject):Boolean
         {
            if(param1 is ConsortiaDomainHallPlayer && ConsortiaDomainHallPlayer(param1).playerVO.playerInfo.ID == ID)
            {
               return true;
            }
            return false;
         });
      }
      
      private function indexOfMonsterByLivingID(param1:int) : int
      {
         LivingID = param1;
         return _disObjSortView.indexOfDisplayObjectByFun(function(param1:DisplayObject):Boolean
         {
            if(param1 is MonsterBone && MonsterBone(param1).eachMonsterInfo.LivingID == LivingID)
            {
               return true;
            }
            return false;
         });
      }
      
      private function setPlayerInfo(param1:ConsortiaDomainPlayerVo) : void
      {
         var _loc3_:int = indexOfConsortiaDomainHallPlayerByID(param1.playerInfo.ID);
         if(_loc3_ != -1)
         {
            _disObjSortView.removeDisplayObjectByIndex(_loc3_,true);
            delete _friendPlayerDic[param1.playerInfo.ID];
         }
         var _loc2_:ConsortiaDomainHallPlayer = new ConsortiaDomainHallPlayer(param1);
         _loc2_.playerPoint = _loc2_.playerVO.currentWalkStartPoint;
         if(!_hidFlag)
         {
            _loc2_.showFightState();
         }
         _loc2_.isHideTitle = true;
         _disObjSortView.addDisplayObject(_loc2_);
         _friendPlayerDic[param1.playerInfo.ID] = _loc2_;
      }
      
      public function set type(param1:String) : void
      {
         _selfPlayer.sceneCharacterActionState = param1;
      }
      
      protected function __updateFrame(param1:starling.events.Event) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = undefined;
         var _loc4_:Number = NaN;
         _disObjSortView.sortDisplayObjectLayer();
         var _loc3_:Array = _disObjSortView.disObjArr;
         var _loc2_:Boolean = ConsortiaDomainManager.instance.isShowFightMonster;
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc6_];
            if(_loc5_)
            {
               if(_loc5_ is ConsortiaDomainHallPlayer)
               {
                  _loc5_.updatePlayer();
               }
               else if(_loc5_ is MonsterBone)
               {
                  _loc5_.visible = true;
                  if(!_loc2_ && MonsterBone(_loc5_).moveEntityState == 5)
                  {
                     _loc5_.visible = false;
                  }
               }
               if(_loc5_ != _selfPlayer)
               {
                  _loc4_ = (_selfPlayer.x - _loc5_.x) * (_selfPlayer.x - _loc5_.x) + (_selfPlayer.y - _loc5_.y) * (_selfPlayer.y - _loc5_.y);
                  if(_loc5_.y > _selfPlayer.y && _loc4_ < 10000)
                  {
                     _loc5_.alpha = 0.5;
                  }
                  else
                  {
                     _loc5_.alpha = 1;
                  }
               }
            }
            _loc6_++;
         }
      }
      
      protected function __onPlayerClick(param1:TouchEvent) : void
      {
         var _loc7_:Number = NaN;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = false;
         var _loc4_:* = null;
         var _loc3_:Touch = param1.getTouch(Starling.current.stage,"ended");
         if(!_loc3_ || !this.touchable || LayerManager.Instance.backGroundInParent || _nativeStageClickFilter.isTypeOf([Bitmap,TextField,Component]) || ObjectUtils.getDisplayObjectSuperParent(_nativeStageClickFilter.nativeStageClickDisplayObj,ChatView,Starling.current.nativeStage) || ObjectUtils.getDisplayObjectSuperParentByName(_nativeStageClickFilter.nativeStageClickDisplayObj,"consortiaDomain.view::BuildsStateView",Starling.current.nativeStage))
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
            _loc7_ = 200;
            if(getTimer() - _lastClick > _loc7_)
            {
               _loc6_ = _loc3_.target;
               _loc8_ = _loc6_.parent;
               _loc5_ = _loc3_.getLocation(this);
               _lastClick = getTimer();
               _loc2_ = _loc6_ is MonsterBone;
               _loc4_ = ObjectUtils.getDisplayObjectSuperParent(_loc6_,BuildView,Starling.current.stage);
               if(_loc2_)
               {
                  _selfPlayer.walkTarget = _loc6_;
               }
               else if(_loc4_)
               {
                  if(_selfPlayer.consortiaDomainPlayerVo.repairBuildId > 0 && _selfPlayer.walkTarget != _loc4_)
                  {
                     _selfPlayer.alertUnRepairBuild();
                     return;
                  }
                  _selfPlayer.walkTarget = _loc4_;
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
               if(!setSelfPlayerPos(_loc5_))
               {
                  if(_loc2_)
                  {
                     _selfPlayer.checkAndFightWithMonster();
                  }
                  else if(_loc4_)
                  {
                     _selfPlayer.checkAndRepairBuild();
                  }
               }
            }
         }
      }
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void
      {
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("newhallsetplayertippos",[null]));
         var _loc2_:Point = this.globalToLocal(new Point(param1.data[0].stageX,param1.data[0].stageY));
         checkAndWalkToPoint(_loc2_);
      }
      
      private function setSelfPlayerPos(param1:Point, param2:Boolean = true) : Boolean
      {
         var _loc4_:* = null;
         var _loc3_:Array = ConsortiaDomainManager.instance.aStarPathFinder.searchPath(_selfPlayer.playerPoint,param1);
         if(_loc3_)
         {
            _loc4_ = _loc3_[_loc3_.length - 1];
            _mouseMovie.visible = param2;
            _mouseMovie.x = _loc4_.x;
            _mouseMovie.y = _loc4_.y;
            _mouseMovie.play("stand");
            _selfPlayer.playerVO.walkPath = _loc3_;
            _selfPlayer.playerVO.currentWalkStartPoint = _selfPlayer.currentWalkStartPoint;
            SocketManager.Instance.out.sendConsortiaDomainMove(_loc3_);
            return true;
         }
         return false;
      }
      
      public function checkAndWalkToPoint(param1:Point) : void
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
         setSelfPlayerPos(param1);
      }
      
      protected function onFinishWalk(param1:NewHallEventStarling) : void
      {
         _mouseMovie.stop();
         _mouseMovie.visible = false;
         var _loc2_:DisplayObject = _selfPlayer.walkTarget;
         if(_loc2_)
         {
            if(_loc2_ is MonsterBone)
            {
               _selfPlayer.checkAndFightWithMonster();
            }
            else if(_loc2_ is BuildView)
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
         var _loc2_:int = StageReferance.stageHeight;
         if(_selfPlayer)
         {
            _loc7_ = -(_selfPlayer.x - _loc6_ / 2);
            _loc3_ = -(_selfPlayer.y - _loc2_ / 2) + 50;
         }
         if(_loc7_ > 0)
         {
            _loc7_ = 0;
         }
         if(_loc7_ < _loc6_ - ConsortiaDomainManager.instance.sceneMapGridData.bgImageW)
         {
            _loc7_ = _loc6_ - ConsortiaDomainManager.instance.sceneMapGridData.bgImageW;
         }
         if(_loc3_ > 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ < _loc2_ - ConsortiaDomainManager.instance.sceneMapGridData.bgImageH)
         {
            _loc3_ = _loc2_ - ConsortiaDomainManager.instance.sceneMapGridData.bgImageH;
         }
         this.x = _loc7_;
         this.y = _loc3_;
         ConsortiaDomainManager.instance.bgLayerViewRect.x = -_loc7_;
         ConsortiaDomainManager.instance.bgLayerViewRect.y = -_loc3_;
         _staticLayer.setCenter();
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
      
      public function get selfPlayer() : ConsortiaDomainHallPlayer
      {
         return _selfPlayer;
      }
      
      private function addBuildsAndEffs() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         _loc4_ = 0;
         while(_loc4_ < monsterSecretBornBuildPos.length / 2)
         {
            _loc3_ = new MonsterSecretBornPoint(_loc4_ + 1,"consortiaDomainMonsterSecretBorn",1.06667);
            if(_loc4_ > 1)
            {
               _loc3_.scaleX = -1;
            }
            _loc3_.touchable = false;
            _loc3_.setXY(monsterSecretBornBuildPos[_loc4_ * 2],monsterSecretBornBuildPos[_loc4_ * 2 + 1]);
            _loc3_.monsterBornBuildState = 1;
            _disObjSortView.addDisplayObject(_loc3_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < monsterNormalBornBuildPos.length / 2)
         {
            _loc1_ = new MonsterNormalBornPoint(_loc4_ + 1,"consortiaDomainMonsterNormalBorn",1.06667);
            if(_loc4_ > 2)
            {
               _loc1_.scaleX = -1;
            }
            _loc1_.laySortY = _loc4_;
            _loc1_.touchable = false;
            _loc1_.setXY(monsterNormalBornBuildPos[_loc4_ * 2],monsterNormalBornBuildPos[_loc4_ * 2 + 1]);
            _loc1_.monsterBornBuildState = 1;
            _disObjSortView.addDisplayObject(_loc1_);
            _loc4_++;
         }
         var _loc2_:BuildView = new BuildView(3,1.06667);
         _loc2_.x = 1181;
         _loc2_.y = 573;
         _loc2_.setBuildXY(-215,-246);
         _loc2_.createEff("consortiaDomainShopEff",-103,-164);
         _disObjSortView.addDisplayObject(_loc2_);
         _loc2_ = new BuildView(4,1.06667);
         _loc2_.x = 1996;
         _loc2_.y = 477;
         _loc2_.setBuildXY(-160,-230);
         _loc2_.createEff("consortiaDomainBagStoreEff",162,-380,-2,2);
         _disObjSortView.addDisplayObject(_loc2_);
         _loc2_ = new BuildView(1,1.06667);
         _loc2_.x = 886;
         _loc2_.y = 1016;
         _loc2_.setBuildXY(-93,-121);
         _loc2_.createEff("consortiaDomainHomeBankEff",-33,2);
         _disObjSortView.addDisplayObject(_loc2_);
         _loc2_ = new BuildView(2,1.06667);
         _loc2_.x = 2250;
         _loc2_.y = 927;
         _loc2_.setBuildXY(-141,-284);
         _loc2_.createEff("consortiaDomainSkillEff",-141,-381);
         _disObjSortView.addDisplayObject(_loc2_);
         _loc2_ = new BuildView(5,1.06667);
         _loc2_.x = 1599;
         _loc2_.y = 910;
         _loc2_.setBuildXY(-347,-346);
         _loc2_.createEff("consortiaDomainCityEff1",423,-53);
         _loc2_.createEff("consortiaDomainCityEff2",103,55);
         _loc2_.createEff("consortiaDomainCityEff3",391,216);
         _disObjSortView.addDisplayObject(_loc2_);
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
