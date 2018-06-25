package DDPlay
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
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.caddyII.bead.QuickBuyItem;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class DDPlayQuickBuy extends BaseAlerFrame
   {
      
      public static const DDPLAY_COIN_NUMBER:int = 0;
      
      public static const CADDY_NUMBER:int = 1;
       
      
      private var _list:HBox;
      
      private var _cellItems:Vector.<QuickBuyItem>;
      
      private var _shopItemInfoList:Vector.<ShopItemInfo>;
      
      private var _money:int;
      
      private var _gift:int;
      
      private var _clickNumber:int;
      
      private var _cellId:Array;
      
      private var _selectedItem:QuickBuyItem;
      
      private var _font2:FilterFrameText;
      
      public function DDPlayQuickBuy()
      {
         _cellId = [201310];
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creatComponentByStylename("DDPlay.quickBox");
         PositionUtils.setPos(_list,"DDPlay.quickBuy.listPos");
         var font1:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("asset.medicineQuickBugText1");
         _font2 = ComponentFactory.Instance.creatComponentByStylename("asset.medicineQuickBugText2");
         var moneyBG:Image = ComponentFactory.Instance.creat("asset.medicineQuickBugTextBg");
         font1.text = LanguageMgr.GetTranslation("tank.ddPlay.quickBuy.totalPay");
         _font2.text = LanguageMgr.GetTranslation("money");
         PositionUtils.setPos(font1,"DDPlay.quickBuy.font1Pos");
         PositionUtils.setPos(_font2,"DDPlay.quickBuy.font2Pos");
         PositionUtils.setPos(moneyBG,"DDPlay.quickBuy.moneybgPos");
         addToContent(moneyBG);
         addToContent(font1);
         addToContent(_font2);
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
         _shopItemInfoList = new Vector.<ShopItemInfo>();
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
         _shopItemInfoList.push(ShopManager.Instance.getMoneyShopItemByTemplateID(_cellId[0]));
         _shopItemInfoList.push(ShopManager.Instance.getGiftShopItemByTemplateID(_cellId[1]));
         _cellItems[0].selectNumber.maximum = 50;
      }
      
      private function __itemClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var item:QuickBuyItem = evt.currentTarget as QuickBuyItem;
         selectedItem = item;
      }
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            if(money > 0 || gift > 0)
            {
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
         money = _cellItems[0].count * _shopItemInfoList[0].getItemPrice(1).bothMoneyValue;
         var item:QuickBuyItem = e.currentTarget as QuickBuyItem;
         selectedItem = item;
      }
      
      private function _numberClose(e:Event) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      private function _numberEnter(e:Event) : void
      {
         if(money > 0 || gift > 0)
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
         var alert:* = null;
         var i:int = 0;
         var j:int = 0;
         if(money > 0 && !_shopItemInfoList[0].isValid || gift > 0 && !_shopItemInfoList[1].isValid)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.quickDate"));
            return;
         }
         if(PlayerManager.Instance.Self.Money < money)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.moveEnable = false;
            alert.addEventListener("response",_responseI);
            return;
         }
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var dresses:Array = [];
         var skins:Array = [];
         var places:Array = [];
         for(i = 0; i < _cellItems.length; )
         {
            for(j = 0; j < _cellItems[i].count; )
            {
               items.push(_shopItemInfoList[i].GoodsID);
               types.push(1);
               colors.push("");
               dresses.push(false);
               skins.push("");
               places.push(-1);
               j++;
            }
            i++;
         }
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,skins,0);
      }
      
      private function _responseI(e:FrameEvent) : void
      {
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(e.target);
      }
      
      private function _showTip() : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bead.quickNoBuy"));
      }
      
      public function set money(value:int) : void
      {
         _money = value;
         _font2.text = value + LanguageMgr.GetTranslation("money");
      }
      
      public function get money() : int
      {
         return _money;
      }
      
      public function set gift(value:int) : void
      {
         _gift = value;
      }
      
      public function get gift() : int
      {
         return _gift;
      }
      
      public function set clickNumber(value:int) : void
      {
         _clickNumber = value;
         _cellItems[_clickNumber].count = 1;
         _cellItems[_clickNumber].setFocus();
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
         _shopItemInfoList = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
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
