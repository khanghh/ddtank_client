package horse.horsePicCherish
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class HorsePicCherishItemListView extends Sprite implements Disposeable
   {
       
      
      private var _itemList:Vector.<HorsePicCherishItem>;
      
      public function HorsePicCherishItemListView(list:Vector.<HorsePicCherishItem>)
      {
         super();
         _itemList = list;
      }
      
      public function show(index:int) : void
      {
         var count:int = 0;
         var i:int = 0;
         var item:* = null;
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         i = (index - 1) * 10;
         while(i < index * 10 && i < _itemList.length)
         {
            item = _itemList[i];
            item.x = count % 5 * (item.width + 2);
            item.y = int(count / 5) * (item.height - 2);
            addChild(item);
            i++;
            count++;
            count;
         }
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _itemList;
         for each(var item in _itemList)
         {
            ObjectUtils.disposeObject(item);
            item = null;
         }
         _itemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
