package sevenday.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.Graphics;   import flash.geom.Matrix;      public class SevendayTaskProgress extends Component   {            public static const Progress:String = "progress";                   protected var _background:Bitmap;            protected var _thuck:Component;            protected var _graphics_thuck:BitmapData;            protected var _value:Number = 0;            protected var _max:Number = 100;            protected var _progressLabel:FilterFrameText;            public function SevendayTaskProgress() { super(); }
            protected function initView() : void { }
            public function setProgress(value:Number, max:Number) : void { }
            protected function drawProgress() : void { }
            public function set labelText(value:String) : void { }
            override public function dispose() : void { }
   }}