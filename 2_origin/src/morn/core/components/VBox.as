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
         var i:int = 0;
         var n:int = 0;
         var item:* = null;
         var items:Array = [];
         var maxWidth:* = 0;
         for(i = 0,n = numChildren; i < n; )
         {
            item = getChildAt(i) as Component;
            if(item)
            {
               items.push(item);
               maxWidth = Number(Math.max(maxWidth,item.displayWidth));
            }
            i++;
         }
         items.sortOn(["y"],16);
         var top:* = 0;
         var _loc8_:int = 0;
         var _loc7_:* = items;
         for each(item in items)
         {
            _maxY = top;
            item.y = top;
            top = Number(top + (item.displayHeight + _space));
            if(_align == "left")
            {
               item.x = 0;
            }
            else if(_align == "center")
            {
               item.x = (maxWidth - item.displayWidth) * 0.5;
            }
            else if(_align == "right")
            {
               item.x = maxWidth - item.displayWidth;
            }
         }
         changeSize();
      }
   }
}
