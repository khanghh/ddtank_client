package morn.core.events{   import flash.display.DisplayObject;   import flash.events.Event;      public class DragEvent extends Event   {            public static const DRAG_START:String = "dragStart";            public static const DRAG_DROP:String = "dragDrop";            public static const DRAG_COMPLETE:String = "dragComplete";                   protected var _data;            protected var _dragInitiator:DisplayObject;            public function DragEvent(type:String, dragInitiator:DisplayObject = null, data:* = null, bubbles:Boolean = true, cancelable:Boolean = false) { super(null,null,null); }
            public function get dragInitiator() : DisplayObject { return null; }
            public function set dragInitiator(value:DisplayObject) : void { }
            public function get data() : * { return null; }
            public function set data(value:*) : void { }
            override public function clone() : Event { return null; }
   }}