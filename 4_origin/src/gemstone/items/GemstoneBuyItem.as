package gemstone.items
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.ShortcutBuyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.view.BuySingleGoodsView;
   
   public class GemstoneBuyItem extends Sprite
   {
       
      
      private var _itemID:int;
      
      private var _needDispatchEvent:Boolean;
      
      private var _storeTab:int;
      
      private var _itemInfo:ItemTemplateInfo;
      
      private var _shopItemInfo:ShopItemInfo;
      
      private var tipData:GoodTipInfo;
      
      private var _cell:BagCell;
      
      private var _txt:FilterFrameText;
      
      private var _btn:SimpleBitmapButton;
      
      public function GemstoneBuyItem()
      {
         super();
      }
      
      public function setup(itemID:int, storeTab:int, needDispacthEvent:Boolean = false) : void
      {
         _itemID = itemID;
         _storeTab = storeTab;
         _needDispatchEvent = needDispacthEvent;
         initliziItemTemplate();
      }
      
      private function initliziItemTemplate() : void
      {
         _itemInfo = ItemManager.Instance.getTemplateById(_itemID);
         _shopItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(_itemID);
         var goodInfo:GoodTipInfo = new GoodTipInfo();
         goodInfo.itemInfo = _itemInfo;
         goodInfo.isBalanceTip = false;
         goodInfo.typeIsSecond = false;
         tipData = goodInfo;
         _btn = ComponentFactory.Instance.creatComponentByStylename("gemstone.buy.btn");
         addChild(_btn);
         mouseChildren = false;
         buttonMode = true;
         useHandCursor = true;
         addEventListener("click",clickHander);
      }
      
      protected function clickHander(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _buyFrame:BuySingleGoodsView = new BuySingleGoodsView(-1);
         LayerManager.Instance.addToLayer(_buyFrame,3,true,1);
         _buyFrame.isDisCount = false;
         _buyFrame.goodsID = int(_itemID.toString() + "01");
         _buyFrame.numberSelecter.valueLimit = "";
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
      
      public function setText(str:String) : void
      {
         _txt.text = str;
      }
      
      public function dispose() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
