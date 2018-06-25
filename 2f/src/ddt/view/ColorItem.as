package ddt.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedButton;   import flash.display.Bitmap;   import flash.events.MouseEvent;      public class ColorItem extends SelectedButton   {                   private var _color:uint;            private var _over:Bitmap;            public function ColorItem() { super(); }
            public function setup(color:uint) : void { }
            override protected function init() : void { }
            private function initEvent() : void { }
            private function removeEvents() : void { }
            private function __mouseOver(evt:MouseEvent) : void { }
            private function __mouseOut(evt:MouseEvent) : void { }
            public function getColor() : uint { return null; }
            override public function dispose() : void { }
   }}