package morn.core.utils
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BitmapUtils
   {
      
      private static var m:Matrix = new Matrix();
      
      private static var newRect:Rectangle = new Rectangle();
      
      private static var clipRect:Rectangle = new Rectangle();
      
      private static var grid:Rectangle = new Rectangle();
      
      private static var destPoint:Point = new Point();
       
      
      public function BitmapUtils()
      {
         super();
      }
      
      public static function scale9Bmd(bmd:BitmapData, sizeGrid:Array, width:int, height:int) : BitmapData
      {
         var repeatFill:Boolean = false;
         var rows:* = null;
         var cols:* = null;
         var newRows:* = null;
         var newCols:* = null;
         var i:int = 0;
         var j:int = 0;
         var tempBmd:* = null;
         if(bmd.width == width && bmd.height == height)
         {
            return bmd;
         }
         width = width > 1?width:1;
         height = height > 1?height:1;
         var gw:int = int(sizeGrid[0]) + int(sizeGrid[2]);
         var gh:int = int(sizeGrid[1]) + int(sizeGrid[3]);
         var newBmd:BitmapData = new BitmapData(width,height,bmd.transparent,0);
         var shape:Shape = new Shape();
         var g:Graphics = shape.graphics;
         if(width > gw && height > gh)
         {
            repeatFill = sizeGrid.length > 4 && sizeGrid[4] == 1;
            setRect(grid,sizeGrid[0],sizeGrid[1],bmd.width - sizeGrid[0] - sizeGrid[2],bmd.height - sizeGrid[1] - sizeGrid[3]);
            rows = [0,grid.top,grid.bottom,bmd.height];
            cols = [0,grid.left,grid.right,bmd.width];
            newRows = [0,grid.top,height - (bmd.height - grid.bottom),height];
            newCols = [0,grid.left,width - (bmd.width - grid.right),width];
            for(i = 0; i < 3; )
            {
               for(j = 0; j < 3; )
               {
                  setRect(newRect,cols[i],rows[j],cols[i + 1] - cols[i],rows[j + 1] - rows[j]);
                  setRect(clipRect,newCols[i],newRows[j],newCols[i + 1] - newCols[i],newRows[j + 1] - newRows[j]);
                  m.identity();
                  m.a = clipRect.width / newRect.width;
                  m.d = clipRect.height / newRect.height;
                  m.tx = clipRect.x - newRect.x * m.a;
                  m.ty = clipRect.y - newRect.y * m.d;
                  if(!repeatFill || i != 1 && j != 1)
                  {
                     newBmd.draw(bmd,m,null,null,clipRect,true);
                  }
                  else if(newRect.width != 0 && newRect.height != 0)
                  {
                     tempBmd = new BitmapData(newRect.width,newRect.height,bmd.transparent,0);
                     tempBmd.copyPixels(bmd,newRect,destPoint);
                     g.clear();
                     g.beginBitmapFill(tempBmd);
                     g.drawRect(0,0,clipRect.width,clipRect.height);
                     g.endFill();
                     m.identity();
                     m.tx = clipRect.x;
                     m.ty = clipRect.y;
                     newBmd.draw(shape,m,null,null,clipRect,true);
                     g.clear();
                     tempBmd.dispose();
                  }
                  j++;
               }
               i++;
            }
         }
         else
         {
            m.identity();
            m.scale(width / bmd.width,height / bmd.height);
            setRect(grid,0,0,width,height);
            newBmd.draw(bmd,m,null,null,grid,true);
         }
         return newBmd;
      }
      
      public static function setRect(rect:Rectangle, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0) : Rectangle
      {
         rect.x = x;
         rect.y = y;
         rect.width = width;
         rect.height = height;
         return rect;
      }
      
      public static function createClips(bmd:BitmapData, xNum:int, yNum:int) : Vector.<BitmapData>
      {
         var i:int = 0;
         var j:int = 0;
         var item:* = null;
         if(bmd == null)
         {
            return null;
         }
         var clips:Vector.<BitmapData> = new Vector.<BitmapData>();
         var width:int = Math.max(bmd.width / xNum,1);
         var height:int = Math.max(bmd.height / yNum,1);
         var point:Point = new Point();
         for(i = 0; i < yNum; )
         {
            for(j = 0; j < xNum; )
            {
               item = new BitmapData(width,height);
               item.copyPixels(bmd,new Rectangle(j * width,i * height,width,height),point);
               clips.push(item);
               j++;
            }
            i++;
         }
         return clips;
      }
   }
}
