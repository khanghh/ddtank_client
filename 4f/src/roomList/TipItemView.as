package roomList{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class TipItemView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _bgII:ScaleBitmapImage;            private var _value:int;            private var _cellWidth:int;            private var _cellheight:int;            public function TipItemView(bg:Bitmap, value:int, cellWidth:int, cellheight:int) { super(); }
            private function init() : void { }
            protected function __itemOut(event:MouseEvent) : void { }
            protected function __itemOver(event:MouseEvent) : void { }
            public function get value() : int { return 0; }
            public function dispose() : void { }
   }}