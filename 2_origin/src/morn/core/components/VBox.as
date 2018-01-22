package morn.core.components
{
   public class VBox extends LayoutBox
   {
      
      public static const NONE:String = "none";
      
      public static const LEFT:String = "left";
      
      public static const CENTER:String = "center";
      
      public static const RIGHT:String = "right";
       
      
      public function VBox()
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
               _loc2_ = Number(Math.max(_loc2_,_loc6_.displayWidth));
            }
            _loc3_++;
         }
         _loc1_.sortOn(["y"],Array.NUMERIC);
         var _loc5_:* = 0;
         for each(_loc6_ in _loc1_)
         {
            _loc6_.y = _maxY = _loc5_;
            _loc5_ = Number(_loc5_ + (_loc6_.displayHeight + _space));
            if(_align == LEFT)
            {
               _loc6_.x = 0;
            }
            else if(_align == CENTER)
            {
               _loc6_.x = (_loc2_ - _loc6_.displayWidth) * 0.5;
            }
            else if(_align == RIGHT)
            {
               _loc6_.x = _loc2_ - _loc6_.displayWidth;
            }
         }
         changeSize();
      }
   }
}
