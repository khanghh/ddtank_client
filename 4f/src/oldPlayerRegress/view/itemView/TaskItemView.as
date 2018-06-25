package oldPlayerRegress.view.itemView{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import flash.display.Bitmap;   import flash.events.MouseEvent;      public class TaskItemView extends Frame   {                   private var _func:Function;            private var _clickID:int;            private var _itemBg:ScaleFrameImage;            private var _light:Scale9CornerImage;            private var _titleField:FilterFrameText;            private var _bmpOK:Bitmap;            public function TaskItemView(func:Function) { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function __MouseOver(event:MouseEvent) : void { }
            protected function __MouseOut(event:MouseEvent) : void { }
            protected function __MouseClick(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
            private function removeVariable() : void { }
            public function get clickID() : int { return 0; }
            public function set clickID(value:int) : void { }
            public function get itemBg() : ScaleFrameImage { return null; }
            public function set itemBg(value:ScaleFrameImage) : void { }
            public function get titleField() : FilterFrameText { return null; }
            public function set titleField(value:FilterFrameText) : void { }
            public function get bmpOK() : Bitmap { return null; }
            public function set bmpOK(value:Bitmap) : void { }
   }}