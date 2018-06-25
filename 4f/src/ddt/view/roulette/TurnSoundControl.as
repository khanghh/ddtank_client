package ddt.view.roulette{   import ddt.manager.SoundManager;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.events.TimerEvent;   import flash.utils.Timer;      public class TurnSoundControl extends EventDispatcher   {                   private var _timer:Timer;            private var _isPlaySound:Boolean = false;            private var _oneArray:Array;            private var _threeArray:Array;            private var _number:int = 0;            public function TurnSoundControl(target:IEventDispatcher = null) { super(null); }
            private function init() : void { }
            private function initEvent() : void { }
            private function _timerOne(evt:TimerEvent) : void { }
            private function _timerComplete(evt:TimerEvent) : void { }
            public function playSound() : void { }
            public function playOneStep() : void { }
            public function playThreeStep(value:int) : void { }
            public function stop() : void { }
            public function dispose() : void { }
   }}