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
      
      public function enableDoubleClick(target:InteractiveObject) : void
      {
         target.addEventListener("mouseDown",__mouseDownHandler);
      }
      
      public function disableDoubleClick(target:InteractiveObject) : void
      {
         target.removeEventListener("mouseDown",__mouseDownHandler);
      }
      
      private function init() : void
      {
         _timer = new Timer(350,1);
         _timer.addEventListener("timerComplete",__timerCompleteHandler);
      }
      
      private function getEvent(type:String) : InteractiveEvent
      {
         var interactiveEvent:InteractiveEvent = new InteractiveEvent(type);
         interactiveEvent.ctrlKey = _ctrlKey;
         return interactiveEvent;
      }
      
      private function __timerCompleteHandler(evt:TimerEvent) : void
      {
         _currentTarget.dispatchEvent(getEvent("interactive_click"));
      }
      
      private function __mouseDownHandler(evt:MouseEvent) : void
      {
         _ctrlKey = evt.ctrlKey;
         if(_timer.running)
         {
            _timer.stop();
            if(_currentTarget != evt.currentTarget)
            {
               return;
            }
            evt.stopImmediatePropagation();
            _currentTarget.dispatchEvent(getEvent("interactive_double_click"));
         }
         else
         {
            _timer.reset();
            _timer.start();
            _currentTarget = evt.currentTarget as InteractiveObject;
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
