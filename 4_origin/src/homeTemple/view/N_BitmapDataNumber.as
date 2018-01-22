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
      
      public function getNumber(param1:String, param2:String = "left") : BitmapData
      {
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc6_:* = null;
         _bitmapdata = new BitmapData(_bitmapdata.width,_bitmapdata.height,true,0);
         var _loc3_:int = 0;
         var _loc5_:int = param1.length;
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc4_ = param1.charAt(_loc8_);
            if(_loc4_ == ".")
            {
               _loc7_ = dot;
               _tempRect.width = dot.width;
               _tempRect.height = dot.height;
               _point.x = _loc3_;
               _point.y = 0;
            }
            else if(_loc4_ == "+")
            {
               _loc7_ = add;
               _tempRect.width = add.width;
               _tempRect.height = add.height;
               _point.x = _loc3_;
               _point.y = 0;
            }
            else if(_loc4_ == "/")
            {
               _loc7_ = sprit;
               _tempRect.width = sprit.width;
               _tempRect.height = sprit.height;
               _point.x = _loc3_;
               _point.y = 0;
            }
            else if(_loc4_ == "-")
            {
               _loc7_ = reduce;
               _tempRect.width = reduce.width;
               _tempRect.height = reduce.height;
               _point.x = _loc3_;
               _point.y = 0;
            }
            else
            {
               _loc7_ = numList[int(_loc4_)];
               _tempRect.width = _loc7_.width;
               _tempRect.height = _loc7_.height;
               _tempRect.width = _loc7_.width;
               _point.x = _loc3_;
               _point.y = 0;
            }
            _loc3_ = _loc3_ + (_loc7_.width + gap);
            _bitmapdata.copyPixels(_loc7_,_tempRect,_point);
            _loc8_++;
         }
         var _loc9_:* = param2;
         if("center" !== _loc9_)
         {
            if("right" !== _loc9_)
            {
               return _bitmapdata;
            }
            _loc6_ = new BitmapData(rect.width,rect.height,true,0);
            _tempRect.x = 0;
            _tempRect.width = _loc3_;
            _point.x = _rect.width - _loc3_;
            _loc6_.copyPixels(_bitmapdata,_tempRect,_point);
            return _loc6_;
         }
         _loc6_ = new BitmapData(rect.width,rect.height,true,0);
         _tempRect.x = 0;
         _tempRect.width = _loc3_;
         _point.x = _rect.width - _loc3_ >> 1;
         _loc6_.copyPixels(_bitmapdata,_tempRect,_point);
         return _loc6_;
      }
      
      public function get rect() : Rectangle
      {
         return _rect;
      }
      
      public function set rect(param1:Rectangle) : void
      {
         _rect = param1;
         _bitmapdata = new BitmapData(_rect.width,_rect.height);
         _tempRect = new Rectangle(0,0,10,param1.height);
      }
   }
}
