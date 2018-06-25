package starling.core{   import com.adobe.utils.AGALMiniAssembler;   import flash.display3D.Context3D;   import flash.display3D.Program3D;   import flash.geom.Matrix;   import flash.geom.Matrix3D;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.geom.Vector3D;   import starling.display.BlendMode;   import starling.display.DisplayObject;   import starling.display.Quad;   import starling.display.QuadBatch;   import starling.display.Stage;   import starling.errors.MissingContextError;   import starling.textures.Texture;   import starling.utils.Color;   import starling.utils.MatrixUtil;   import starling.utils.RectangleUtil;   import starling.utils.SystemUtil;      public class RenderSupport   {            private static const RENDER_TARGET_NAME:String = "Starling.renderTarget";            private static var sPoint:Point = new Point();            private static var sPoint3D:Vector3D = new Vector3D();            private static var sClipRect:Rectangle = new Rectangle();            private static var sBufferRect:Rectangle = new Rectangle();            private static var sScissorRect:Rectangle = new Rectangle();            private static var sAssembler:AGALMiniAssembler = new AGALMiniAssembler();            private static var sMatrix3D:Matrix3D = new Matrix3D();            private static var sMatrixData:Vector.<Number> = new <Number>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];                   private var mProjectionMatrix:Matrix;            private var mModelViewMatrix:Matrix;            private var mMvpMatrix:Matrix;            private var mMatrixStack:Vector.<Matrix>;            private var mMatrixStackSize:int;            private var mProjectionMatrix3D:Matrix3D;            private var mModelViewMatrix3D:Matrix3D;            private var mMvpMatrix3D:Matrix3D;            private var mMatrixStack3D:Vector.<Matrix3D>;            private var mMatrixStack3DSize:int;            private var mDrawCount:int;            private var mBlendMode:String;            private var mClipRectStack:Vector.<Rectangle>;            private var mClipRectStackSize:int;            private var mQuadBatches:Vector.<QuadBatch>;            private var mCurrentQuadBatchID:int;            private var mMasks:Vector.<DisplayObject>;            private var mStencilReferenceValue:uint = 0;            public function RenderSupport() { super(); }
            public static function transformMatrixForObject(matrix:Matrix, object:DisplayObject) : void { }
            public static function setDefaultBlendFactors(premultipliedAlpha:Boolean) : void { }
            public static function setBlendFactors(premultipliedAlpha:Boolean, blendMode:String = "normal") : void { }
            public static function clear(rgb:uint = 0, alpha:Number = 0.0) : void { }
            public static function assembleAgal(vertexShader:String, fragmentShader:String, resultProgram:Program3D = null) : Program3D { return null; }
            public static function getTextureLookupFlags(format:String, mipMapping:Boolean, repeat:Boolean = false, smoothing:String = "bilinear") : String { return null; }
            public function dispose() : void { }
            public function setProjectionMatrix(x:Number, y:Number, width:Number, height:Number, stageWidth:Number = 0, stageHeight:Number = 0, cameraPos:Vector3D = null) : void { }
            [Deprecated(replacement="setProjectionMatrix")]      public function setOrthographicProjection(x:Number, y:Number, width:Number, height:Number) : void { }
            public function loadIdentity() : void { }
            public function translateMatrix(dx:Number, dy:Number) : void { }
            public function rotateMatrix(angle:Number) : void { }
            public function scaleMatrix(sx:Number, sy:Number) : void { }
            public function prependMatrix(matrix:Matrix) : void { }
            public function transformMatrix(object:DisplayObject) : void { }
            public function pushMatrix() : void { }
            public function popMatrix() : void { }
            public function resetMatrix() : void { }
            public function get mvpMatrix() : Matrix { return null; }
            public function get modelViewMatrix() : Matrix { return null; }
            public function get projectionMatrix() : Matrix { return null; }
            public function set projectionMatrix(value:Matrix) : void { }
            public function transformMatrix3D(object:DisplayObject) : void { }
            public function pushMatrix3D() : void { }
            public function popMatrix3D() : void { }
            public function get mvpMatrix3D() : Matrix3D { return null; }
            public function get projectionMatrix3D() : Matrix3D { return null; }
            public function set projectionMatrix3D(value:Matrix3D) : void { }
            public function applyBlendMode(premultipliedAlpha:Boolean) : void { }
            public function get blendMode() : String { return null; }
            public function set blendMode(value:String) : void { }
            public function get renderTarget() : Texture { return null; }
            public function set renderTarget(target:Texture) : void { }
            public function setRenderTarget(target:Texture, antiAliasing:int = 0) : void { }
            public function pushClipRect(rectangle:Rectangle, intersectWithCurrent:Boolean = true) : Rectangle { return null; }
            public function popClipRect() : void { }
            public function applyClipRect() : void { }
            public function pushMask(mask:DisplayObject) : void { }
            public function popMask() : void { }
            private function drawMask(mask:DisplayObject) : void { }
            public function get stencilReferenceValue() : uint { return null; }
            public function set stencilReferenceValue(value:uint) : void { }
            public function batchQuad(quad:Quad, parentAlpha:Number, texture:Texture = null, smoothing:String = null) : void { }
            public function batchQuadBatch(quadBatch:QuadBatch, parentAlpha:Number) : void { }
            public function finishQuadBatch() : void { }
            public function nextFrame() : void { }
            private function trimQuadBatches() : void { }
            private function createQuadBatch() : QuadBatch { return null; }
            public function clear(rgb:uint = 0, alpha:Number = 0.0) : void { }
            public function raiseDrawCount(value:uint = 1) : void { }
            public function get drawCount() : int { return 0; }
   }}