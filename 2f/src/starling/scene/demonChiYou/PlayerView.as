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

import flash.display.Sprite;
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
      
      public function PlayerView(){super();}
      
      private function drawMouseClickLayer() : void{}
      
      private function drawBossClickLayer() : void{}
      
      private function sendPkg() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onOtherEnter(param1:CEvent) : void{}
      
      private function onOtherLeave(param1:CEvent) : void{}
      
      private function onBossEnd(param1:flash.events.Event) : void{}
      
      private function onFightState(param1:PkgEvent) : void{}
      
      private function onBossClick(param1:MouseEvent) : void{}
      
      private function onStageResize(param1:ResizeEvent) : void{}
      
      protected function __onShowPets(param1:NewHallEvent) : void{}
      
      protected function __onFriendPlayerInfo(param1:PkgEvent) : void{}
      
      private function startLoadOtherPlayer(param1:Boolean = true) : void{}
      
      protected function __onloadPlayerRes(param1:TimerEvent) : void{}
      
      private function getRandNum(param1:int, param2:int) : int{return 0;}
      
      protected function __onPlayerHid(param1:PkgEvent) : void{}
      
      protected function __updateTitle(param1:NewHallEvent) : void{}
      
      protected function __updatePlayerDressInfo(param1:PlayerDressEvent) : void{}
      
      private function addSelfPlayer() : void{}
      
      private function readPlayerInfoPkg(param1:PackageIn) : DemonChiYouPlayerVO{return null;}
      
      private function initFriendVo(param1:PlayerVO) : void{}
      
      private function getEndPointIndex(param1:int) : int{return 0;}
      
      private function getPointPath(param1:int, param2:int) : Array{return null;}
      
      private function setPlayerInfo(param1:DemonChiYouPlayerVO, param2:Boolean = false) : void{}
      
      private function removePlayerByID(param1:int = 0) : void{}
      
      private function addPlayerCallBack(param1:DemonChiYouHallPlayer) : void{}
      
      public function set type(param1:String) : void{}
      
      private function playerActionChange(param1:SceneCharacterEvent) : void{}
      
      protected function __updateFrame(param1:starling.events.Event) : void{}
      
      protected function __onPlayerClick(param1:MouseEvent) : void{}
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void{}
      
      public function setSelfPlayerPos(param1:Point, param2:Boolean = true) : Boolean{return false;}
      
      public function setPlayerBorderPos(param1:Point) : Point{return null;}
      
      protected function __onFishWalk(param1:NewHallEventStarling) : void{}
      
      private function startGame() : void{}
      
      private function checkDistance() : Boolean{return false;}
      
      private function checkCanStartGame() : Boolean{return false;}
      
      protected function ajustScreen() : void{}
      
      public function setCenter(param1:SceneCharacterEvent = null) : void{}
      
      public function getSelfPlayerPos() : Point{return null;}
      
      private function getPlayerIndexById(param1:int) : int{return 0;}
      
      public function getRomdonPos() : Point{return null;}
      
      override public function dispose() : void{}
      
      public function set mapID(param1:int) : void{}
   }
}
