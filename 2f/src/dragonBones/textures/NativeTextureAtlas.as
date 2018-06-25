package dragonBones.textures{   import dragonBones.objects.DataParser;   import flash.display.BitmapData;   import flash.display.MovieClip;   import flash.geom.Rectangle;      public class NativeTextureAtlas implements ITextureAtlas   {                   protected var _subTextureDataDic:Object;            protected var _isDifferentConfig:Boolean;            protected var _name:String;            protected var _movieClip:MovieClip;            protected var _bitmapData:BitmapData;            protected var _scale:Number;            public function NativeTextureAtlas(texture:Object, textureAtlasRawData:Object, textureScale:Number = 1, isDifferentConfig:Boolean = false) { super(); }
            public function get name() : String { return null; }
            public function get movieClip() : MovieClip { return null; }
            public function get bitmapData() : BitmapData { return null; }
            public function get scale() : Number { return 0; }
            public function dispose() : void { }
            public function getRegion(name:String) : Rectangle { return null; }
            public function getFrame(name:String) : Rectangle { return null; }
            protected function parseData(textureAtlasRawData:Object) : void { }
            protected function movieClipToBitmapData() : void { }
            private function getNearest2N(_n:uint) : uint { return null; }
   }}