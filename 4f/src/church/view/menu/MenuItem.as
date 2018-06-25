package church.view.menu{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.text.TextFormat;      public class MenuItem extends Sprite implements Disposeable   {                   private var _textFormat1:TextFormat;            private var _textFormat2:TextFormat;            private var _label:FilterFrameText;            private var _bg:ScaleFrameImage;            protected var _enable:Boolean = false;            public function MenuItem(label:String = "") { super(); }
            private function removeEvent() : void { }
            private function __rollOver(event:MouseEvent) : void { }
            private function __rollOut(event:MouseEvent) : void { }
            private function __mouseClick(event:MouseEvent) : void { }
            public function get enable() : Boolean { return false; }
            public function set enable(value:Boolean) : void { }
            public function dispose() : void { }
   }}