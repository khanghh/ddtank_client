package starlingPhy.maps
{
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.RenderTexture;
   import starling.textures.Texture;
   
   public class Tile3D extends Sprite
   {
       
      
      private const BLOCK_WIDTH:int = 1024;
      
      private const BLOCK_HEIGHT:int = 1024;
      
      private var _digable:Boolean;
      
      private var _canvasList:Vector.<RenderTexture>;
      
      private var _blockList:Vector.<Image>;
      
      private var _thisBm:BitmapData;
      
      public function Tile3D(param1:BitmapData, param2:Boolean){super();}
      
      private function createCanvas(param1:BitmapData) : void{}
      
      private function getBlockWidth(param1:int, param2:int, param3:int) : int{return 0;}
      
      private function getBlockHeight(param1:int, param2:int, param3:int) : int{return 0;}
      
      private function getBitmapDataBlock(param1:int, param2:int, param3:int, param4:int, param5:BitmapData) : Image{return null;}
      
      public function Dig(param1:Point, param2:Bitmap, param3:Bitmap = null) : void{}
      
      private function digImage(param1:Point, param2:Bitmap, param3:String) : void{}
      
      public function get bitmapData() : BitmapData{return null;}
      
      public function DigFillRect(param1:Rectangle) : void{}
      
      public function GetAlpha(param1:int, param2:int) : uint{return null;}
      
      override public function dispose() : void{}
   }
}
