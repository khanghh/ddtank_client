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
      
      public function setup(param1:int, param2:int, param3:Boolean = false) : void
      {
         _itemID = param1;
         _storeTab = param2;
         _needDispatchEvent = param3;
         initliziItemTemplate();
      }
      
      protected function initliziItemTemplate() : void
      {
         _itemInfo = ItemManager.Instance.getTemplateById(_itemID);
         _shopItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(_itemID);
         var _loc1_:GoodTipInfo = new GoodTipInfo();
         _loc1_.itemInfo = _itemInfo;
         _loc1_.isBalanceTip = false;
         _loc1_.typeIsSecond = false;
         tipData = _loc1_;
      }
      
      override protected function __onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(_enable)
         {
            param1.stopImmediatePropagation();
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
            _loc2_ = new BuySingleGoodsView(-1);
            LayerManager.Instance.addToLayer(_loc2_,_viewLayerType,true,1);
            _loc2_.isDisCount = false;
            _loc2_.goodsID = int(_itemID.toString() + "01");
            _loc2_.numberSelecter.valueLimit = "";
         }
      }
      
      public function set viewLayerType(param1:int) : void
      {
         _viewLayerType = param1;
      }
      
      private function removeFromStageHandler(param1:Event) : void
      {
         BagStore.instance.reduceTipPanelNumber();
      }
      
      private function __shortCutBuyHandler(param1:ShortcutBuyEvent) : void
      {
         param1.stopImmediatePropagation();
         if(_needDispatchEvent)
         {
            dispatchEvent(new ShortcutBuyEvent(param1.ItemID,param1.ItemNum));
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
