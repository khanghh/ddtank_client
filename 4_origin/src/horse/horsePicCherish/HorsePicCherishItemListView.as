package horse.horsePicCherish
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class HorsePicCherishItemListView extends Sprite implements Disposeable
   {
       
      
      private var _itemList:Vector.<HorsePicCherishItem>;
      
      public function HorsePicCherishItemListView(param1:Vector.<HorsePicCherishItem>)
      {
         super();
         _itemList = param1;
      }
      
      public function show(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         _loc4_ = (param1 - 1) * 8;
         while(_loc4_ < param1 * 8 && _loc4_ < _itemList.length)
         {
            _loc3_ = _itemList[_loc4_];
            _loc3_.x = _loc2_ % 4 * (_loc3_.width + 2);
            _loc3_.y = int(_loc2_ / 4) * (_loc3_.height - 2);
            addChild(_loc3_);
            _loc4_++;
            _loc2_++;
            _loc2_;
         }
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _itemList;
         for each(var _loc1_ in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _itemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
