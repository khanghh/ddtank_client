package com.pickgliss.utils
{
   import com.pickgliss.events.InteractiveEvent;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public final class DoubleClickManager
   {
      
      private static var _instance:DoubleClickManager;
       
      
      private const DoubleClickSpeed:uint = 350;
      
      private var _timer:Timer;
      
      private var _currentTarget:InteractiveObject;
      
      private var _ctrlKey:Boolean;
      
      public function DoubleClickManager()
      {
         super();
         init();
      }
      
      public static function get Instance() : DoubleClickManager
      {
         if(!_instance)
         {
            _instance = new DoubleClickManager();
         }
         return _instance;
      }
      
      public function enableDoubleClick(param1:InteractiveObject) : void
      {
         param1.addEventListener("mouseDown",__mouseDownHandler);
      }
      
      public function disableDoubleClick(param1:InteractiveObject) : void
      {
         param1.removeEventListener("mouseDown",__mouseDownHandler);
      }
      
      private function init() : void
      {
         _timer = new Timer(350,1);
         _timer.addEventListener("timerComplete",__timerCompleteHandler);
      }
      
      private function getEvent(param1:String) : InteractiveEvent
      {
         var _loc2_:InteractiveEvent = new InteractiveEvent(param1);
         _loc2_.ctrlKey = _ctrlKey;
         return _loc2_;
      }
      
      private function __timerCompleteHandler(param1:TimerEvent) : void
      {
         _currentTarget.dispatchEvent(getEvent("interactive_click"));
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         _ctrlKey = param1.ctrlKey;
         if(_timer.running)
         {
            _timer.stop();
            if(_currentTarget != param1.currentTarget)
            {
               return;
            }
            param1.stopImmediatePropagation();
            _currentTarget.dispatchEvent(getEvent("interactive_double_click"));
         }
         else
         {
            _timer.reset();
            _timer.start();
            _currentTarget = param1.currentTarget as InteractiveObject;
         }
      }
      
      public function clearTarget() : void
      {
         if(_timer)
         {
            _timer.stop();
         }
         _currentTarget = null;
      }
   }
}
