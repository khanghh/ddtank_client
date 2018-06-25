package giftSystem.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.BitmapData;   import flash.display.Graphics;   import flash.geom.Matrix;      public class GiftPropress extends Component   {                   private var _backgound:MovieImage;            private var _thuck:Component;            private var _graphics_thuck:BitmapData;            private var _value:Number = 0;            private var _max:Number = 100;            private var _propgressLabel:FilterFrameText;            public function GiftPropress() { super(); }
            private function initView() : void { }
            public function setProgress(value:Number, max:Number) : void { }
            private function drawProgress() : void { }
            public function set labelText(value:String) : void { }
            override public function dispose() : void { }
   }}