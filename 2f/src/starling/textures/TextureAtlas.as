package starling.textures{   import flash.geom.Rectangle;   import flash.utils.Dictionary;   import starling.utils.cleanMasterString;      public class TextureAtlas   {            private static var sNames:Vector.<String> = new Vector.<String>(0);                   private var mAtlasTexture:Texture;            private var mSubTextures:Dictionary;            private var mSubTextureNames:Vector.<String>;            public function TextureAtlas(texture:Texture, atlasXml:XML = null) { super(); }
            private static function parseBool(value:String) : Boolean { return false; }
            public function dispose() : void { }
            protected function parseAtlasXml(atlasXml:XML) : void { }
            public function getTexture(name:String) : Texture { return null; }
            public function getTextures(prefix:String = "", result:Vector.<Texture> = null) : Vector.<Texture> { return null; }
            public function getNames(prefix:String = "", result:Vector.<String> = null) : Vector.<String> { return null; }
            public function getRegion(name:String) : Rectangle { return null; }
            public function getFrame(name:String) : Rectangle { return null; }
            public function getRotation(name:String) : Boolean { return false; }
            public function addRegion(name:String, region:Rectangle, frame:Rectangle = null, rotated:Boolean = false) : void { }
            public function removeRegion(name:String) : void { }
            public function get texture() : Texture { return null; }
   }}