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
      
      public function NewShopMultiBugleView(param1:uint){super(null);}
      
      override protected function __onKeyDownd(param1:KeyboardEvent) : void{}
      
      override protected function addItems() : void{}
      
      override protected function __click(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
