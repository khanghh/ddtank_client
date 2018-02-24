package starling.display.graphics
{
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.VertexBuffer3D;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.geom.GraphicsPolygon;
   import starling.display.graphics.util.IGraphicDrawHelper;
   import starling.display.materials.IMaterial;
   import starling.display.materials.StandardMaterial;
   import starling.display.shaders.fragment.VertexColorFragmentShader;
   import starling.display.shaders.vertex.StandardVertexShader;
   import starling.errors.AbstractMethodError;
   import starling.errors.MissingContextError;
   import starling.events.Event;
   import starling.textures.Texture;
   import starling.utils.getNextPowerOfTwo;
   
   public class Graphic extends DisplayObject
   {
      
      protected static const VERTEX_STRIDE:int = 9;
      
      protected static var sHelperMatrix:Matrix = new Matrix();
      
      protected static var defaultVertexShaderDictionary:Dictionary = new Dictionary(true);
      
      protected static var defaultFragmentShaderDictionary:Dictionary = new Dictionary(true);
      
      private static var sGraphicHelperRect:Rectangle = new Rectangle();
      
      private static var sGraphicHelperPoint:Point = new Point();
      
      private static var sGraphicHelperPointTR:Point = new Point();
      
      private static var sGraphicHelperPointBL:Point = new Point();
       
      
      protected var _material:IMaterial;
      
      protected var vertexBuffer:VertexBuffer3D;
      
      protected var indexBuffer:IndexBuffer3D;
      
      protected var vertices:Vector.<Number>;
      
      protected var indices:Vector.<uint>;
      
      protected var _uvMatrix:Matrix;
      
      protected var buffersInvalid:Boolean = false;
      
      protected var geometryInvalid:Boolean = false;
      
      protected var uvsInvalid:Boolean = false;
      
      protected var uvMappingsChanged:Boolean = false;
      
      protected var isGeometryScaled:Boolean = false;
      
      protected var minBounds:Point;
      
      protected var maxBounds:Point;
      
      protected var _precisionHitTest:Boolean = false;
      
      protected var _precisionHitTestDistance:Number = 0;
      
      protected var _graphicDrawHelper:IGraphicDrawHelper = null;
      
      public function Graphic(){super();}
      
      private function onContextCreated(param1:Event) : void{}
      
      protected function onGraphicLostContext() : void{}
      
      override public function dispose() : void{}
      
      public function set material(param1:IMaterial) : void{}
      
      public function get material() : IMaterial{return null;}
      
      public function get uvMatrix() : Matrix{return null;}
      
      public function set uvMatrix(param1:Matrix) : void{}
      
      public function shapeHitTest(param1:Number, param2:Number) : Boolean{return false;}
      
      public function set precisionHitTest(param1:Boolean) : void{}
      
      public function get precisionHitTest() : Boolean{return false;}
      
      public function set precisionHitTestDistance(param1:Number) : void{}
      
      public function get precisionHitTestDistance() : Number{return 0;}
      
      protected function shapeHitTestLocalInternal(param1:Number, param2:Number) : Boolean{return false;}
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject{return null;}
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle{return null;}
      
      protected function buildGeometry() : void{}
      
      protected function applyUVMatrix() : void{}
      
      public function adjustUVMappings(param1:Number, param2:Number, param3:Texture) : void{}
      
      public function validateNow() : void{}
      
      protected function setGeometryInvalid(param1:Boolean = true) : void{}
      
      override public function render(param1:RenderSupport, param2:Number) : void{}
      
      public function exportToPolygon(param1:GraphicsPolygon = null) : GraphicsPolygon{return null;}
      
      public function set graphicDrawHelper(param1:IGraphicDrawHelper) : void{}
      
      public function get graphicDrawHelper() : IGraphicDrawHelper{return null;}
   }
}
