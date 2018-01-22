package ddt.view.caddyII.bead
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuickBuyBead extends BaseAlerFrame
   {
       
      
      private var _list:HBox;
      
      private var _cellItems:Vector.<QuickBuyItem>;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _money:int;
      
      private var _clickNumber:int;
      
      private var _cellId:Array;
      
      private var _selectedItem:QuickBuyItem;
      
      public function QuickBuyBead()
      {
         _cellId = [311500,312500,313500];
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creatComponentByStylename("bead.quickBox");
         var _loc2_:Image = ComponentFactory.Instance.creatComponentByStylename("bead.quickFont1");
         var _loc1_:Image = ComponentFactory.Instance.creatComponentByStylename("bead.quickFont2");
         var _loc3_:Image = ComponentFactory.Instance.creatComponentByStylename("bead.quickMoneyBG");
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("bead.moneyTxt");
         addToContent(_loc2_);
         addToContent(_loc1_);
         addToContent(_loc3_);
         addToContent(_moneyTxt);
         creatCell();
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_response);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
         var _loc3_:int = 0;
         var _loc2_:* = _cellItems;
         for each(var _loc1_ in _cellItems)
         {
            _loc1_.removeEventListener("change",_numberChange);
            _loc1_.removeEventListener("click",__itemClick);
            _loc1_.removeEventListener("number_close",_numberClose);
            _loc1_.removeEventListener("number_enter",_numberEnter);
         }
      }
      
      private function creatCell() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cellItems = new Vector.<QuickBuyItem>();
         _list.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < _cellId.length)
         {
            _loc1_ = new QuickBuyItem();
            _loc1_.itemID = _cellId[_loc2_];
            _loc1_.addEventListener("change",_numberChange);
            _loc1_.addEventListener("click",__itemClick);
            _loc1_.addEventListener("number_close",_numberClose);
            _loc1_.addEventListener("number_enter",_numberEnter);
            _list.addChild(_loc1_);
            _cellItems.push(_loc1_);
            _loc2_++;
         }
         _list.commitChanges();
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:QuickBuyItem = param1.currentTarget as QuickBuyItem;
         selectedItem = _loc2_;
      }
      
      private function _response(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(money > 0)
            {
               if(PlayerManager.Instance.Self.Money < money)
               {
                  ObjectUtils.disposeObject(this);
                  _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
                  _loc2_.moveEnable = false;
                  _loc2_.addEventListener("response",_responseI);
                  return;
               }
               buy();
               ObjectUtils.disposeObject(this);
            }
            else
            {
               _showTip();
            }
         }
         else
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      private function _numberChange(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _cellItems;
         for each(var _loc3_ in _cellItems)
         {
            _loc4_ = _loc4_ + _loc3_.count * ShopManager.Instance.getMoneyShopItemByTemplateID(_loc3_.info.TemplateID).getItemPrice(1).bothMoneyValue;
         }
         money = _loc4_;
         var _loc2_:QuickBuyItem = param1.currentTarget as QuickBuyItem;
         selectedItem = _loc2_;
      }
      
      private function _numberClose(param1:Event) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      private function _numberEnter(param1:Event) : void
      {
         if(money > 0)
         {
            buy();
            ObjectUtils.disposeObject(this);
         }
         else
         {
            _showTip();
         }
      }
      
      private function buy() : void
      {
         var _loc8_:int = 0;
         var _loc1_:Array = [];
         var _loc6_:Array = [];
         var _loc2_:Array = [];
         var _loc4_:Array = [];
         var _loc7_:Array = [];
         var _loc5_:Array = [];
         var _loc10_:int = 0;
         var _loc9_:* = _cellItems;
         for each(var _loc3_ in _cellItems)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc3_.count)
            {
               _loc1_.push(ShopManager.Instance.getMoneyShopItemByTemplateID(_loc3_.info.TemplateID).GoodsID);
               _loc6_.push(1);
               _loc2_.push("");
               _loc4_.push(false);
               _loc7_.push("");
               _loc5_.push(-1);
               _loc8_++;
            }
         }
         SocketManager.Instance.out.sendBuyGoods(_loc1_,_loc6_,_loc2_,_loc5_,_loc4_,_loc7_,5);
      }
      
      private function _responseI(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.showFillFrame();
         }
         ObjectUtils.disposeObject(param1.target);
      }
      
      private function _showTip() : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bead.quickNode"));
      }
      
      public function set money(param1:int) : void
      {
         _money = param1;
         _moneyTxt.text = String(_money);
      }
      
      public function get money() : int
      {
         return _money;
      }
      
      public function set clickNumber(param1:int) : void
      {
         if(param1 >= 0)
         {
            _clickNumber = param1;
            _cellItems[_clickNumber].count = 1;
            _cellItems[_clickNumber].setFocus();
         }
      }
      
      public function show(param1:int) : void
      {
         var _loc2_:AlertInfo = new AlertInfo();
         _loc2_.title = LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy");
         _loc2_.data = _list;
         _loc2_.submitLabel = LanguageMgr.GetTranslation("store.view.shortcutBuy.buyBtn");
         _loc2_.showCancel = false;
         _loc2_.moveEnable = false;
         info = _loc2_;
         addToContent(_list);
         LayerManager.Instance.addToLayer(this,2,true,1);
         clickNumber = param1;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         var _loc3_:int = 0;
         var _loc2_:* = _cellItems;
         for each(var _loc1_ in _cellItems)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _cellItems = null;
         _cellId = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_moneyTxt)
         {
            ObjectUtils.disposeObject(_moneyTxt);
         }
         _moneyTxt = null;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get selectedItem() : QuickBuyItem
      {
         return _selectedItem;
      }
      
      public function set selectedItem(param1:QuickBuyItem) : void
      {
         var _loc2_:QuickBuyItem = _selectedItem;
         _selectedItem = param1;
         _selectedItem.selected = true;
         if(_loc2_ && _selectedItem != _loc2_)
         {
            _loc2_.selected = false;
         }
      }
   }
}
