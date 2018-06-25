package starling.display{   import flash.geom.Matrix;   import starling.display.graphics.Fill;   import starling.display.graphics.Graphic;   import starling.display.graphics.NGon;   import starling.display.graphics.Plane;   import starling.display.graphics.RoundedRectangle;   import starling.display.graphics.Stroke;   import starling.display.materials.IMaterial;   import starling.display.shaders.fragment.TextureFragmentShader;   import starling.display.util.CurveUtil;   import starling.textures.Texture;      public class Graphics   {            protected static const BEZIER_ERROR:Number = 0.75;            protected static var s_textureFragmentShader:TextureFragmentShader = new TextureFragmentShader();                   protected var _container:DisplayObjectContainer;            protected var _penPosX:Number;            protected var _penPosY:Number;            protected var _currentFill:Fill;            protected var _fillStyleSet:Boolean;            protected var _fillColor:uint;            protected var _fillAlpha:Number;            protected var _fillTexture:Texture;            protected var _fillMaterial:IMaterial;            protected var _fillMatrix:Matrix;            protected var _currentStroke:Stroke;            protected var _strokeStyleSet:Boolean;            protected var _strokeThickness:Number;            protected var _strokeColor:uint;            protected var _strokeAlpha:Number;            protected var _strokeTexture:Texture;            protected var _strokeMaterial:IMaterial;            protected var _strokeInterrupted:Boolean;            protected var _precisionHitTest:Boolean = false;            protected var _precisionHitTestDistance:Number = 0;            public function Graphics(displayObjectContainer:DisplayObjectContainer) { super(); }
            public function clear() : void { }
            public function dispose() : void { }
            public function beginFill(color:uint, alpha:Number = 1.0) : void { }
            public function beginTextureFill(texture:Texture, uvMatrix:Matrix = null, color:uint = 16777215, alpha:Number = 1.0) : void { }
            public function beginMaterialFill(material:IMaterial, uvMatrix:Matrix = null) : void { }
            public function endFill() : void { }
            protected function disposeFill() : void { }
            public function lineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0) : void { }
            public function lineTexture(thickness:Number = NaN, texture:Texture = null) : void { }
            public function lineMaterial(thickness:Number = NaN, material:IMaterial = null) : void { }
            protected function endStroke() : void { }
            protected function disposeStroke() : void { }
            public function moveTo(x:Number, y:Number) : void { }
            public function lineTo(x:Number, y:Number) : void { }
            public function curveTo(cx:Number, cy:Number, a2x:Number, a2y:Number, error:Number = 0.75) : void { }
            public function cubicCurveTo(c1x:Number, c1y:Number, c2x:Number, c2y:Number, a2x:Number, a2y:Number, error:Number = 0.75) : void { }
            public function drawCircle(x:Number, y:Number, radius:Number) : void { }
            public function drawEllipse(x:Number, y:Number, width:Number, height:Number) : void { }
            public function drawRect(x:Number, y:Number, width:Number, height:Number) : void { }
            public function drawRoundRect(x:Number, y:Number, width:Number, height:Number, radius:Number) : void { }
            public function drawRoundRectComplex(x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number) : void { }
            public function set precisionHitTest(value:Boolean) : void { }
            public function get precisionHitTest() : Boolean { return false; }
            public function set precisionHitTestDistance(value:Number) : void { }
            public function get precisionHitTestDistance() : Number { return 0; }
            protected function getStrokeInstance() : Stroke { return null; }
            protected function getFillInstance() : Fill { return null; }
            protected function createStroke() : void { }
            protected function createFill() : void { }
            protected function applyStrokeStyleToGraphic(graphic:Graphic) : void { }
            protected function applyFillStyleToGraphic(graphic:Graphic) : void { }
   }}