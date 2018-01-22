package christmas.view.playingSnowman
{
   import christmas.ChristmasCoreController;
   import christmas.ChristmasCoreManager;
   import christmas.event.ChristmasRoomEvent;
   import christmas.info.MonsterInfo;
   import christmas.manager.ChristmasMonsterManager;
   import christmas.model.ChristmasRoomModel;
   import christmas.player.ChristmasMonster;
   import christmas.player.ChristmasRoomPlayer;
   import christmas.player.PlayerVO;
   import church.vo.SceneMapVO;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class ChristmasScneneMap extends Sprite implements Disposeable
   {
      
      private static var selectSpeek:int = 1;
      
      public static var packsNum:int = 2;
       
      
      protected var articleLayer:Sprite;
      
      protected var meshLayer:Sprite;
      
      protected var bgLayer:Sprite;
      
      protected var skyLayer:Sprite;
      
      protected var snowLayer:Sprite;
      
      public var sceneScene:SceneScene;
      
      protected var _data:DictionaryData;
      
      protected var _characters:DictionaryData;
      
      public var selfPlayer:ChristmasRoomPlayer;
      
      private var last_click:Number;
      
      private var current_display_fire:int = 0;
      
      private var _currentLoadingPlayer:ChristmasRoomPlayer;
      
      private var _isShowName:Boolean = true;
      
      private var _isChatBall:Boolean = true;
      
      private var _clickInterval:Number = 200;
      
      private var _lastClick:Number = 0;
      
      private var _sceneMapVO:SceneMapVO;
      
      private var _model:ChristmasRoomModel;
      
      private var armyPos:Point;
      
      private var decorationLayer:Sprite;
      
      protected var _mapObjs:DictionaryData;
      
      protected var _monsters:DictionaryData;
      
      private var _snowMC:MovieClip;
      
      private var _snowCenterMc:MovieClip;
      
      private var _snowSpeakPng:Bitmap;
      
      private var _snowSpeak:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _mouseMovie:MovieClip;
      
      private var r:int = 250;
      
      private var auto:Point;
      
      private var autoMove:Boolean = false;
      
      private var _entering:Boolean = false;
      
      private var _speakTimer:Timer;
      
      private var _timeFive:Timer;
      
      private var endPoint:Point;
      
      protected var reference:ChristmasRoomPlayer;
      
      public function ChristmasScneneMap(param1:ChristmasRoomModel, param2:SceneScene, param3:DictionaryData, param4:DictionaryData, param5:Sprite, param6:Sprite, param7:Sprite = null, param8:Sprite = null, param9:Sprite = null, param10:Sprite = null){super();}
      
      private function initSnow() : void{}
      
      private function __onMouseOver(param1:MouseEvent) : void{}
      
      private function __onMouseOut(param1:MouseEvent) : void{}
      
      private function _enterSnowNPC(param1:MouseEvent) : void{}
      
      private function isAwradActOpen() : Boolean{return false;}
      
      private function isPacksComplete(param1:int = 1) : void{}
      
      private function checkDistance() : Boolean{return false;}
      
      public function set enterIng(param1:Boolean) : void{}
      
      public function get sceneMapVO() : SceneMapVO{return null;}
      
      public function set sceneMapVO(param1:SceneMapVO) : void{}
      
      protected function init() : void{}
      
      private function __santaSpeakTimer(param1:TimerEvent) : void{}
      
      private function __santaSpeakFiveSeconds(param1:TimerEvent) : void{}
      
      public function stopAllTimer() : void{}
      
      private function __santaSpeakFiveSecondsComplete(param1:TimerEvent) : void{}
      
      protected function addEvent() : void{}
      
      private function __getPacks(param1:CrazyTankSocketEvent) : void{}
      
      private function __addMonster(param1:DictionaryEvent) : void{}
      
      private function __removeMonster(param1:DictionaryEvent) : void{}
      
      private function __onMonsterUpdate(param1:DictionaryEvent) : void{}
      
      private function __snowSpeak(param1:CrazyTankSocketEvent) : void{}
      
      private function __timeShowSnowSpeak(param1:TimerEvent) : void{}
      
      private function __timeSnowSpeakComplete(param1:TimerEvent) : void{}
      
      private function menuChange(param1:ChristmasRoomEvent) : void{}
      
      public function nameVisible() : void{}
      
      protected function updateMap(param1:Event) : void{}
      
      protected function __click(param1:MouseEvent) : void{}
      
      public function sendMyPosition(param1:Array) : void{}
      
      public function movePlayer(param1:int, param2:Array) : void{}
      
      public function updatePlayersStauts(param1:int, param2:int, param3:Point) : void{}
      
      public function __otherPlayrStartFight(param1:ChristmasRoomEvent) : void{}
      
      public function updateSelfStatus(param1:int) : void{}
      
      public function checkSelfStatus() : int{return 0;}
      
      public function playerRevive(param1:int) : void{}
      
      public function setCenter(param1:SceneCharacterEvent = null) : void{}
      
      public function addSelfPlayer() : void{}
      
      protected function ajustScreen(param1:ChristmasRoomPlayer) : void{}
      
      protected function __addPlayer(param1:DictionaryEvent) : void{}
      
      private function addPlayerCallBack(param1:ChristmasRoomPlayer, param2:Boolean, param3:int) : void{}
      
      private function playerActionChange(param1:SceneCharacterEvent) : void{}
      
      protected function __removePlayer(param1:DictionaryEvent) : void{}
      
      protected function BuildEntityDepth() : void{}
      
      protected function getPointDepth(param1:Number, param2:Number) : Number{return 0;}
      
      protected function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
