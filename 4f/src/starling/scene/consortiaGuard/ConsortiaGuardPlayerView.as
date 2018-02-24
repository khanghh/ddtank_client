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
      
      public function ConsortiaGuardPlayerView(){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __onClickBossIcon(param1:ConsortiaGuardEvent) : void{}
      
      public function initPlayerView() : void{}
      
      private function __startLoading(param1:flash.events.Event) : void{}
      
      private function __onAddPlayer(param1:ConsortiaGuardEvent) : void{}
      
      private function __onUpdatePlayerState(param1:ConsortiaGuardEvent) : void{}
      
      private function __onRemovePlayer(param1:ConsortiaGuardEvent) : void{}
      
      private function __onUpdatePlayerView(param1:ConsortiaGuardEvent) : void{}
      
      private function startLoadOtherPlayer(param1:Boolean = true) : void{}
      
      protected function __onloadPlayerRes(param1:TimerEvent) : void{}
      
      public function addSelfPlayer() : void{}
      
      private function checkPlayerRevive() : void{}
      
      private function addPlayerInfo(param1:FightPlayerVo) : void{}
      
      private function removePlayerByID(param1:int = 0) : void{}
      
      public function set type(param1:String) : void{}
      
      protected function __updateFrame(param1:starling.events.Event) : void{}
      
      protected function __onPlayerClick(param1:TouchEvent) : void{}
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void{}
      
      public function setSelfPlayerPos(param1:Point, param2:Boolean = true) : Boolean{return false;}
      
      public function setPlayerBorderPos(param1:Point) : Point{return null;}
      
      protected function __onFishWalk(param1:NewHallEventStarling) : void{}
      
      protected function ajustScreen() : void{}
      
      public function setCenter(param1:SceneCharacterEvent = null) : void{}
      
      public function getSelfPlayerPos() : Point{return null;}
      
      private function getPlayerIndexById(param1:int) : int{return 0;}
      
      private function updateAllPlayerShow() : void{}
      
      private function initFriendVo(param1:PlayerVO) : void{}
      
      private function getPointPath(param1:int, param2:int) : Array{return null;}
      
      private function getEndPointIndex(param1:int) : int{return 0;}
      
      public function getRomdonPos() : Point{return null;}
      
      override public function dispose() : void{}
   }
}
