package starlingPhy.maps{   import com.pickgliss.utils.ObjectUtils;   import com.pickgliss.utils.StarlingObjectUtils;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.geom.Matrix;   import flash.geom.Point;   import flash.geom.Rectangle;   import starling.display.Image;   import starling.display.Sprite;   import starling.textures.RenderTexture;   import starling.textures.Texture;      public class Tile3D extends Sprite   {                   private const BLOCK_WIDTH:int = 1024;            private const BLOCK_HEIGHT:int = 1024;            private var _digable:Boolean;            private var _canvasList:Vector.<RenderTexture>;            private var _blockList:Vector.<Image>;            private var _thisBm:BitmapData;            public function Tile3D(bitmapData:BitmapData, digable:Boolean) { super(); }
            private function createCanvas(bd:BitmapData) : void { }
            private function getBlockWidth(col:int, colCount:int, bdwidth:int) : int { return 0; }
            private function getBlockHeight(row:int, rowCount:int, bdheight:int) : int { return 0; }
            private function getBitmapDataBlock(col:int, colCount:int, row:int, rowCount:int, bmData:BitmapData) : Image { return null; }
            public function Dig(center:Point, surface:Bitmap, border:Bitmap = null) : void { }
            private function digImage(center:Point, bm:Bitmap, blendMode:String) : void { }
            public function get bitmapData() : BitmapData { return null; }
            public function DigFillRect(rect:Rectangle) : void { }
            public function GetAlpha(x:int, y:int) : uint { return null; }
            override public function dispose() : void { }
   }}