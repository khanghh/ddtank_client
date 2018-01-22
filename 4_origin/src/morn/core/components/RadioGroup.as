package morn.core.components
{
   import flash.display.DisplayObject;
   
   public class RadioGroup extends Group
   {
      
      public static const HORIZENTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
       
      
      public function RadioGroup(param1:String = null, param2:String = null)
      {
         super(param1,param2);
         _direction = HORIZENTAL;
      }
      
      override protected function createItem(param1:String, param2:String) : DisplayObject
      {
         return new RadioButton(param1,param2);
      }
      
      override protected function changeLabels() : void
      {
         var _loc1_:* = NaN;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:RadioButton = null;
         if(_items)
         {
            _loc1_ = 0;
            _loc2_ = 0;
            _loc3_ = _items.length;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = _items[_loc2_] as RadioButton;
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
      
      public function get selectedValue() : Object
      {
         return _selectedIndex > -1 && _selectedIndex < _items.length?RadioButton(_items[_selectedIndex]).value:null;
      }
      
      public function set selectedValue(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:RadioButton = null;
         if(_items)
         {
            _loc2_ = 0;
            _loc3_ = _items.length;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = _items[_loc2_] as RadioButton;
               if(_loc4_.value == param1)
               {
                  selectedIndex = _loc2_;
                  break;
               }
               _loc2_++;
            }
         }
      }
   }
}
