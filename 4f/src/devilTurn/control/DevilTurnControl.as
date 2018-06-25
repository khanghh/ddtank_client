package devilTurn.control{   import ddt.view.roulette.TurnSoundControl;   import devilTurn.view.DevilTurnCell;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.TimerEvent;   import flash.utils.Timer;      public class DevilTurnControl extends EventDispatcher   {            public static const SPEEDUP_RATE:int = -80;            public static const SPEEDDOWN_RATE:int = 80;            public static const PLAY_SOUNDTHREESTEP_NUMBER:int = 14;            public static const TYPE_SPEED_UP:int = 1;            public static const TYPE_SPEED_UNCHANGE:int = 2;            public static const TYPE_SPEED_DOWN:int = 3;                   private var _goodsList:Vector.<DevilTurnCell>;            private var _sound:TurnSoundControl;            private var _delay:Array;            private var _moveTime:Array;            private var _nowDelayTime:int = 1000;            private var _turnTypeTimeSum:int = 0;            private var _timer:Timer;            private var _turnType:int = 0;            private var _stepTime:int;            private var _isStopTurn:Boolean = true;            private var _selectedGoodsNumber:Number;            private var _moderationNumber:Number;            private var _startModerationNumber:Number;            private var _turnStop:Boolean;            private var _sparkleNumber:Number;            private var _turnContinue:Boolean;            public function DevilTurnControl() { super(); }
            private function init() : void { }
            public function turn(list:Vector.<DevilTurnCell>, _select:int) : void { }
            private function clearListSelect() : void { }
            private function __onTimerComplete(e:TimerEvent) : void { }
            private function _nextNode() : void { }
            private function _updateTurnType(value:int) : void { }
            public function set turnContinue(value:Boolean) : void { }
            public function get turnContinue() : Boolean { return false; }
            private function startTurn() : void { }
            public function stopTurn() : void { }
            private function turnComplete() : void { }
            private function _startTimer(time:int) : void { }
            public function set nowDelayTime(value:int) : void { }
            public function set turnType(value:int) : void { }
            public function set selectedGoodsNumber(value:int) : void { }
            public function set sparkleNumber(value:int) : void { }
            private function get prevSelected() : int { return 0; }
            public function get turnType() : int { return 0; }
            public function get nowDelayTime() : int { return 0; }
            public function get sparkleNumber() : int { return 0; }
            public function get isTurn() : Boolean { return false; }
            public function dispose() : void { }
   }}