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
      
      public function AvatarCollectionItemListView(){super();}
      
      private function initView() : void{}
      
      public function refreshView(param1:Array) : void{}
      
      public function dispose() : void{}
   }
}
