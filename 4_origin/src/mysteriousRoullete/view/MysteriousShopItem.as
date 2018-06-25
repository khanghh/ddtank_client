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
      
      public function MysteriousShopItem(type:int)
      {
         this.type = type;
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
      
      override public function set shopItemInfo(value:ShopItemInfo) : void
      {
         .super.shopItemInfo = value;
         if(_shopItemInfo.BuyType == 1)
         {
            _itemCount.text = _shopItemInfo.AUnit.toString();
         }
         else
         {
            _itemCount.text = "";
         }
      }
      
      private function __getBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("mysteriousRoulette.ensureGet"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,true,2);
         _alertFrame.addEventListener("response",__alertResponseHandler);
      }
      
      private function __buyBtnClick(event:MouseEvent) : void
      {
         price = shopItemInfo.getItemPrice(1).bothMoneyValue;
         SoundManager.instance.play("008");
         var alertAsk:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("mysteriousRoulette.ensureBuy",price),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
         alertAsk.addEventListener("response",__alertBuyGoods);
      }
      
      protected function __alertBuyGoods(event:FrameEvent) : void
      {
         var alertFrame:* = null;
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__alertBuyGoods);
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  frame.dispose();
                  return;
               }
               if(false)
               {
                  if(PlayerManager.Instance.Self.BandMoney < price)
                  {
                     frame.dispose();
                     alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("buried.alertInfo.noBindMoney"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
                     alertFrame.addEventListener("response",onResponseHander);
                     return;
                  }
               }
               else if(PlayerManager.Instance.Self.Money < price)
               {
                  frame.dispose();
                  alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
                  alertFrame.addEventListener("response",_response);
                  return;
               }
               buy(false);
               break;
         }
         frame.dispose();
      }
      
      private function onResponseHander(e:FrameEvent) : void
      {
         var alertFrame:* = null;
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",onResponseHander);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.Money < price)
            {
               alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               alertFrame.addEventListener("response",_response);
               return;
            }
            buy(false);
         }
         e.currentTarget.dispose();
      }
      
      private function _response(evt:FrameEvent) : void
      {
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      private function __alertResponseHandler(event:FrameEvent) : void
      {
         _alertFrame.removeEventListener("response",__alertResponseHandler);
         _alertFrame.dispose();
         _alertFrame = null;
         switch(int(event.responseCode) - 2)
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
      
      private function buy(isbind:Boolean = false) : void
      {
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var dresses:Array = [];
         var places:Array = [];
         var goodsTypes:Array = [];
         var binds:Array = [];
         items.push(shopItemInfo.GoodsID);
         types.push(1);
         colors.push("");
         dresses.push("");
         places.push("");
         goodsTypes.push(1);
         binds.push(false);
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,null,0,goodsTypes,binds);
      }
      
      public function turnGray(flag:Boolean = false) : void
      {
         if(_buyBtn)
         {
            _buyBtn.enable = !flag;
         }
         if(_getBtn)
         {
            _getBtn.enable = !flag;
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
