package org.bytearray.display
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class ScaleBitmap extends Bitmap implements Disposeable
   {
       
      
      protected var _originalBitmap:BitmapData;
      
      protected var _scale9Grid:Rectangle = null;
      
      public function ScaleBitmap(bmpData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
      {
         super(bmpData,pixelSnapping,smoothing);
         _originalBitmap = bmpData.clone();
      }
      
      override public function set bitmapData(bmpData:BitmapData) : void
      {
         if(_originalBitmap)
         {
            _originalBitmap.dispose();
         }
         _originalBitmap = bmpData.clone();
         if(_scale9Grid != null)
         {
            if(!validGrid(_scale9Grid))
            {
               _scale9Grid = null;
            }
            setSize(bmpData.width,bmpData.height);
         }
         else
         {
            assignBitmapData(_originalBitmap.clone());
         }
      }
      
      public function dispose() : void
      {
         if(_originalBitmap)
         {
            _originalBitmap.dispose();
         }
         _originalBitmap = null;
         bitmapData.dispose();
         if(_scale9Grid)
         {
            _scale9Grid = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function getOriginalBitmapData() : BitmapData
      {
         return _originalBitmap;
      }
      
      override public function set height(h:Number) : void
      {
         if(h != height)
         {
            setSize(width,h);
         }
      }
      
      override public function get scale9Grid() : Rectangle
      {
         return _scale9Grid;
      }
      
      override public function set scale9Grid(r:Rectangle) : void
      {
         var currentWidth:Number = NaN;
         var currentHeight:Number = NaN;
         if(_scale9Grid == null && r != null || _scale9Grid != null && !_scale9Grid.equals(r))
         {
            if(r == null)
            {
               currentWidth = width;
               currentHeight = height;
               _scale9Grid = null;
               assignBitmapData(_originalBitmap.clone());
               setSize(currentWidth,currentHeight);
            }
            else
            {
               if(!validGrid(r))
               {
                  throw new Error("#001 - The _scale9Grid does not match the original BitmapData");
               }
               _scale9Grid = r.clone();
               resizeBitmap(width,height);
               scaleX = 1;
               scaleY = 1;
            }
         }
      }
      
      public function setSize(w:Number, h:Number) : void
      {
         if(_scale9Grid == null)
         {
            .super.width = w;
            .super.height = h;
         }
         else
         {
            w = Math.max(w,_originalBitmap.width - _scale9Grid.width);
            h = Math.max(h,_originalBitmap.height - _scale9Grid.height);
            resizeBitmap(w,h);
         }
      }
      
      override public function set width(w:Number) : void
      {
         if(w != width)
         {
            setSize(w,height);
         }
      }
      
      protected function resizeBitmap(w:Number, h:Number) : void
      {
         var origin:* = null;
         var draw:* = null;
         var cx:int = 0;
         var cy:int = 0;
         var bmpData:BitmapData = new BitmapData(w,h,true,0);
         var rows:Array = [0,_scale9Grid.top,_scale9Grid.bottom,_originalBitmap.height];
         var cols:Array = [0,_scale9Grid.left,_scale9Grid.right,_originalBitmap.width];
         var dRows:Array = [0,_scale9Grid.top,h - (_originalBitmap.height - _scale9Grid.bottom),h];
         var dCols:Array = [0,_scale9Grid.left,w - (_originalBitmap.width - _scale9Grid.right),w];
         var mat:Matrix = new Matrix();
         for(cx = 0; cx < 3; )
         {
            for(cy = 0; cy < 3; )
            {
               origin = new Rectangle(cols[cx],rows[cy],cols[cx + 1] - cols[cx],rows[cy + 1] - rows[cy]);
               draw = new Rectangle(dCols[cx],dRows[cy],dCols[cx + 1] - dCols[cx],dRows[cy + 1] - dRows[cy]);
               mat.identity();
               mat.a = draw.width / origin.width;
               mat.d = draw.height / origin.height;
               mat.tx = draw.x - origin.x * mat.a;
               mat.ty = draw.y - origin.y * mat.d;
               bmpData.draw(_originalBitmap,mat,null,null,draw,smoothing);
               cy++;
            }
            cx++;
         }
         assignBitmapData(bmpData);
      }
      
      private function assignBitmapData(bmp:BitmapData) : void
      {
         super.bitmapData.dispose();
         .super.bitmapData = bmp;
      }
      
      private function validGrid(r:Rectangle) : Boolean
      {
         return r.right <= _originalBitmap.width && r.bottom <= _originalBitmap.height;
      }
   }
}
