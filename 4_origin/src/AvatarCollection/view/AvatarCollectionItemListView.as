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
         var i:int = 0;
         var tmp:* = null;
         _itemList = new Vector.<AvatarCollectionItemCell>();
         for(i = 0; i < 12; )
         {
            tmp = new AvatarCollectionItemCell();
            tmp.x = i % 6 * 84;
            tmp.y = int(i / 6) * 87;
            addChild(tmp);
            _itemList.push(tmp);
            i++;
         }
      }
      
      public function refreshView(dataList:Array) : void
      {
         var i:int = 0;
         var tmpData:* = null;
         _dataList = dataList;
         var tmpLen:int = !!_dataList?_dataList.length:0;
         for(i = 0; i < 12; )
         {
            tmpData = null;
            if(i < tmpLen)
            {
               tmpData = _dataList[i];
            }
            _itemList[i].refreshView(tmpData);
            i++;
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
