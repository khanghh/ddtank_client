package starling.display{   import flash.display3D.Context3D;   import flash.display3D.IndexBuffer3D;   import flash.display3D.Program3D;   import flash.display3D.VertexBuffer3D;   import flash.errors.IllegalOperationError;   import flash.geom.Matrix;   import flash.geom.Matrix3D;   import flash.geom.Rectangle;   import flash.utils.Dictionary;   import flash.utils.getQualifiedClassName;   import starling.core.RenderSupport;   import starling.core.Starling;   import starling.errors.MissingContextError;   import starling.filters.FragmentFilter;   import starling.textures.Texture;   import starling.utils.VertexData;      public class QuadBatch extends DisplayObject   {            public static const MAX_NUM_QUADS:int = 16383;            private static const QUAD_PROGRAM_NAME:String = "QB_q";            private static var sHelperMatrix:Matrix = new Matrix();            private static var sRenderAlpha:Vector.<Number> = new <Number>[1,1,1,1];            private static var sProgramNameCache:Dictionary = new Dictionary();                   private var mNumQuads:int;            private var mSyncRequired:Boolean;            private var mBatchable:Boolean;            private var mForceTinted:Boolean;            private var mOwnsTexture:Boolean;            private var mTinted:Boolean;            private var mTexture:Texture;            private var mSmoothing:String;            private var mVertexBuffer:VertexBuffer3D;            private var mIndexData:Vector.<uint>;            private var mIndexBuffer:IndexBuffer3D;            protected var mVertexData:VertexData;            public function QuadBatch() { super(); }
            public static function compile(object:DisplayObject, quadBatches:Vector.<QuadBatch>) : void { }
            public static function optimize(quadBatches:Vector.<QuadBatch>) : void { }
            private static function compileObject(object:DisplayObject, quadBatches:Vector.<QuadBatch>, quadBatchID:int, transformationMatrix:Matrix, alpha:Number = 1.0, blendMode:String = null, ignoreCurrentFilter:Boolean = false) : int { return 0; }
            private static function getImageProgramName(tinted:Boolean, mipMap:Boolean = true, repeat:Boolean = false, format:String = "bgra", smoothing:String = "bilinear") : String { return null; }
            override public function dispose() : void { }
            private function onContextCreated(event:Object) : void { }
            protected function onVertexDataChanged() : void { }
            public function clone() : QuadBatch { return null; }
            private function expand() : void { }
            private function createBuffers() : void { }
            private function destroyBuffers() : void { }
            private function syncBuffers() : void { }
            public function renderCustom(mvpMatrix:Matrix3D, parentAlpha:Number = 1.0, blendMode:String = null) : void { }
            public function reset() : void { }
            public function addImage(image:Image, parentAlpha:Number = 1.0, modelViewMatrix:Matrix = null, blendMode:String = null) : void { }
            public function addQuad(quad:Quad, parentAlpha:Number = 1.0, texture:Texture = null, smoothing:String = null, modelViewMatrix:Matrix = null, blendMode:String = null) : void { }
            public function addQuadBatch(quadBatch:QuadBatch, parentAlpha:Number = 1.0, modelViewMatrix:Matrix = null, blendMode:String = null) : void { }
            public function isStateChange(tinted:Boolean, parentAlpha:Number, texture:Texture, smoothing:String, blendMode:String, numQuads:int = 1) : Boolean { return false; }
            public function transformQuad(quadID:int, matrix:Matrix) : void { }
            public function getVertexColor(quadID:int, vertexID:int) : uint { return null; }
            public function setVertexColor(quadID:int, vertexID:int, color:uint) : void { }
            public function getVertexAlpha(quadID:int, vertexID:int) : Number { return 0; }
            public function setVertexAlpha(quadID:int, vertexID:int, alpha:Number) : void { }
            public function getQuadColor(quadID:int) : uint { return null; }
            public function setQuadColor(quadID:int, color:uint) : void { }
            public function getQuadAlpha(quadID:int) : Number { return 0; }
            public function setQuadAlpha(quadID:int, alpha:Number) : void { }
            public function setQuad(quadID:Number, quad:Quad) : void { }
            public function getQuadBounds(quadID:int, transformationMatrix:Matrix = null, resultRect:Rectangle = null) : Rectangle { return null; }
            override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle { return null; }
            override public function render(support:RenderSupport, parentAlpha:Number) : void { }
            public function get numQuads() : int { return 0; }
            public function get tinted() : Boolean { return false; }
            public function get texture() : Texture { return null; }
            public function get smoothing() : String { return null; }
            public function get premultipliedAlpha() : Boolean { return false; }
            public function get batchable() : Boolean { return false; }
            public function set batchable(value:Boolean) : void { }
            public function get forceTinted() : Boolean { return false; }
            public function set forceTinted(value:Boolean) : void { }
            public function get ownsTexture() : Boolean { return false; }
            public function set ownsTexture(value:Boolean) : void { }
            public function get capacity() : int { return 0; }
            public function set capacity(value:int) : void { }
            private function getProgram(tinted:Boolean) : Program3D { return null; }
   }}