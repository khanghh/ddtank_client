package morn.core.components
{
   public class HBox extends LayoutBox
   {
      
      public static const NONE:String = "none";
      
      public static const TOP:String = "top";
      
      public static const MIDDLE:String = "middle";
      
      public static const BOTTOM:String = "bottom";
       
      
      public function HBox()
      {
         super();
      }
      
      override protected function changeItems() : void
      {
         var _loc6_:Component = null;
         var _loc1_:Array = [];
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = numChildren;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = getChildAt(_loc3_) as Component;
            if(_loc6_)
            {
               _loc1_.push(_loc6_);
               _loc2_ = Number(Math.max(_loc2_,_loc6_.displayHeight));
            }
            _loc3_++;
         }
         _loc1_.sortOn(["x"],Array.NUMERIC);
         var _loc5_:* = 0;
         for each(_loc6_ in _loc1_)
         {
            _loc6_.x = _maxX = _loc5_;
            _loc5_ = Number(_loc5_ + (_loc6_.displayWidth + _space));
            if(_align == TOP)
            {
               _loc6_.y = 0;
            }
            else if(_align == MIDDLE)
            {
               _loc6_.y = (_loc2_ - _loc6_.displayHeight) * 0.5;
            }
            else if(_align == BOTTOM)
            {
               _loc6_.y = _loc2_ - _loc6_.displayHeight;
            }
         }
         changeSize();
      }
   }
}
