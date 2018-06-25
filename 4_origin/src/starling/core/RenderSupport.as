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
      
      public function RenderSupport()
      {
         mMasks = new Vector.<DisplayObject>(0);
         super();
         mProjectionMatrix = new Matrix();
         mModelViewMatrix = new Matrix();
         mMvpMatrix = new Matrix();
         mMatrixStack = new Vector.<Matrix>(0);
         mMatrixStackSize = 0;
         mProjectionMatrix3D = new Matrix3D();
         mModelViewMatrix3D = new Matrix3D();
         mMvpMatrix3D = new Matrix3D();
         mMatrixStack3D = new Vector.<Matrix3D>(0);
         mMatrixStack3DSize = 0;
         mDrawCount = 0;
         mBlendMode = "normal";
         mClipRectStack = new Vector.<Rectangle>(0);
         mCurrentQuadBatchID = 0;
         mQuadBatches = new <QuadBatch>[createQuadBatch()];
         loadIdentity();
         setProjectionMatrix(0,0,400,300);
      }
      
      public static function transformMatrixForObject(matrix:Matrix, object:DisplayObject) : void
      {
         MatrixUtil.prependMatrix(matrix,object.transformationMatrix);
      }
      
      public static function setDefaultBlendFactors(premultipliedAlpha:Boolean) : void
      {
         setBlendFactors(premultipliedAlpha);
      }
      
      public static function setBlendFactors(premultipliedAlpha:Boolean, blendMode:String = "normal") : void
      {
         var blendFactors:Array = BlendMode.getBlendFactors(blendMode,premultipliedAlpha);
         Starling.context.setBlendFactors(blendFactors[0],blendFactors[1]);
      }
      
      public static function clear(rgb:uint = 0, alpha:Number = 0.0) : void
      {
         Starling.context.clear(Color.getRed(rgb) / 255,Color.getGreen(rgb) / 255,Color.getBlue(rgb) / 255,alpha);
      }
      
      public static function assembleAgal(vertexShader:String, fragmentShader:String, resultProgram:Program3D = null) : Program3D
      {
         var context:* = null;
         if(resultProgram == null)
         {
            context = Starling.context;
            if(context == null)
            {
               throw new MissingContextError();
            }
            resultProgram = context.createProgram();
         }
         resultProgram.upload(sAssembler.assemble("vertex",vertexShader),sAssembler.assemble("fragment",fragmentShader));
         return resultProgram;
      }
      
      public static function getTextureLookupFlags(format:String, mipMapping:Boolean, repeat:Boolean = false, smoothing:String = "bilinear") : String
      {
         var options:Array = ["2d",!!repeat?"repeat":"clamp"];
         if(format == "compressed")
         {
            options.push("dxt1");
         }
         else if(format == "compressedAlpha")
         {
            options.push("dxt5");
         }
         if(smoothing == "none")
         {
            options.push("nearest",!!mipMapping?"mipnearest":"mipnone");
         }
         else if(smoothing == "bilinear")
         {
            options.push("linear",!!mipMapping?"mipnearest":"mipnone");
         }
         else
         {
            options.push("linear",!!mipMapping?"miplinear":"mipnone");
         }
         return "<" + options.join() + ">";
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = mQuadBatches;
         for each(var quadBatch in mQuadBatches)
         {
            quadBatch.dispose();
         }
      }
      
      public function setProjectionMatrix(x:Number, y:Number, width:Number, height:Number, stageWidth:Number = 0, stageHeight:Number = 0, cameraPos:Vector3D = null) : void
      {
         var _loc14_:* = NaN;
         _loc14_ = 1;
         if(stageWidth <= 0)
         {
            stageWidth = width;
         }
         if(stageHeight <= 0)
         {
            stageHeight = height;
         }
         if(cameraPos == null)
         {
            cameraPos = sPoint3D;
            cameraPos.setTo(stageWidth / 2,stageHeight / 2,stageWidth / Math.tan(0.5) * 0.5);
         }
         mProjectionMatrix.setTo(2 / width,0,0,-2 / height,-(2 * x + width) / width,(2 * y + height) / height);
         var _loc13_:Number = Math.abs(cameraPos.z);
         var _loc11_:Number = cameraPos.x - stageWidth / 2;
         var _loc10_:Number = cameraPos.y - stageHeight / 2;
         var _loc12_:Number = _loc13_ * 20;
         var _loc8_:Number = stageWidth / width;
         var _loc9_:Number = stageHeight / height;
         sMatrixData[0] = 2 * _loc13_ / stageWidth;
         sMatrixData[5] = -2 * _loc13_ / stageHeight;
         sMatrixData[10] = _loc12_ / (_loc12_ - 1);
         sMatrixData[14] = -_loc12_ * 1 / (_loc12_ - 1);
         sMatrixData[11] = 1;
         var _loc15_:* = 0;
         var _loc16_:* = sMatrixData[_loc15_] * _loc8_;
         sMatrixData[_loc15_] = _loc16_;
         _loc16_ = 5;
         _loc15_ = sMatrixData[_loc16_] * _loc9_;
         sMatrixData[_loc16_] = _loc15_;
         sMatrixData[8] = _loc8_ - 1 - 2 * _loc8_ * (x - _loc11_) / stageWidth;
         sMatrixData[9] = -_loc9_ + 1 + 2 * _loc9_ * (y - _loc10_) / stageHeight;
         mProjectionMatrix3D.copyRawDataFrom(sMatrixData);
         mProjectionMatrix3D.prependTranslation(-stageWidth / 2 - _loc11_,-stageHeight / 2 - _loc10_,_loc13_);
         applyClipRect();
      }
      
      [Deprecated(replacement="setProjectionMatrix")]
      public function setOrthographicProjection(x:Number, y:Number, width:Number, height:Number) : void
      {
         var stage:Stage = Starling.current.stage;
         sClipRect.setTo(x,y,width,height);
         setProjectionMatrix(x,y,width,height,stage.stageWidth,stage.stageHeight,stage.cameraPosition);
      }
      
      public function loadIdentity() : void
      {
         mModelViewMatrix.identity();
         mModelViewMatrix3D.identity();
      }
      
      public function translateMatrix(dx:Number, dy:Number) : void
      {
         MatrixUtil.prependTranslation(mModelViewMatrix,dx,dy);
      }
      
      public function rotateMatrix(angle:Number) : void
      {
         MatrixUtil.prependRotation(mModelViewMatrix,angle);
      }
      
      public function scaleMatrix(sx:Number, sy:Number) : void
      {
         MatrixUtil.prependScale(mModelViewMatrix,sx,sy);
      }
      
      public function prependMatrix(matrix:Matrix) : void
      {
         MatrixUtil.prependMatrix(mModelViewMatrix,matrix);
      }
      
      public function transformMatrix(object:DisplayObject) : void
      {
         MatrixUtil.prependMatrix(mModelViewMatrix,object.transformationMatrix);
      }
      
      public function pushMatrix() : void
      {
         if(mMatrixStack.length < mMatrixStackSize + 1)
         {
            mMatrixStack.push(new Matrix());
         }
         mMatrixStackSize = Number(mMatrixStackSize) + 1;
         mMatrixStack[int(Number(mMatrixStackSize))].copyFrom(mModelViewMatrix);
      }
      
      public function popMatrix() : void
      {
         mMatrixStackSize = mMatrixStackSize - 1;
         mModelViewMatrix.copyFrom(mMatrixStack[int(mMatrixStackSize - 1)]);
      }
      
      public function resetMatrix() : void
      {
         mMatrixStackSize = 0;
         mMatrixStack3DSize = 0;
         loadIdentity();
      }
      
      public function get mvpMatrix() : Matrix
      {
         mMvpMatrix.copyFrom(mModelViewMatrix);
         mMvpMatrix.concat(mProjectionMatrix);
         return mMvpMatrix;
      }
      
      public function get modelViewMatrix() : Matrix
      {
         return mModelViewMatrix;
      }
      
      public function get projectionMatrix() : Matrix
      {
         return mProjectionMatrix;
      }
      
      public function set projectionMatrix(value:Matrix) : void
      {
         mProjectionMatrix.copyFrom(value);
         applyClipRect();
      }
      
      public function transformMatrix3D(object:DisplayObject) : void
      {
         mModelViewMatrix3D.prepend(MatrixUtil.convertTo3D(mModelViewMatrix,sMatrix3D));
         mModelViewMatrix3D.prepend(object.transformationMatrix3D);
         mModelViewMatrix.identity();
      }
      
      public function pushMatrix3D() : void
      {
         if(mMatrixStack3D.length < mMatrixStack3DSize + 1)
         {
            mMatrixStack3D.push(new Matrix3D());
         }
         mMatrixStack3DSize = Number(mMatrixStack3DSize) + 1;
         mMatrixStack3D[int(Number(mMatrixStack3DSize))].copyFrom(mModelViewMatrix3D);
      }
      
      public function popMatrix3D() : void
      {
         mMatrixStack3DSize = mMatrixStack3DSize - 1;
         mModelViewMatrix3D.copyFrom(mMatrixStack3D[int(mMatrixStack3DSize - 1)]);
      }
      
      public function get mvpMatrix3D() : Matrix3D
      {
         if(mMatrixStack3DSize == 0)
         {
            MatrixUtil.convertTo3D(mvpMatrix,mMvpMatrix3D);
         }
         else
         {
            mMvpMatrix3D.copyFrom(mProjectionMatrix3D);
            mMvpMatrix3D.prepend(mModelViewMatrix3D);
            mMvpMatrix3D.prepend(MatrixUtil.convertTo3D(mModelViewMatrix,sMatrix3D));
         }
         return mMvpMatrix3D;
      }
      
      public function get projectionMatrix3D() : Matrix3D
      {
         return mProjectionMatrix3D;
      }
      
      public function set projectionMatrix3D(value:Matrix3D) : void
      {
         mProjectionMatrix3D.copyFrom(value);
      }
      
      public function applyBlendMode(premultipliedAlpha:Boolean) : void
      {
         setBlendFactors(premultipliedAlpha,mBlendMode);
      }
      
      public function get blendMode() : String
      {
         return mBlendMode;
      }
      
      public function set blendMode(value:String) : void
      {
         if(value != "auto")
         {
            mBlendMode = value;
         }
      }
      
      public function get renderTarget() : Texture
      {
         return Starling.current.contextData["Starling.renderTarget"];
      }
      
      public function set renderTarget(target:Texture) : void
      {
         setRenderTarget(target);
      }
      
      public function setRenderTarget(target:Texture, antiAliasing:int = 0) : void
      {
         Starling.current.contextData["Starling.renderTarget"] = target;
         applyClipRect();
         if(target)
         {
            Starling.context.setRenderToTexture(target.base,SystemUtil.supportsDepthAndStencil,antiAliasing);
         }
         else
         {
            Starling.context.setRenderToBackBuffer();
         }
      }
      
      public function pushClipRect(rectangle:Rectangle, intersectWithCurrent:Boolean = true) : Rectangle
      {
         if(mClipRectStack.length < mClipRectStackSize + 1)
         {
            mClipRectStack.push(new Rectangle());
         }
         mClipRectStack[mClipRectStackSize].copyFrom(rectangle);
         rectangle = mClipRectStack[mClipRectStackSize];
         if(intersectWithCurrent && mClipRectStackSize > 0)
         {
            RectangleUtil.intersect(rectangle,mClipRectStack[mClipRectStackSize - 1],rectangle);
         }
         mClipRectStackSize = mClipRectStackSize + 1;
         applyClipRect();
         return rectangle;
      }
      
      public function popClipRect() : void
      {
         if(mClipRectStackSize > 0)
         {
            mClipRectStackSize = mClipRectStackSize - 1;
            applyClipRect();
         }
      }
      
      public function applyClipRect() : void
      {
         var height:int = 0;
         var width:int = 0;
         var rect:* = null;
         var renderTarget:* = null;
         finishQuadBatch();
         var context:Context3D = Starling.context;
         if(context == null)
         {
            return;
         }
         if(mClipRectStackSize > 0)
         {
            rect = mClipRectStack[mClipRectStackSize - 1];
            renderTarget = this.renderTarget;
            if(renderTarget)
            {
               width = renderTarget.root.nativeWidth;
               height = renderTarget.root.nativeHeight;
            }
            else
            {
               width = Starling.current.backBufferWidth;
               height = Starling.current.backBufferHeight;
            }
            MatrixUtil.transformCoords(mProjectionMatrix,rect.x,rect.y,sPoint);
            sClipRect.x = (sPoint.x * 0.5 + 0.5) * width;
            sClipRect.y = (0.5 - sPoint.y * 0.5) * height;
            MatrixUtil.transformCoords(mProjectionMatrix,rect.right,rect.bottom,sPoint);
            sClipRect.right = (sPoint.x * 0.5 + 0.5) * width;
            sClipRect.bottom = (0.5 - sPoint.y * 0.5) * height;
            sBufferRect.setTo(0,0,width,height);
            RectangleUtil.intersect(sClipRect,sBufferRect,sScissorRect);
            if(sScissorRect.width < 1 || sScissorRect.height < 1)
            {
               sScissorRect.setTo(0,0,1,1);
            }
            context.setScissorRectangle(sScissorRect);
         }
         else
         {
            context.setScissorRectangle(null);
         }
      }
      
      public function pushMask(mask:DisplayObject) : void
      {
         mMasks[mMasks.length] = mask;
         mStencilReferenceValue = Number(mStencilReferenceValue) + 1;
         var context:Context3D = Starling.context;
         if(context == null)
         {
            return;
         }
         finishQuadBatch();
         context.setStencilActions("frontAndBack","equal","incrementSaturate");
         drawMask(mask);
         context.setStencilReferenceValue(mStencilReferenceValue);
         context.setStencilActions("frontAndBack","equal","keep");
      }
      
      public function popMask() : void
      {
         var mask:DisplayObject = mMasks.pop();
         mStencilReferenceValue = Number(mStencilReferenceValue) - 1;
         var context:Context3D = Starling.context;
         if(context == null)
         {
            return;
         }
         finishQuadBatch();
         context.setStencilActions("frontAndBack","equal","decrementSaturate");
         drawMask(mask);
         context.setStencilReferenceValue(mStencilReferenceValue);
         context.setStencilActions("frontAndBack","equal","keep");
      }
      
      private function drawMask(mask:DisplayObject) : void
      {
         pushMatrix();
         var stage:Stage = mask.stage;
         if(stage)
         {
            mask.getTransformationMatrix(stage,mModelViewMatrix);
         }
         else
         {
            transformMatrix(mask);
         }
         mask.render(this,0);
         finishQuadBatch();
         popMatrix();
      }
      
      public function get stencilReferenceValue() : uint
      {
         return mStencilReferenceValue;
      }
      
      public function set stencilReferenceValue(value:uint) : void
      {
         mStencilReferenceValue = value;
         if(Starling.current.contextValid)
         {
            Starling.context.setStencilReferenceValue(value);
         }
      }
      
      public function batchQuad(quad:Quad, parentAlpha:Number, texture:Texture = null, smoothing:String = null) : void
      {
         if(mQuadBatches[mCurrentQuadBatchID].isStateChange(quad.tinted,parentAlpha,texture,smoothing,mBlendMode))
         {
            finishQuadBatch();
         }
         mQuadBatches[mCurrentQuadBatchID].addQuad(quad,parentAlpha,texture,smoothing,mModelViewMatrix,mBlendMode);
      }
      
      public function batchQuadBatch(quadBatch:QuadBatch, parentAlpha:Number) : void
      {
         if(mQuadBatches[mCurrentQuadBatchID].isStateChange(quadBatch.tinted,parentAlpha,quadBatch.texture,quadBatch.smoothing,mBlendMode))
         {
            finishQuadBatch();
         }
         mQuadBatches[mCurrentQuadBatchID].addQuadBatch(quadBatch,parentAlpha,mModelViewMatrix,mBlendMode);
      }
      
      public function finishQuadBatch() : void
      {
         var currentBatch:QuadBatch = mQuadBatches[mCurrentQuadBatchID];
         if(currentBatch.numQuads != 0)
         {
            if(mMatrixStack3DSize == 0)
            {
               currentBatch.renderCustom(mProjectionMatrix3D);
            }
            else
            {
               mMvpMatrix3D.copyFrom(mProjectionMatrix3D);
               mMvpMatrix3D.prepend(mModelViewMatrix3D);
               currentBatch.renderCustom(mMvpMatrix3D);
            }
            currentBatch.reset();
            mCurrentQuadBatchID = mCurrentQuadBatchID + 1;
            mDrawCount = mDrawCount + 1;
            if(mQuadBatches.length <= mCurrentQuadBatchID)
            {
               mQuadBatches.push(createQuadBatch());
            }
         }
      }
      
      public function nextFrame() : void
      {
         resetMatrix();
         trimQuadBatches();
         mMasks.length = 0;
         mCurrentQuadBatchID = 0;
         mBlendMode = "normal";
         mDrawCount = 0;
      }
      
      private function trimQuadBatches() : void
      {
         var numToRemove:int = 0;
         var i:int = 0;
         var numUsedBatches:int = mCurrentQuadBatchID + 1;
         var numTotalBatches:int = mQuadBatches.length;
         if(numTotalBatches >= 16 && numTotalBatches > 2 * numUsedBatches)
         {
            numToRemove = numTotalBatches - numUsedBatches;
            for(i = 0; i < numToRemove; )
            {
               mQuadBatches.pop().dispose();
               i++;
            }
         }
      }
      
      private function createQuadBatch() : QuadBatch
      {
         var profile:String = Starling.current.profile;
         var forceTinted:Boolean = profile != "baselineConstrained" && profile != "baseline";
         var quadBatch:QuadBatch = new QuadBatch();
         quadBatch.forceTinted = forceTinted;
         return quadBatch;
      }
      
      public function clear(rgb:uint = 0, alpha:Number = 0.0) : void
      {
         RenderSupport.clear(rgb,alpha);
      }
      
      public function raiseDrawCount(value:uint = 1) : void
      {
         mDrawCount = mDrawCount + value;
      }
      
      public function get drawCount() : int
      {
         return mDrawCount;
      }
   }
}
