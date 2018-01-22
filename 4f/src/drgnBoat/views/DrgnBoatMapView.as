package drgnBoat.views
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import drgnBoat.DrgnBoatManager;
   import drgnBoat.data.DrgnBoatCarInfo;
   import drgnBoat.data.DrgnBoatPlayerInfo;
   import drgnBoat.event.DrgnBoatEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.data.DictionaryData;
   
   public class DrgnBoatMapView extends Sprite implements Disposeable
   {
       
      
      private var _mapLayer:Sprite;
      
      private var _playerLayer:Sprite;
      
      private var _playerList:Vector.<DrgnBoatGamePlayer>;
      
      private var _selfPlayer:DrgnBoatGamePlayer;
      
      private var _itemList:DictionaryData;
      
      private var _playerItemList:Array;
      
      private var _rankArriveList:Array;
      
      private var _needRankList:DictionaryData;
      
      private var _isStartGame:Boolean = false;
      
      private var _mapBitmapData:BitmapData;
      
      private var _startMc:MovieClip;
      
      private var _endMc:MovieClip;
      
      private var _boguArr:Array;
      
      private var _finishTag:Bitmap;
      
      private var _runPercent:DrgnBoatRunPercent;
      
      private var _arriveCountDown:DrgnBoatArriveCountDown;
      
      private var _npcArriveTime:Date;
      
      private var _npcPlayer:DrgnBoatGamePlayer;
      
      private var _paopaoView:DrgnBoatNPCpaopao;
      
      private var _enterFrameCount:int = 0;
      
      private var _secondCount:int = 0;
      
      private var _beyondNPC:Boolean;
      
      private var _endFlag:Boolean = false;
      
      private var _isTween:Boolean = false;
      
      public function DrgnBoatMapView(){super();}
      
      public function set runPercent(param1:DrgnBoatRunPercent) : void{}
      
      public function set arriveCountDown(param1:DrgnBoatArriveCountDown) : void{}
      
      private function initView() : void{}
      
      private function initMapLayer() : void{}
      
      private function initPlayer() : void{}
      
      private function initEvent() : void{}
      
      private function rankArriveListChangeHandler(param1:DrgnBoatEvent) : void{}
      
      private function refreshNeedRankList() : void{}
      
      private function updateRankList() : void{}
      
      private function playerFightStateChangeHandler(param1:DrgnBoatEvent) : void{}
      
      private function createPlayerHandler(param1:Event) : void{}
      
      private function useSkillHandler(param1:DrgnBoatEvent) : void{}
      
      private function refreshBuffHandler(param1:DrgnBoatEvent) : void{}
      
      private function refreshItemHandler(param1:DrgnBoatEvent) : void{}
      
      private function playerItemDepth() : void{}
      
      private function moveHandler(param1:DrgnBoatEvent) : void{}
      
      private function updateMap(param1:Event) : void{}
      
      private function calibrateNpcPos() : void{}
      
      private function setCenter(param1:Boolean = true) : void{}
      
      private function tweenComplete() : void{}
      
      public function startGame() : void{}
      
      public function endGame() : void{}
      
      private function playLaunchMcHandler(param1:DrgnBoatEvent) : void{}
      
      protected function __launchTimerComplete(param1:TimerEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
      
      public function get selfPlayer() : DrgnBoatGamePlayer{return null;}
      
      public function set npcArriveTime(param1:Date) : void{}
      
      public function npcChat(param1:String, param2:int = 0) : void{}
      
      protected function __paopaoViewHide(param1:Event) : void{}
   }
}
