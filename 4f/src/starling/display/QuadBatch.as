package starling.display
{
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.errors.IllegalOperationError;
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.errors.MissingContextError;
   import starling.filters.FragmentFilter;
   import starling.textures.Texture;
   import starling.utils.VertexData;
   
   public class QuadBatch extends DisplayObject
   {
      
      public static const MAX_NUM_QUADS:int = 16383;
      
      private static const QUAD_PROGRAM_NAME:String = "QB_q";
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sRenderAlpha:Vector.<Number> = new <Number>[1,1,1,1];
      
      private static var sProgramNameCache:Dictionary = new Dictionary();
       
      
      private var mNumQuads:int;
      
      private var mSyncRequired:Boolean;
      
      private var mBatchable:Boolean;
      
      private var mForceTinted:Boolean;
      
      private var mOwnsTexture:Boolean;
      
      private var mTinted:Boolean;
      
      private var mTexture:Texture;
      
      private var mSmoothing:String;
      
      private var mVertexBuffer:VertexBuffer3D;
      
      private var mIndexData:Vector.<uint>;
      
      private var mIndexBuffer:IndexBuffer3D;
      
      protected var mVertexData:VertexData;
      
      public function QuadBatch(){super();}
      
      public static function compile(param1:DisplayObject, param2:Vector.<QuadBatch>) : void{}
      
      public static function optimize(param1:Vector.<QuadBatch>) : void{}
      
      private static function compileObject(param1:DisplayObject, param2:Vector.<QuadBatch>, param3:int, param4:Matrix, param5:Number = 1.0, param6:String = null, param7:Boolean = false) : int{return 0;}
      
      private static function getImageProgramName(param1:Boolean, param2:Boolean = true, param3:Boolean = false, param4:String = "bgra", param5:String = "bilinear") : String{return null;}
      
      override public function dispose() : void{}
      
      private function onContextCreated(param1:Object) : void{}
      
      protected function onVertexDataChanged() : void{}
      
      public function clone() : QuadBatch{return null;}
      
      private function expand() : void{}
      
      private function createBuffers() : void{}
      
      private function destroyBuffers() : void{}
      
      private function syncBuffers() : void{}
      
      public function renderCustom(param1:Matrix3D, param2:Number = 1.0, param3:String = null) : void{}
      
      public function reset() : void{}
      
      public function addImage(param1:Image, param2:Number = 1.0, param3:Matrix = null, param4:String = null) : void{}
      
      public function addQuad(param1:Quad, param2:Number = 1.0, param3:Texture = null, param4:String = null, param5:Matrix = null, param6:String = null) : void{}
      
      public function addQuadBatch(param1:QuadBatch, param2:Number = 1.0, param3:Matrix = null, param4:String = null) : void{}
      
      public function isStateChange(param1:Boolean, param2:Number, param3:Texture, param4:String, param5:String, param6:int = 1) : Boolean{return false;}
      
      public function transformQuad(param1:int, param2:Matrix) : void{}
      
      public function getVertexColor(param1:int, param2:int) : uint{return null;}
      
      public function setVertexColor(param1:int, param2:int, param3:uint) : void{}
      
      public function getVertexAlpha(param1:int, param2:int) : Number{return 0;}
      
      public function setVertexAlpha(param1:int, param2:int, param3:Number) : void{}
      
      public function getQuadColor(param1:int) : uint{return null;}
      
      public function setQuadColor(param1:int, param2:uint) : void{}
      
      public function getQuadAlpha(param1:int) : Number{return 0;}
      
      public function setQuadAlpha(param1:int, param2:Number) : void{}
      
      public function setQuad(param1:Number, param2:Quad) : void{}
      
      public function getQuadBounds(param1:int, param2:Matrix = null, param3:Rectangle = null) : Rectangle{return null;}
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle{return null;}
      
      override public function render(param1:RenderSupport, param2:Number) : void{}
      
      public function get numQuads() : int{return 0;}
      
      public function get tinted() : Boolean{return false;}
      
      public function get texture() : Texture{return null;}
      
      public function get smoothing() : String{return null;}
      
      public function get premultipliedAlpha() : Boolean{return false;}
      
      public function get batchable() : Boolean{return false;}
      
      public function set batchable(param1:Boolean) : void{}
      
      public function get forceTinted() : Boolean{return false;}
      
      public function set forceTinted(param1:Boolean) : void{}
      
      public function get ownsTexture() : Boolean{return false;}
      
      public function set ownsTexture(param1:Boolean) : void{}
      
      public function get capacity() : int{return 0;}
      
      public function set capacity(param1:int) : void{}
      
      private function getProgram(param1:Boolean) : Program3D{return null;}
   }
}
