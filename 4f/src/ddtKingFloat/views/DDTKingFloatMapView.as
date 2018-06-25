package ddtKingFloat.views{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddtKingFloat.DDTKingFloatEvent;   import ddtKingFloat.DDTKingFloatManager;   import ddtKingFloat.components.DDTKingFloatNPCpaopao;   import ddtKingFloat.data.DDTKingFloatCarInfo;   import ddtKingFloat.data.DDTKingFloatPlayerInfo;   import ddtKingFloat.player.DDTKingFloatGameItem;   import ddtKingFloat.player.DDTKingFloatGamePlayer;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.utils.Timer;   import road7th.data.DictionaryData;      public class DDTKingFloatMapView extends Sprite implements Disposeable   {            public static const LEN:int = 33600;            public static const INIT_X:int = 280;                   private var _mapLayer:Sprite;            private var _playerLayer:Sprite;            private var _playerList:Vector.<DDTKingFloatGamePlayer>;            private var _selfPlayer:DDTKingFloatGamePlayer;            private var _itemList:DictionaryData;            private var _playerItemList:Array;            private var _rankArriveList:Array;            private var _needRankList:DictionaryData;            private var _isStartGame:Boolean = false;            private var _mapBitmapData:BitmapData;            private var _startMc:MovieClip;            private var _endMc:MovieClip;            private var _finishTag:Bitmap;            private var _runPercent:DDTKingFloatRunPercent;            private var _arriveCountDown:DDTKingFloatArriveCountDown;            private var _npcArriveTime:Date;            private var _npcPlayer:DDTKingFloatGamePlayer;            private var _paopaoView:DDTKingFloatNPCpaopao;            private var _mapImg0:Bitmap;            private var _mapImg1:Bitmap;            private var _mapWidth:Number = 0;            private var _enterFrameCount:int = 0;            private var _secondCount:int = 0;            private var _beyondNPC:Boolean;            private var _endFlag:Boolean = false;            private var __preTime:Number = 0;            private var __curTime:Number = 0;            private var _isTween:Boolean = false;            private var bmpWidth:Number;            public function DDTKingFloatMapView() { super(); }
            public function set runPercent(value:DDTKingFloatRunPercent) : void { }
            public function set arriveCountDown(value:DDTKingFloatArriveCountDown) : void { }
            private function initView() : void { }
            private function initMapLayer() : void { }
            private function initPlayer() : void { }
            private function initEvent() : void { }
            private function rankArriveListChangeHandler(event:DDTKingFloatEvent) : void { }
            private function refreshNeedRankList() : void { }
            private function updateRankList() : void { }
            private function playerFightStateChangeHandler(event:DDTKingFloatEvent) : void { }
            private function createPlayerHandler(event:Event) : void { }
            private function useSkillHandler(event:DDTKingFloatEvent) : void { }
            private function refreshBuffHandler(event:DDTKingFloatEvent) : void { }
            private function refreshItemHandler(event:DDTKingFloatEvent) : void { }
            private function playerItemDepth() : void { }
            private function moveHandler(event:DDTKingFloatEvent) : void { }
            private function updateMap(event:Event) : void { }
            private function calibrateNpcPos() : void { }
            private function setCenter(isNeedTween:Boolean = true) : void { }
            private function tweenComplete() : void { }
            public function startGame() : void { }
            public function endGame() : void { }
            private function playLaunchMcHandler(event:DDTKingFloatEvent) : void { }
            protected function __launchTimerComplete(event:TimerEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
            public function get selfPlayer() : DDTKingFloatGamePlayer { return null; }
            public function set npcArriveTime(value:Date) : void { }
            public function npcChat(str:String, direction:int = 0) : void { }
            protected function __paopaoViewHide(event:Event) : void { }
   }}