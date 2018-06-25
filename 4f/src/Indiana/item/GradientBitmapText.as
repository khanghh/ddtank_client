package Indiana.item{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.geom.Matrix;   import flash.text.TextFormat;      public class GradientBitmapText extends Component   {                   private var _field:FilterFrameText;            private var _bmp:Bitmap;            private var currentMatix:Matrix;            private var _graidenBmp:ScaleBitmapImage;            public function GradientBitmapText() { super(); }
            public function set FilterTxtStyle(style:String) : void { }
            public function set FontSize(size:int) : void { }
            public function set BitMapStyle(str:String) : void { }
            public function setText(s:String) : void { }
            public function get textWidth() : Number { return 0; }
            private function render() : void { }
            private function drawBox() : void { }
            override public function dispose() : void { }
   }}