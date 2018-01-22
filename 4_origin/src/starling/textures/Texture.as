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
      
      public static function fromData(param1:Object, param2:TextureOptions = null) : starling.textures.Texture
      {
         var _loc3_:starling.textures.Texture = null;
         if(param1 is Bitmap)
         {
            param1 = (param1 as Bitmap).bitmapData;
         }
         if(param2 == null)
         {
            param2 = new TextureOptions();
         }
         if(param1 is Class)
         {
            _loc3_ = fromEmbeddedAsset(param1 as Class,param2.mipMapping,param2.optimizeForRenderToTexture,param2.scale,param2.format,param2.repeat);
         }
         else if(param1 is BitmapData)
         {
            _loc3_ = fromBitmapData(param1 as BitmapData,param2.mipMapping,param2.optimizeForRenderToTexture,param2.scale,param2.format,param2.repeat);
         }
         else if(param1 is ByteArray)
         {
            _loc3_ = fromAtfData(param1 as ByteArray,param2.scale,param2.mipMapping,param2.onReady,param2.repeat);
         }
         else
         {
            throw new ArgumentError("Unsupported \'data\' type: " + getQualifiedClassName(param1));
         }
         return _loc3_;
      }
      
      public static function fromEmbeddedAsset(param1:Class, param2:Boolean = true, param3:Boolean = false, param4:Number = 1, param5:String = "bgra", param6:Boolean = false) : starling.textures.Texture
      {
         assetClass = param1;
         mipMapping = param2;
         optimizeForRenderToTexture = param3;
         scale = param4;
         format = param5;
         repeat = param6;
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
      
      public static function fromBitmap(param1:Bitmap, param2:Boolean = true, param3:Boolean = false, param4:Number = 1, param5:String = "bgra", param6:Boolean = false) : starling.textures.Texture
      {
         return fromBitmapData(param1.bitmapData,param2,param3,param4,param5,param6);
      }
      
      public static function fromBitmapData(param1:BitmapData, param2:Boolean = true, param3:Boolean = false, param4:Number = 1, param5:String = "bgra", param6:Boolean = false) : starling.textures.Texture
      {
         data = param1;
         generateMipMaps = param2;
         optimizeForRenderToTexture = param3;
         scale = param4;
         format = param5;
         repeat = param6;
         var texture:starling.textures.Texture = starling.textures.Texture.empty(data.width / scale,data.height / scale,true,generateMipMaps,optimizeForRenderToTexture,scale,format,repeat);
         texture.root.uploadBitmapData(data);
         texture.root.onRestore = function():void
         {
            texture.root.uploadBitmapData(data);
         };
         return texture;
      }
      
      public static function fromAtfData(param1:ByteArray, param2:Number = 1, param3:Boolean = true, param4:Function = null, param5:Boolean = false) : starling.textures.Texture
      {
         data = param1;
         scale = param2;
         useMipMaps = param3;
         async = param4;
         repeat = param5;
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
      
      public static function fromNetStream(param1:NetStream, param2:Number = 1, param3:Function = null) : starling.textures.Texture
      {
         stream = param1;
         scale = param2;
         onComplete = param3;
         if(stream.client == stream && !("onMetaData" in stream))
         {
            stream.client = {"onMetaData":function(param1:Object):void
            {
            }};
         }
         return fromVideoAttachment("NetStream",stream,scale,onComplete);
      }
      
      public static function fromCamera(param1:Camera, param2:Number = 1, param3:Function = null) : starling.textures.Texture
      {
         return fromVideoAttachment("Camera",param1,param2,param3);
      }
      
      private static function fromVideoAttachment(param1:String, param2:Object, param3:Number, param4:Function) : starling.textures.Texture
      {
         type = param1;
         attachment = param2;
         scale = param3;
         onComplete = param4;
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
         base.addEventListener("textureReady",function(param1:Object):void
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
      
      public static function fromColor(param1:Number, param2:Number, param3:uint = 4294967295, param4:Boolean = false, param5:Number = -1, param6:String = "bgra") : starling.textures.Texture
      {
         width = param1;
         height = param2;
         color = param3;
         optimizeForRenderToTexture = param4;
         scale = param5;
         format = param6;
         var texture:starling.textures.Texture = starling.textures.Texture.empty(width,height,true,false,optimizeForRenderToTexture,scale,format);
         texture.root.clear(color,Color.getAlpha(color) / 255);
         texture.root.onRestore = function():void
         {
            texture.root.clear(color,Color.getAlpha(color) / 255);
         };
         return texture;
      }
      
      public static function empty(param1:Number, param2:Number, param3:Boolean = true, param4:Boolean = true, param5:Boolean = false, param6:Number = -1, param7:String = "bgra", param8:Boolean = false) : starling.textures.Texture
      {
         var _loc9_:int = 0;
         var _loc14_:int = 0;
         var _loc12_:* = null;
         if(param6 <= 0)
         {
            param6 = Starling.contentScaleFactor;
         }
         var _loc15_:Context3D = Starling.context;
         if(_loc15_ == null)
         {
            throw new MissingContextError();
         }
         var _loc11_:Number = param1 * param6;
         var _loc10_:Number = param2 * param6;
         var _loc16_:Boolean = !param4 && !param8 && Starling.current.profile != "baselineConstrained" && "createRectangleTexture" in _loc15_ && param7.indexOf("compressed") == -1;
         if(_loc16_)
         {
            _loc14_ = Math.ceil(_loc11_ - 1.0e-9);
            _loc9_ = Math.ceil(_loc10_ - 1.0e-9);
            _loc12_ = _loc15_["createRectangleTexture"](_loc14_,_loc9_,param7,param5);
         }
         else
         {
            _loc14_ = getNextPowerOfTwo(_loc11_);
            _loc9_ = getNextPowerOfTwo(_loc10_);
            _loc12_ = _loc15_.createTexture(_loc14_,_loc9_,param7,param5);
         }
         var _loc13_:ConcreteTexture = new ConcreteTexture(_loc12_,param7,_loc14_,_loc9_,param4,param3,param5,param6,param8);
         _loc13_.onRestore = _loc13_.clear;
         if(_loc14_ - _loc11_ < 0.001 && _loc9_ - _loc10_ < 0.001)
         {
            return _loc13_;
         }
         return new SubTexture(_loc13_,new Rectangle(0,0,param1,param2),true);
      }
      
      public static function fromTexture(param1:starling.textures.Texture, param2:Rectangle = null, param3:Rectangle = null, param4:Boolean = false) : starling.textures.Texture
      {
         return new SubTexture(param1,param2,false,param3,param4);
      }
      
      public static function get maxSize() : int
      {
         var _loc1_:Starling = Starling.current;
         var _loc2_:String = !!_loc1_?_loc1_.profile:"baseline";
         if(_loc2_ == "baseline" || _loc2_ == "baselineConstrained")
         {
            return 2048;
         }
         return 4096;
      }
      
      public function dispose() : void
      {
      }
      
      public function adjustVertexData(param1:VertexData, param2:int, param3:int) : void
      {
      }
      
      public function adjustTexCoords(param1:Vector.<Number>, param2:int = 0, param3:int = 0, param4:int = -1) : void
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
