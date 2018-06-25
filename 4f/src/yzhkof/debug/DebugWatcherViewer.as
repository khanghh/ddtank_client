package yzhkof.debug{   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.text.TextField;   import flash.text.TextFieldAutoSize;   import flash.utils.getQualifiedClassName;   import yzhkof.ui.DragPanel;   import yzhkof.ui.ScrollPanel;   import yzhkof.ui.TextPanel;   import yzhkof.ui.TileContainer;   import yzhkof.ui.event.ComponentEvent;      public class DebugWatcherViewer extends DragPanel   {                   private var watch_arr:Array;            private var textField_arr:Array;            private var scrollPanel:ScrollPanel;            private var tileContainer:TileContainer;            private var btn_Container:TileContainer;            private var clear_btn:TextPanel;            public function DebugWatcherViewer() { super(); }
            private function init() : void { }
            private function initView() : void { }
            private function addEvent() : void { }
            private function __clearClick(event:MouseEvent) : void { }
            private function __enterFrame(event:Event) : void { }
            private function __createComplete(e:Event) : void { }
            public function addWatch(obj:Object, property:String, name:String = null) : void { }
   }}class WatchData{          public var object:Object;      public var property:String;      public var name:String;      function WatchData() { super(); }
}