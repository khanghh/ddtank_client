package mysteriousRoullete.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import shop.view.ShopGoodItem;
   
   public class MysteriousShopItem extends ShopGoodItem
   {
      
      public static const TYPE_FREE:int = 0;
      
      public static const TYPE_DISCOUNT:int = 1;
       
      
      private var _itemCount:FilterFrameText;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var type:int = 1;
      
      private var _alertFrame:BaseAlerFrame;
      
      private var price:int;
      
      public function MysteriousShopItem(param1:int)
      {
         this.type = param1;
         super();
      }
      
      override protected function initContent() : void
      {
         super.initContent();
         removeChild(_payPaneaskBtn);
         removeChild(_payPaneBuyBtn);
         removeChild(_payPaneGivingBtn);
         _shopItemCellTypeBg.parent.removeChild(_shopItemCellTypeBg);
         _itemCount = ComponentFactory.Instance.creatComponentByStylename("mysteriousRoulette.itemCount");
         _itemCount.text = "100";
         addChild(_itemCount);
         switch(int(type))
         {
            case 0:
               _getBtn = ComponentFactory.Instance.creatComponentByStylename("mysteriousRoulette.getBtn");
               _getBtn.addEventListener("click",__getBtnClick);
               addChild(_getBtn);
               removeChild(_payType);
               break;
            case 1:
               _buyBtn = ComponentFactory.Instance.creatComponentByStylename("mysteriousRoulette.buyBtn");
               _buyBtn.addEventListener("click",__buyBtnClick);
               addChild(_buyBtn);
         }
      }
      
      override public function set shopItemInfo(param1:ShopItemInfo) : void
      {
         .super.shopItemInfo = param1;
         if(_shopItemInfo.BuyType == 1)
         {
            _itemCount.text = _shopItemInfo.AUnit.toString();
         }
         else
         {
            _itemCount.text = "";
         }
      }
      
      private function __getBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("mysteriousRoulette.ensureGet"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,true,2);
         _alertFrame.addEventListener("response",__alertResponseHandler);
      }
      
      private function __buyBtnClick(param1:MouseEvent) : void
      {
         price = shopItemInfo.getItemPrice(1).bothMoneyValue;
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("mysteriousRoulette.ensureBuy",price),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
         _loc2_.addEventListener("response",__alertBuyGoods);
      }
      
      protected function __alertBuyGoods(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",__alertBuyGoods);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  _loc3_.dispose();
                  return;
               }
               if(PlayerManager.Instance.Self.Money < price)
               {
                  _loc3_.dispose();
                  _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
                  _loc2_.addEventListener("response",_response);
                  return;
               }
               buy(false);
               break;
         }
         _loc3_.dispose();
      }
      
      private function onResponseHander(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",onResponseHander);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.Money < price)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               _loc2_.addEventListener("response",_response);
               return;
            }
            buy(false);
         }
         param1.currentTarget.dispose();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function __alertResponseHandler(param1:FrameEvent) : void
      {
         _alertFrame.removeEventListener("response",__alertResponseHandler);
         _alertFrame.dispose();
         _alertFrame = null;
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               buy();
               break;
         }
      }
      
      private function buy(param1:Boolean = false) : void
      {
         var _loc3_:Array = [];
         var _loc8_:Array = [];
         var _loc5_:Array = [];
         var _loc6_:Array = [];
         var _loc7_:Array = [];
         var _loc4_:Array = [];
         var _loc2_:Array = [];
         _loc3_.push(shopItemInfo.GoodsID);
         _loc8_.push(1);
         _loc5_.push("");
         _loc6_.push("");
         _loc7_.push("");
         _loc4_.push(1);
         _loc2_.push(false);
         SocketManager.Instance.out.sendBuyGoods(_loc3_,_loc8_,_loc5_,_loc7_,_loc6_,null,0,_loc4_,_loc2_);
      }
      
      public function turnGray(param1:Boolean = false) : void
      {
         if(_buyBtn)
         {
            _buyBtn.enable = !param1;
         }
         if(_getBtn)
         {
            _getBtn.enable = !param1;
         }
      }
      
      override protected function removeEvent() : void
      {
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__getBtnClick);
         }
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyBtnClick);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemCount);
         _itemCount = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         super.dispose();
      }
   }
}
