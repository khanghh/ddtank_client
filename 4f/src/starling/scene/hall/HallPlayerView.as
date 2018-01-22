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

import flash.display.Sprite;
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
      
      public function HallPlayerView(){super();}
      
      private function drawMouseClickLayer() : void{}
      
      private function sendPkg() : void{}
      
      private function initEvent() : void{}
      
      private function onStageResize(param1:ResizeEvent) : void{}
      
      protected function __onShowPets(param1:NewHallEvent) : void{}
      
      protected function __onFriendPlayerInfo(param1:PkgEvent) : void{}
      
      private function startLoadOtherPlayer(param1:Boolean = true) : void{}
      
      private function judgePlayerShow(param1:int) : Boolean{return false;}
      
      protected function __onloadPlayerRes(param1:TimerEvent) : void{}
      
      private function getRandNum(param1:int, param2:int) : int{return 0;}
      
      protected function __onPlayerHid(param1:PkgEvent) : void{}
      
      protected function __updateTitle(param1:NewHallEvent) : void{}
      
      protected function __updatePlayerDressInfo(param1:PlayerDressEvent) : void{}
      
      private function addSelfPlayer() : void{}
      
      private function readPlayerInfoPkg(param1:PackageIn) : PlayerVO{return null;}
      
      private function initFriendVo(param1:PlayerVO) : void{}
      
      private function getEndPointIndex(param1:int) : int{return 0;}
      
      private function getPointPath(param1:int, param2:int) : Array{return null;}
      
      private function setPlayerInfo(param1:PlayerVO, param2:Boolean = false) : void{}
      
      private function removePlayerByID(param1:int = 0) : void{}
      
      private function addPlayerCallBack(param1:HallPlayer) : void{}
      
      public function set type(param1:String) : void{}
      
      private function playerActionChange(param1:SceneCharacterEvent) : void{}
      
      protected function __updateFrame(param1:Event) : void{}
      
      protected function __onPlayerClick(param1:MouseEvent) : void{}
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void{}
      
      public function setSelfPlayerPos(param1:Point, param2:Boolean = true, param3:Boolean = false) : Boolean{return false;}
      
      public function setPlayerBorderPos(param1:Point) : Point{return null;}
      
      protected function __onFishWalk(param1:NewHallEventStarling) : void{}
      
      public function sendMyPosition(param1:Array) : void{}
      
      protected function ajustScreen() : void{}
      
      public function setCenter(param1:SceneCharacterEvent = null) : void{}
      
      public function moveBgToTargetPos(param1:Number, param2:Number, param3:Number) : void{}
      
      private function onMoveBgToTargetPosUpdate() : void{}
      
      public function getSelfPlayerPos() : Point{return null;}
      
      private function getPlayerIndexById(param1:int) : int{return 0;}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
      
      public function set mapID(param1:int) : void{}
      
      public function get staticLayer() : StaticLayer{return null;}
   }
}
