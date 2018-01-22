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
      
      public function Graphic()
      {
         super();
         indices = new Vector.<uint>();
         vertices = new Vector.<Number>();
         var _loc2_:Starling = Starling.current;
         var _loc1_:StandardVertexShader = defaultVertexShaderDictionary[_loc2_];
         if(_loc1_ == null)
         {
            _loc1_ = new StandardVertexShader();
            defaultVertexShaderDictionary[_loc2_] = _loc1_;
         }
         var _loc3_:VertexColorFragmentShader = defaultFragmentShaderDictionary[_loc2_];
         if(_loc3_ == null)
         {
            _loc3_ = new VertexColorFragmentShader();
            defaultFragmentShaderDictionary[_loc2_] = _loc3_;
         }
         _material = new StandardMaterial(_loc1_,_loc3_);
         minBounds = new Point();
         maxBounds = new Point();
         if(Starling.current)
         {
            Starling.current.addEventListener("context3DCreate",onContextCreated);
         }
      }
      
      private function onContextCreated(param1:Event) : void
      {
         geometryInvalid = true;
         buffersInvalid = true;
         uvsInvalid = true;
         _material.restoreOnLostContext();
         onGraphicLostContext();
      }
      
      protected function onGraphicLostContext() : void
      {
      }
      
      override public function dispose() : void
      {
         if(Starling.current)
         {
            Starling.current.removeEventListener("context3DCreate",onContextCreated);
            super.dispose();
         }
         if(vertexBuffer)
         {
            vertexBuffer.dispose();
            vertexBuffer = null;
         }
         if(indexBuffer)
         {
            indexBuffer.dispose();
            indexBuffer = null;
         }
         if(material)
         {
            material = null;
         }
         vertices = null;
         indices = null;
         _uvMatrix = null;
         minBounds = null;
         maxBounds = null;
         geometryInvalid = true;
      }
      
      public function set material(param1:IMaterial) : void
      {
         _material = param1;
      }
      
      public function get material() : IMaterial
      {
         return _material;
      }
      
      public function get uvMatrix() : Matrix
      {
         return _uvMatrix;
      }
      
      public function set uvMatrix(param1:Matrix) : void
      {
         _uvMatrix = param1;
         uvsInvalid = true;
         geometryInvalid = true;
      }
      
      public function shapeHitTest(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:Point = globalToLocal(new Point(param1,param2));
         return _loc3_.x >= minBounds.x && _loc3_.x <= maxBounds.x && _loc3_.y >= minBounds.y && _loc3_.y <= maxBounds.y;
      }
      
      public function set precisionHitTest(param1:Boolean) : void
      {
         _precisionHitTest = param1;
      }
      
      public function get precisionHitTest() : Boolean
      {
         return _precisionHitTest;
      }
      
      public function set precisionHitTestDistance(param1:Number) : void
      {
         _precisionHitTestDistance = param1;
      }
      
      public function get precisionHitTestDistance() : Number
      {
         return _precisionHitTestDistance;
      }
      
      protected function shapeHitTestLocalInternal(param1:Number, param2:Number) : Boolean
      {
         return param1 >= minBounds.x - _precisionHitTestDistance && param1 <= maxBounds.x + _precisionHitTestDistance && param2 >= minBounds.y - _precisionHitTestDistance && param2 <= maxBounds.y + _precisionHitTestDistance;
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(param2 && (visible == false || touchable == false))
         {
            return null;
         }
         if(minBounds == null || maxBounds == null)
         {
            return null;
         }
         if(getBounds(this,sGraphicHelperRect).containsPoint(param1))
         {
            if(_precisionHitTest)
            {
               if(shapeHitTestLocalInternal(param1.x,param1.y))
               {
                  return this;
               }
            }
            else
            {
               return this;
            }
         }
         return null;
      }
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         if(param2 == null)
         {
            param2 = new Rectangle();
         }
         if(param1 == this)
         {
            param2.x = minBounds.x;
            param2.y = minBounds.y;
            param2.right = maxBounds.x;
            param2.bottom = maxBounds.y;
            if(_precisionHitTest)
            {
               param2.x = param2.x - _precisionHitTestDistance;
               param2.y = param2.y - _precisionHitTestDistance;
               param2.width = param2.width + _precisionHitTestDistance * 2;
               param2.height = param2.height + _precisionHitTestDistance * 2;
            }
            return param2;
         }
         getTransformationMatrix(param1,sHelperMatrix);
         var _loc5_:Matrix = sHelperMatrix;
         sGraphicHelperPointTR.x = minBounds.x + (maxBounds.x - minBounds.x);
         sGraphicHelperPointTR.y = minBounds.y;
         sGraphicHelperPointBL.x = minBounds.x;
         sGraphicHelperPointBL.y = minBounds.y + (maxBounds.y - minBounds.y);
         var _loc4_:Point = sHelperMatrix.transformPoint(minBounds);
         sGraphicHelperPointTR = sHelperMatrix.transformPoint(sGraphicHelperPointTR);
         var _loc3_:Point = sHelperMatrix.transformPoint(maxBounds);
         sGraphicHelperPointBL = sHelperMatrix.transformPoint(sGraphicHelperPointBL);
         param2.x = Math.min(_loc4_.x,_loc3_.x,sGraphicHelperPointTR.x,sGraphicHelperPointBL.x);
         param2.y = Math.min(_loc4_.y,_loc3_.y,sGraphicHelperPointTR.y,sGraphicHelperPointBL.y);
         param2.right = Math.max(_loc4_.x,_loc3_.x,sGraphicHelperPointTR.x,sGraphicHelperPointBL.x);
         param2.bottom = Math.max(_loc4_.y,_loc3_.y,sGraphicHelperPointTR.y,sGraphicHelperPointBL.y);
         if(_precisionHitTest)
         {
            param2.x = param2.x - _precisionHitTestDistance;
            param2.y = param2.y - _precisionHitTestDistance;
            param2.width = param2.width + _precisionHitTestDistance * 2;
            param2.height = param2.height + _precisionHitTestDistance * 2;
         }
         return param2;
      }
      
      protected function buildGeometry() : void
      {
         throw new AbstractMethodError();
      }
      
      protected function applyUVMatrix() : void
      {
         var _loc2_:int = 0;
         if(!vertices)
         {
            return;
         }
         if(!_uvMatrix)
         {
            return;
         }
         var _loc1_:Point = new Point();
         _loc2_ = 0;
         while(_loc2_ < vertices.length)
         {
            _loc1_.x = vertices[_loc2_ + 7];
            _loc1_.y = vertices[_loc2_ + 8];
            _loc1_ = _uvMatrix.transformPoint(_loc1_);
            vertices[_loc2_ + 7] = _loc1_.x;
            vertices[_loc2_ + 8] = _loc1_.y;
            _loc2_ = _loc2_ + 9;
         }
      }
      
      public function adjustUVMappings(param1:Number, param2:Number, param3:Texture) : void
      {
         var _loc9_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Number = getNextPowerOfTwo(param3.nativeWidth);
         var _loc6_:Number = getNextPowerOfTwo(param3.nativeHeight);
         var _loc5_:Number = 1 / _loc8_;
         var _loc12_:Number = 1 / _loc6_;
         if(vertices == null || vertices.length == 0)
         {
            return;
         }
         var _loc4_:int = vertices.length;
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc9_ = vertices[_loc7_];
            _loc13_ = vertices[_loc7_ + 1];
            _loc11_ = (param1 + _loc9_) * _loc5_;
            _loc10_ = (param2 + _loc13_) * _loc12_;
            vertices[_loc7_ + 7] = _loc11_;
            vertices[_loc7_ + 8] = _loc10_;
            _loc7_ = _loc7_ + 9;
         }
         uvMappingsChanged = true;
         _uvMatrix = null;
      }
      
      public function validateNow() : void
      {
         if(geometryInvalid == false && uvMappingsChanged == false)
         {
            return;
         }
         if(vertexBuffer && (buffersInvalid || uvsInvalid || isGeometryScaled))
         {
            vertexBuffer.dispose();
            indexBuffer.dispose();
         }
         if(buffersInvalid || geometryInvalid)
         {
            buildGeometry();
            applyUVMatrix();
         }
         else if(uvsInvalid)
         {
            applyUVMatrix();
         }
      }
      
      protected function setGeometryInvalid(param1:Boolean = true) : void
      {
         if(param1)
         {
            buffersInvalid = true;
         }
         geometryInvalid = true;
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         var _loc4_:int = 0;
         validateNow();
         if(indices == null || indices.length < 3)
         {
            return;
         }
         if(buffersInvalid || uvsInvalid || isGeometryScaled)
         {
            _loc4_ = vertices.length / 9;
            vertexBuffer = Starling.context.createVertexBuffer(_loc4_,9);
            vertexBuffer.uploadFromVector(vertices,0,_loc4_);
            indexBuffer = Starling.context.createIndexBuffer(indices.length);
            indexBuffer.uploadFromVector(indices,0,indices.length);
            geometryInvalid = false;
            isGeometryScaled = false;
            uvsInvalid = false;
            buffersInvalid = false;
         }
         else if(geometryInvalid || uvMappingsChanged)
         {
            vertexBuffer.uploadFromVector(vertices,0,vertices.length / 9);
            indexBuffer.uploadFromVector(indices,0,indices.length);
            geometryInvalid = false;
            uvMappingsChanged = false;
         }
         var _loc3_:Context3D = Starling.context;
         if(_loc3_ == null)
         {
            throw new MissingContextError();
         }
         param1.finishQuadBatch();
         if(_graphicDrawHelper)
         {
            _graphicDrawHelper.onDrawTriangles(_material,param1,vertexBuffer,indexBuffer,param2 * this.alpha);
         }
         else
         {
            RenderSupport.setBlendFactors(_material.premultipliedAlpha,this.blendMode == "auto"?param1.blendMode:this.blendMode);
            _material.drawTriangles(Starling.context,param1.mvpMatrix3D,vertexBuffer,indexBuffer,param2 * this.alpha);
            param1.raiseDrawCount();
         }
         _loc3_.setTextureAt(0,null);
         _loc3_.setTextureAt(1,null);
         _loc3_.setVertexBufferAt(0,null);
         _loc3_.setVertexBufferAt(1,null);
         _loc3_.setVertexBufferAt(2,null);
      }
      
      public function exportToPolygon(param1:GraphicsPolygon = null) : GraphicsPolygon
      {
         var _loc7_:* = 0;
         var _loc3_:* = null;
         validateNow();
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1)
         {
            _loc4_ = param1.lastVertexIndex <= 0?0:Number(param1.lastVertexIndex * 9);
            _loc5_ = param1.lastIndexIndex <= 0?0:Number(param1.lastIndexIndex * 9);
         }
         var _loc6_:Array = [];
         var _loc2_:int = vertices.length;
         _loc7_ = _loc4_;
         while(_loc7_ < _loc2_)
         {
            _loc6_.push(vertices[_loc7_ + 0]);
            _loc6_.push(vertices[_loc7_ + 1]);
            _loc7_ = int(_loc7_ + 9);
         }
         if(param1 == null)
         {
            _loc3_ = new GraphicsPolygon(_loc6_,indices);
            return _loc3_;
         }
         param1.append(_loc6_,indices);
         return param1;
      }
      
      public function set graphicDrawHelper(param1:IGraphicDrawHelper) : void
      {
         validateNow();
         _graphicDrawHelper = param1;
         _graphicDrawHelper.initialize(vertices.length / 9);
      }
      
      public function get graphicDrawHelper() : IGraphicDrawHelper
      {
         return _graphicDrawHelper;
      }
   }
}
