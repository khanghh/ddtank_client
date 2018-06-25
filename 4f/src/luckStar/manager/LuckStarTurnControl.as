package luckStar.manager{   import ddt.view.roulette.TurnSoundControl;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.events.TimerEvent;   import flash.utils.Timer;   import luckStar.cell.LuckStarCell;      public class LuckStarTurnControl extends EventDispatcher   {            public static const SPEEDUP_RATE:int = -60;            public static const SPEEDDOWN_RATE:int = 40;            public static const PLAY_SOUNDTHREESTEP_NUMBER:int = 14;            public static const TURNCOMPLETE:String = "turn_complete";            public static const TYPE_SPEED_UP:int = 1;            public static const TYPE_SPEED_UNCHANGE:int = 2;            public static const TYPE_SPEED_DOWN:int = 3;            public static const SHADOW_NUMBER:int = 3;            public static const DOWN_SUB_SHADOW_BOL:int = 9;                   private var _goodsList:Vector.<LuckStarCell>;            private var _sound:TurnSoundControl;            private var _delay:Array;            private var _moveTime:Array;            private var _nowDelayTime:int = 1000;            private var _turnTypeTimeSum:int = 0;            private var _timer:Timer;            private var _turnType:int = 0;            private var _stepTime:int;            private var _isStopTurn:Boolean = true;            private var _selectedGoodsNumber:Number;            private var _moderationNumber:Number;            private var _startModerationNumber:Number;            private var _turnStop:Boolean;            private var _sparkleNumber:Number;            private var _turnContinue:Boolean;            public function LuckStarTurnControl(target:IEventDispatcher = null) { super(null); }
            private function init() : void { }
            private function __onTimerComplete(e:TimerEvent) : void { }
            private function _nextNode() : void { }
            private function _updateTurnType(value:int) : void { }
            private function _clearPrevSelct(now:int, prev:int) : void { }
            public function turn(list:Vector.<LuckStarCell>, _select:int) : void { }
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