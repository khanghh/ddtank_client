package morn.core.components{   import flash.events.Event;      [Event(name="scroll",type="morn.core.events.UIEvent")]   public class TextArea extends TextInput   {                   protected var _vScrollBar:VScrollBar;            protected var _hScrollBar:HScrollBar;            public function TextArea(text:String = "") { super(null); }
            override protected function initialize() : void { }
            override public function set width(value:Number) : void { }
            override public function set height(value:Number) : void { }
            protected function onTextFieldScroll(e:Event) : void { }
            public function get scrollBarSkin() : String { return null; }
            public function set scrollBarSkin(value:String) : void { }
            public function get vScrollBarSkin() : String { return null; }
            public function set vScrollBarSkin(value:String) : void { }
            public function get hScrollBarSkin() : String { return null; }
            public function set hScrollBarSkin(value:String) : void { }
            public function get scrollBar() : VScrollBar { return null; }
            public function get vScrollBar() : VScrollBar { return null; }
            public function get hScrollBar() : HScrollBar { return null; }
            public function get maxScrollV() : int { return 0; }
            public function get scrollV() : int { return 0; }
            public function get maxScrollH() : int { return 0; }
            public function get scrollH() : int { return 0; }
            protected function onScrollBarChange(e:Event) : void { }
            private function changeScroll() : void { }
            public function scrollTo(line:int) : void { }
            override public function dispose() : void { }
   }}