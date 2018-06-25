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
         var senceLayer:SpriteLayer = LayerManager.Instance.getLayerByType(5);
         _clickBossLayer = new ConsortiaGuardSceneClick();
         senceLayer.addChild(_clickBossLayer);
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
      
      private function __onClickBossIcon(event:ConsortiaGuardEvent) : void
      {
         setSelfPlayerPos(Point(event.data));
      }
      
      public function initPlayerView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = ConsortiaGuardControl.Instance.model.playerList;
         for each(var vo in ConsortiaGuardControl.Instance.model.playerList)
         {
            addPlayerInfo(vo);
         }
      }
      
      private function __startLoading(e:flash.events.Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      private function __onAddPlayer(e:ConsortiaGuardEvent) : void
      {
         var vo:FightPlayerVo = ConsortiaGuardControl.Instance.model.playerList[int(e.data)];
         addPlayerInfo(vo);
      }
      
      private function __onUpdatePlayerState(e:ConsortiaGuardEvent) : void
      {
         var player:* = null;
         var id:int = e.data as int;
         if(id == PlayerManager.Instance.Self.ID)
         {
            player = _selfPlayer;
         }
         else
         {
            player = _friendPlayerDic[id];
         }
         player.fightPlayerVo.stateType = "consortiaGuard";
         player.updatePlayerState();
         if(id == PlayerManager.Instance.Self.ID)
         {
            checkPlayerRevive();
         }
      }
      
      private function __onRemovePlayer(e:ConsortiaGuardEvent) : void
      {
         removePlayerByID(int(e.data));
      }
      
      private function __onUpdatePlayerView(e:ConsortiaGuardEvent) : void
      {
         updateAllPlayerShow();
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
               addPlayerInfo(_loadPlayerDic[id]);
               delete _loadPlayerDic[id];
            }
         }
         if(id == null)
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
         var selfPlayerVO:FightPlayerVo = PlayerManager.Instance.fightVo;
         if(_friendPlayerDic[selfPlayerVO.playerInfo.ID])
         {
            removePlayerByID(selfPlayerVO.playerInfo.ID);
         }
         _selfPlayer = new FightPlayer(selfPlayerVO);
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
         var view:* = null;
         if(_selfPlayer.fightPlayerVo.isDie)
         {
            view = new ConsortiaGuardReviveView();
            view.show(_selfPlayer.fightPlayerVo);
         }
      }
      
      private function addPlayerInfo(friendVo:FightPlayerVo) : void
      {
         var friendPlayer:* = null;
         if(friendVo.playerInfo.ID != PlayerManager.Instance.Self.ID)
         {
            if(_friendPlayerDic[friendVo.playerInfo.ID])
            {
               removePlayerByID(friendVo.playerInfo.ID);
            }
            friendPlayer = new FightPlayer(friendVo);
            friendPlayer.fightPlayerVo.stateType = "consortiaGuard";
            friendPlayer.showPlayer = ConsortiaGuardControl.Instance.showPlayer;
            friendPlayer.updatePlayerState();
            friendPlayer.playerPoint = getRomdonPos();
            _friendPlayerDic[friendPlayer.playerVO.playerInfo.ID] = friendPlayer;
            _disObjSortView.addDisplayObject(friendPlayer);
         }
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
               if(_disObjSortView.indexOfDisplayObject(hallPlayer) != -1)
               {
                  _disObjSortView.removeDisplayObject(hallPlayer,false);
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
               if(_disObjSortView.indexOfDisplayObject(hallPlayer) != -1)
               {
                  _disObjSortView.removeDisplayObject(hallPlayer,false);
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
      
      public function set type(value:String) : void
      {
         _selfPlayer.sceneCharacterActionState = value;
      }
      
      protected function __updateFrame(event:starling.events.Event) : void
      {
         var i:int = 0;
         var obj:* = undefined;
         var dis:Number = NaN;
         if(!_playerArray)
         {
            return;
         }
         _disObjSortView.sortDisplayObjectLayer();
         var entityArr:Array = _disObjSortView.disObjArr;
         for(i = 0; i < entityArr.length; )
         {
            obj = entityArr[i];
            if(obj)
            {
               if(obj is FightPlayer)
               {
                  obj.updatePlayer();
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
         var touch:Touch = event.getTouch(Starling.current.stage,"ended");
         if(!touch || !this.touchable || LayerManager.Instance.backGroundInParent || _nativeStageClickFilter.isTypeOf([Bitmap,TextField,Component]) || ObjectUtils.getDisplayObjectSuperParent(_nativeStageClickFilter.nativeStageClickDisplayObj,ChatView,Starling.current.nativeStage) || ObjectUtils.getDisplayObjectSuperParent(_nativeStageClickFilter.nativeStageClickDisplayObj,ConsortiaGuardBossBar,Starling.current.nativeStage) || ObjectUtils.getDisplayObjectSuperParent(_nativeStageClickFilter.nativeStageClickDisplayObj,ConsortiaGuardSubBossRank,Starling.current.nativeStage))
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
            clickInterval = 200;
            if(getTimer() - _lastClick > clickInterval)
            {
               touchDisplayObject = touch.target;
               touchDisplayObjectP = touchDisplayObject.parent;
               targetPoint = touch.getLocation(this);
               if(_nativeStageClickFilter.isTypeOf([ConsortiaGuardBoss]))
               {
                  _fightTarget = ObjectUtils.getDisplayObjectSuperParent(_nativeStageClickFilter.nativeStageClickDisplayObj,ConsortiaGuardBoss,Starling.current.nativeStage);
                  trace("click----- ",_fightTarget.index);
                  targetPoint = _fightTarget.location;
               }
               else
               {
                  _fightTarget = null;
               }
               _lastClick = getTimer();
               setSelfPlayerPos(targetPoint);
            }
         }
      }
      
      protected function __onSetSelfPlayerPos(event:NewHallEvent) : void
      {
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("newhallsetplayertippos",[null]));
         var targetPoint:Point = this.globalToLocal(new Point(event.data[0].stageX,event.data[0].stageY));
         setSelfPlayerPos(targetPoint,true);
      }
      
      public function setSelfPlayerPos(pos:Point, mouseFlag:Boolean = true) : Boolean
      {
         var currClickTime:int = 0;
         if(_aStarPathFinder && !_aStarPathFinder.hit(pos) && !_selfPlayer.fightPlayerVo.isFight && !_selfPlayer.fightPlayerVo.isDie)
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
         var _loc8_:* = xf;
         _clickBossLayer.x = _loc8_;
         this.x = _loc8_;
         _loc8_ = yf;
         _clickBossLayer.y = _loc8_;
         this.y = _loc8_;
         _staticLayer.setPos(-xf,-yf);
         _staticLayer.setCenter();
         if(!_hidFlag)
         {
            var _loc10_:int = 0;
            var _loc9_:* = _unLoadPlayerDic;
            for(var id1 in _unLoadPlayerDic)
            {
               if(_unLoadPlayerDic[id1] && _unLoadPlayerDic[id1].currentWalkStartPoint)
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
      
      private function updateAllPlayerShow() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _friendPlayerDic;
         for each(var player in _friendPlayerDic)
         {
            if(!player.fightPlayerVo.playerInfo.isSelf)
            {
               player.showPlayer = ConsortiaGuardControl.Instance.showPlayer;
            }
         }
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
