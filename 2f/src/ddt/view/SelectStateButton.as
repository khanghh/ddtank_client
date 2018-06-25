package ddt.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class SelectStateButton extends Sprite implements Disposeable   {                   private var _bg:DisplayObject;            private var _overBg:DisplayObject;            private var _gray:Boolean;            private var _enable:Boolean;            private var _selected:Boolean;            public function SelectStateButton() { super(); }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function __outHander(event:MouseEvent) : void { }
            private function __overHandler(event:MouseEvent) : void { }
            private function __clickHander(event:MouseEvent) : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(value:Boolean) : void { }
            public function get enable() : Boolean { return false; }
            public function set enable(value:Boolean) : void { }
            public function get gray() : Boolean { return false; }
            public function set gray(value:Boolean) : void { }
            public function set backGround(value:DisplayObject) : void { }
            public function set overBackGround(value:DisplayObject) : void { }
            public function dispose() : void { }
   }}