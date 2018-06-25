package yzhkof.ui{   import yzhkof.ui.event.ComponentEvent;      [Event(name="COMPONENT_CHANGE",type="yzhkof.ui.event.ComponentEvent")]   [Event(name="DRAW_COMPLETE",type="yzhkof.ui.event.ComponentEvent")]   public class ComponentBase extends CommitingSprite   {                   protected var _width:Number = 0;            protected var _height:Number = 0;            public function ComponentBase() { super(); }
            override public function get width() : Number { return 0; }
            override public function set width(value:Number) : void { }
            override public function get height() : Number { return 0; }
            override public function set height(value:Number) : void { }
            override protected function commitChage(changeThing:String = "default_change") : void { }
            public function get contentWidth() : Number { return 0; }
            public function get contentHeight() : Number { return 0; }
            override protected final function afterDraw() : void { }
            protected function drawComplete() : void { }
   }}