package starling.display{   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.geom.Matrix;   import flash.geom.Point;   import flash.geom.Rectangle;   import starling.core.RenderSupport;   import starling.textures.Texture;   import starling.textures.TextureSmoothing;   import starling.utils.VertexData;      public class Image extends Quad   {                   private var mTexture:Texture;            private var mSmoothing:String;            private var mVertexDataCache:VertexData;            private var mVertexDataCacheInvalid:Boolean;            public function Image(texture:Texture) { super(null,null,null,null); }
            public static function fromBitmap(bitmap:Bitmap, generateMipMaps:Boolean = true, scale:Number = 1) : Image { return null; }
            public static function fromBitmapData(bitmapData:BitmapData, generateMipMaps:Boolean = true, scale:Number = 1) : Image { return null; }
            override protected function onVertexDataChanged() : void { }
            public function readjustSize() : void { }
            public function setTexCoords(vertexID:int, coords:Point) : void { }
            public function setTexCoordsTo(vertexID:int, u:Number, v:Number) : void { }
            public function getTexCoords(vertexID:int, resultPoint:Point = null) : Point { return null; }
            override public function copyVertexDataTo(targetData:VertexData, targetVertexID:int = 0) : void { }
            override public function copyVertexDataTransformedTo(targetData:VertexData, targetVertexID:int = 0, matrix:Matrix = null) : void { }
            public function get texture() : Texture { return null; }
            public function set texture(value:Texture) : void { }
            public function get smoothing() : String { return null; }
            public function set smoothing(value:String) : void { }
            override public function render(support:RenderSupport, parentAlpha:Number) : void { }
   }}