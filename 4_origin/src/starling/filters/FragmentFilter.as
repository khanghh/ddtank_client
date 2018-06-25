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
      
      public function FragmentFilter(numPasses:int = 1, resolution:Number = 1.0)
      {
         mHelperMatrix = new Matrix();
         mHelperMatrix3D = new Matrix3D();
         mHelperRect = new Rectangle();
         mHelperRect2 = new Rectangle();
         super();
         if(Capabilities.isDebugger && getQualifiedClassName(this) == "starling.filters::FragmentFilter")
         {
            throw new AbstractClassError();
         }
         if(numPasses < 1)
         {
            throw new ArgumentError("At least one pass is required.");
         }
         mNumPasses = numPasses;
         mMarginY = 0;
         mMarginX = 0;
         mOffsetY = 0;
         mOffsetX = 0;
         mResolution = resolution;
         mPassTextures = new Vector.<Texture>(0);
         mMode = "replace";
         mVertexData = new VertexData(4);
         mVertexData.setTexCoords(0,0,0);
         mVertexData.setTexCoords(1,1,0);
         mVertexData.setTexCoords(2,0,1);
         mVertexData.setTexCoords(3,1,1);
         mIndexData = new <uint>[0,1,2,1,3,2];
         mIndexData.fixed = true;
         if(Starling.current.contextValid)
         {
            createPrograms();
         }
         Starling.current.stage3D.addEventListener("context3DCreate",onContextCreated,false,0,true);
      }
      
      public function dispose() : void
      {
         Starling.current.stage3D.removeEventListener("context3DCreate",onContextCreated);
         if(mVertexBuffer)
         {
            mVertexBuffer.dispose();
         }
         if(mIndexBuffer)
         {
            mIndexBuffer.dispose();
         }
         disposePassTextures();
         disposeCache();
      }
      
      private function onContextCreated(event:Object) : void
      {
         mVertexBuffer = null;
         mIndexBuffer = null;
         disposePassTextures();
         createPrograms();
         if(mCache)
         {
            cache();
         }
      }
      
      public function render(object:DisplayObject, support:RenderSupport, parentAlpha:Number) : void
      {
         if(mode == "above")
         {
            object.render(support,parentAlpha);
         }
         if(mCacheRequested)
         {
            mCacheRequested = false;
            mCache = renderPasses(object,support,1,true);
            disposePassTextures();
         }
         if(mCache)
         {
            mCache.render(support,parentAlpha);
         }
         else
         {
            renderPasses(object,support,parentAlpha,false);
         }
         if(mode == "below")
         {
            object.render(support,parentAlpha);
         }
      }
      
      private function renderPasses(object:DisplayObject, support:RenderSupport, parentAlpha:Number, intoCache:Boolean = false) : QuadBatch
      {
         var passTexture:* = null;
         var previousStencilRefValue:* = 0;
         var previousRenderTarget:* = null;
         var intersectWithStage:Boolean = false;
         var i:int = 0;
         var quadBatch:* = null;
         var image:* = null;
         var cacheTexture:Texture = null;
         var context:Context3D = Starling.context;
         var targetSpace:DisplayObject = object.stage;
         var stage:Stage = Starling.current.stage;
         var scale:Number = Starling.current.contentScaleFactor;
         var projMatrix:Matrix = mHelperMatrix;
         var projMatrix3D:Matrix3D = mHelperMatrix3D;
         var bounds:Rectangle = mHelperRect;
         var boundsPot:Rectangle = mHelperRect2;
         if(context == null)
         {
            throw new MissingContextError();
         }
         intersectWithStage = !intoCache && mOffsetX == 0 && mOffsetY == 0;
         calculateBounds(object,targetSpace,mResolution * scale,intersectWithStage,bounds,boundsPot);
         if(bounds.isEmpty())
         {
            disposePassTextures();
            return !!intoCache?new QuadBatch():null;
         }
         updateBuffers(context,boundsPot);
         updatePassTextures(boundsPot.width,boundsPot.height,mResolution * scale);
         support.finishQuadBatch();
         support.raiseDrawCount(mNumPasses);
         support.pushMatrix();
         support.pushMatrix3D();
         support.pushClipRect(boundsPot,false);
         projMatrix.copyFrom(support.projectionMatrix);
         projMatrix3D.copyFrom(support.projectionMatrix3D);
         previousRenderTarget = support.renderTarget;
         previousStencilRefValue = uint(support.stencilReferenceValue);
         if(previousRenderTarget && !SystemUtil.supportsRelaxedTargetClearRequirement)
         {
            throw new IllegalOperationError("To nest filters, you need at least Flash Player / AIR version 15.");
         }
         if(intoCache)
         {
            cacheTexture = Texture.empty(boundsPot.width,boundsPot.height,true,false,true,mResolution * scale);
         }
         support.renderTarget = mPassTextures[0];
         support.clear();
         support.blendMode = "normal";
         support.stencilReferenceValue = 0;
         support.setProjectionMatrix(bounds.x,bounds.y,boundsPot.width,boundsPot.height,stage.stageWidth,stage.stageHeight,stage.cameraPosition);
         object.render(support,parentAlpha);
         support.finishQuadBatch();
         RenderSupport.setBlendFactors(true);
         support.loadIdentity();
         context.setVertexBufferAt(mVertexPosAtID,mVertexBuffer,0,"float2");
         context.setVertexBufferAt(mTexCoordsAtID,mVertexBuffer,6,"float2");
         for(i = 0; i < mNumPasses; )
         {
            if(i < mNumPasses - 1)
            {
               support.renderTarget = getPassTexture(i + 1);
               support.clear();
            }
            else if(intoCache)
            {
               support.renderTarget = cacheTexture;
               support.clear();
            }
            else
            {
               support.popClipRect();
               support.projectionMatrix = projMatrix;
               support.projectionMatrix3D = projMatrix3D;
               support.renderTarget = previousRenderTarget;
               support.translateMatrix(mOffsetX,mOffsetY);
               support.stencilReferenceValue = previousStencilRefValue;
               support.blendMode = object.blendMode;
               support.applyBlendMode(true);
            }
            passTexture = getPassTexture(i);
            context.setProgramConstantsFromMatrix("vertex",mMvpConstantID,support.mvpMatrix3D,true);
            context.setTextureAt(mBaseTextureID,passTexture.base);
            activate(i,context,passTexture);
            context.drawTriangles(mIndexBuffer,0,2);
            deactivate(i,context,passTexture);
            i++;
         }
         context.setVertexBufferAt(mVertexPosAtID,null);
         context.setVertexBufferAt(mTexCoordsAtID,null);
         context.setTextureAt(mBaseTextureID,null);
         support.popMatrix();
         support.popMatrix3D();
         if(intoCache)
         {
            support.projectionMatrix.copyFrom(projMatrix);
            support.projectionMatrix3D.copyFrom(projMatrix3D);
            support.renderTarget = previousRenderTarget;
            support.popClipRect();
            quadBatch = new QuadBatch();
            image = new Image(cacheTexture);
            object.getTransformationMatrix(targetSpace,sTransformationMatrix).invert();
            MatrixUtil.prependTranslation(sTransformationMatrix,bounds.x + mOffsetX,bounds.y + mOffsetY);
            quadBatch.addImage(image,1,sTransformationMatrix);
            quadBatch.ownsTexture = true;
            return quadBatch;
         }
         return null;
      }
      
      private function updateBuffers(context:Context3D, bounds:Rectangle) : void
      {
         mVertexData.setPosition(0,bounds.x,bounds.y);
         mVertexData.setPosition(1,bounds.right,bounds.y);
         mVertexData.setPosition(2,bounds.x,bounds.bottom);
         mVertexData.setPosition(3,bounds.right,bounds.bottom);
         if(mVertexBuffer == null)
         {
            mVertexBuffer = context.createVertexBuffer(4,8);
            mIndexBuffer = context.createIndexBuffer(6);
            mIndexBuffer.uploadFromVector(mIndexData,0,6);
         }
         mVertexBuffer.uploadFromVector(mVertexData.rawData,0,4);
      }
      
      private function updatePassTextures(width:Number, height:Number, scale:Number) : void
      {
         var i:int = 0;
         var numPassTextures:int = mNumPasses > 1?2:1;
         var needsUpdate:Boolean = mPassTextures.length != numPassTextures || Math.abs(mPassTextures[0].nativeWidth - width * scale) > 0.1 || Math.abs(mPassTextures[0].nativeHeight - height * scale) > 0.1;
         if(needsUpdate)
         {
            disposePassTextures();
            for(i = 0; i < numPassTextures; )
            {
               mPassTextures[i] = Texture.empty(width,height,true,false,true,scale);
               i++;
            }
         }
      }
      
      private function getPassTexture(pass:int) : Texture
      {
         return mPassTextures[pass % 2];
      }
      
      private function calculateBounds(object:DisplayObject, targetSpace:DisplayObject, scale:Number, intersectWithStage:Boolean, resultRect:Rectangle, resultPotRect:Rectangle) : void
      {
         var stage:* = null;
         var minSize:int = 0;
         var minWidth:Number = NaN;
         var minHeight:Number = NaN;
         var marginX:Number = mMarginX;
         var marginY:Number = mMarginY;
         if(targetSpace is Stage)
         {
            stage = targetSpace as Stage;
            if(object == stage || object == object.root)
            {
               marginY = 0;
               marginX = 0;
               resultRect.setTo(0,0,stage.stageWidth,stage.stageHeight);
            }
            else
            {
               object.getBounds(stage,resultRect);
            }
            if(intersectWithStage)
            {
               sStageBounds.setTo(0,0,stage.stageWidth,stage.stageHeight);
               RectangleUtil.intersect(resultRect,sStageBounds,resultRect);
            }
         }
         else
         {
            object.getBounds(targetSpace,resultRect);
         }
         if(!resultRect.isEmpty())
         {
            resultRect.inflate(marginX,marginY);
            minSize = 64 / scale;
            minWidth = resultRect.width > minSize?resultRect.width:minSize;
            minHeight = resultRect.height > minSize?resultRect.height:minSize;
            resultPotRect.setTo(resultRect.x,resultRect.y,getNextPowerOfTwo(minWidth * scale) / scale,getNextPowerOfTwo(minHeight * scale) / scale);
         }
      }
      
      private function disposePassTextures() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = mPassTextures;
         for each(var texture in mPassTextures)
         {
            texture.dispose();
         }
         mPassTextures.length = 0;
      }
      
      private function disposeCache() : void
      {
         if(mCache)
         {
            mCache.dispose();
            mCache = null;
         }
      }
      
      protected function createPrograms() : void
      {
         throw new Error("Method has to be implemented in subclass!");
      }
      
      protected function activate(pass:int, context:Context3D, texture:Texture) : void
      {
         throw new Error("Method has to be implemented in subclass!");
      }
      
      protected function deactivate(pass:int, context:Context3D, texture:Texture) : void
      {
      }
      
      protected function assembleAgal(fragmentShader:String = null, vertexShader:String = null) : Program3D
      {
         if(fragmentShader == null)
         {
            fragmentShader = "tex oc, v0, fs0 <2d, clamp, linear, mipnone>";
         }
         if(vertexShader == null)
         {
            vertexShader = "m44 op, va0, vc0 \nmov v0, va1      \n";
         }
         return RenderSupport.assembleAgal(vertexShader,fragmentShader);
      }
      
      public function cache() : void
      {
         mCacheRequested = true;
         disposeCache();
      }
      
      public function clearCache() : void
      {
         mCacheRequested = false;
         disposeCache();
      }
      
      function compile(object:DisplayObject) : QuadBatch
      {
         var support:* = null;
         var stage:* = null;
         var quadBatch:* = null;
         if(mCache)
         {
            return mCache;
         }
         stage = object.stage;
         support = new RenderSupport();
         object.getTransformationMatrix(stage,support.modelViewMatrix);
         quadBatch = renderPasses(object,support,1,true);
         support.dispose();
         return quadBatch;
      }
      
      public function get isCached() : Boolean
      {
         return mCache != null || mCacheRequested;
      }
      
      public function get resolution() : Number
      {
         return mResolution;
      }
      
      public function set resolution(value:Number) : void
      {
         if(value <= 0)
         {
            throw new ArgumentError("Resolution must be > 0");
         }
         mResolution = value;
      }
      
      public function get mode() : String
      {
         return mMode;
      }
      
      public function set mode(value:String) : void
      {
         mMode = value;
      }
      
      public function get offsetX() : Number
      {
         return mOffsetX;
      }
      
      public function set offsetX(value:Number) : void
      {
         mOffsetX = value;
      }
      
      public function get offsetY() : Number
      {
         return mOffsetY;
      }
      
      public function set offsetY(value:Number) : void
      {
         mOffsetY = value;
      }
      
      protected function get marginX() : Number
      {
         return mMarginX;
      }
      
      protected function set marginX(value:Number) : void
      {
         mMarginX = value;
      }
      
      protected function get marginY() : Number
      {
         return mMarginY;
      }
      
      protected function set marginY(value:Number) : void
      {
         mMarginY = value;
      }
      
      protected function set numPasses(value:int) : void
      {
         mNumPasses = value;
      }
      
      protected function get numPasses() : int
      {
         return mNumPasses;
      }
      
      protected final function get vertexPosAtID() : int
      {
         return mVertexPosAtID;
      }
      
      protected final function set vertexPosAtID(value:int) : void
      {
         mVertexPosAtID = value;
      }
      
      protected final function get texCoordsAtID() : int
      {
         return mTexCoordsAtID;
      }
      
      protected final function set texCoordsAtID(value:int) : void
      {
         mTexCoordsAtID = value;
      }
      
      protected final function get baseTextureID() : int
      {
         return mBaseTextureID;
      }
      
      protected final function set baseTextureID(value:int) : void
      {
         mBaseTextureID = value;
      }
      
      protected final function get mvpConstantID() : int
      {
         return mMvpConstantID;
      }
      
      protected final function set mvpConstantID(value:int) : void
      {
         mMvpConstantID = value;
      }
   }
}
