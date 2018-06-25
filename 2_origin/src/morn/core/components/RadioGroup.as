package morn.core.components
{
   import flash.display.DisplayObject;
   
   public class RadioGroup extends Group
   {
      
      public static const HORIZENTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
       
      
      public function RadioGroup(labels:String = null, skin:String = null)
      {
         super(labels,skin);
         _direction = "horizontal";
      }
      
      override protected function createItem(skin:String, label:String) : DisplayObject
      {
         return new RadioButton(skin,label);
      }
      
      override protected function changeLabels() : void
      {
         var left:* = NaN;
         var i:int = 0;
         var n:int = 0;
         var radio:* = null;
         if(_items)
         {
            left = 0;
            for(i = 0,n = _items.length; i < n; )
            {
               radio = _items[i] as RadioButton;
               if(_skin)
               {
                  radio.skin = _skin;
               }
               if(_labelColors)
               {
                  radio.labelColors = _labelColors;
               }
               if(_labelStroke)
               {
                  radio.labelStroke = _labelStroke;
               }
               if(_labelSize)
               {
                  radio.labelSize = _labelSize;
               }
               if(_labelBold)
               {
                  radio.labelBold = _labelBold;
               }
               if(_labelMargin)
               {
                  radio.labelMargin = _labelMargin;
               }
               if(_direction == "horizontal")
               {
                  radio.y = 0;
                  radio.x = left;
                  left = Number(left + (radio.width + _space));
               }
               else
               {
                  radio.x = 0;
                  radio.y = left;
                  left = Number(left + (radio.height + _space));
               }
               i++;
            }
         }
      }
      
      public function get selectedValue() : Object
      {
         return _selectedIndex > -1 && _selectedIndex < _items.length?RadioButton(_items[_selectedIndex]).value:null;
      }
      
      public function set selectedValue(value:Object) : void
      {
         var i:int = 0;
         var n:int = 0;
         var item:* = null;
         if(_items)
         {
            for(i = 0,n = _items.length; i < n; )
            {
               item = _items[i] as RadioButton;
               if(item.value == value)
               {
                  selectedIndex = i;
                  break;
               }
               i++;
            }
         }
      }
   }
}
