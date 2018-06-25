package drgnBoat.views{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import drgnBoat.DrgnBoatManager;   import drgnBoat.data.DrgnBoatCarInfo;   import drgnBoat.data.DrgnBoatPlayerInfo;   import drgnBoat.event.DrgnBoatEvent;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.utils.Timer;   import road7th.data.DictionaryData;      public class DrgnBoatMapView extends Sprite implements Disposeable   {                   private var _mapLayer:Sprite;            private var _playerLayer:Sprite;            private var _playerList:Vector.<DrgnBoatGamePlayer>;            private var _selfPlayer:DrgnBoatGamePlayer;            private var _itemList:DictionaryData;            private var _playerItemList:Array;            private var _rankArriveList:Array;            private var _needRankList:DictionaryData;            private var _isStartGame:Boolean = false;            private var _mapBitmapData:BitmapData;            private var _startMc:MovieClip;            private var _endMc:MovieClip;            private var _boguArr:Array;            private var _finishTag:Bitmap;            private var _runPercent:DrgnBoatRunPercent;            private var _arriveCountDown:DrgnBoatArriveCountDown;            private var _npcArriveTime:Date;            private var _npcPlayer:DrgnBoatGamePlayer;            private var _paopaoView:DrgnBoatNPCpaopao;            private var _enterFrameCount:int = 0;            private var _secondCount:int = 0;            private var _beyondNPC:Boolean;            private var _endFlag:Boolean = false;            private var _isTween:Boolean = false;            public function DrgnBoatMapView() { super(); }
            public function set runPercent(value:DrgnBoatRunPercent) : void { }
            public function set arriveCountDown(value:DrgnBoatArriveCountDown) : void { }
            private function initView() : void { }
            private function initMapLayer() : void { }
            private function initPlayer() : void { }
            private function initEvent() : void { }
            private function rankArriveListChangeHandler(event:DrgnBoatEvent) : void { }
            private function refreshNeedRankList() : void { }
            private function updateRankList() : void { }
            private function playerFightStateChangeHandler(event:DrgnBoatEvent) : void { }
            private function createPlayerHandler(event:Event) : void { }
            private function useSkillHandler(event:DrgnBoatEvent) : void { }
            private function refreshBuffHandler(event:DrgnBoatEvent) : void { }
            private function refreshItemHandler(event:DrgnBoatEvent) : void { }
            private function playerItemDepth() : void { }
            private function moveHandler(event:DrgnBoatEvent) : void { }
            private function updateMap(event:Event) : void { }
            private function calibrateNpcPos() : void { }
            private function setCenter(isNeedTween:Boolean = true) : void { }
            private function tweenComplete() : void { }
            public function startGame() : void { }
            public function endGame() : void { }
            private function playLaunchMcHandler(event:DrgnBoatEvent) : void { }
            protected function __launchTimerComplete(event:TimerEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
            public function get selfPlayer() : DrgnBoatGamePlayer { return null; }
            public function set npcArriveTime(value:Date) : void { }
            public function npcChat(str:String, direction:int = 0) : void { }
            protected function __paopaoViewHide(event:Event) : void { }
   }}