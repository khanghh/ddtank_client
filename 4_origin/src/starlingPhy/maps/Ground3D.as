package starlingPhy.maps
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import road7th.utils.MathUtils;
   
   public class Ground3D extends Tile3D
   {
       
      
      private var _bound:Rectangle;
      
      public function Ground3D(param1:BitmapData, param2:Boolean)
      {
         super(param1,param2);
         _bound = new Rectangle(0,0,width,height);
      }
      
      public function IsEmpty(param1:int, param2:int) : Boolean
      {
         return GetAlpha(param1,param2) <= 150;
      }
      
      public function IsRectangleEmpty(param1:Rectangle) : Boolean
      {
         param1 = _bound.intersection(param1);
         if(param1.width == 0 || param1.height == 0)
         {
            return true;
         }
         if(!IsXLineEmpty(param1.x,param1.y,param1.width))
         {
            return false;
         }
         if(param1.height > 1)
         {
            if(!IsXLineEmpty(param1.x,param1.y + param1.height - 1,param1.width))
            {
               return false;
            }
            if(!IsYLineEmtpy(param1.x,param1.y + 1,param1.height - 1))
            {
               return false;
            }
            if(param1.width > 1 && !IsYLineEmtpy(param1.x + param1.width - 1,param1.y,param1.height - 1))
            {
               return false;
            }
         }
         return true;
      }
      
      public function IsRectangeEmptyQuick(param1:Rectangle) : Boolean
      {
         param1 = _bound.intersection(param1);
         if(IsEmpty(param1.right,param1.bottom) && IsEmpty(param1.left,param1.bottom) && IsEmpty(param1.right,param1.top) && IsEmpty(param1.left,param1.top))
         {
            return true;
         }
         return false;
      }
      
      public function IsCircleEmptyQuick(param1:Rectangle, param2:Number = 30) : Boolean
      {
         var _loc7_:* = NaN;
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         param1 = _bound.intersection(param1);
         var _loc5_:Number = param1.width / 2;
         var _loc8_:Point = new Point(0,0);
         var _loc6_:Number = 360 / param2;
         _loc7_ = 1;
         while(_loc7_ <= _loc6_)
         {
            _loc8_.x = _loc5_ * Math.cos(_loc7_ * param2 * MathUtils.RADIAN);
            _loc8_.y = _loc5_ * Math.sin(_loc7_ * param2 * MathUtils.RADIAN);
            _loc4_ = param1.x + _loc8_.x + _loc5_;
            _loc3_ = param1.y + _loc8_.y + _loc5_;
            if(!IsEmpty(_loc4_,_loc3_))
            {
               return false;
            }
            _loc7_++;
         }
         return true;
      }
      
      public function IsXLineEmpty(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc4_:int = 0;
         param1 = param1 < 0?0:param1;
         param3 = param1 + param3 > width?width - param1:param3;
         _loc4_ = 0;
         while(_loc4_ < param3)
         {
            if(!IsEmpty(param1 + _loc4_,param2))
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      public function IsYLineEmtpy(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc4_:int = 0;
         param2 = param2 < 0?0:param2;
         param3 = param2 + param3 > height?height - param2:param3;
         _loc4_ = 0;
         while(_loc4_ < param3)
         {
            if(!IsEmpty(param1,param2 + _loc4_))
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      public function IsBitmapDataEmpty(param1:BitmapData, param2:Point = null) : Boolean
      {
         return !bitmapData.hitTest(new Point(this.x,this.y),150,param1,param2,150);
      }
      
      override public function dispose() : void
      {
         _bound = null;
         super.dispose();
      }
   }
}
