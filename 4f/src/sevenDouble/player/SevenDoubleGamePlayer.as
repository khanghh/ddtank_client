package sevenDouble.player{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.utils.Timer;   import road7th.data.DictionaryData;   import sevenDouble.SevenDoubleControl;   import sevenDouble.SevenDoubleManager;   import sevenDouble.data.SevenDoubleCarInfo;   import sevenDouble.data.SevenDoublePlayerInfo;   import sevenDouble.event.SevenDoubleEvent;   import sevenDouble.view.SevenDoubleBuffCountDownView;      public class SevenDoubleGamePlayer extends Sprite implements Disposeable   {                   private var _playerInfo:SevenDoublePlayerInfo;            private var _playerMc:MovieClip;            private var _destinationX:int;            private var _carInfo:SevenDoubleCarInfo;            private var _moveTimer:Timer;            private var _nameTxt:FilterFrameText;            private var _buffCountDownList:DictionaryData;            private var _isDispose:Boolean = false;            private var _fightMc:MovieClip;            private var _leapArrow:Bitmap;            public function SevenDoubleGamePlayer(playerInfo:SevenDoublePlayerInfo) { super(); }
            public function get playerInfo() : SevenDoublePlayerInfo { return null; }
            public function set destinationX(value:Number) : void { }
            private function loadRes() : void { }
            private function onLoadComplete(event:LoaderEvent) : void { }
            private function moveTimerHandler(event:TimerEvent) : void { }
            private function showOrHideLeapArrow(event:SevenDoubleEvent) : void { }
            public function refreshBuffCountDown() : void { }
            private function buffCountDownEnd(event:Event) : void { }
            public function updatePlayer() : void { }
            public function refreshFightMc() : void { }
            public function startGame() : void { }
            public function endGame() : void { }
            public function dispose() : void { }
   }}