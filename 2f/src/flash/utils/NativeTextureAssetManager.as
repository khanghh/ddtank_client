package flash.utils{   import dragonBones.textures.NativeTextureAtlas;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.geom.Point;   import flash.geom.Rectangle;      public class NativeTextureAssetManager   {                   private var _btmds:Dictionary;            private var _btmdAtlas:Dictionary;            public function NativeTextureAssetManager() { super(); }
            public function addBitmapData(name:String, btmd:BitmapData) : void { }
            public function addBitmapDataAtlas(name:String, atlas:NativeTextureAtlas) : void { }
            public function removeBitmapData(name:String, dispose:Boolean = true) : void { }
            public function removeBitmapDataAtlas(name:String, dispose:Boolean = true) : void { }
            public function getBitmapData(name:String) : BitmapData { return null; }
            private function parseNativeTexture(name:String, atlas:NativeTextureAtlas) : BitmapData { return null; }
            public function getBitmap(name:String) : Bitmap { return null; }
            public function getBitmapDataAtlas(name:String) : NativeTextureAtlas { return null; }
            public function purge() : void { }
            public function dispose() : void { }
            public function get btmdAtlas() : Dictionary { return null; }
   }}