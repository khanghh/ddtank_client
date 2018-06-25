package starling.textures{   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display3D.Context3D;   import flash.display3D.textures.TextureBase;   import flash.geom.Rectangle;   import flash.media.Camera;   import flash.net.NetStream;   import flash.system.Capabilities;   import flash.utils.ByteArray;   import flash.utils.getQualifiedClassName;   import starling.core.Starling;   import starling.errors.AbstractClassError;   import starling.errors.MissingContextError;   import starling.errors.NotSupportedError;   import starling.utils.Color;   import starling.utils.SystemUtil;   import starling.utils.VertexData;   import starling.utils.execute;   import starling.utils.getNextPowerOfTwo;      public class Texture   {                   public var textureName:String;            public function Texture() { super(); }
            public static function fromData(data:Object, options:TextureOptions = null) : starling.textures.Texture { return null; }
            public static function fromEmbeddedAsset(assetClass:Class, mipMapping:Boolean = true, optimizeForRenderToTexture:Boolean = false, scale:Number = 1, format:String = "bgra", repeat:Boolean = false) : starling.textures.Texture { return null; }
            public static function fromBitmap(bitmap:Bitmap, generateMipMaps:Boolean = true, optimizeForRenderToTexture:Boolean = false, scale:Number = 1, format:String = "bgra", repeat:Boolean = false) : starling.textures.Texture { return null; }
            public static function fromBitmapData(data:BitmapData, generateMipMaps:Boolean = true, optimizeForRenderToTexture:Boolean = false, scale:Number = 1, format:String = "bgra", repeat:Boolean = false) : starling.textures.Texture { return null; }
            public static function fromAtfData(data:ByteArray, scale:Number = 1, useMipMaps:Boolean = true, async:Function = null, repeat:Boolean = false) : starling.textures.Texture { return null; }
            public static function fromNetStream(stream:NetStream, scale:Number = 1, onComplete:Function = null) : starling.textures.Texture { return null; }
            public static function fromCamera(camera:Camera, scale:Number = 1, onComplete:Function = null) : starling.textures.Texture { return null; }
            private static function fromVideoAttachment(type:String, attachment:Object, scale:Number, onComplete:Function) : starling.textures.Texture { return null; }
            public static function fromColor(width:Number, height:Number, color:uint = 4294967295, optimizeForRenderToTexture:Boolean = false, scale:Number = -1, format:String = "bgra") : starling.textures.Texture { return null; }
            public static function empty(width:Number, height:Number, premultipliedAlpha:Boolean = true, mipMapping:Boolean = true, optimizeForRenderToTexture:Boolean = false, scale:Number = -1, format:String = "bgra", repeat:Boolean = false) : starling.textures.Texture { return null; }
            public static function fromTexture(texture:starling.textures.Texture, region:Rectangle = null, frame:Rectangle = null, rotated:Boolean = false) : starling.textures.Texture { return null; }
            public static function get maxSize() : int { return 0; }
            public function dispose() : void { }
            public function adjustVertexData(vertexData:VertexData, vertexID:int, count:int) : void { }
            public function adjustTexCoords(texCoords:Vector.<Number>, startIndex:int = 0, stride:int = 0, count:int = -1) : void { }
            public function get frame() : Rectangle { return null; }
            public function get repeat() : Boolean { return false; }
            public function get width() : Number { return 0; }
            public function get height() : Number { return 0; }
            public function get nativeWidth() : Number { return 0; }
            public function get nativeHeight() : Number { return 0; }
            public function get scale() : Number { return 0; }
            public function get base() : TextureBase { return null; }
            public function get root() : ConcreteTexture { return null; }
            public function get format() : String { return null; }
            public function get mipMapping() : Boolean { return false; }
            public function get premultipliedAlpha() : Boolean { return false; }
   }}