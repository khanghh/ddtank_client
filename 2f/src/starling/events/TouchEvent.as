package starling.events{   import starling.display.DisplayObject;      public class TouchEvent extends Event   {            public static const TOUCH:String = "touch";            private static var sTouches:Vector.<Touch> = new Vector.<Touch>(0);                   private var mShiftKey:Boolean;            private var mCtrlKey:Boolean;            private var mTimestamp:Number;            private var mVisitedObjects:Vector.<EventDispatcher>;            public function TouchEvent(type:String, touches:Vector.<Touch>, shiftKey:Boolean = false, ctrlKey:Boolean = false, bubbles:Boolean = true) { super(null,null,null); }
            public function getTouches(target:DisplayObject, phase:String = null, result:Vector.<Touch> = null) : Vector.<Touch> { return null; }
            public function getTouch(target:DisplayObject, phase:String = null, id:int = -1) : Touch { return null; }
            public function interactsWith(target:DisplayObject) : Boolean { return false; }
            protected function dispatch(chain:Vector.<EventDispatcher>) : void { }
            public function get timestamp() : Number { return 0; }
            public function get touches() : Vector.<Touch> { return null; }
            public function get shiftKey() : Boolean { return false; }
            public function get ctrlKey() : Boolean { return false; }
   }}