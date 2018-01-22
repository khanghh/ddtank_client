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
      
      public function DoubleClickManager(){super();}
      
      public static function get Instance() : DoubleClickManager{return null;}
      
      public function enableDoubleClick(param1:InteractiveObject) : void{}
      
      public function disableDoubleClick(param1:InteractiveObject) : void{}
      
      private function init() : void{}
      
      private function getEvent(param1:String) : InteractiveEvent{return null;}
      
      private function __timerCompleteHandler(param1:TimerEvent) : void{}
      
      private function __mouseDownHandler(param1:MouseEvent) : void{}
      
      public function clearTarget() : void{}
   }
}
