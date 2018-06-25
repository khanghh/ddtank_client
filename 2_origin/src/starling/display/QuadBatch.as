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
      
      public function QuadBatch()
      {
         super();
         mVertexData = new VertexData(0,true);
         mIndexData = new Vector.<uint>(0);
         mNumQuads = 0;
         mTinted = false;
         mSyncRequired = false;
         mBatchable = false;
         mForceTinted = false;
         mOwnsTexture = false;
         Starling.current.stage3D.addEventListener("context3DCreate",onContextCreated,false,0,true);
      }
      
      public static function compile(object:DisplayObject, quadBatches:Vector.<QuadBatch>) : void
      {
         compileObject(object,quadBatches,-1,new Matrix());
      }
      
      public static function optimize(quadBatches:Vector.<QuadBatch>) : void
      {
         var batch2:* = null;
         var batch1:* = null;
         var i:int = 0;
         var j:int = 0;
         for(i = 0; i < quadBatches.length; )
         {
            batch1 = quadBatches[i];
            for(j = i + 1; j < quadBatches.length; )
            {
               batch2 = quadBatches[j];
               if(!batch1.isStateChange(batch2.tinted,1,batch2.texture,batch2.smoothing,batch2.blendMode))
               {
                  batch1.addQuadBatch(batch2);
                  batch2.dispose();
                  quadBatches.splice(j,1);
               }
               else
               {
                  j++;
               }
            }
            i++;
         }
      }
      
      private static function compileObject(object:DisplayObject, quadBatches:Vector.<QuadBatch>, quadBatchID:int, transformationMatrix:Matrix, alpha:Number = 1.0, blendMode:String = null, ignoreCurrentFilter:Boolean = false) : int
      {
         var i:int = 0;
         var quadBatch:* = null;
         var numChildren:int = 0;
         var childMatrix:* = null;
         var child:* = null;
         var childBlendMode:* = null;
         var texture:* = null;
         var smoothing:* = null;
         var tinted:Boolean = false;
         var numQuads:int = 0;
         var image:* = null;
         if(object is Sprite3D)
         {
            throw new IllegalOperationError("Sprite3D objects cannot be flattened");
         }
         var isRootObject:Boolean = false;
         var objectAlpha:* = Number(object.alpha);
         var container:DisplayObjectContainer = object as DisplayObjectContainer;
         var quad:Quad = object as Quad;
         var batch:QuadBatch = object as QuadBatch;
         var filter:FragmentFilter = object.filter;
         if(quadBatchID == -1)
         {
            isRootObject = true;
            quadBatchID = 0;
            objectAlpha = 1;
            blendMode = object.blendMode;
            ignoreCurrentFilter = true;
            if(quadBatches.length == 0)
            {
               quadBatches[0] = new QuadBatch();
            }
            else
            {
               quadBatches[0].reset();
               quadBatches[0].ownsTexture = false;
            }
         }
         else
         {
            if(object.mask)
            {
               trace("[Starling] Masks are ignored on children of a flattened sprite.");
            }
            if(object is Sprite && (object as Sprite).clipRect)
            {
               trace("[Starling] ClipRects are ignored on children of a flattened sprite.");
            }
         }
         if(filter && !ignoreCurrentFilter)
         {
            if(filter.mode == "above")
            {
               quadBatchID = compileObject(object,quadBatches,quadBatchID,transformationMatrix,alpha,blendMode,true);
            }
            quadBatchID = compileObject(filter.compile(object),quadBatches,quadBatchID,transformationMatrix,alpha,blendMode);
            quadBatches[quadBatchID].ownsTexture = true;
            if(filter.mode == "below")
            {
               quadBatchID = compileObject(object,quadBatches,quadBatchID,transformationMatrix,alpha,blendMode,true);
            }
         }
         else if(container)
         {
            numChildren = container.numChildren;
            childMatrix = new Matrix();
            for(i = 0; i < numChildren; )
            {
               child = container.getChildAt(i);
               if(child.hasVisibleArea)
               {
                  childBlendMode = child.blendMode == "auto"?blendMode:child.blendMode;
                  childMatrix.copyFrom(transformationMatrix);
                  RenderSupport.transformMatrixForObject(childMatrix,child);
                  quadBatchID = compileObject(child,quadBatches,quadBatchID,childMatrix,alpha * objectAlpha,childBlendMode);
               }
               i++;
            }
         }
         else if(quad || batch)
         {
            if(quad)
            {
               image = quad as Image;
               texture = !!image?image.texture:null;
               smoothing = !!image?image.smoothing:null;
               tinted = quad.tinted;
               numQuads = 1;
            }
            else
            {
               texture = batch.mTexture;
               smoothing = batch.mSmoothing;
               tinted = batch.mTinted;
               numQuads = batch.mNumQuads;
            }
            quadBatch = quadBatches[quadBatchID];
            if(quadBatch.isStateChange(tinted,alpha * objectAlpha,texture,smoothing,blendMode,numQuads))
            {
               quadBatchID++;
               if(quadBatches.length <= quadBatchID)
               {
                  quadBatches.push(new QuadBatch());
               }
               quadBatch = quadBatches[quadBatchID];
               quadBatch.reset();
               quadBatch.ownsTexture = false;
            }
            if(quad)
            {
               quadBatch.addQuad(quad,alpha,texture,smoothing,transformationMatrix,blendMode);
            }
            else
            {
               quadBatch.addQuadBatch(batch,alpha,transformationMatrix,blendMode);
            }
         }
         else
         {
            throw new Error("Unsupported display object: " + getQualifiedClassName(object));
         }
         if(isRootObject)
         {
            for(i = quadBatches.length - 1; i > quadBatchID; )
            {
               quadBatches.pop().dispose();
               i--;
            }
         }
         return quadBatchID;
      }
      
      private static function getImageProgramName(tinted:Boolean, mipMap:Boolean = true, repeat:Boolean = false, format:String = "bgra", smoothing:String = "bilinear") : String
      {
         var bitField:uint = 0;
         if(tinted)
         {
            bitField = bitField | 1;
         }
         if(mipMap)
         {
            bitField = bitField | 2;
         }
         if(repeat)
         {
            bitField = bitField | 4;
         }
         if(smoothing == "none")
         {
            bitField = bitField | 8;
         }
         else if(smoothing == "trilinear")
         {
            bitField = bitField | 16;
         }
         if(format == "compressed")
         {
            bitField = bitField | 32;
         }
         else if(format == "compressedAlpha")
         {
            bitField = bitField | 64;
         }
         var name:String = sProgramNameCache[bitField];
         if(name == null)
         {
            name = "QB_i." + bitField.toString(16);
            sProgramNameCache[bitField] = name;
         }
         return name;
      }
      
      override public function dispose() : void
      {
         Starling.current.stage3D.removeEventListener("context3DCreate",onContextCreated);
         destroyBuffers();
         mVertexData.numVertices = 0;
         mIndexData.length = 0;
         mNumQuads = 0;
         if(mTexture && mOwnsTexture)
         {
            mTexture.dispose();
         }
         super.dispose();
      }
      
      private function onContextCreated(event:Object) : void
      {
         createBuffers();
      }
      
      protected function onVertexDataChanged() : void
      {
         mSyncRequired = true;
      }
      
      public function clone() : QuadBatch
      {
         var clone:QuadBatch = new QuadBatch();
         clone.mVertexData = mVertexData.clone(0,mNumQuads * 4);
         clone.mIndexData = mIndexData.slice(0,mNumQuads * 6);
         clone.mNumQuads = mNumQuads;
         clone.mTinted = mTinted;
         clone.mTexture = mTexture;
         clone.mSmoothing = mSmoothing;
         clone.mSyncRequired = true;
         clone.blendMode = blendMode;
         clone.alpha = alpha;
         return clone;
      }
      
      private function expand() : void
      {
         var oldCapacity:int = this.capacity;
         if(oldCapacity >= 16383)
         {
            throw new Error("Exceeded maximum number of quads!");
         }
         this.capacity = oldCapacity < 8?16:Number(oldCapacity * 2);
      }
      
      private function createBuffers() : void
      {
         destroyBuffers();
         var numVertices:int = mVertexData.numVertices;
         var numIndices:int = mIndexData.length;
         var context:Context3D = Starling.context;
         if(numVertices == 0)
         {
            return;
         }
         if(context == null)
         {
            throw new MissingContextError();
         }
         mVertexBuffer = context.createVertexBuffer(numVertices,8);
         mVertexBuffer.uploadFromVector(mVertexData.rawData,0,numVertices);
         mIndexBuffer = context.createIndexBuffer(numIndices);
         mIndexBuffer.uploadFromVector(mIndexData,0,numIndices);
         mSyncRequired = false;
      }
      
      private function destroyBuffers() : void
      {
         if(mVertexBuffer)
         {
            mVertexBuffer.dispose();
            mVertexBuffer = null;
         }
         if(mIndexBuffer)
         {
            mIndexBuffer.dispose();
            mIndexBuffer = null;
         }
      }
      
      private function syncBuffers() : void
      {
         if(mVertexBuffer == null)
         {
            createBuffers();
         }
         else
         {
            mVertexBuffer.uploadFromVector(mVertexData.rawData,0,mVertexData.numVertices);
            mSyncRequired = false;
         }
      }
      
      public function renderCustom(mvpMatrix:Matrix3D, parentAlpha:Number = 1.0, blendMode:String = null) : void
      {
         if(mNumQuads == 0)
         {
            return;
         }
         if(mSyncRequired)
         {
            syncBuffers();
         }
         var pma:Boolean = mVertexData.premultipliedAlpha;
         var context:Context3D = Starling.context;
         var tinted:Boolean = mTinted || parentAlpha != 1;
         var _loc7_:* = !!pma?parentAlpha:1;
         sRenderAlpha[2] = _loc7_;
         _loc7_ = _loc7_;
         sRenderAlpha[1] = _loc7_;
         sRenderAlpha[0] = _loc7_;
         sRenderAlpha[3] = parentAlpha;
         RenderSupport.setBlendFactors(pma,!!blendMode?blendMode:this.blendMode);
         context.setProgram(getProgram(tinted));
         context.setProgramConstantsFromVector("vertex",0,sRenderAlpha,1);
         context.setProgramConstantsFromMatrix("vertex",1,mvpMatrix,true);
         context.setVertexBufferAt(0,mVertexBuffer,0,"float2");
         if(mTexture == null || tinted)
         {
            context.setVertexBufferAt(1,mVertexBuffer,2,"float4");
         }
         if(mTexture)
         {
            context.setTextureAt(0,mTexture.base);
            context.setVertexBufferAt(2,mVertexBuffer,6,"float2");
         }
         context.drawTriangles(mIndexBuffer,0,mNumQuads * 2);
         if(mTexture)
         {
            context.setTextureAt(0,null);
            context.setVertexBufferAt(2,null);
         }
         context.setVertexBufferAt(1,null);
         context.setVertexBufferAt(0,null);
      }
      
      public function reset() : void
      {
         if(mTexture && mOwnsTexture)
         {
            mTexture.dispose();
         }
         mNumQuads = 0;
         mTexture = null;
         mSmoothing = null;
         mSyncRequired = true;
      }
      
      public function addImage(image:Image, parentAlpha:Number = 1.0, modelViewMatrix:Matrix = null, blendMode:String = null) : void
      {
         addQuad(image,parentAlpha,image.texture,image.smoothing,modelViewMatrix,blendMode);
      }
      
      public function addQuad(quad:Quad, parentAlpha:Number = 1.0, texture:Texture = null, smoothing:String = null, modelViewMatrix:Matrix = null, blendMode:String = null) : void
      {
         if(modelViewMatrix == null)
         {
            modelViewMatrix = quad.transformationMatrix;
         }
         var alpha:Number = parentAlpha * quad.alpha;
         var vertexID:int = mNumQuads * 4;
         if(mNumQuads + 1 > mVertexData.numVertices / 4)
         {
            expand();
         }
         if(mNumQuads == 0)
         {
            this.blendMode = !!blendMode?blendMode:quad.blendMode;
            mTexture = texture;
            mTinted = mForceTinted || quad.tinted || parentAlpha != 1;
            mSmoothing = smoothing;
            mVertexData.setPremultipliedAlpha(quad.premultipliedAlpha);
         }
         quad.copyVertexDataTransformedTo(mVertexData,vertexID,modelViewMatrix);
         if(alpha != 1)
         {
            mVertexData.scaleAlpha(vertexID,alpha,4);
         }
         mSyncRequired = true;
         mNumQuads = Number(mNumQuads) + 1;
      }
      
      public function addQuadBatch(quadBatch:QuadBatch, parentAlpha:Number = 1.0, modelViewMatrix:Matrix = null, blendMode:String = null) : void
      {
         if(modelViewMatrix == null)
         {
            modelViewMatrix = quadBatch.transformationMatrix;
         }
         var alpha:Number = parentAlpha * quadBatch.alpha;
         var vertexID:int = mNumQuads * 4;
         var numQuads:int = quadBatch.numQuads;
         if(mNumQuads + numQuads > capacity)
         {
            capacity = mNumQuads + numQuads;
         }
         if(mNumQuads == 0)
         {
            this.blendMode = !!blendMode?blendMode:quadBatch.blendMode;
            mTexture = quadBatch.mTexture;
            mTinted = mForceTinted || quadBatch.mTinted || parentAlpha != 1;
            mSmoothing = quadBatch.mSmoothing;
            mVertexData.setPremultipliedAlpha(quadBatch.mVertexData.premultipliedAlpha,false);
         }
         quadBatch.mVertexData.copyTransformedTo(mVertexData,vertexID,modelViewMatrix,0,numQuads * 4);
         if(alpha != 1)
         {
            mVertexData.scaleAlpha(vertexID,alpha,numQuads * 4);
         }
         mSyncRequired = true;
         mNumQuads = mNumQuads + numQuads;
      }
      
      public function isStateChange(tinted:Boolean, parentAlpha:Number, texture:Texture, smoothing:String, blendMode:String, numQuads:int = 1) : Boolean
      {
         if(mNumQuads == 0)
         {
            return false;
         }
         if(mNumQuads + numQuads > 16383)
         {
            return true;
         }
         if(mTexture == null && texture == null)
         {
            return this.blendMode != blendMode;
         }
         if(mTexture != null && texture != null)
         {
            return mTexture.base != texture.base || mTexture.repeat != texture.repeat || mSmoothing != smoothing || mTinted != (mForceTinted || tinted || parentAlpha != 1) || this.blendMode != blendMode;
         }
         return true;
      }
      
      public function transformQuad(quadID:int, matrix:Matrix) : void
      {
         mVertexData.transformVertex(quadID * 4,matrix,4);
         mSyncRequired = true;
      }
      
      public function getVertexColor(quadID:int, vertexID:int) : uint
      {
         return mVertexData.getColor(quadID * 4 + vertexID);
      }
      
      public function setVertexColor(quadID:int, vertexID:int, color:uint) : void
      {
         mVertexData.setColor(quadID * 4 + vertexID,color);
         mSyncRequired = true;
      }
      
      public function getVertexAlpha(quadID:int, vertexID:int) : Number
      {
         return mVertexData.getAlpha(quadID * 4 + vertexID);
      }
      
      public function setVertexAlpha(quadID:int, vertexID:int, alpha:Number) : void
      {
         mVertexData.setAlpha(quadID * 4 + vertexID,alpha);
         mSyncRequired = true;
      }
      
      public function getQuadColor(quadID:int) : uint
      {
         return mVertexData.getColor(quadID * 4);
      }
      
      public function setQuadColor(quadID:int, color:uint) : void
      {
         var i:int = 0;
         for(i = 0; i < 4; )
         {
            mVertexData.setColor(quadID * 4 + i,color);
            i++;
         }
         mSyncRequired = true;
      }
      
      public function getQuadAlpha(quadID:int) : Number
      {
         return mVertexData.getAlpha(quadID * 4);
      }
      
      public function setQuadAlpha(quadID:int, alpha:Number) : void
      {
         var i:int = 0;
         for(i = 0; i < 4; )
         {
            mVertexData.setAlpha(quadID * 4 + i,alpha);
            i++;
         }
         mSyncRequired = true;
      }
      
      public function setQuad(quadID:Number, quad:Quad) : void
      {
         var matrix:Matrix = quad.transformationMatrix;
         var alpha:Number = quad.alpha;
         var vertexID:int = quadID * 4;
         quad.copyVertexDataTransformedTo(mVertexData,vertexID,matrix);
         if(alpha != 1)
         {
            mVertexData.scaleAlpha(vertexID,alpha,4);
         }
         mSyncRequired = true;
      }
      
      public function getQuadBounds(quadID:int, transformationMatrix:Matrix = null, resultRect:Rectangle = null) : Rectangle
      {
         return mVertexData.getBounds(transformationMatrix,quadID * 4,4,resultRect);
      }
      
      override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle
      {
         if(resultRect == null)
         {
            resultRect = new Rectangle();
         }
         var transformationMatrix:Matrix = targetSpace == this?null:getTransformationMatrix(targetSpace,sHelperMatrix);
         return mVertexData.getBounds(transformationMatrix,0,mNumQuads * 4,resultRect);
      }
      
      override public function render(support:RenderSupport, parentAlpha:Number) : void
      {
         if(mNumQuads)
         {
            if(mBatchable)
            {
               support.batchQuadBatch(this,parentAlpha);
            }
            else
            {
               support.finishQuadBatch();
               support.raiseDrawCount();
               renderCustom(support.mvpMatrix3D,alpha * parentAlpha,support.blendMode);
            }
         }
      }
      
      public function get numQuads() : int
      {
         return mNumQuads;
      }
      
      public function get tinted() : Boolean
      {
         return mTinted || mForceTinted;
      }
      
      public function get texture() : Texture
      {
         return mTexture;
      }
      
      public function get smoothing() : String
      {
         return mSmoothing;
      }
      
      public function get premultipliedAlpha() : Boolean
      {
         return mVertexData.premultipliedAlpha;
      }
      
      public function get batchable() : Boolean
      {
         return mBatchable;
      }
      
      public function set batchable(value:Boolean) : void
      {
         mBatchable = value;
      }
      
      public function get forceTinted() : Boolean
      {
         return mForceTinted;
      }
      
      public function set forceTinted(value:Boolean) : void
      {
         mForceTinted = value;
      }
      
      public function get ownsTexture() : Boolean
      {
         return mOwnsTexture;
      }
      
      public function set ownsTexture(value:Boolean) : void
      {
         mOwnsTexture = value;
      }
      
      public function get capacity() : int
      {
         return mVertexData.numVertices / 4;
      }
      
      public function set capacity(value:int) : void
      {
         var i:* = 0;
         var oldCapacity:int = capacity;
         if(value == oldCapacity)
         {
            return;
         }
         if(value == 0)
         {
            throw new Error("Capacity must be > 0");
         }
         if(value > 16383)
         {
            value = 16383;
         }
         if(mNumQuads > value)
         {
            mNumQuads = value;
         }
         mVertexData.numVertices = value * 4;
         mIndexData.length = value * 6;
         for(i = oldCapacity; i < value; )
         {
            mIndexData[int(i * 6)] = i * 4;
            mIndexData[int(i * 6 + 1)] = i * 4 + 1;
            mIndexData[int(i * 6 + 2)] = i * 4 + 2;
            mIndexData[int(i * 6 + 3)] = i * 4 + 1;
            mIndexData[int(i * 6 + 4)] = i * 4 + 3;
            mIndexData[int(i * 6 + 5)] = i * 4 + 2;
            i++;
         }
         destroyBuffers();
         mSyncRequired = true;
      }
      
      private function getProgram(tinted:Boolean) : Program3D
      {
         var vertexShader:* = null;
         var fragmentShader:* = null;
         var target:Starling = Starling.current;
         var programName:String = "QB_q";
         if(mTexture)
         {
            programName = getImageProgramName(tinted,mTexture.mipMapping,mTexture.repeat,mTexture.format,mSmoothing);
         }
         var program:Program3D = target.getProgram(programName);
         if(!program)
         {
            if(!mTexture)
            {
               vertexShader = "m44 op, va0, vc1 \nmul v0, va1, vc0 \n";
               fragmentShader = "mov oc, v0       \n";
            }
            else
            {
               vertexShader = !!tinted?"m44 op, va0, vc1 \nmul v0, va1, vc0 \nmov v1, va2      \n":"m44 op, va0, vc1 \nmov v1, va2      \n";
               fragmentShader = !!tinted?"tex ft1,  v1, fs0 <???> \nmul  oc, ft1,  v0       \n":"tex  oc,  v1, fs0 <???> \n";
               fragmentShader = fragmentShader.replace("<???>",RenderSupport.getTextureLookupFlags(mTexture.format,mTexture.mipMapping,mTexture.repeat,smoothing));
            }
            program = target.registerProgramFromSource(programName,vertexShader,fragmentShader);
         }
         return program;
      }
   }
}
