package starling.display
{
   import flash.geom.Matrix;
   import starling.display.graphics.Fill;
   import starling.display.graphics.Graphic;
   import starling.display.graphics.NGon;
   import starling.display.graphics.Plane;
   import starling.display.graphics.RoundedRectangle;
   import starling.display.graphics.Stroke;
   import starling.display.materials.IMaterial;
   import starling.display.shaders.fragment.TextureFragmentShader;
   import starling.display.util.CurveUtil;
   import starling.textures.Texture;
   
   public class Graphics
   {
      
      protected static const BEZIER_ERROR:Number = 0.75;
      
      protected static var s_textureFragmentShader:TextureFragmentShader = new TextureFragmentShader();
       
      
      protected var _container:DisplayObjectContainer;
      
      protected var _penPosX:Number;
      
      protected var _penPosY:Number;
      
      protected var _currentFill:Fill;
      
      protected var _fillStyleSet:Boolean;
      
      protected var _fillColor:uint;
      
      protected var _fillAlpha:Number;
      
      protected var _fillTexture:Texture;
      
      protected var _fillMaterial:IMaterial;
      
      protected var _fillMatrix:Matrix;
      
      protected var _currentStroke:Stroke;
      
      protected var _strokeStyleSet:Boolean;
      
      protected var _strokeThickness:Number;
      
      protected var _strokeColor:uint;
      
      protected var _strokeAlpha:Number;
      
      protected var _strokeTexture:Texture;
      
      protected var _strokeMaterial:IMaterial;
      
      protected var _strokeInterrupted:Boolean;
      
      protected var _precisionHitTest:Boolean = false;
      
      protected var _precisionHitTestDistance:Number = 0;
      
      public function Graphics(param1:DisplayObjectContainer){super();}
      
      public function clear() : void{}
      
      public function dispose() : void{}
      
      public function beginFill(param1:uint, param2:Number = 1.0) : void{}
      
      public function beginTextureFill(param1:Texture, param2:Matrix = null, param3:uint = 16777215, param4:Number = 1.0) : void{}
      
      public function beginMaterialFill(param1:IMaterial, param2:Matrix = null) : void{}
      
      public function endFill() : void{}
      
      protected function disposeFill() : void{}
      
      public function lineStyle(param1:Number = NaN, param2:uint = 0, param3:Number = 1.0) : void{}
      
      public function lineTexture(param1:Number = NaN, param2:Texture = null) : void{}
      
      public function lineMaterial(param1:Number = NaN, param2:IMaterial = null) : void{}
      
      protected function endStroke() : void{}
      
      protected function disposeStroke() : void{}
      
      public function moveTo(param1:Number, param2:Number) : void{}
      
      public function lineTo(param1:Number, param2:Number) : void{}
      
      public function curveTo(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0.75) : void{}
      
      public function cubicCurveTo(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number = 0.75) : void{}
      
      public function drawCircle(param1:Number, param2:Number, param3:Number) : void{}
      
      public function drawEllipse(param1:Number, param2:Number, param3:Number, param4:Number) : void{}
      
      public function drawRect(param1:Number, param2:Number, param3:Number, param4:Number) : void{}
      
      public function drawRoundRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : void{}
      
      public function drawRoundRectComplex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void{}
      
      public function set precisionHitTest(param1:Boolean) : void{}
      
      public function get precisionHitTest() : Boolean{return false;}
      
      public function set precisionHitTestDistance(param1:Number) : void{}
      
      public function get precisionHitTestDistance() : Number{return 0;}
      
      protected function getStrokeInstance() : Stroke{return null;}
      
      protected function getFillInstance() : Fill{return null;}
      
      protected function createStroke() : void{}
      
      protected function createFill() : void{}
      
      protected function applyStrokeStyleToGraphic(param1:Graphic) : void{}
      
      protected function applyFillStyleToGraphic(param1:Graphic) : void{}
   }
}
