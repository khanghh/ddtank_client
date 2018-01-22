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
      
      public function setup(param1:int, param2:int, param3:Boolean = false) : void
      {
         _itemID = param1;
         _storeTab = param2;
         _needDispatchEvent = param3;
         initliziItemTemplate();
      }
      
      private function initliziItemTemplate() : void
      {
         _itemInfo = ItemManager.Instance.getTemplateById(_itemID);
         _shopItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(_itemID);
         var _loc1_:GoodTipInfo = new GoodTipInfo();
         _loc1_.itemInfo = _itemInfo;
         _loc1_.isBalanceTip = false;
         _loc1_.typeIsSecond = false;
         tipData = _loc1_;
         _btn = ComponentFactory.Instance.creatComponentByStylename("gemstone.buy.btn");
         addChild(_btn);
         mouseChildren = false;
         buttonMode = true;
         useHandCursor = true;
         addEventListener("click",clickHander);
      }
      
      protected function clickHander(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BuySingleGoodsView = new BuySingleGoodsView(-1);
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
         _loc2_.isDisCount = false;
         _loc2_.goodsID = int(_itemID.toString() + "01");
         _loc2_.numberSelecter.valueLimit = "";
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
      
      public function setText(param1:String) : void
      {
         _txt.text = param1;
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
