package starling.textures{   import starling.core.Starling;      public class TextureOptions   {                   private var mScale:Number;            private var mFormat:String;            private var mMipMapping:Boolean;            private var mOptimizeForRenderToTexture:Boolean = false;            private var mOnReady:Function = null;            private var mRepeat:Boolean = false;            public function TextureOptions(scale:Number = 1.0, mipMapping:Boolean = false, format:String = "bgra", repeat:Boolean = false) { super(); }
            public function clone() : TextureOptions { return null; }
            public function get scale() : Number { return 0; }
            public function set scale(value:Number) : void { }
            public function get format() : String { return null; }
            public function set format(value:String) : void { }
            public function get mipMapping() : Boolean { return false; }
            public function set mipMapping(value:Boolean) : void { }
            public function get optimizeForRenderToTexture() : Boolean { return false; }
            public function set optimizeForRenderToTexture(value:Boolean) : void { }
            public function get repeat() : Boolean { return false; }
            public function set repeat(value:Boolean) : void { }
            public function get onReady() : Function { return null; }
            public function set onReady(value:Function) : void { }
   }}