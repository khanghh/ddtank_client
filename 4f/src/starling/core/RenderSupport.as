package starling.core
{
   import com.adobe.utils.AGALMiniAssembler;
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   import starling.display.BlendMode;
   import starling.display.DisplayObject;
   import starling.display.Quad;
   import starling.display.QuadBatch;
   import starling.display.Stage;
   import starling.errors.MissingContextError;
   import starling.textures.Texture;
   import starling.utils.Color;
   import starling.utils.MatrixUtil;
   import starling.utils.RectangleUtil;
   import starling.utils.SystemUtil;
   
   public class RenderSupport
   {
      
      private static const RENDER_TARGET_NAME:String = "Starling.renderTarget";
      
      private static var sPoint:Point = new Point();
      
      private static var sPoint3D:Vector3D = new Vector3D();
      
      private static var sClipRect:Rectangle = new Rectangle();
      
      private static var sBufferRect:Rectangle = new Rectangle();
      
      private static var sScissorRect:Rectangle = new Rectangle();
      
      private static var sAssembler:AGALMiniAssembler = new AGALMiniAssembler();
      
      private static var sMatrix3D:Matrix3D = new Matrix3D();
      
      private static var sMatrixData:Vector.<Number> = new <Number>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
       
      
      private var mProjectionMatrix:Matrix;
      
      private var mModelViewMatrix:Matrix;
      
      private var mMvpMatrix:Matrix;
      
      private var mMatrixStack:Vector.<Matrix>;
      
      private var mMatrixStackSize:int;
      
      private var mProjectionMatrix3D:Matrix3D;
      
      private var mModelViewMatrix3D:Matrix3D;
      
      private var mMvpMatrix3D:Matrix3D;
      
      private var mMatrixStack3D:Vector.<Matrix3D>;
      
      private var mMatrixStack3DSize:int;
      
      private var mDrawCount:int;
      
      private var mBlendMode:String;
      
      private var mClipRectStack:Vector.<Rectangle>;
      
      private var mClipRectStackSize:int;
      
      private var mQuadBatches:Vector.<QuadBatch>;
      
      private var mCurrentQuadBatchID:int;
      
      private var mMasks:Vector.<DisplayObject>;
      
      private var mStencilReferenceValue:uint = 0;
      
      public function RenderSupport(){super();}
      
      public static function transformMatrixForObject(param1:Matrix, param2:DisplayObject) : void{}
      
      public static function setDefaultBlendFactors(param1:Boolean) : void{}
      
      public static function setBlendFactors(param1:Boolean, param2:String = "normal") : void{}
      
      public static function clear(param1:uint = 0, param2:Number = 0.0) : void{}
      
      public static function assembleAgal(param1:String, param2:String, param3:Program3D = null) : Program3D{return null;}
      
      public static function getTextureLookupFlags(param1:String, param2:Boolean, param3:Boolean = false, param4:String = "bilinear") : String{return null;}
      
      public function dispose() : void{}
      
      public function setProjectionMatrix(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Number = 0, param7:Vector3D = null) : void{}
      
      [Deprecated(replacement="setProjectionMatrix")]
      public function setOrthographicProjection(param1:Number, param2:Number, param3:Number, param4:Number) : void{}
      
      public function loadIdentity() : void{}
      
      public function translateMatrix(param1:Number, param2:Number) : void{}
      
      public function rotateMatrix(param1:Number) : void{}
      
      public function scaleMatrix(param1:Number, param2:Number) : void{}
      
      public function prependMatrix(param1:Matrix) : void{}
      
      public function transformMatrix(param1:DisplayObject) : void{}
      
      public function pushMatrix() : void{}
      
      public function popMatrix() : void{}
      
      public function resetMatrix() : void{}
      
      public function get mvpMatrix() : Matrix{return null;}
      
      public function get modelViewMatrix() : Matrix{return null;}
      
      public function get projectionMatrix() : Matrix{return null;}
      
      public function set projectionMatrix(param1:Matrix) : void{}
      
      public function transformMatrix3D(param1:DisplayObject) : void{}
      
      public function pushMatrix3D() : void{}
      
      public function popMatrix3D() : void{}
      
      public function get mvpMatrix3D() : Matrix3D{return null;}
      
      public function get projectionMatrix3D() : Matrix3D{return null;}
      
      public function set projectionMatrix3D(param1:Matrix3D) : void{}
      
      public function applyBlendMode(param1:Boolean) : void{}
      
      public function get blendMode() : String{return null;}
      
      public function set blendMode(param1:String) : void{}
      
      public function get renderTarget() : Texture{return null;}
      
      public function set renderTarget(param1:Texture) : void{}
      
      public function setRenderTarget(param1:Texture, param2:int = 0) : void{}
      
      public function pushClipRect(param1:Rectangle, param2:Boolean = true) : Rectangle{return null;}
      
      public function popClipRect() : void{}
      
      public function applyClipRect() : void{}
      
      public function pushMask(param1:DisplayObject) : void{}
      
      public function popMask() : void{}
      
      private function drawMask(param1:DisplayObject) : void{}
      
      public function get stencilReferenceValue() : uint{return null;}
      
      public function set stencilReferenceValue(param1:uint) : void{}
      
      public function batchQuad(param1:Quad, param2:Number, param3:Texture = null, param4:String = null) : void{}
      
      public function batchQuadBatch(param1:QuadBatch, param2:Number) : void{}
      
      public function finishQuadBatch() : void{}
      
      public function nextFrame() : void{}
      
      private function trimQuadBatches() : void{}
      
      private function createQuadBatch() : QuadBatch{return null;}
      
      public function clear(param1:uint = 0, param2:Number = 0.0) : void{}
      
      public function raiseDrawCount(param1:uint = 1) : void{}
      
      public function get drawCount() : int{return 0;}
   }
}
