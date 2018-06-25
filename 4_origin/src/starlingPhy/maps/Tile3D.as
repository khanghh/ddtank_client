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
      
      public function Tile3D(bitmapData:BitmapData, digable:Boolean)
      {
         super();
         createCanvas(bitmapData);
         _thisBm = bitmapData;
         _digable = digable;
      }
      
      private function createCanvas(bd:BitmapData) : void
      {
         var i:int = 0;
         var j:int = 0;
         var temp:* = null;
         var canvas:* = null;
         var block:* = null;
         var colCount:int = bd.width / 1024 + 1;
         var rowCount:int = bd.height / 1024 + 1;
         _blockList = new Vector.<Image>();
         _canvasList = new Vector.<RenderTexture>();
         for(i = 0; i < rowCount; )
         {
            for(j = 0; j < colCount; )
            {
               temp = getBitmapDataBlock(j,colCount,i,rowCount,bd);
               canvas = new RenderTexture(temp.width,temp.height);
               canvas.draw(temp);
               _canvasList.push(canvas);
               block = new Image(canvas);
               block.x = j * 1024;
               block.y = i * 1024;
               addChild(block);
               _blockList.push(block);
               temp.texture.dispose();
               temp.dispose();
               j++;
            }
            i++;
         }
      }
      
      private function getBlockWidth(col:int, colCount:int, bdwidth:int) : int
      {
         if(col < colCount - 1)
         {
            return 1024;
         }
         return bdwidth % 1024;
      }
      
      private function getBlockHeight(row:int, rowCount:int, bdheight:int) : int
      {
         if(row < rowCount - 1)
         {
            return 1024;
         }
         return bdheight % 1024;
      }
      
      private function getBitmapDataBlock(col:int, colCount:int, row:int, rowCount:int, bmData:BitmapData) : Image
      {
         var bm:BitmapData = new BitmapData(getBlockWidth(col,colCount,bmData.width),getBlockHeight(row,rowCount,bmData.height));
         bm.copyPixels(bmData,new Rectangle(col * 1024,row * 1024,bm.width,bm.height),new Point());
         var result:Image = new Image(Texture.fromBitmapData(bm,false));
         bm.dispose();
         return result;
      }
      
      public function Dig(center:Point, surface:Bitmap, border:Bitmap = null) : void
      {
         var matrix:Matrix = new Matrix(1,0,0,1,center.x,center.y);
         if(surface && _digable)
         {
            digImage(center,surface,"erase");
            matrix.tx = matrix.tx - surface.width / 2;
            matrix.ty = matrix.ty - surface.height / 2;
            bitmapData.draw(surface,matrix,null,"erase");
         }
         if(border && _digable)
         {
            digImage(center,border,"alpha");
         }
      }
      
      private function digImage(center:Point, bm:Bitmap, blendMode:String) : void
      {
         var i:int = 0;
         var m:* = null;
         var temp:Image = Image.fromBitmap(bm,false);
         temp.blendMode = blendMode;
         for(i = 0; i < _canvasList.length; )
         {
            m = new Matrix(1,0,0,1,center.x - bm.width / 2 - _blockList[i].x,center.y - bm.height / 2 - _blockList[i].y);
            _canvasList[i].draw(temp,m);
            i++;
         }
         temp.texture.dispose();
         temp.dispose();
      }
      
      public function get bitmapData() : BitmapData
      {
         return _thisBm;
      }
      
      public function DigFillRect(rect:Rectangle) : void
      {
      }
      
      public function GetAlpha(x:int, y:int) : uint
      {
         return _thisBm.getPixel32(x,y) >> 24 & 255;
      }
      
      override public function dispose() : void
      {
         var texture:* = null;
         var image:* = null;
         while(_canvasList.length)
         {
            texture = _canvasList.pop();
            texture.dispose();
         }
         _canvasList = null;
         while(_blockList.length)
         {
            image = _blockList.pop();
            StarlingObjectUtils.disposeObject(image,true);
         }
         _blockList = null;
         ObjectUtils.disposeObject(_thisBm);
         _thisBm = null;
         super.dispose();
      }
   }
}
