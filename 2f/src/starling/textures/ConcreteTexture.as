package starling.textures{   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display3D.Context3D;   import flash.display3D.textures.TextureBase;   import flash.geom.Matrix;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.media.Camera;   import flash.net.NetStream;   import flash.utils.ByteArray;   import flash.utils.getQualifiedClassName;   import starling.core.RenderSupport;   import starling.core.Starling;   import starling.errors.MissingContextError;   import starling.errors.NotSupportedError;   import starling.utils.Color;   import starling.utils.execute;      public class ConcreteTexture extends starling.textures.Texture   {            private static const TEXTURE_READY:String = "textureReady";            private static var sOrigin:Point = new Point();                   private var mBase:TextureBase;            private var mFormat:String;            private var mWidth:int;            private var mHeight:int;            private var mMipMapping:Boolean;            private var mPremultipliedAlpha:Boolean;            private var mOptimizedForRenderTexture:Boolean;            private var mScale:Number;            private var mRepeat:Boolean;            private var mOnRestore:Function;            private var mDataUploaded:Boolean;            private var mTextureReadyCallback:Function;            public function ConcreteTexture(base:TextureBase, format:String, width:int, height:int, mipMapping:Boolean, premultipliedAlpha:Boolean, optimizedForRenderTexture:Boolean = false, scale:Number = 1, repeat:Boolean = false) { super(); }
            override public function dispose() : void { }
            public function uploadBitmap(bitmap:Bitmap) : void { }
            public function uploadBitmapData(data:BitmapData) : void { }
            public function uploadAtfData(data:ByteArray, offset:int = 0, async:* = null) : void { }
            public function attachNetStream(netStream:NetStream, onComplete:Function = null) : void { }
            public function attachCamera(camera:Camera, onComplete:Function = null) : void { }
            protected function attachVideo(type:String, attachment:Object, onComplete:Function = null) : void { }
            private function onTextureReady(event:Object) : void { }
            private function onContextCreated() : void { }
            protected function createBase() : void { }
            public function clear(color:uint = 0, alpha:Number = 0.0) : void { }
            public function get optimizedForRenderTexture() : Boolean { return false; }
            public function get onRestore() : Function { return null; }
            public function set onRestore(value:Function) : void { }
            override public function get base() : TextureBase { return null; }
            override public function get root() : ConcreteTexture { return null; }
            override public function get format() : String { return null; }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
            override public function get nativeWidth() : Number { return 0; }
            override public function get nativeHeight() : Number { return 0; }
            override public function get scale() : Number { return 0; }
            override public function get mipMapping() : Boolean { return false; }
            override public function get premultipliedAlpha() : Boolean { return false; }
            override public function get repeat() : Boolean { return false; }
   }}