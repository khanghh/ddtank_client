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
      
      public function NewShopMultiBugleView(param1:uint)
      {
         _shopData = new DictionaryData();
         super(param1);
      }
      
      override protected function __onKeyDownd(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      override protected function addItems() : void
      {
         var _loc1_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         if(_type == 6)
         {
            _itemContainer.x = 1;
            _itemContainer.y = 5;
            _itemContainer.spacing = 10;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.texpQuickBuy");
            _buyFrom = 6;
            _loc4_ = [40003,40006];
            _loc3_ = [2,2];
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc1_ = _loc4_[_loc5_];
            _info = ShopManager.Instance.getMoneyShopItemByTemplateID(_loc1_);
            if(!_shopData.hasKey(_loc1_))
            {
               _shopData.add(_loc1_,_info);
            }
            _loc2_ = 1;
            while(_loc2_ <= 3)
            {
               if(_loc2_ >= _loc3_[_loc5_] && _info.getItemPrice(_loc2_).IsValid)
               {
                  addItem(_info,_loc2_);
               }
               _loc2_++;
            }
            _loc5_++;
         }
         _info = _shopData[_loc4_[0]] as ShopItemInfo;
      }
      
      override protected function __click(param1:MouseEvent) : void
      {
         var _loc2_:NewShopBugViewItem = param1.currentTarget as NewShopBugViewItem;
         _info = _shopData[_loc2_.info.TemplateID] as ShopItemInfo;
         super.__click(param1);
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
