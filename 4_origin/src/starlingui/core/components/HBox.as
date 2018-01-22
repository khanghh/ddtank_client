package starlingui.core.components
{
   import starling.display.DisplayObject;
   
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
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Array = [];
         var _loc4_:* = 0;
         _loc6_ = 0;
         _loc3_ = numChildren;
         while(_loc6_ < _loc3_)
         {
            _loc2_ = getChildAt(_loc6_) as DisplayObject;
            if(_loc2_)
            {
               _loc1_.push(_loc2_);
               _loc4_ = Number(Math.max(_loc4_,_loc2_.height));
            }
            _loc6_++;
         }
         _loc1_.sortOn(["x"],16);
         var _loc5_:* = 0;
         var _loc8_:int = 0;
         var _loc7_:* = _loc1_;
         for each(_loc2_ in _loc1_)
         {
            _maxX = _loc5_;
            _loc2_.x = _loc5_;
            _loc5_ = Number(_loc5_ + (_loc2_.width + _space));
            if(_align == "top")
            {
               _loc2_.y = 0;
            }
            else if(_align == "middle")
            {
               _loc2_.y = (_loc4_ - _loc2_.height) * 0.5;
            }
            else if(_align == "bottom")
            {
               _loc2_.y = _loc4_ - _loc2_.height;
            }
         }
         changeSize();
      }
   }
}
