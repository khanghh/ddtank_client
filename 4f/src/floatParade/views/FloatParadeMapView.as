package floatParade.views{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.utils.Timer;   import floatParade.FloatParadeEvent;   import floatParade.FloatParadeManager;   import floatParade.components.FloatParadeNPCpaopao;   import floatParade.data.FloatParadeCarInfo;   import floatParade.data.FloatParadePlayerInfo;   import floatParade.player.FloatParadeGameItem;   import floatParade.player.FloatParadeGamePlayer;   import road7th.data.DictionaryData;      public class FloatParadeMapView extends Sprite implements Disposeable   {            public static const LEN:int = 33600;            public static const INIT_X:int = 280;                   private var _mapLayer:Sprite;            private var _playerLayer:Sprite;            private var _playerList:Vector.<FloatParadeGamePlayer>;            private var _selfPlayer:FloatParadeGamePlayer;            private var _itemList:DictionaryData;            private var _playerItemList:Array;            private var _rankArriveList:Array;            private var _needRankList:DictionaryData;            private var _isStartGame:Boolean = false;            private var _mapBitmapData:BitmapData;            private var _startMc:MovieClip;            private var _endMc:MovieClip;            private var _boguArr:Array;            private var _finishTag:Bitmap;            private var _runPercent:FloatParadeRunPercent;            private var _arriveCountDown:FloatParadeArriveCountDown;            private var _npcArriveTime:Date;            private var _npcPlayer:FloatParadeGamePlayer;            private var _paopaoView:FloatParadeNPCpaopao;            private var _enterFrameCount:int = 0;            private var _secondCount:int = 0;            private var _beyondNPC:Boolean;            private var _endFlag:Boolean = false;            private var _isTween:Boolean = false;            public function FloatParadeMapView() { super(); }
            public function set runPercent(value:FloatParadeRunPercent) : void { }
            public function set arriveCountDown(value:FloatParadeArriveCountDown) : void { }
            private function initView() : void { }
            private function initMapLayer() : void { }
            private function initPlayer() : void { }
            private function initEvent() : void { }
            private function rankArriveListChangeHandler(event:FloatParadeEvent) : void { }
            private function refreshNeedRankList() : void { }
            private function updateRankList() : void { }
            private function playerFightStateChangeHandler(event:FloatParadeEvent) : void { }
            private function createPlayerHandler(event:Event) : void { }
            private function useSkillHandler(event:FloatParadeEvent) : void { }
            private function refreshBuffHandler(event:FloatParadeEvent) : void { }
            private function refreshItemHandler(event:FloatParadeEvent) : void { }
            private function playerItemDepth() : void { }
            private function moveHandler(event:FloatParadeEvent) : void { }
            private function updateMap(event:Event) : void { }
            private function calibrateNpcPos() : void { }
            private function setCenter(isNeedTween:Boolean = true) : void { }
            private function tweenComplete() : void { }
            public function startGame() : void { }
            public function endGame() : void { }
            private function playLaunchMcHandler(event:FloatParadeEvent) : void { }
            protected function __launchTimerComplete(event:TimerEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
            public function get selfPlayer() : FloatParadeGamePlayer { return null; }
            public function set npcArriveTime(value:Date) : void { }
            public function npcChat(str:String, direction:int = 0) : void { }
            protected function __paopaoViewHide(event:Event) : void { }
   }}