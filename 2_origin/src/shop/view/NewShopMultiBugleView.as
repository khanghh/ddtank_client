package shop.view
{
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   
   public class NewShopMultiBugleView extends NewShopBugleView
   {
       
      
      private var _shopData:DictionaryData;
      
      public function NewShopMultiBugleView(type:uint)
      {
         _shopData = new DictionaryData();
         KeyboardShortcutsManager.Instance.prohibitNewHandBag(false);
         super(type);
      }
      
      override protected function __onKeyDownd(e:KeyboardEvent) : void
      {
         e.stopImmediatePropagation();
         e.stopPropagation();
      }
      
      override protected function addItems() : void
      {
         var id:int = 0;
         var shopIdList:* = null;
         var indexList:* = null;
         var i:int = 0;
         var index:int = 0;
         if(_type == 40002)
         {
            _itemContainer.x = 1;
            _itemContainer.y = 5;
            _itemContainer.spacing = 10;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.texpQuickBuy");
            _buyFrom = 6;
            shopIdList = [40003,40006];
            indexList = [2,2];
         }
         else if(_type == 40008)
         {
            _itemContainer.x = 70;
            _itemContainer.y = 2;
            _itemContainer.spacing = 60;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.texpQuickBuy");
            _buyFrom = 6;
            shopIdList = [40008];
            indexList = [2];
         }
         i = 0;
         while(i < shopIdList.length)
         {
            id = shopIdList[i];
            _info = ShopManager.Instance.getMoneyShopItemByTemplateID(id);
            if(!_shopData.hasKey(id))
            {
               _shopData.add(id,_info);
            }
            index = 1;
            while(index <= 3)
            {
               if(index >= indexList[i] && _info.getItemPrice(index).IsValid)
               {
                  addItem(_info,index);
               }
               index++;
            }
            i++;
         }
         _info = _shopData[shopIdList[0]] as ShopItemInfo;
      }
      
      override protected function __click(e:MouseEvent) : void
      {
         var item:NewShopBugViewItem = e.currentTarget as NewShopBugViewItem;
         _info = _shopData[item.info.TemplateID] as ShopItemInfo;
         super.__click(e);
      }
      
      override public function dispose() : void
      {
         _shopData.clear();
         _shopData = null;
         KeyboardShortcutsManager.Instance.prohibitNewHandBag(true);
         super.dispose();
      }
   }
}
