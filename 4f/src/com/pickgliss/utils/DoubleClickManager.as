package com.pickgliss.utils{   import com.pickgliss.events.InteractiveEvent;   import flash.display.InteractiveObject;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;      public final class DoubleClickManager   {            private static var _instance:DoubleClickManager;                   private const DoubleClickSpeed:uint = 350;            private var _timer:Timer;            private var _currentTarget:InteractiveObject;            private var _ctrlKey:Boolean;            public function DoubleClickManager() { super(); }
            public static function get Instance() : DoubleClickManager { return null; }
            public function enableDoubleClick(target:InteractiveObject) : void { }
            public function disableDoubleClick(target:InteractiveObject) : void { }
            private function init() : void { }
            private function getEvent(type:String) : InteractiveEvent { return null; }
            private function __timerCompleteHandler(evt:TimerEvent) : void { }
            private function __mouseDownHandler(evt:MouseEvent) : void { }
            public function clearTarget() : void { }
   }}