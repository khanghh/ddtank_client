package starling.textures
{
   import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display3D.textures.TextureBase;
import flash.geom.Point;
import flash.media.Camera;
import flash.net.NetStream;
import flash.utils.ByteArray;

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
      
      public function ConcreteTexture(param1:TextureBase, param2:String, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:Boolean = false, param8:Number = 1, param9:Boolean = false){super();}
      
      override public function dispose() : void{}
      
      public function uploadBitmap(param1:Bitmap) : void{}
      
      public function uploadBitmapData(param1:BitmapData) : void{}
      
      public function uploadAtfData(param1:ByteArray, param2:int = 0, param3:* = null) : void{}
      
      public function attachNetStream(param1:NetStream, param2:Function = null) : void{}
      
      public function attachCamera(param1:Camera, param2:Function = null) : void{}
      
      function attachVideo(param1:String, param2:Object, param3:Function = null) : void{}
      
      private function onTextureReady(param1:Object) : void{}
      
      private function onContextCreated() : void{}
      
      function createBase() : void{}
      
      public function clear(param1:uint = 0, param2:Number = 0.0) : void{}
      
      public function get optimizedForRenderTexture() : Boolean{return false;}
      
      public function get onRestore() : Function{return null;}
      
      public function set onRestore(param1:Function) : void{}
      
      override public function get base() : TextureBase{return null;}
      
      override public function get root() : ConcreteTexture{return null;}
      
      override public function get format() : String{return null;}
      
      override public function get width() : Number{return 0;}
      
      override public function get height() : Number{return 0;}
      
      override public function get nativeWidth() : Number{return 0;}
      
      override public function get nativeHeight() : Number{return 0;}
      
      override public function get scale() : Number{return 0;}
      
      override public function get mipMapping() : Boolean{return false;}
      
      override public function get premultipliedAlpha() : Boolean{return false;}
      
      override public function get repeat() : Boolean{return false;}
   }
}
