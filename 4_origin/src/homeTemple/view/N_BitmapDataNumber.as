package homeTemple.view
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class N_BitmapDataNumber
   {
       
      
      public var numList:Vector.<BitmapData>;
      
      public var dot:BitmapData;
      
      public var sprit:BitmapData;
      
      public var add:BitmapData;
      
      public var reduce:BitmapData;
      
      public var gap:Number = 1;
      
      private var _rect:Rectangle;
      
      private var _bitmapdata:BitmapData;
      
      private var _tempRect:Rectangle;
      
      private var _point:Point;
      
      public function N_BitmapDataNumber()
      {
         _point = new Point(0,0);
         super();
      }
      
      public function getNumber(num:String, align:String = "left") : BitmapData
      {
         var char:* = null;
         var bd:* = null;
         var i:int = 0;
         var tempData:* = null;
         _bitmapdata = new BitmapData(_bitmapdata.width,_bitmapdata.height,true,0);
         var __position:int = 0;
         var len:int = num.length;
         for(i = 0; i < len; )
         {
            char = num.charAt(i);
            if(char == ".")
            {
               bd = dot;
               _tempRect.width = dot.width;
               _tempRect.height = dot.height;
               _point.x = __position;
               _point.y = 0;
            }
            else if(char == "+")
            {
               bd = add;
               _tempRect.width = add.width;
               _tempRect.height = add.height;
               _point.x = __position;
               _point.y = 0;
            }
            else if(char == "/")
            {
               bd = sprit;
               _tempRect.width = sprit.width;
               _tempRect.height = sprit.height;
               _point.x = __position;
               _point.y = 0;
            }
            else if(char == "-")
            {
               bd = reduce;
               _tempRect.width = reduce.width;
               _tempRect.height = reduce.height;
               _point.x = __position;
               _point.y = 0;
            }
            else
            {
               bd = numList[int(char)];
               _tempRect.width = bd.width;
               _tempRect.height = bd.height;
               _tempRect.width = bd.width;
               _point.x = __position;
               _point.y = 0;
            }
            __position = __position + (bd.width + gap);
            _bitmapdata.copyPixels(bd,_tempRect,_point);
            i++;
         }
         var _loc9_:* = align;
         if("center" !== _loc9_)
         {
            if("right" !== _loc9_)
            {
               return _bitmapdata;
            }
            tempData = new BitmapData(rect.width,rect.height,true,0);
            _tempRect.x = 0;
            _tempRect.width = __position;
            _point.x = _rect.width - __position;
            tempData.copyPixels(_bitmapdata,_tempRect,_point);
            return tempData;
         }
         tempData = new BitmapData(rect.width,rect.height,true,0);
         _tempRect.x = 0;
         _tempRect.width = __position;
         _point.x = _rect.width - __position >> 1;
         tempData.copyPixels(_bitmapdata,_tempRect,_point);
         return tempData;
      }
      
      public function get rect() : Rectangle
      {
         return _rect;
      }
      
      public function set rect(value:Rectangle) : void
      {
         _rect = value;
         _bitmapdata = new BitmapData(_rect.width,_rect.height);
         _tempRect = new Rectangle(0,0,10,value.height);
      }
   }
}
