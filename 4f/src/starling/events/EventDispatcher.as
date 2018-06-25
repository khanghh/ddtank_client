package starling.events{   import flash.utils.Dictionary;   import starling.display.DisplayObject;      public class EventDispatcher   {            private static var sBubbleChains:Array = [];                   private var mEventListeners:Dictionary;            public function EventDispatcher() { super(); }
            public function addEventListener(type:String, listener:Function) : void { }
            public function removeEventListener(type:String, listener:Function) : void { }
            public function removeEventListeners(type:String = null) : void { }
            public function dispatchEvent(event:Event) : void { }
            protected function invokeEvent(event:Event) : Boolean { return false; }
            protected function bubbleEvent(event:Event) : void { }
            public function dispatchEventWith(type:String, bubbles:Boolean = false, data:Object = null) : void { }
            public function hasEventListener(type:String) : Boolean { return false; }
   }}