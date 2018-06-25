package morn.core.components
{
   import flash.display.DisplayObject;
   
   public class Tab extends Group
   {
      
      public static const HORIZENTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
       
      
      public function Tab(labels:String = null, skin:String = null)
      {
         super(labels,skin);
         _direction = "horizontal";
      }
      
      override protected function createItem(skin:String, label:String) : DisplayObject
      {
         return new Button(skin,label);
      }
      
      override protected function changeLabels() : void
      {
         var left:* = NaN;
         var i:int = 0;
         var n:int = 0;
         var btn:* = null;
         if(_items)
         {
            left = 0;
            for(i = 0,n = _items.length; i < n; )
            {
               btn = _items[i] as Button;
               if(_skin)
               {
                  btn.skin = _skin;
               }
               if(_labelColors)
               {
                  btn.labelColors = _labelColors;
               }
               if(_labelStroke)
               {
                  btn.labelStroke = _labelStroke;
               }
               if(_labelSize)
               {
                  btn.labelSize = _labelSize;
               }
               if(_labelBold)
               {
                  btn.labelBold = _labelBold;
               }
               if(_labelMargin)
               {
                  btn.labelMargin = _labelMargin;
               }
               if(_direction == "horizontal")
               {
                  btn.y = 0;
                  btn.x = left;
                  left = Number(left + (btn.width + _space));
               }
               else
               {
                  btn.x = 0;
                  btn.y = left;
                  left = Number(left + (btn.height + _space));
               }
               i++;
            }
         }
      }
   }
}
