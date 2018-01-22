package labyrinth.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.command.QuickBuyFrame;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.ShortcutBuyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import labyrinth.LabyrinthControl;
   import labyrinth.LabyrinthManager;
   import shop.view.ShopGoodItem;
   
   public class LabyrinthShopItem extends ShopGoodItem
   {
       
      
      protected var _explanation:FilterFrameText;
      
      private var _frame:BuyFrame;
      
      public function LabyrinthShopItem()
      {
         super();
      }
      
      override protected function initContent() : void
      {
         super.initContent();
         _explanation = UICreatShortcut.creatTextAndAdd("labyrinth.view.LabyrinthShopItem.explanationText",LanguageMgr.GetTranslation("labyrinth.view.LabyrinthShopItem.explanationText",1),this);
         _explanation.visible = false;
         _shopItemCellTypeBg.parent.removeChild(_shopItemCellTypeBg);
      }
      
      override protected function initPrice() : void
      {
         if(BuriedManager.Instance.isOpening)
         {
            _itemPriceTxt.text = String(_shopItemInfo.AValue1);
            _payType.setFrame(4);
         }
         else
         {
            _itemPriceTxt.text = String(_shopItemInfo.getItemPrice(1).hardCurrencyValue);
            _payType.setFrame(3);
         }
         _payPaneGivingBtn.visible = false;
      }
      
      override public function set shopItemInfo(param1:ShopItemInfo) : void
      {
         .super.shopItemInfo = param1;
         updateCircumscribe();
      }
      
      protected function updateCircumscribe() : void
      {
         _payPaneaskBtn.visible = false;
         if(BuriedManager.Instance.isOpening)
         {
            if(_shopItemInfo)
            {
               _explanation.visible = false;
               _payPaneBuyBtn.visible = true;
               _itemCellBtn.filters = null;
            }
            else
            {
               _explanation.visible = false;
               _payPaneBuyBtn.visible = false;
            }
            if(shopItemInfo && shopItemInfo.TemplateInfo && shopItemInfo.TemplateInfo.Quality == 5)
            {
               _explanation.visible = true;
               _explanation.text = LanguageMgr.GetTranslation("buried.view.LabyrinthShopItem.explanationText");
               _payPaneBuyBtn.visible = false;
               _payType.visible = false;
               _itemPriceTxt.visible = false;
            }
            return;
         }
         if(!_shopItemInfo)
         {
            _explanation.visible = false;
            _payPaneBuyBtn.visible = false;
         }
         else if(_shopItemInfo.LimitGrade <= LabyrinthManager.Instance.model.myProgress)
         {
            _explanation.visible = false;
            _payPaneBuyBtn.visible = true;
            _itemCellBtn.filters = null;
         }
         else
         {
            _explanation.visible = true;
            _explanation.text = LanguageMgr.GetTranslation("labyrinth.view.LabyrinthShopItem.explanationText",_shopItemInfo.LimitGrade);
            _payPaneBuyBtn.visible = false;
            _itemCellBtn.filters = [new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
         }
      }
      
      override protected function __payPanelClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(LabyrinthControl.Instance.buyFrameEnable)
         {
            if(BuriedManager.Instance.isOpening)
            {
               _frame = ComponentFactory.Instance.creat("labyrinth.view.buyFrame");
               _frame.value = _shopItemInfo.AValue1;
               _frame.show();
               _frame.addEventListener("response",__onframeEvent);
            }
            else
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
               _loc2_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
               _loc2_.setItemID(shopItemInfo.TemplateID,1);
               _loc2_.buyFrom = 0;
               _loc2_.addEventListener("shortcutBuy",__shortCutBuyHandler);
               _loc2_.addEventListener("removedFromStage",removeFromStageHandler);
               LayerManager.Instance.addToLayer(_loc2_,2,true,1);
            }
         }
         else
         {
            buy();
         }
      }
      
      private function removeFromStageHandler(param1:Event) : void
      {
         BagStore.instance.reduceTipPanelNumber();
      }
      
      private function __shortCutBuyHandler(param1:ShortcutBuyEvent) : void
      {
         param1.stopImmediatePropagation();
         dispatchEvent(new ShortcutBuyEvent(param1.ItemID,param1.ItemNum));
      }
      
      protected function __onframeEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               buy();
         }
         _frame.removeEventListener("response",__onframeEvent);
         ObjectUtils.disposeObject(_frame);
         _frame = null;
      }
      
      private function buy() : void
      {
         var _loc2_:Array = [];
         var _loc7_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc6_:Array = [];
         var _loc3_:Array = [];
         var _loc1_:Array = [];
         _loc2_.push(shopItemInfo.GoodsID);
         _loc7_.push(1);
         _loc4_.push("");
         _loc5_.push("");
         _loc6_.push("");
         _loc3_.push(1);
         _loc1_.push("");
         SocketManager.Instance.out.sendBuyGoods(_loc2_,_loc7_,_loc4_,_loc6_,_loc5_,null,0,_loc3_,_loc1_);
      }
   }
}
