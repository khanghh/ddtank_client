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
      
      public function Texture(){super();}
      
      public static function fromData(param1:Object, param2:TextureOptions = null) : starling.textures.Texture{return null;}
      
      public static function fromEmbeddedAsset(param1:Class, param2:Boolean = true, param3:Boolean = false, param4:Number = 1, param5:String = "bgra", param6:Boolean = false) : starling.textures.Texture{return null;}
      
      public static function fromBitmap(param1:Bitmap, param2:Boolean = true, param3:Boolean = false, param4:Number = 1, param5:String = "bgra", param6:Boolean = false) : starling.textures.Texture{return null;}
      
      public static function fromBitmapData(param1:BitmapData, param2:Boolean = true, param3:Boolean = false, param4:Number = 1, param5:String = "bgra", param6:Boolean = false) : starling.textures.Texture{return null;}
      
      public static function fromAtfData(param1:ByteArray, param2:Number = 1, param3:Boolean = true, param4:Function = null, param5:Boolean = false) : starling.textures.Texture{return null;}
      
      public static function fromNetStream(param1:NetStream, param2:Number = 1, param3:Function = null) : starling.textures.Texture{return null;}
      
      public static function fromCamera(param1:Camera, param2:Number = 1, param3:Function = null) : starling.textures.Texture{return null;}
      
      private static function fromVideoAttachment(param1:String, param2:Object, param3:Number, param4:Function) : starling.textures.Texture{return null;}
      
      public static function fromColor(param1:Number, param2:Number, param3:uint = 4294967295, param4:Boolean = false, param5:Number = -1, param6:String = "bgra") : starling.textures.Texture{return null;}
      
      public static function empty(param1:Number, param2:Number, param3:Boolean = true, param4:Boolean = true, param5:Boolean = false, param6:Number = -1, param7:String = "bgra", param8:Boolean = false) : starling.textures.Texture{return null;}
      
      public static function fromTexture(param1:starling.textures.Texture, param2:Rectangle = null, param3:Rectangle = null, param4:Boolean = false) : starling.textures.Texture{return null;}
      
      public static function get maxSize() : int{return 0;}
      
      public function dispose() : void{}
      
      public function adjustVertexData(param1:VertexData, param2:int, param3:int) : void{}
      
      public function adjustTexCoords(param1:Vector.<Number>, param2:int = 0, param3:int = 0, param4:int = -1) : void{}
      
      public function get frame() : Rectangle{return null;}
      
      public function get repeat() : Boolean{return false;}
      
      public function get width() : Number{return 0;}
      
      public function get height() : Number{return 0;}
      
      public function get nativeWidth() : Number{return 0;}
      
      public function get nativeHeight() : Number{return 0;}
      
      public function get scale() : Number{return 0;}
      
      public function get base() : TextureBase{return null;}
      
      public function get root() : ConcreteTexture{return null;}
      
      public function get format() : String{return null;}
      
      public function get mipMapping() : Boolean{return false;}
      
      public function get premultipliedAlpha() : Boolean{return false;}
   }
}
