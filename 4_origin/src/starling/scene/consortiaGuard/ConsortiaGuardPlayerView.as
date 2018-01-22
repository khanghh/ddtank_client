package starling.scene.consortiaGuard
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.SpriteLayer;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import consortion.guard.ConsortiaGuardControl;
   import consortion.guard.ConsortiaGuardEvent;
   import consortion.view.guard.ConsortiaGuardBoss;
   import consortion.view.guard.ConsortiaGuardBossBar;
   import consortion.view.guard.ConsortiaGuardReviveView;
   import consortion.view.guard.ConsortiaGuardSubBossRank;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatView;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import gameCommon.GameControl;
   import hall.aStar.AStarPathFinder;
   import hall.event.NewHallEvent;
   import hall.player.aStar.Grid;
   import hall.player.aStar.Node;
   import hall.player.vo.PlayerVO;
   import newTitle.NewTitleManager;
   import road7th.comm.PackageIn;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.display.player.FightPlayer;
   import starling.display.player.FightPlayerVo;
   import starling.display.sceneCharacter.event.SceneCharacterEvent;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.scene.common.DisplayObjectSortView;
   import starling.scene.common.NativeStageClickFilter;
   import starling.scene.hall.SceneMapGridData;
   import starling.scene.hall.event.NewHallEventStarling;
   
   public class ConsortiaGuardPlayerView extends Sprite
   {
       
      
      private const randomPathX:int = 2;
      
      private const randomPathY:int = 1;
      
      private const randomPathMap:Object = {"0_1":[462,470,1098,1022]};
      
      private var _selfPlayer:FightPlayer;
      
      private var _friendPlayerDic:Dictionary;
      
      private var _disObjSortView:DisplayObjectSortView;
      
      private var _playerArray:Array;
      
      private var _lastClickTime:int = 0;
      
      private var _playerPos:Point;
      
      private var _hidFlag:Boolean;
      
      private var _loadPlayerDic:Dictionary;
      
      private var _unLoadPlayerDic:Dictionary;
      
      private var _loadPkg:PackageIn;
      
      private var _loadTimer:Timer;
      
      private var _judgePos:Point;
      
      private var _lastClick:Number = 0;
      
      private var _sceneMapGridData:SceneMapGridData;
      
      private var _aStarPathFinder:AStarPathFinder;
      
      private var _mouseMovie:BoneMovieStarling;
      
      private var _clickBossLayer:ConsortiaGuardSceneClick;
      
      private var _staticLayer:ConsortiaGuardStaticLayer;
      
      private var _nativeStageClickFilter:NativeStageClickFilter;
      
      private var _boss1:BoneMovieFastStarling;
      
      private var _boss2:BoneMovieFastStarling;
      
      private var _boss3:BoneMovieFastStarling;
      
      private var _boss4:BoneMovieFastStarling;
      
      private var _statue:ConsortiaGuardStatue;
      
      private var _fightTarget:ConsortiaGuardBoss;
      
      public function ConsortiaGuardPlayerView()
      {
         super();
         init();
         _friendPlayerDic = new Dictionary();
         _playerArray = [];
         _loadTimer = new Timer(1500);
         _loadTimer.stop();
         _loadTimer.addEventListener("timer",__onloadPlayerRes);
         _sceneMapGridData = ComponentFactory.Instance.creatCustomObject("consortiaGuard.map.SceneMapGridData");
         _aStarPathFinder = new AStarPathFinder();
         _aStarPathFinder.init(_sceneMapGridData);
         _playerPos = new Point(743,1044);
         var _loc1_:SpriteLayer = LayerManager.Instance.getLayerByType(5);
         _clickBossLayer = new ConsortiaGuardSceneClick();
         _loc1_.addChild(_clickBossLayer);
         initEvent();
      }
      
      private function init() : void
      {
         _staticLayer = new ConsortiaGuardStaticLayer();
         addChild(_staticLayer);
         _disObjSortView = new DisplayObjectSortView();
         addChild(_disObjSortView);
         _nativeStageClickFilter = new NativeStageClickFilter();
         _boss1 = BoneMovieFactory.instance.creatBoneMovieFast("ConsortiaGuardBossMovie_1");
         var _loc1_:* = 1.5;
         _boss1.scaleY = _loc1_;
         _boss1.scaleX = _loc1_;
         PositionUtils.setPos(_boss1,"consortiaGuard.bossPos0");
         _disObjSortView.addDisplayObject(_boss1);
         _boss2 = BoneMovieFactory.instance.creatBoneMovieFast("ConsortiaGuardBossMovie_4");
         _loc1_ = 1.3;
         _boss2.scaleY = _loc1_;
         _boss2.scaleX = _loc1_;
         PositionUtils.setPos(_boss2,"consortiaGuard.bossPos1");
         _disObjSortView.addDisplayObject(_boss2);
         _boss3 = BoneMovieFactory.instance.creatBoneMovieFast("ConsortiaGuardBossMovie_2");
         _loc1_ = 1.2;
         _boss3.scaleY = _loc1_;
         _boss3.scaleX = _loc1_;
         PositionUtils.setPos(_boss3,"consortiaGuard.bossPos2");
         _disObjSortView.addDisplayObject(_boss3);
         _boss4 = BoneMovieFactory.instance.creatBoneMovieFast("ConsortiaGuardBossMovie_3");
         _loc1_ = 1.5;
         _boss4.scaleY = _loc1_;
         _boss4.scaleX = _loc1_;
         PositionUtils.setPos(_boss4,"consortiaGuard.bossPos3");
         _disObjSortView.addDisplayObject(_boss4);
         _statue = new ConsortiaGuardStatue();
         PositionUtils.setPos(_statue,"consortiaGuard.statuePos");
         _disObjSortView.addDisplayObject(_statue);
      }
      
      private function initEvent() : void
      {
         Starling.current.stage.addEventListener("touch",__onPlayerClick);
         PlayerManager.Instance.addEventListener("setselfplayerpos",__onSetSelfPlayerPos);
         ConsortiaGuardControl.Instance.addEventListener("addPlayer",__onAddPlayer);
         ConsortiaGuardControl.Instance.addEventListener("updatePlayerState",__onUpdatePlayerState);
         ConsortiaGuardControl.Instance.addEventListener("removePlayer",__onRemovePlayer);
         ConsortiaGuardControl.Instance.addEventListener("updatePlayerView",__onUpdatePlayerView);
         ConsortiaGuardControl.Instance.addEventListener("clickBossIcon",__onClickBossIcon);
      }
      
      private function removeEvent() : void
      {
         Starling.current.stage.removeEventListener("touch",__onPlayerClick);
         removeEventListener("enterFrame",__updateFrame);
         PlayerManager.Instance.removeEventListener("setselfplayerpos",__onSetSelfPlayerPos);
         ConsortiaGuardControl.Instance.removeEventListener("addPlayer",__onAddPlayer);
         ConsortiaGuardControl.Instance.removeEventListener("updatePlayerState",__onUpdatePlayerState);
         ConsortiaGuardControl.Instance.removeEventListener("removePlayer",__onRemovePlayer);
         ConsortiaGuardControl.Instance.removeEventListener("updatePlayerView",__onUpdatePlayerView);
         ConsortiaGuardControl.Instance.removeEventListener("clickBossIcon",__onClickBossIcon);
         StateManager.getInGame_Step_8 = true;
      }
      
      private function __onClickBossIcon(param1:ConsortiaGuardEvent) : void
      {
         setSelfPlayerPos(Point(param1.data));
      }
      
      public function initPlayerView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = ConsortiaGuardControl.Instance.model.playerList;
         for each(var _loc1_ in ConsortiaGuardControl.Instance.model.playerList)
         {
            addPlayerInfo(_loc1_);
         }
      }
      
      private function __startLoading(param1:flash.events.Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      private function __onAddPlayer(param1:ConsortiaGuardEvent) : void
      {
         var _loc2_:FightPlayerVo = ConsortiaGuardControl.Instance.model.playerList[int(param1.data)];
         addPlayerInfo(_loc2_);
      }
      
      private function __onUpdatePlayerState(param1:ConsortiaGuardEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = param1.data as int;
         if(_loc2_ == PlayerManager.Instance.Self.ID)
         {
            _loc3_ = _selfPlayer;
         }
         else
         {
            _loc3_ = _friendPlayerDic[_loc2_];
         }
         _loc3_.fightPlayerVo.stateType = "consortiaGuard";
         _loc3_.updatePlayerState();
         if(_loc2_ == PlayerManager.Instance.Self.ID)
         {
            checkPlayerRevive();
         }
      }
      
      private function __onRemovePlayer(param1:ConsortiaGuardEvent) : void
      {
         removePlayerByID(int(param1.data));
      }
      
      private function __onUpdatePlayerView(param1:ConsortiaGuardEvent) : void
      {
         updateAllPlayerShow();
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
               addPlayerInfo(_loadPlayerDic[_loc2_]);
               delete _loadPlayerDic[_loc2_];
            }
         }
         if(_loc2_ == null)
         {
            _loadTimer.stop();
            _loadTimer.reset();
         }
      }
      
      public function addSelfPlayer() : void
      {
         if(!_mouseMovie)
         {
            _mouseMovie = BoneMovieFactory.instance.creatBoneMovie("hallScene.MouseClickMovie");
            _mouseMovie.stop();
            _mouseMovie.visible = false;
            _mouseMovie.touchable = false;
            addChild(_mouseMovie);
         }
         var _loc1_:FightPlayerVo = PlayerManager.Instance.fightVo;
         if(_friendPlayerDic[_loc1_.playerInfo.ID])
         {
            removePlayerByID(_loc1_.playerInfo.ID);
         }
         _selfPlayer = new FightPlayer(_loc1_);
         _selfPlayer.updatePlayerState();
         checkPlayerRevive();
         _selfPlayer.playerPoint = _playerPos;
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
         _selfPlayer.addEventListener("newhallbtnclick",__onFishWalk);
         _playerArray.push(_selfPlayer);
      }
      
      private function checkPlayerRevive() : void
      {
         var _loc1_:* = null;
         if(_selfPlayer.fightPlayerVo.isDie)
         {
            _loc1_ = new ConsortiaGuardReviveView();
            _loc1_.show(_selfPlayer.fightPlayerVo);
         }
      }
      
      private function addPlayerInfo(param1:FightPlayerVo) : void
      {
         var _loc2_:* = null;
         if(param1.playerInfo.ID != PlayerManager.Instance.Self.ID)
         {
            if(_friendPlayerDic[param1.playerInfo.ID])
            {
               removePlayerByID(param1.playerInfo.ID);
            }
            _loc2_ = new FightPlayer(param1);
            _loc2_.fightPlayerVo.stateType = "consortiaGuard";
            _loc2_.showPlayer = ConsortiaGuardControl.Instance.showPlayer;
            _loc2_.updatePlayerState();
            _loc2_.playerPoint = getRomdonPos();
            _friendPlayerDic[_loc2_.playerVO.playerInfo.ID] = _loc2_;
            _disObjSortView.addDisplayObject(_loc2_);
         }
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
               if(_disObjSortView.indexOfDisplayObject(_loc3_) != -1)
               {
                  _disObjSortView.removeDisplayObject(_loc3_,false);
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
               if(_disObjSortView.indexOfDisplayObject(_loc3_) != -1)
               {
                  _disObjSortView.removeDisplayObject(_loc3_,false);
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
      
      public function set type(param1:String) : void
      {
         _selfPlayer.sceneCharacterActionState = param1;
      }
      
      protected function __updateFrame(param1:starling.events.Event) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = undefined;
         var _loc3_:Number = NaN;
         if(!_playerArray)
         {
            return;
         }
         _disObjSortView.sortDisplayObjectLayer();
         var _loc2_:Array = _disObjSortView.disObjArr;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc5_];
            if(_loc4_)
            {
               if(_loc4_ is FightPlayer)
               {
                  _loc4_.updatePlayer();
               }
               if(_loc4_ != _selfPlayer)
               {
                  _loc3_ = (_selfPlayer.x - _loc4_.x) * (_selfPlayer.x - _loc4_.x) + (_selfPlayer.y - _loc4_.y) * (_selfPlayer.y - _loc4_.y);
                  if(_loc4_.y > _selfPlayer.y && _loc3_ < 10000)
                  {
                     _loc4_.alpha = 0.5;
                  }
                  else
                  {
                     _loc4_.alpha = 1;
                  }
               }
            }
            _loc5_++;
         }
      }
      
      protected function __onPlayerClick(param1:TouchEvent) : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc2_:Touch = param1.getTouch(Starling.current.stage,"ended");
         if(!_loc2_ || !this.touchable || LayerManager.Instance.backGroundInParent || _nativeStageClickFilter.isTypeOf([Bitmap,TextField,Component]) || ObjectUtils.getDisplayObjectSuperParent(_nativeStageClickFilter.nativeStageClickDisplayObj,ChatView,Starling.current.nativeStage) || ObjectUtils.getDisplayObjectSuperParent(_nativeStageClickFilter.nativeStageClickDisplayObj,ConsortiaGuardBossBar,Starling.current.nativeStage) || ObjectUtils.getDisplayObjectSuperParent(_nativeStageClickFilter.nativeStageClickDisplayObj,ConsortiaGuardSubBossRank,Starling.current.nativeStage))
         {
            return;
         }
         if(ConsortiaGuardControl.Instance.bossRankShow)
         {
            ConsortiaGuardControl.Instance.dispatchEvent(new ConsortiaGuardEvent("hideBossRank"));
         }
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("newhallsetplayertippos",[null]));
         if(_selfPlayer)
         {
            _loc5_ = 200;
            if(getTimer() - _lastClick > _loc5_)
            {
               _loc4_ = _loc2_.target;
               _loc6_ = _loc4_.parent;
               _loc3_ = _loc2_.getLocation(this);
               if(_nativeStageClickFilter.isTypeOf([ConsortiaGuardBoss]))
               {
                  _fightTarget = ObjectUtils.getDisplayObjectSuperParent(_nativeStageClickFilter.nativeStageClickDisplayObj,ConsortiaGuardBoss,Starling.current.nativeStage);
                  trace("click----- ",_fightTarget.index);
                  _loc3_ = _fightTarget.location;
               }
               else
               {
                  _fightTarget = null;
               }
               _lastClick = getTimer();
               setSelfPlayerPos(_loc3_);
            }
         }
      }
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void
      {
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("newhallsetplayertippos",[null]));
         var _loc2_:Point = this.globalToLocal(new Point(param1.data[0].stageX,param1.data[0].stageY));
         setSelfPlayerPos(_loc2_,true);
      }
      
      public function setSelfPlayerPos(param1:Point, param2:Boolean = true) : Boolean
      {
         var _loc3_:int = 0;
         if(_aStarPathFinder && !_aStarPathFinder.hit(param1) && !_selfPlayer.fightPlayerVo.isFight && !_selfPlayer.fightPlayerVo.isDie)
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
         if(_fightTarget)
         {
            SocketManager.Instance.out.sendConsortiaGuradFight(_fightTarget.index);
            _fightTarget = null;
         }
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
         var _loc8_:* = _loc7_;
         _clickBossLayer.x = _loc8_;
         this.x = _loc8_;
         _loc8_ = _loc3_;
         _clickBossLayer.y = _loc8_;
         this.y = _loc8_;
         _staticLayer.setPos(-_loc7_,-_loc3_);
         _staticLayer.setCenter();
         if(!_hidFlag)
         {
            var _loc10_:int = 0;
            var _loc9_:* = _unLoadPlayerDic;
            for(var _loc5_ in _unLoadPlayerDic)
            {
               if(_unLoadPlayerDic[_loc5_] && _unLoadPlayerDic[_loc5_].currentWalkStartPoint)
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
      
      private function updateAllPlayerShow() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _friendPlayerDic;
         for each(var _loc1_ in _friendPlayerDic)
         {
            if(!_loc1_.fightPlayerVo.playerInfo.isSelf)
            {
               _loc1_.showPlayer = ConsortiaGuardControl.Instance.showPlayer;
            }
         }
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
         StarlingObjectUtils.disposeObject(_boss1);
         _boss1 = null;
         StarlingObjectUtils.disposeObject(_boss2);
         _boss2 = null;
         StarlingObjectUtils.disposeObject(_boss3);
         _boss3 = null;
         StarlingObjectUtils.disposeObject(_boss4);
         _boss4 = null;
         StarlingObjectUtils.disposeObject(_statue);
         _statue = null;
         removePlayerByID();
         if(_selfPlayer)
         {
            _selfPlayer.removeEventListener("newhallbtnclick",__onFishWalk);
            StarlingObjectUtils.disposeObject(_selfPlayer);
            _selfPlayer = null;
         }
         _disObjSortView.dispose();
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
         ObjectUtils.disposeObject(_clickBossLayer);
         _clickBossLayer = null;
         _friendPlayerDic = null;
         _playerArray = null;
         _loadPlayerDic = null;
         _unLoadPlayerDic = null;
         _playerPos = null;
         _loadPkg = null;
         _judgePos = null;
         _disObjSortView = null;
         _sceneMapGridData = null;
         _aStarPathFinder.dispose();
         _aStarPathFinder = null;
         _staticLayer = null;
         super.dispose();
      }
   }
}
