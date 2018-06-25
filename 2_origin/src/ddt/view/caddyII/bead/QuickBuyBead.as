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
         var font1:Image = ComponentFactory.Instance.creatComponentByStylename("bead.quickFont1");
         var font2:Image = ComponentFactory.Instance.creatComponentByStylename("bead.quickFont2");
         var moneyBG:Image = ComponentFactory.Instance.creatComponentByStylename("bead.quickMoneyBG");
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("bead.moneyTxt");
         addToContent(font1);
         addToContent(font2);
         addToContent(moneyBG);
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
         for each(var item in _cellItems)
         {
            item.removeEventListener("change",_numberChange);
            item.removeEventListener("click",__itemClick);
            item.removeEventListener("number_close",_numberClose);
            item.removeEventListener("number_enter",_numberEnter);
         }
      }
      
      private function creatCell() : void
      {
         var i:int = 0;
         var item:* = null;
         _cellItems = new Vector.<QuickBuyItem>();
         _list.beginChanges();
         for(i = 0; i < _cellId.length; )
         {
            item = new QuickBuyItem();
            item.itemID = _cellId[i];
            item.addEventListener("change",_numberChange);
            item.addEventListener("click",__itemClick);
            item.addEventListener("number_close",_numberClose);
            item.addEventListener("number_enter",_numberEnter);
            _list.addChild(item);
            _cellItems.push(item);
            i++;
         }
         _list.commitChanges();
      }
      
      private function __itemClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var item:QuickBuyItem = evt.currentTarget as QuickBuyItem;
         selectedItem = item;
      }
      
      private function _response(e:FrameEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.play("008");
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            if(money > 0)
            {
               if(PlayerManager.Instance.Self.Money < money)
               {
                  ObjectUtils.disposeObject(this);
                  alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
                  alert.moveEnable = false;
                  alert.addEventListener("response",_responseI);
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
      
      private function _numberChange(e:Event) : void
      {
         var sum:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _cellItems;
         for each(var item in _cellItems)
         {
            sum = sum + item.count * ShopManager.Instance.getMoneyShopItemByTemplateID(item.info.TemplateID).getItemPrice(1).bothMoneyValue;
         }
         money = sum;
         var targetItem:QuickBuyItem = e.currentTarget as QuickBuyItem;
         selectedItem = targetItem;
      }
      
      private function _numberClose(e:Event) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      private function _numberEnter(e:Event) : void
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
         var i:int = 0;
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var dresses:Array = [];
         var skins:Array = [];
         var places:Array = [];
         var _loc10_:int = 0;
         var _loc9_:* = _cellItems;
         for each(var item in _cellItems)
         {
            for(i = 0; i < item.count; )
            {
               items.push(ShopManager.Instance.getMoneyShopItemByTemplateID(item.info.TemplateID).GoodsID);
               types.push(1);
               colors.push("");
               dresses.push(false);
               skins.push("");
               places.push(-1);
               i++;
            }
         }
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,skins,5);
      }
      
      private function _responseI(e:FrameEvent) : void
      {
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            LeavePageManager.showFillFrame();
         }
         ObjectUtils.disposeObject(e.target);
      }
      
      private function _showTip() : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bead.quickNode"));
      }
      
      public function set money(value:int) : void
      {
         _money = value;
         _moneyTxt.text = String(_money);
      }
      
      public function get money() : int
      {
         return _money;
      }
      
      public function set clickNumber(value:int) : void
      {
         if(value >= 0)
         {
            _clickNumber = value;
            _cellItems[_clickNumber].count = 1;
            _cellItems[_clickNumber].setFocus();
         }
      }
      
      public function show(number:int) : void
      {
         var alertInfo:AlertInfo = new AlertInfo();
         alertInfo.title = LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy");
         alertInfo.data = _list;
         alertInfo.submitLabel = LanguageMgr.GetTranslation("store.view.shortcutBuy.buyBtn");
         alertInfo.showCancel = false;
         alertInfo.moveEnable = false;
         info = alertInfo;
         addToContent(_list);
         LayerManager.Instance.addToLayer(this,2,true,1);
         clickNumber = number;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         var _loc3_:int = 0;
         var _loc2_:* = _cellItems;
         for each(var item in _cellItems)
         {
            ObjectUtils.disposeObject(item);
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
      
      public function set selectedItem(val:QuickBuyItem) : void
      {
         var selectedItem:QuickBuyItem = _selectedItem;
         _selectedItem = val;
         _selectedItem.selected = true;
         if(selectedItem && _selectedItem != selectedItem)
         {
            selectedItem.selected = false;
         }
      }
   }
}
