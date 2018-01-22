package starling.filters
{
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.errors.IllegalOperationError;
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.utils.getQualifiedClassName;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.QuadBatch;
   import starling.display.Stage;
   import starling.errors.AbstractClassError;
   import starling.errors.MissingContextError;
   import starling.textures.Texture;
   import starling.utils.MatrixUtil;
   import starling.utils.RectangleUtil;
   import starling.utils.SystemUtil;
   import starling.utils.VertexData;
   import starling.utils.getNextPowerOfTwo;
   
   public class FragmentFilter
   {
      
      private static var sStageBounds:Rectangle = new Rectangle();
      
      private static var sTransformationMatrix:Matrix = new Matrix();
       
      
      private const MIN_TEXTURE_SIZE:int = 64;
      
      protected const PMA:Boolean = true;
      
      protected const STD_VERTEX_SHADER:String = "m44 op, va0, vc0 \nmov v0, va1      \n";
      
      protected const STD_FRAGMENT_SHADER:String = "tex oc, v0, fs0 <2d, clamp, linear, mipnone>";
      
      private var mVertexPosAtID:int = 0;
      
      private var mTexCoordsAtID:int = 1;
      
      private var mBaseTextureID:int = 0;
      
      private var mMvpConstantID:int = 0;
      
      private var mNumPasses:int;
      
      private var mPassTextures:Vector.<Texture>;
      
      private var mMode:String;
      
      private var mResolution:Number;
      
      private var mMarginX:Number;
      
      private var mMarginY:Number;
      
      private var mOffsetX:Number;
      
      private var mOffsetY:Number;
      
      private var mVertexData:VertexData;
      
      private var mVertexBuffer:VertexBuffer3D;
      
      private var mIndexData:Vector.<uint>;
      
      private var mIndexBuffer:IndexBuffer3D;
      
      private var mCacheRequested:Boolean;
      
      private var mCache:QuadBatch;
      
      private var mHelperMatrix:Matrix;
      
      private var mHelperMatrix3D:Matrix3D;
      
      private var mHelperRect:Rectangle;
      
      private var mHelperRect2:Rectangle;
      
      public function FragmentFilter(param1:int = 1, param2:Number = 1.0){super();}
      
      public function dispose() : void{}
      
      private function onContextCreated(param1:Object) : void{}
      
      public function render(param1:DisplayObject, param2:RenderSupport, param3:Number) : void{}
      
      private function renderPasses(param1:DisplayObject, param2:RenderSupport, param3:Number, param4:Boolean = false) : QuadBatch{return null;}
      
      private function updateBuffers(param1:Context3D, param2:Rectangle) : void{}
      
      private function updatePassTextures(param1:Number, param2:Number, param3:Number) : void{}
      
      private function getPassTexture(param1:int) : Texture{return null;}
      
      private function calculateBounds(param1:DisplayObject, param2:DisplayObject, param3:Number, param4:Boolean, param5:Rectangle, param6:Rectangle) : void{}
      
      private function disposePassTextures() : void{}
      
      private function disposeCache() : void{}
      
      protected function createPrograms() : void{}
      
      protected function activate(param1:int, param2:Context3D, param3:Texture) : void{}
      
      protected function deactivate(param1:int, param2:Context3D, param3:Texture) : void{}
      
      protected function assembleAgal(param1:String = null, param2:String = null) : Program3D{return null;}
      
      public function cache() : void{}
      
      public function clearCache() : void{}
      
      function compile(param1:DisplayObject) : QuadBatch{return null;}
      
      public function get isCached() : Boolean{return false;}
      
      public function get resolution() : Number{return 0;}
      
      public function set resolution(param1:Number) : void{}
      
      public function get mode() : String{return null;}
      
      public function set mode(param1:String) : void{}
      
      public function get offsetX() : Number{return 0;}
      
      public function set offsetX(param1:Number) : void{}
      
      public function get offsetY() : Number{return 0;}
      
      public function set offsetY(param1:Number) : void{}
      
      protected function get marginX() : Number{return 0;}
      
      protected function set marginX(param1:Number) : void{}
      
      protected function get marginY() : Number{return 0;}
      
      protected function set marginY(param1:Number) : void{}
      
      protected function set numPasses(param1:int) : void{}
      
      protected function get numPasses() : int{return 0;}
      
      protected final function get vertexPosAtID() : int{return 0;}
      
      protected final function set vertexPosAtID(param1:int) : void{}
      
      protected final function get texCoordsAtID() : int{return 0;}
      
      protected final function set texCoordsAtID(param1:int) : void{}
      
      protected final function get baseTextureID() : int{return 0;}
      
      protected final function set baseTextureID(param1:int) : void{}
      
      protected final function get mvpConstantID() : int{return 0;}
      
      protected final function set mvpConstantID(param1:int) : void{}
   }
}
