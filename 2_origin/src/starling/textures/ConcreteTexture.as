package starling.textures
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display3D.Context3D;
   import flash.display3D.textures.TextureBase;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.Camera;
   import flash.net.NetStream;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.§core:starling_internal§.createBase;
   import starling.errors.MissingContextError;
   import starling.errors.NotSupportedError;
   import starling.utils.Color;
   import starling.utils.execute;
   
   public class ConcreteTexture extends starling.textures.Texture
   {
      
      private static const TEXTURE_READY:String = "textureReady";
      
      private static var sOrigin:Point = new Point();
       
      
      private var mBase:TextureBase;
      
      private var mFormat:String;
      
      private var mWidth:int;
      
      private var mHeight:int;
      
      private var mMipMapping:Boolean;
      
      private var mPremultipliedAlpha:Boolean;
      
      private var mOptimizedForRenderTexture:Boolean;
      
      private var mScale:Number;
      
      private var mRepeat:Boolean;
      
      private var mOnRestore:Function;
      
      private var mDataUploaded:Boolean;
      
      private var mTextureReadyCallback:Function;
      
      public function ConcreteTexture(base:TextureBase, format:String, width:int, height:int, mipMapping:Boolean, premultipliedAlpha:Boolean, optimizedForRenderTexture:Boolean = false, scale:Number = 1, repeat:Boolean = false)
      {
         super();
         mScale = scale <= 0?1:Number(scale);
         mBase = base;
         mFormat = format;
         mWidth = width;
         mHeight = height;
         mMipMapping = mipMapping;
         mPremultipliedAlpha = premultipliedAlpha;
         mOptimizedForRenderTexture = optimizedForRenderTexture;
         mRepeat = repeat;
         mOnRestore = null;
         mDataUploaded = false;
         mTextureReadyCallback = null;
      }
      
      override public function dispose() : void
      {
         if(mBase)
         {
            mBase.removeEventListener("textureReady",onTextureReady);
            mBase.dispose();
         }
         this.onRestore = null;
         super.dispose();
      }
      
      public function uploadBitmap(bitmap:Bitmap) : void
      {
         uploadBitmapData(bitmap.bitmapData);
      }
      
      public function uploadBitmapData(data:BitmapData) : void
      {
         var potData:* = null;
         var potTexture:* = null;
         var currentWidth:* = 0;
         var currentHeight:* = 0;
         var level:int = 0;
         var canvas:* = null;
         var transform:* = null;
         var bounds:* = null;
         if(data.width != mWidth || data.height != mHeight)
         {
            potData = new BitmapData(mWidth,mHeight,true,0);
            potData.copyPixels(data,data.rect,sOrigin);
            data = potData;
         }
         if(mBase is flash.display3D.textures.Texture)
         {
            potTexture = mBase as flash.display3D.textures.Texture;
            potTexture.uploadFromBitmapData(data);
            if(mMipMapping && data.width > 1 && data.height > 1)
            {
               currentWidth = data.width >> 1;
               currentHeight = data.height >> 1;
               level = 1;
               canvas = new BitmapData(currentWidth,currentHeight,true,0);
               transform = new Matrix(0.5,0,0,0.5);
               bounds = new Rectangle();
               while(currentWidth >= 1 || currentHeight >= 1)
               {
                  bounds.width = currentWidth;
                  bounds.height = currentHeight;
                  canvas.fillRect(bounds,0);
                  canvas.draw(data,transform,null,null,null,true);
                  level++;
                  potTexture.uploadFromBitmapData(canvas,level);
                  transform.scale(0.5,0.5);
                  currentWidth = currentWidth >> 1;
                  currentHeight = currentHeight >> 1;
               }
               canvas.dispose();
            }
         }
         else
         {
            mBase["uploadFromBitmapData"](data);
         }
         if(potData)
         {
            potData.dispose();
         }
         mDataUploaded = true;
      }
      
      public function uploadAtfData(data:ByteArray, offset:int = 0, async:* = null) : void
      {
         var isAsync:Boolean = async is Function || async === true;
         var potTexture:flash.display3D.textures.Texture = mBase as flash.display3D.textures.Texture;
         if(potTexture == null)
         {
            throw new Error("This texture type does not support ATF data");
         }
         if(async is Function)
         {
            mTextureReadyCallback = async as Function;
            mBase.addEventListener("textureReady",onTextureReady);
         }
         potTexture.uploadCompressedTextureFromByteArray(data,offset,isAsync);
         mDataUploaded = true;
      }
      
      public function attachNetStream(netStream:NetStream, onComplete:Function = null) : void
      {
         attachVideo("NetStream",netStream,onComplete);
      }
      
      public function attachCamera(camera:Camera, onComplete:Function = null) : void
      {
         attachVideo("Camera",camera,onComplete);
      }
      
      function attachVideo(type:String, attachment:Object, onComplete:Function = null) : void
      {
         var _loc4_:String = getQualifiedClassName(mBase);
         if(_loc4_ == "flash.display3D.textures::VideoTexture")
         {
            mDataUploaded = true;
            mTextureReadyCallback = onComplete;
            mBase["attach" + type](attachment);
            mBase.addEventListener("textureReady",onTextureReady);
            return;
         }
         throw new Error("This texture type does not support " + type + " data");
      }
      
      private function onTextureReady(event:Object) : void
      {
         mBase.removeEventListener("textureReady",onTextureReady);
         execute(mTextureReadyCallback,this);
         mTextureReadyCallback = null;
      }
      
      private function onContextCreated() : void
      {
         createBase();
         if(mOnRestore != null)
         {
            mOnRestore();
         }
         if(!mDataUploaded)
         {
            clear();
         }
      }
      
      function createBase() : void
      {
         var context:Context3D = Starling.context;
         var className:String = getQualifiedClassName(mBase);
         if(className == "flash.display3D.textures::Texture")
         {
            mBase = context.createTexture(mWidth,mHeight,mFormat,mOptimizedForRenderTexture);
         }
         else if(className == "flash.display3D.textures::RectangleTexture")
         {
            mBase = context["createRectangleTexture"](mWidth,mHeight,mFormat,mOptimizedForRenderTexture);
         }
         else if(className == "flash.display3D.textures::VideoTexture")
         {
            mBase = context["createVideoTexture"]();
         }
         else
         {
            throw new NotSupportedError("Texture type not supported: " + className);
         }
         mDataUploaded = false;
      }
      
      public function clear(color:uint = 0, alpha:Number = 0.0) : void
      {
         var context:Context3D = Starling.context;
         if(context == null)
         {
            throw new MissingContextError();
         }
         if(mPremultipliedAlpha && alpha < 1)
         {
            color = Color.rgb(Color.getRed(color) * alpha,Color.getGreen(color) * alpha,Color.getBlue(color) * alpha);
         }
         context.setRenderToTexture(mBase);
         try
         {
            RenderSupport.clear(color,alpha);
         }
         catch(e:Error)
         {
         }
         context.setRenderToBackBuffer();
         mDataUploaded = true;
      }
      
      public function get optimizedForRenderTexture() : Boolean
      {
         return mOptimizedForRenderTexture;
      }
      
      public function get onRestore() : Function
      {
         return mOnRestore;
      }
      
      public function set onRestore(value:Function) : void
      {
         Starling.current.removeEventListener("context3DCreate",onContextCreated);
         if(Starling.handleLostContext && value != null)
         {
            mOnRestore = value;
            Starling.current.addEventListener("context3DCreate",onContextCreated);
         }
         else
         {
            mOnRestore = null;
         }
      }
      
      override public function get base() : TextureBase
      {
         return mBase;
      }
      
      override public function get root() : ConcreteTexture
      {
         return this;
      }
      
      override public function get format() : String
      {
         return mFormat;
      }
      
      override public function get width() : Number
      {
         return mWidth / mScale;
      }
      
      override public function get height() : Number
      {
         return mHeight / mScale;
      }
      
      override public function get nativeWidth() : Number
      {
         return mWidth;
      }
      
      override public function get nativeHeight() : Number
      {
         return mHeight;
      }
      
      override public function get scale() : Number
      {
         return mScale;
      }
      
      override public function get mipMapping() : Boolean
      {
         return mMipMapping;
      }
      
      override public function get premultipliedAlpha() : Boolean
      {
         return mPremultipliedAlpha;
      }
      
      override public function get repeat() : Boolean
      {
         return mRepeat;
      }
   }
}
