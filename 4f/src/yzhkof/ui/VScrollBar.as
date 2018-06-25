package yzhkof.ui{   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Rectangle;   import yzhkof.MyGraphy;   import yzhkof.ui.mouse.MouseManager;      public class VScrollBar extends ComponentBase   {            private static const BAR_WIDTH:Number = 10;                   private var thumb:Sprite;            private var dragRectangle:Rectangle;            private var _maxScrollV:Number = 0;            private var _scrollV:Number = 0;            public function VScrollBar() { super(); }
            private function init() : void { }
            private function __thumbMouseDown(e:Event) : void { }
            private function __thumbMouseUp(e:Event) : void { }
            private function __thumbDraging(e:Event) : void { }
            private function updateThumbPositionByData() : void { }
            private function updateDataByThumbPosition() : void { }
            override protected function onDraw() : void { }
            private function drawScrollLine() : void { }
            public function get maxScrollV() : Number { return 0; }
            public function set maxScrollV(value:Number) : void { }
            public function get scrollV() : Number { return 0; }
            public function set scrollV(value:Number) : void { }
   }}