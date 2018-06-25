package yzhkof.ui{   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Rectangle;   import yzhkof.ui.event.ComponentEvent;      public class ScrollPanel extends ComponentContainer   {                   private var vScrollBar:VScrollBar;            private var viewRectangle:Rectangle;            private var contentContainer:Sprite;            private var rectContaner:Sprite;            private var _source:DisplayObject;            private var _maxScrollV:Number = 0;            private var _scrollV:Number = 0;            public function ScrollPanel() { super(); }
            private function init() : void { }
            private function __scrollChange(e:Event) : void { }
            private function __scrollBarUpdate(e:Event) : void { }
            private function updateScrollByContent() : void { }
            override public function set height(value:Number) : void { }
            override public function set width(value:Number) : void { }
            override protected function onDraw() : void { }
            public function get maxScrollV() : Number { return 0; }
            public function get scrollV() : Number { return 0; }
            public function set scrollV(value:Number) : void { }
            private function __childSizeChange(e:Event) : void { }
            public function get source() : DisplayObject { return null; }
            public function set source(value:DisplayObject) : void { }
   }}