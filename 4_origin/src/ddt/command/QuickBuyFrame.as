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
      
      private function _numberClose(param1:Event) : void
      {
         cancelMoney();
         ObjectUtils.disposeObject(this);
      }
      
      private function _numberEnter(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         doPay(null);
      }
      
      public function setTitleText(param1:String) : void
      {
         titleText = param1;
      }
      
      public function hideSelectedBand() : void
      {
         _view.hideSelectedBand();
      }
      
      public function set itemID(param1:int) : void
      {
         _view.ItemID = param1;
         _shopItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(_view._itemID);
         perPrice();
      }
      
      public function setIsStoneExploreView(param1:Boolean) : void
      {
         _flag = param1;
      }
      
      public function setItemID(param1:int, param2:int, param3:int = 1) : void
      {
         _view.setItemID(param1,param2,param3);
         _shopItemInfo = ShopManager.Instance.getShopItemByTemplateID(_view._itemID,param2);
         if(param2 == 1)
         {
            _unitPrice = _shopItemInfo.getItemPrice(1).hardCurrencyValue;
         }
         else if(param2 == 2)
         {
            _unitPrice = _shopItemInfo.getItemPrice(1).gesteValue;
         }
         else if(param2 == 3)
         {
            _unitPrice = _shopItemInfo.getItemPrice(param3).bothMoneyValue;
         }
         else if(param2 == 6)
         {
            _unitPrice = _shopItemInfo.getItemPrice(param3).badgeValue;
         }
      }
      
      public function set stoneNumber(param1:int) : void
      {
         _view.stoneNumber = param1;
      }
      
      public function set maxLimit(param1:int) : void
      {
         _view.maxLimit = param1;
      }
      
      protected function perPrice() : void
      {
         var _loc1_:ShopItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(_view.ItemID);
         if(_loc1_)
         {
            _unitPrice = _loc1_.getItemPrice(1).bothMoneyValue;
         }
         else
         {
            _unitPrice = 0;
         }
      }
      
      public function set recordLastBuyCount(param1:Boolean) : void
      {
         _recordLastBuyCount = param1;
         if(_recordLastBuyCount)
         {
            _view.stoneNumber = SharedManager.Instance.lastBuyCount;
         }
      }
      
      protected function doPay(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc9_:* = null;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc10_:int = 0;
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
            _loc3_ = [];
            _loc8_ = [];
            _loc4_ = [];
            _loc5_ = [];
            _loc9_ = [];
            _loc7_ = [];
            _loc2_ = [];
            _loc10_ = 0;
            while(_loc10_ < _view.stoneNumber)
            {
               _loc3_.push(_shopItemInfo.GoodsID);
               _loc8_.push(_view.time);
               _loc4_.push("");
               _loc5_.push(false);
               _loc9_.push("");
               _loc7_.push(-1);
               _loc2_.push(_view.isBand);
               _loc10_++;
            }
            SocketManager.Instance.out.sendBuyGoods(_loc3_,_loc8_,_loc4_,_loc7_,_loc5_,_loc9_,_buyFrom,null,_loc2_);
         }
         dispatchEvent(new ShortcutBuyEvent(_view._itemID,_view.stoneNumber));
         var _loc6_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_view._itemID);
         if(_loc6_.CategoryID == 11)
         {
            if(_loc6_.TemplateID == 100100)
            {
               PlayerManager.Instance.dispatchEvent(new BagEvent("gemstone_buy_count",null));
            }
            else if(!(_loc6_.TemplateID == 112150 || _loc6_.TemplateID == 11233))
            {
               PlayerManager.Instance.dispatchEvent(new BagEvent("quickBugCards",null));
            }
         }
         dispose();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            cancelMoney();
            ObjectUtils.disposeObject(this);
         }
         else if(param1.responseCode == 2)
         {
            doPay(null);
         }
      }
      
      private function _responseI(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 3)
         {
            doMoney();
         }
         else
         {
            cancelMoney();
         }
         ObjectUtils.disposeObject(param1.target);
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
      
      public function set buyFrom(param1:int) : void
      {
         _buyFrom = param1;
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
