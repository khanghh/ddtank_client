package AvatarCollection.view
{
   import AvatarCollection.data.AvatarCollectionUnitVo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class AvatarCollectionRightView extends Sprite implements Disposeable
   {
       
      
      private var _data:AvatarCollectionUnitVo;
      
      private var _itemListView:AvatarCollectionItemListView;
      
      private var _propertyView:AvatarCollectionPropertyView;
      
      private var _moneyView:AvatarCollectionMoneyView;
      
      private var _timeView:AvatarCollectionTimeView;
      
      public function AvatarCollectionRightView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _itemListView = new AvatarCollectionItemListView();
         addChild(_itemListView);
         _moneyView = new AvatarCollectionMoneyView();
         addChild(_moneyView);
         _timeView = new AvatarCollectionTimeView();
         addChild(_timeView);
         _propertyView = new AvatarCollectionPropertyView();
         addChild(_propertyView);
      }
      
      public function refreshView(data:AvatarCollectionUnitVo) : void
      {
         _itemListView.refreshView(!!data?data.totalItemList:null);
         _propertyView.refreshView(data);
         _timeView.refreshView(data);
      }
      
      public function set selectedAllBtn(value:Boolean) : void
      {
         _timeView.selected = value;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         _itemListView = null;
         _propertyView = null;
         _moneyView = null;
         _timeView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
