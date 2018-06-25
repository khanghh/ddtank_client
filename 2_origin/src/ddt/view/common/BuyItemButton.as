package ddt.view.common
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import ddt.bagStore.BagStore;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.ShortcutBuyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.view.tips.GoodTipInfo;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.view.BuySingleGoodsView;
   
   public class BuyItemButton extends TextButton
   {
       
      
      protected var _itemInfo:ItemTemplateInfo;
      
      protected var _shopItemInfo:ShopItemInfo;
      
      private var _needDispatchEvent:Boolean;
      
      private var _storeTab:int;
      
      private var _itemID:int;
      
      private var _viewLayerType:int;
      
      public function BuyItemButton()
      {
         super();
         _viewLayerType = 3;
      }
      
      public function setup(itemID:int, storeTab:int, needDispacthEvent:Boolean = false) : void
      {
         _itemID = itemID;
         _storeTab = storeTab;
         _needDispatchEvent = needDispacthEvent;
         initliziItemTemplate();
      }
      
      protected function initliziItemTemplate() : void
      {
         _itemInfo = ItemManager.Instance.getTemplateById(_itemID);
         _shopItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(_itemID);
         var goodInfo:GoodTipInfo = new GoodTipInfo();
         goodInfo.itemInfo = _itemInfo;
         goodInfo.isBalanceTip = false;
         goodInfo.typeIsSecond = false;
         tipData = goodInfo;
      }
      
      override protected function __onMouseClick(event:MouseEvent) : void
      {
         var _buyFrame:* = null;
         if(_enable)
         {
            event.stopImmediatePropagation();
            if(useLogID != 0 && ComponentSetting.SEND_USELOG_ID != null)
            {
               ComponentSetting.SEND_USELOG_ID(useLogID);
            }
            SoundManager.instance.play("008");
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _buyFrame = new BuySingleGoodsView(-1);
            LayerManager.Instance.addToLayer(_buyFrame,_viewLayerType,true,1);
            _buyFrame.isDisCount = false;
            _buyFrame.goodsID = int(_itemID.toString() + "01");
            _buyFrame.numberSelecter.valueLimit = "";
         }
      }
      
      public function set viewLayerType(value:int) : void
      {
         _viewLayerType = value;
      }
      
      private function removeFromStageHandler(event:Event) : void
      {
         BagStore.instance.reduceTipPanelNumber();
      }
      
      private function __shortCutBuyHandler(evt:ShortcutBuyEvent) : void
      {
         evt.stopImmediatePropagation();
         if(_needDispatchEvent)
         {
            dispatchEvent(new ShortcutBuyEvent(evt.ItemID,evt.ItemNum));
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _itemInfo = null;
         _shopItemInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
