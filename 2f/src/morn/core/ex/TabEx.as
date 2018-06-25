package morn.core.ex{   import flash.display.DisplayObject;      public class TabEx extends GroupEx   {            public static const HORIZENTAL:String = "horizontal";            public static const VERTICAL:String = "vertical";                   protected var _offset:String;            public function TabEx(imageLabels:String = null, skin:String = null) { super(null,null); }
            override protected function createItem(skin:String, imageLabel:String) : DisplayObject { return null; }
            public function set offset(value:String) : void { }
            public function get offset() : String { return null; }
            override protected function changeImageLabels() : void { }
   }}