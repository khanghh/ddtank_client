package ddt.view.roulette{   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.events.TimerEvent;   import flash.utils.Timer;      public class TurnControl extends EventDispatcher   {            public static const TURNCOMPLETE:String = "turn_complete";            public static const TYPE_SPEED_UP:int = 1;            public static const TYPE_SPEED_UNCHANGE:int = 2;            public static const TYPE_SPEED_DOWN:int = 3;            public static const MINTIME_PLAY_SOUNDONESTEP:int = 30;            public static const PLAY_SOUNDTHREESTEP_NUMBER:int = 14;            public static const SHADOW_NUMBER:int = 3;            public static const DOWN_SUB_SHADOW_BOL:int = 9;            public static const SPEEDUP_RATE:int = -60;            public static const SPEEDDOWN_RATE:int = 30;                   private var _goodsList:Vector.<RouletteGoodsCell>;            private var _turnType:int = 1;            private var _timer:Timer;            private var _timerII:Timer;            private var _isStopTurn:Boolean = false;            private var _nowDelayTime:int = 1000;            private var _sparkleNumber:int = 0;            private var _delay:Array;            private var _moveTime:Array;            private var _selectedGoodsNumber:int = 0;            private var _turnTypeTimeSum:int = 0;            private var _stepTime:int = 0;            private var _startModerationNumber:int = 0;            private var _moderationNumber:int = 0;            private var _sound:TurnSoundControl;            public function TurnControl(target:IEventDispatcher = null) { super(null); }
            private function init() : void { }
            public function set autoMove(boo:Boolean) : void { }
            private function initEvent() : void { }
            private function _startTimer(time:int) : void { }
            private function _nextNode() : void { }
            private function _clearPrevSelct(now:int, prev:int) : void { }
            private function _timeComplete(e:TimerEvent) : void { }
            private function _timerIITimer(e:TimerEvent) : void { }
            private function _updateTurnType(value:int) : void { }
            public function startTurn() : void { }
            public function stopTurn() : void { }
            private function _turnComplete() : void { }
            public function turnPlate(list:Vector.<RouletteGoodsCell>, _select:int) : void { }
            public function turnPlateII(list:Vector.<RouletteGoodsCell>) : void { }
            public function set sparkleNumber(value:int) : void { }
            public function get sparkleNumber() : int { return 0; }
            private function get prevSelected() : int { return 0; }
            public function set nowDelayTime(value:int) : void { }
            public function get nowDelayTime() : int { return 0; }
            public function set turnType(value:int) : void { }
            public function get turnType() : int { return 0; }
            public function set goodsList(list:Vector.<RouletteGoodsCell>) : void { }
            public function set selectedGoodsNumber(value:int) : void { }
            public function dispose() : void { }
   }}