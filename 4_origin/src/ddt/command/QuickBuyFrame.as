package ddt.command
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.ShortcutBuyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   
   public class QuickBuyFrame extends Frame
   {
       
      
      public var canDispose:Boolean;
      
      protected var _view:QuickBuyFrameView;
      
      protected var _shopItemInfo:ShopItemInfo;
      
      protected var _submitButton:TextButton;
      
      protected var _unitPrice:Number;
      
      protected var _buyFrom:int;
      
      protected var _recordLastBuyCount:Boolean;
      
      private var _flag:Boolean;
      
      public function QuickBuyFrame()
      {
         super();
         canDispose = true;
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _view = new QuickBuyFrameView();
         addToContent(_view);
         _submitButton = ComponentFactory.Instance.creatComponentByStylename("ddtcore.quickEnter");
         _submitButton.text = LanguageMgr.GetTranslation("store.view.shortcutBuy.buyBtn");
         _view.addChild(_submitButton);
         escEnable = true;
         enterEnable = true;
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_response);
         _submitButton.addEventListener("click",doPay);
         _view.addEventListener("number_close",_numberClose);
         addEventListener("number_enter",_numberEnter);
      }
      
      private function removeEvnets() : void
      {
         removeEventListener("response",_response);
         if(_submitButton)
         {
            _submitButton.removeEventListener("click",doPay);
         }
         if(_view)
         {
            _view.removeEventListener("number_close",_numberClose);
         }
         removeEventListener("number_enter",_numberEnter);
      }
      
      private function _numberClose(e:Event) : void
      {
         cancelMoney();
         ObjectUtils.disposeObject(this);
      }
      
      private function _numberEnter(e:Event) : void
      {
         e.stopImmediatePropagation();
         doPay(null);
      }
      
      public function setTitleText(value:String) : void
      {
         titleText = value;
      }
      
      public function hideSelectedBand() : void
      {
         _view.hideSelectedBand();
      }
      
      public function set itemID(value:int) : void
      {
         _view.ItemID = value;
         _shopItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(_view._itemID);
         perPrice();
      }
      
      public function setIsStoneExploreView(value:Boolean) : void
      {
         _flag = value;
      }
      
      public function setItemID(ID:int, type:int, param:int = 1) : void
      {
         _view.setItemID(ID,type,param);
         _shopItemInfo = ShopManager.Instance.getShopItemByTemplateID(_view._itemID,type);
         if(type == 1)
         {
            _unitPrice = _shopItemInfo.getItemPrice(1).hardCurrencyValue;
         }
         else if(type == 2)
         {
            _unitPrice = _shopItemInfo.getItemPrice(1).gesteValue;
         }
         else if(type == 3)
         {
            _unitPrice = _shopItemInfo.getItemPrice(param).bothMoneyValue;
         }
         else if(type == 6)
         {
            _unitPrice = _shopItemInfo.getItemPrice(param).badgeValue;
         }
      }
      
      public function set stoneNumber(value:int) : void
      {
         _view.stoneNumber = value;
      }
      
      public function set maxLimit(value:int) : void
      {
         _view.maxLimit = value;
      }
      
      protected function perPrice() : void
      {
         var itemInfo:ShopItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(_view.ItemID);
         if(itemInfo)
         {
            _unitPrice = itemInfo.getItemPrice(1).bothMoneyValue;
         }
         else
         {
            _unitPrice = 0;
         }
      }
      
      public function set recordLastBuyCount(value:Boolean) : void
      {
         _recordLastBuyCount = value;
         if(_recordLastBuyCount)
         {
            _view.stoneNumber = SharedManager.Instance.lastBuyCount;
         }
      }
      
      protected function doPay(e:Event) : void
      {
         var items:* = null;
         var types:* = null;
         var colors:* = null;
         var dresses:* = null;
         var skins:* = null;
         var places:* = null;
         var bands:* = null;
         var i:int = 0;
         SoundManager.instance.play("008");
         if(_shopItemInfo == null || !_shopItemInfo.isValid)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.quickDate"));
            return;
         }
         if(_view.type == 0 || _view.type == 3)
         {
            if(_view.isBand && PlayerManager.Instance.Self.BandMoney < _view.stoneNumber * _unitPrice)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.lijinbuzu"));
               return;
            }
            if(!_view.isBand && PlayerManager.Instance.Self.Money < _view.stoneNumber * _unitPrice)
            {
               LeavePageManager.showFillFrame();
               return;
            }
         }
         else if(_view.type == 1)
         {
            if(!_view.isBand && PlayerManager.Instance.Self.hardCurrency < _view.stoneNumber * _unitPrice)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.lackCoin"));
               return;
            }
         }
         else if(_view.type == 2)
         {
            if(!_view.isBand && PlayerManager.Instance.Self.Offer < _view.stoneNumber * _unitPrice)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ConsortiaShopItem.gongXunbuzu"));
               return;
            }
         }
         else if(_view.type == 6)
         {
            if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12567) < _view.stoneNumber * _unitPrice)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ConsortiaShopItem.badgebuzu"));
               return;
            }
         }
         if(_recordLastBuyCount)
         {
            SharedManager.Instance.lastBuyCount = _view.stoneNumber;
         }
         if(_view.ItemID == 11233)
         {
            SocketManager.Instance.out.sendQuickBuyGoldBox(_view.stoneNumber,_view.isBand);
         }
         else
         {
            items = [];
            types = [];
            colors = [];
            dresses = [];
            skins = [];
            places = [];
            bands = [];
            for(i = 0; i < _view.stoneNumber; )
            {
               items.push(_shopItemInfo.GoodsID);
               types.push(_view.time);
               colors.push("");
               dresses.push(false);
               skins.push("");
               places.push(-1);
               bands.push(_view.isBand);
               i++;
            }
            SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,skins,_buyFrom,null,bands);
         }
         dispatchEvent(new ShortcutBuyEvent(_view._itemID,_view.stoneNumber));
         var itemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_view._itemID);
         if(itemInfo.CategoryID == 11)
         {
            if(itemInfo.TemplateID == 100100)
            {
               PlayerManager.Instance.dispatchEvent(new BagEvent("gemstone_buy_count",null));
            }
            else if(!(itemInfo.TemplateID == 112150 || itemInfo.TemplateID == 11233))
            {
               PlayerManager.Instance.dispatchEvent(new BagEvent("quickBugCards",null));
            }
         }
         dispose();
      }
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            cancelMoney();
            ObjectUtils.disposeObject(this);
         }
         else if(e.responseCode == 2)
         {
            doPay(null);
         }
      }
      
      private function _responseI(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 3)
         {
            doMoney();
         }
         else
         {
            cancelMoney();
         }
         ObjectUtils.disposeObject(e.target);
      }
      
      private function doMoney() : void
      {
         LeavePageManager.leaveToFillPath();
         dispatchEvent(new ShortcutBuyEvent(0,0,false,false,"shortcutBuyMoneyOk"));
      }
      
      private function cancelMoney() : void
      {
         dispatchEvent(new ShortcutBuyEvent(0,0,false,false,"shortcutBuyMoneyCancel"));
      }
      
      public function set buyFrom(value:int) : void
      {
         _buyFrom = value;
      }
      
      public function get buyFrom() : int
      {
         return _buyFrom;
      }
      
      override public function dispose() : void
      {
         _recordLastBuyCount = false;
         canDispose = false;
         super.dispose();
         removeEvnets();
         _view = null;
         _shopItemInfo = null;
         if(_submitButton)
         {
            ObjectUtils.disposeObject(_submitButton);
         }
         _submitButton = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
