package starling.scene.consortiaGuard{   import bones.BoneMovieFactory;   import bones.display.BoneMovieFastStarling;   import bones.display.BoneMovieStarling;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.core.SpriteLayer;   import com.pickgliss.utils.ObjectUtils;   import com.pickgliss.utils.StarlingObjectUtils;   import consortion.guard.ConsortiaGuardControl;   import consortion.guard.ConsortiaGuardEvent;   import consortion.view.guard.ConsortiaGuardBoss;   import consortion.view.guard.ConsortiaGuardBossBar;   import consortion.view.guard.ConsortiaGuardReviveView;   import consortion.view.guard.ConsortiaGuardSubBossRank;   import ddt.manager.ChatManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.utils.PositionUtils;   import ddt.view.chat.ChatView;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.text.TextField;   import flash.utils.Dictionary;   import flash.utils.Timer;   import flash.utils.getTimer;   import gameCommon.GameControl;   import hall.aStar.AStarPathFinder;   import hall.event.NewHallEvent;   import hall.player.aStar.Grid;   import hall.player.aStar.Node;   import hall.player.vo.PlayerVO;   import newTitle.NewTitleManager;   import road7th.comm.PackageIn;   import starling.core.Starling;   import starling.display.DisplayObject;   import starling.display.Sprite;   import starling.display.player.FightPlayer;   import starling.display.player.FightPlayerVo;   import starling.display.sceneCharacter.event.SceneCharacterEvent;   import starling.events.Touch;   import starling.events.TouchEvent;   import starling.scene.common.DisplayObjectSortView;   import starling.scene.common.NativeStageClickFilter;   import starling.scene.hall.SceneMapGridData;   import starling.scene.hall.event.NewHallEventStarling;      public class ConsortiaGuardPlayerView extends Sprite   {                   private const randomPathX:int = 2;            private const randomPathY:int = 1;            private const randomPathMap:Object = {"0_1":[462,470,1098,1022]};            private var _selfPlayer:FightPlayer;            private var _friendPlayerDic:Dictionary;            private var _disObjSortView:DisplayObjectSortView;            private var _playerArray:Array;            private var _lastClickTime:int = 0;            private var _playerPos:Point;            private var _hidFlag:Boolean;            private var _loadPlayerDic:Dictionary;            private var _unLoadPlayerDic:Dictionary;            private var _loadPkg:PackageIn;            private var _loadTimer:Timer;            private var _judgePos:Point;            private var _lastClick:Number = 0;            private var _sceneMapGridData:SceneMapGridData;            private var _aStarPathFinder:AStarPathFinder;            private var _mouseMovie:BoneMovieStarling;            private var _clickBossLayer:ConsortiaGuardSceneClick;            private var _staticLayer:ConsortiaGuardStaticLayer;            private var _nativeStageClickFilter:NativeStageClickFilter;            private var _boss1:BoneMovieFastStarling;            private var _boss2:BoneMovieFastStarling;            private var _boss3:BoneMovieFastStarling;            private var _boss4:BoneMovieFastStarling;            private var _statue:ConsortiaGuardStatue;            private var _fightTarget:ConsortiaGuardBoss;            public function ConsortiaGuardPlayerView() { super(); }
            private function init() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __onClickBossIcon(event:ConsortiaGuardEvent) : void { }
            public function initPlayerView() : void { }
            private function __startLoading(e:flash.events.Event) : void { }
            private function __onAddPlayer(e:ConsortiaGuardEvent) : void { }
            private function __onUpdatePlayerState(e:ConsortiaGuardEvent) : void { }
            private function __onRemovePlayer(e:ConsortiaGuardEvent) : void { }
            private function __onUpdatePlayerView(e:ConsortiaGuardEvent) : void { }
            private function startLoadOtherPlayer(flag:Boolean = true) : void { }
            protected function __onloadPlayerRes(event:TimerEvent) : void { }
            public function addSelfPlayer() : void { }
            private function checkPlayerRevive() : void { }
            private function addPlayerInfo(friendVo:FightPlayerVo) : void { }
            private function removePlayerByID(id:int = 0) : void { }
            public function set type(value:String) : void { }
            protected function __updateFrame(event:starling.events.Event) : void { }
            protected function __onPlayerClick(event:TouchEvent) : void { }
            protected function __onSetSelfPlayerPos(event:NewHallEvent) : void { }
            public function setSelfPlayerPos(pos:Point, mouseFlag:Boolean = true) : Boolean { return false; }
            public function setPlayerBorderPos(pos:Point) : Point { return null; }
            protected function __onFishWalk(event:NewHallEventStarling) : void { }
            protected function ajustScreen() : void { }
            public function setCenter(event:SceneCharacterEvent = null) : void { }
            public function getSelfPlayerPos() : Point { return null; }
            private function getPlayerIndexById(id:int) : int { return 0; }
            private function updateAllPlayerShow() : void { }
            private function initFriendVo(friendVo:PlayerVO) : void { }
            private function getPointPath(newStartPointIndex:int, newEndPointIndex:int) : Array { return null; }
            private function getEndPointIndex(startPointIndex:int) : int { return 0; }
            public function getRomdonPos() : Point { return null; }
            override public function dispose() : void { }
   }}