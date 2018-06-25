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
         var i:int = 0;
         var n:int = 0;
         var item:* = null;
         var items:Array = [];
         var maxHeight:* = 0;
         for(i = 0,n = numChildren; i < n; )
         {
            item = getChildAt(i) as DisplayObject;
            if(item)
            {
               items.push(item);
               maxHeight = Number(Math.max(maxHeight,item.height));
            }
            i++;
         }
         items.sortOn(["x"],16);
         var left:* = 0;
         var _loc8_:int = 0;
         var _loc7_:* = items;
         for each(item in items)
         {
            _maxX = left;
            item.x = left;
            left = Number(left + (item.width + _space));
            if(_align == "top")
            {
               item.y = 0;
            }
            else if(_align == "middle")
            {
               item.y = (maxHeight - item.height) * 0.5;
            }
            else if(_align == "bottom")
            {
               item.y = maxHeight - item.height;
            }
         }
         changeSize();
      }
   }
}
