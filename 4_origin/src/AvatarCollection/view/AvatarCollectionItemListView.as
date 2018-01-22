package AvatarCollection.view
{
   import AvatarCollection.data.AvatarCollectionItemVo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class AvatarCollectionItemListView extends Sprite implements Disposeable
   {
       
      
      private var _itemList:Vector.<AvatarCollectionItemCell>;
      
      private var _dataList:Array;
      
      public function AvatarCollectionItemListView()
      {
         super();
         this.x = 29;
         this.y = 25;
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _itemList = new Vector.<AvatarCollectionItemCell>();
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = new AvatarCollectionItemCell();
            _loc1_.x = _loc2_ % 6 * 84;
            _loc1_.y = int(_loc2_ / 6) * 87;
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function refreshView(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _dataList = param1;
         var _loc3_:int = !!_dataList?_dataList.length:0;
         _loc4_ = 0;
         while(_loc4_ < 12)
         {
            _loc2_ = null;
            if(_loc4_ < _loc3_)
            {
               _loc2_ = _dataList[_loc4_];
            }
            _itemList[_loc4_].refreshView(_loc2_);
            _loc4_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _itemList = null;
         _dataList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
