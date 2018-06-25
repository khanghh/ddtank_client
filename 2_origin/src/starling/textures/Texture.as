package starling.textures
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display3D.Context3D;
   import flash.display3D.textures.TextureBase;
   import flash.geom.Rectangle;
   import flash.media.Camera;
   import flash.net.NetStream;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   import starling.core.Starling;
   import starling.errors.AbstractClassError;
   import starling.errors.MissingContextError;
   import starling.errors.NotSupportedError;
   import starling.utils.Color;
   import starling.utils.SystemUtil;
   import starling.utils.VertexData;
   import starling.utils.execute;
   import starling.utils.getNextPowerOfTwo;
   
   public class Texture
   {
       
      
      public var textureName:String;
      
      public function Texture()
      {
         super();
         if(Capabilities.isDebugger && getQualifiedClassName(this) == "starling.textures::Texture")
         {
            throw new AbstractClassError();
         }
      }
      
      public static function fromData(data:Object, options:TextureOptions = null) : starling.textures.Texture
      {
         var texture:starling.textures.Texture = null;
         if(data is Bitmap)
         {
            data = (data as Bitmap).bitmapData;
         }
         if(options == null)
         {
            options = new TextureOptions();
         }
         if(data is Class)
         {
            texture = fromEmbeddedAsset(data as Class,options.mipMapping,options.optimizeForRenderToTexture,options.scale,options.format,options.repeat);
         }
         else if(data is BitmapData)
         {
            texture = fromBitmapData(data as BitmapData,options.mipMapping,options.optimizeForRenderToTexture,options.scale,options.format,options.repeat);
         }
         else if(data is ByteArray)
         {
            texture = fromAtfData(data as ByteArray,options.scale,options.mipMapping,options.onReady,options.repeat);
         }
         else
         {
            throw new ArgumentError("Unsupported \'data\' type: " + getQualifiedClassName(data));
         }
         return texture;
      }
      
      public static function fromEmbeddedAsset(assetClass:Class, mipMapping:Boolean = true, optimizeForRenderToTexture:Boolean = false, scale:Number = 1, format:String = "bgra", repeat:Boolean = false) : starling.textures.Texture
      {
         assetClass = assetClass;
         mipMapping = mipMapping;
         optimizeForRenderToTexture = optimizeForRenderToTexture;
         scale = scale;
         format = format;
         repeat = repeat;
         var asset:Object = new assetClass();
         if(asset is Bitmap)
         {
            var texture:starling.textures.Texture = starling.textures.Texture.fromBitmap(asset as Bitmap,mipMapping,optimizeForRenderToTexture,scale,format,repeat);
            texture.root.onRestore = function():void
            {
               texture.root.uploadBitmap(new assetClass());
            };
         }
         else if(asset is ByteArray)
         {
            texture = starling.textures.Texture.fromAtfData(asset as ByteArray,scale,mipMapping,null,repeat);
            texture.root.onRestore = function():void
            {
               texture.root.uploadAtfData(new assetClass());
            };
         }
         else
         {
            throw new ArgumentError("Invalid asset type: " + getQualifiedClassName(asset));
         }
         asset = null;
         return texture;
      }
      
      public static function fromBitmap(bitmap:Bitmap, generateMipMaps:Boolean = true, optimizeForRenderToTexture:Boolean = false, scale:Number = 1, format:String = "bgra", repeat:Boolean = false) : starling.textures.Texture
      {
         return fromBitmapData(bitmap.bitmapData,generateMipMaps,optimizeForRenderToTexture,scale,format,repeat);
      }
      
      public static function fromBitmapData(data:BitmapData, generateMipMaps:Boolean = true, optimizeForRenderToTexture:Boolean = false, scale:Number = 1, format:String = "bgra", repeat:Boolean = false) : starling.textures.Texture
      {
         data = data;
         generateMipMaps = generateMipMaps;
         optimizeForRenderToTexture = optimizeForRenderToTexture;
         scale = scale;
         format = format;
         repeat = repeat;
         var texture:starling.textures.Texture = starling.textures.Texture.empty(data.width / scale,data.height / scale,true,generateMipMaps,optimizeForRenderToTexture,scale,format,repeat);
         texture.root.uploadBitmapData(data);
         texture.root.onRestore = function():void
         {
            texture.root.uploadBitmapData(data);
         };
         return texture;
      }
      
      public static function fromAtfData(data:ByteArray, scale:Number = 1, useMipMaps:Boolean = true, async:Function = null, repeat:Boolean = false) : starling.textures.Texture
      {
         data = data;
         scale = scale;
         useMipMaps = useMipMaps;
         async = async;
         repeat = repeat;
         var context:Context3D = Starling.context;
         if(context == null)
         {
            throw new MissingContextError();
         }
         var atfData:AtfData = new AtfData(data);
         var nativeTexture:flash.display3D.textures.Texture = context.createTexture(atfData.width,atfData.height,atfData.format,false);
         var concreteTexture:ConcreteTexture = new ConcreteTexture(nativeTexture,atfData.format,atfData.width,atfData.height,useMipMaps && atfData.numTextures > 1,false,false,scale,repeat);
         concreteTexture.uploadAtfData(data,0,async);
         concreteTexture.onRestore = function():void
         {
            concreteTexture.uploadAtfData(data,0);
         };
         return concreteTexture;
      }
      
      public static function fromNetStream(stream:NetStream, scale:Number = 1, onComplete:Function = null) : starling.textures.Texture
      {
         stream = stream;
         scale = scale;
         onComplete = onComplete;
         if(stream.client == stream && !("onMetaData" in stream))
         {
            stream.client = {"onMetaData":function(md:Object):void
            {
            }};
         }
         return fromVideoAttachment("NetStream",stream,scale,onComplete);
      }
      
      public static function fromCamera(camera:Camera, scale:Number = 1, onComplete:Function = null) : starling.textures.Texture
      {
         return fromVideoAttachment("Camera",camera,scale,onComplete);
      }
      
      private static function fromVideoAttachment(type:String, attachment:Object, scale:Number, onComplete:Function) : starling.textures.Texture
      {
         type = type;
         attachment = attachment;
         scale = scale;
         onComplete = onComplete;
         if(!SystemUtil.supportsVideoTexture)
         {
            throw new NotSupportedError("Video Textures are not supported on this platform");
         }
         var context:Context3D = Starling.context;
         if(context == null)
         {
            throw new MissingContextError();
         }
         var base:TextureBase = context["createVideoTexture"]();
         base["attach" + type](attachment);
         base.addEventListener("textureReady",function(event:Object):void
         {
            base.removeEventListener("textureReady",arguments.callee);
            execute(onComplete,texture);
         });
         var texture:ConcreteVideoTexture = new ConcreteVideoTexture(base,scale);
         texture.onRestore = function():void
         {
            texture.root.attachVideo(type,attachment);
         };
         return texture;
      }
      
      public static function fromColor(width:Number, height:Number, color:uint = 4294967295, optimizeForRenderToTexture:Boolean = false, scale:Number = -1, format:String = "bgra") : starling.textures.Texture
      {
         width = width;
         height = height;
         color = color;
         optimizeForRenderToTexture = optimizeForRenderToTexture;
         scale = scale;
         format = format;
         var texture:starling.textures.Texture = starling.textures.Texture.empty(width,height,true,false,optimizeForRenderToTexture,scale,format);
         texture.root.clear(color,Color.getAlpha(color) / 255);
         texture.root.onRestore = function():void
         {
            texture.root.clear(color,Color.getAlpha(color) / 255);
         };
         return texture;
      }
      
      public static function empty(width:Number, height:Number, premultipliedAlpha:Boolean = true, mipMapping:Boolean = true, optimizeForRenderToTexture:Boolean = false, scale:Number = -1, format:String = "bgra", repeat:Boolean = false) : starling.textures.Texture
      {
         var actualHeight:int = 0;
         var actualWidth:int = 0;
         var nativeTexture:* = null;
         if(scale <= 0)
         {
            scale = Starling.contentScaleFactor;
         }
         var context:Context3D = Starling.context;
         if(context == null)
         {
            throw new MissingContextError();
         }
         var origWidth:Number = width * scale;
         var origHeight:Number = height * scale;
         var useRectTexture:Boolean = !mipMapping && !repeat && Starling.current.profile != "baselineConstrained" && "createRectangleTexture" in context && format.indexOf("compressed") == -1;
         if(useRectTexture)
         {
            actualWidth = Math.ceil(origWidth - 1.0e-9);
            actualHeight = Math.ceil(origHeight - 1.0e-9);
            nativeTexture = context["createRectangleTexture"](actualWidth,actualHeight,format,optimizeForRenderToTexture);
         }
         else
         {
            actualWidth = getNextPowerOfTwo(origWidth);
            actualHeight = getNextPowerOfTwo(origHeight);
            nativeTexture = context.createTexture(actualWidth,actualHeight,format,optimizeForRenderToTexture);
         }
         var concreteTexture:ConcreteTexture = new ConcreteTexture(nativeTexture,format,actualWidth,actualHeight,mipMapping,premultipliedAlpha,optimizeForRenderToTexture,scale,repeat);
         concreteTexture.onRestore = concreteTexture.clear;
         if(actualWidth - origWidth < 0.001 && actualHeight - origHeight < 0.001)
         {
            return concreteTexture;
         }
         return new SubTexture(concreteTexture,new Rectangle(0,0,width,height),true);
      }
      
      public static function fromTexture(texture:starling.textures.Texture, region:Rectangle = null, frame:Rectangle = null, rotated:Boolean = false) : starling.textures.Texture
      {
         return new SubTexture(texture,region,false,frame,rotated);
      }
      
      public static function get maxSize() : int
      {
         var target:Starling = Starling.current;
         var profile:String = !!target?target.profile:"baseline";
         if(profile == "baseline" || profile == "baselineConstrained")
         {
            return 2048;
         }
         return 4096;
      }
      
      public function dispose() : void
      {
      }
      
      public function adjustVertexData(vertexData:VertexData, vertexID:int, count:int) : void
      {
      }
      
      public function adjustTexCoords(texCoords:Vector.<Number>, startIndex:int = 0, stride:int = 0, count:int = -1) : void
      {
      }
      
      public function get frame() : Rectangle
      {
         return null;
      }
      
      public function get repeat() : Boolean
      {
         return false;
      }
      
      public function get width() : Number
      {
         return 0;
      }
      
      public function get height() : Number
      {
         return 0;
      }
      
      public function get nativeWidth() : Number
      {
         return 0;
      }
      
      public function get nativeHeight() : Number
      {
         return 0;
      }
      
      public function get scale() : Number
      {
         return 1;
      }
      
      public function get base() : TextureBase
      {
         return null;
      }
      
      public function get root() : ConcreteTexture
      {
         return null;
      }
      
      public function get format() : String
      {
         return "bgra";
      }
      
      public function get mipMapping() : Boolean
      {
         return false;
      }
      
      public function get premultipliedAlpha() : Boolean
      {
         return false;
      }
   }
}
