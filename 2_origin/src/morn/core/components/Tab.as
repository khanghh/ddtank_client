package morn.core.components
{
   import flash.display.DisplayObject;
   
   public class Tab extends Group
   {
      
      public static const HORIZENTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
       
      
      public function Tab(param1:String = null, param2:String = null)
      {
         super(param1,param2);
         _direction = HORIZENTAL;
      }
      
      override protected function createItem(param1:String, param2:String) : DisplayObject
      {
         return new Button(param1,param2);
      }
      
      override protected function changeLabels() : void
      {
         var _loc1_:* = NaN;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Button = null;
         if(_items)
         {
            _loc1_ = 0;
            _loc2_ = 0;
            _loc3_ = _items.length;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = _items[_loc2_] as Button;
               if(_skin)
               {
                  _loc4_.skin = _skin;
               }
               if(_labelColors)
               {
                  _loc4_.labelColors = _labelColors;
               }
               if(_labelStroke)
               {
                  _loc4_.labelStroke = _labelStroke;
               }
               if(_labelSize)
               {
                  _loc4_.labelSize = _labelSize;
               }
               if(_labelBold)
               {
                  _loc4_.labelBold = _labelBold;
               }
               if(_labelMargin)
               {
                  _loc4_.labelMargin = _labelMargin;
               }
               if(_direction == HORIZENTAL)
               {
                  _loc4_.y = 0;
                  _loc4_.x = _loc1_;
                  _loc1_ = Number(_loc1_ + (_loc4_.width + _space));
               }
               else
               {
                  _loc4_.x = 0;
                  _loc4_.y = _loc1_;
                  _loc1_ = Number(_loc1_ + (_loc4_.height + _space));
               }
               _loc2_++;
            }
         }
      }
   }
}
