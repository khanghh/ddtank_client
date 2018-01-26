package ddt.view.roulette
{
   import ddt.manager.SoundManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TurnSoundControl extends EventDispatcher
   {
       
      
      private var _timer:Timer;
      
      private var _isPlaySound:Boolean = false;
      
      private var _oneArray:Array;
      
      private var _threeArray:Array;
      
      private var _number:int = 0;
      
      public function TurnSoundControl(param1:IEventDispatcher = null){super(null);}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function _timerOne(param1:TimerEvent) : void{}
      
      private function _timerComplete(param1:TimerEvent) : void{}
      
      public function playSound() : void{}
      
      public function playOneStep() : void{}
      
      public function playThreeStep(param1:int) : void{}
      
      public function stop() : void{}
      
      public function dispose() : void{}
   }
}
