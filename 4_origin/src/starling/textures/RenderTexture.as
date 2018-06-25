package starling.textures
{
   import flash.display3D.Context3D;
   import flash.display3D.textures.TextureBase;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.errors.MissingContextError;
   import starling.filters.FragmentFilter;
   import starling.utils.SystemUtil;
   import starling.utils.execute;
   import starling.utils.getNextPowerOfTwo;
   
   public class RenderTexture extends SubTexture
   {
      
      private static var sClipRect:Rectangle = new Rectangle();
      
      public static var optimizePersistentBuffers:Boolean = false;
       
      
      private const CONTEXT_POT_SUPPORT_KEY:String = "RenderTexture.supportsNonPotDimensions";
      
      private const PMA:Boolean = true;
      
      private var mActiveTexture:Texture;
      
      private var mBufferTexture:Texture;
      
      private var mHelperImage:Image;
      
      private var mDrawing:Boolean;
      
      private var mBufferReady:Boolean;
      
      private var mIsPersistent:Boolean;
      
      private var mSupport:RenderSupport;
      
      public function RenderTexture(width:int, height:int, persistent:Boolean = true, scale:Number = -1, format:String = "bgra", repeat:Boolean = false)
      {
         if(scale <= 0)
         {
            scale = Starling.contentScaleFactor;
         }
         var legalWidth:Number = width;
         var legalHeight:Number = height;
         if(!supportsNonPotDimensions)
         {
            legalWidth = getNextPowerOfTwo(width * scale) / scale;
            legalHeight = getNextPowerOfTwo(height * scale) / scale;
         }
         mActiveTexture = Texture.empty(legalWidth,legalHeight,true,false,true,scale,format,repeat);
         mActiveTexture.root.onRestore = mActiveTexture.root.clear;
         super(mActiveTexture,new Rectangle(0,0,width,height),true,null,false);
         var rootWidth:Number = mActiveTexture.root.width;
         var rootHeight:Number = mActiveTexture.root.height;
         mIsPersistent = persistent;
         mSupport = new RenderSupport();
         mSupport.setProjectionMatrix(0,0,rootWidth,rootHeight,width,height);
         if(persistent && (!optimizePersistentBuffers || !SystemUtil.supportsRelaxedTargetClearRequirement))
         {
            mBufferTexture = Texture.empty(legalWidth,legalHeight,true,false,true,scale,format,repeat);
            mBufferTexture.root.onRestore = mBufferTexture.root.clear;
            mHelperImage = new Image(mBufferTexture);
            mHelperImage.smoothing = "none";
         }
      }
      
      override public function dispose() : void
      {
         mSupport.dispose();
         mActiveTexture.dispose();
         if(isDoubleBuffered)
         {
            mBufferTexture.dispose();
            mHelperImage.dispose();
         }
         super.dispose();
      }
      
      public function draw(object:DisplayObject, matrix:Matrix = null, alpha:Number = 1.0, antiAliasing:int = 0) : void
      {
         if(object == null)
         {
            return;
         }
         if(mDrawing)
         {
            render(object,matrix,alpha);
         }
         else
         {
            renderBundled(render,object,matrix,alpha,antiAliasing);
         }
      }
      
      public function drawBundled(drawingBlock:Function, antiAliasing:int = 0) : void
      {
         renderBundled(drawingBlock,null,null,1,antiAliasing);
      }
      
      private function render(object:DisplayObject, matrix:Matrix = null, alpha:Number = 1.0) : void
      {
         var filter:FragmentFilter = object.filter;
         var mask:DisplayObject = object.mask;
         mSupport.loadIdentity();
         mSupport.blendMode = object.blendMode == "auto"?"normal":object.blendMode;
         if(matrix)
         {
            mSupport.prependMatrix(matrix);
         }
         else
         {
            mSupport.transformMatrix(object);
         }
         if(mask)
         {
            mSupport.pushMask(mask);
         }
         if(filter)
         {
            filter.render(object,mSupport,alpha);
         }
         else
         {
            object.render(mSupport,alpha);
         }
         if(mask)
         {
            mSupport.popMask();
         }
      }
      
      private function renderBundled(renderBlock:Function, object:DisplayObject = null, matrix:Matrix = null, alpha:Number = 1.0, antiAliasing:int = 0) : void
      {
         var tmpTexture:* = null;
         var context:Context3D = Starling.context;
         if(context == null)
         {
            throw new MissingContextError();
         }
         if(!Starling.current.contextValid)
         {
            return;
         }
         if(isDoubleBuffered)
         {
            tmpTexture = mActiveTexture;
            mActiveTexture = mBufferTexture;
            mBufferTexture = tmpTexture;
            mHelperImage.texture = mBufferTexture;
         }
         var previousRenderTarget:Texture = mSupport.renderTarget;
         sClipRect.setTo(0,0,mActiveTexture.width,mActiveTexture.height);
         mSupport.pushClipRect(sClipRect);
         mSupport.setRenderTarget(mActiveTexture,antiAliasing);
         if(isDoubleBuffered || !isPersistent || !mBufferReady)
         {
            mSupport.clear();
         }
         if(isDoubleBuffered && mBufferReady)
         {
            mHelperImage.render(mSupport,1);
         }
         else
         {
            mBufferReady = true;
         }
         var _loc9_:int = 0;
         try
         {
            mDrawing = true;
            execute(renderBlock,object,matrix,alpha);
         }
         catch(_loc10_:*)
         {
            _loc9_ = 1;
         }
         mDrawing = false;
         mSupport.finishQuadBatch();
         mSupport.nextFrame();
         mSupport.renderTarget = previousRenderTarget;
         mSupport.popClipRect();
         if(!int(_loc9_))
         {
            return;
         }
         throw _loc10_;
      }
      
      public function clear(rgb:uint = 0, alpha:Number = 0.0) : void
      {
         if(!Starling.current.contextValid)
         {
            return;
         }
         var previousRenderTarget:Texture = mSupport.renderTarget;
         mSupport.renderTarget = mActiveTexture;
         mSupport.clear(rgb,alpha);
         mSupport.renderTarget = previousRenderTarget;
         mBufferReady = true;
      }
      
      private function get supportsNonPotDimensions() : Boolean
      {
         var texture:* = null;
         var buffer:* = null;
         var target:Starling = Starling.current;
         var context:Context3D = Starling.context;
         var support:Object = target.contextData["RenderTexture.supportsNonPotDimensions"];
         if(support == null)
         {
            if(target.profile != "baselineConstrained" && "createRectangleTexture" in context)
            {
               var _loc6_:int = 0;
               try
               {
                  texture = context["createRectangleTexture"](2,3,"bgra",true);
                  context.setRenderToTexture(texture);
                  context.clear();
                  context.setRenderToBackBuffer();
                  context.createVertexBuffer(1,1);
                  support = true;
               }
               catch(e:Error)
               {
                  support = false;
                  _loc6_ = 0;
               }
            }
            else
            {
               support = false;
            }
            target.contextData["RenderTexture.supportsNonPotDimensions"] = support;
         }
         return support;
      }
      
      private function get isDoubleBuffered() : Boolean
      {
         return mBufferTexture != null;
      }
      
      public function get isPersistent() : Boolean
      {
         return mIsPersistent;
      }
      
      override public function get base() : TextureBase
      {
         return mActiveTexture.base;
      }
      
      override public function get root() : ConcreteTexture
      {
         return mActiveTexture.root;
      }
   }
}
