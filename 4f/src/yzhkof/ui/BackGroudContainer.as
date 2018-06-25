package yzhkof.ui{   import flash.filters.DropShadowFilter;      public class BackGroudContainer extends ComponentBase   {                   protected var _color:uint;            private var _alpha:Number;            private var _shadow:Boolean = false;            public function BackGroudContainer(color:uint = 16777215, alpha:Number = 1) { super(); }
            public function get color() : uint { return null; }
            public function set color(value:uint) : void { }
            override protected function onDraw() : void { }
            protected function drawBackGround() : void { }
            public function get shadow() : Boolean { return false; }
            public function set shadow(value:Boolean) : void { }
   }}