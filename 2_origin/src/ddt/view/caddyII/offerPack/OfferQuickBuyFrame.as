package ddt.view.caddyII.offerPack
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.NumberSelecter;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class OfferQuickBuyFrame extends BaseAlerFrame
   {
       
      
      private var _list:HBox;
      
      private var _cellItems:Vector.<OfferQuickCell>;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _selectNumber:NumberSelecter;
      
      private var _itemGroup:SelectedButtonGroup;
      
      private var _money:int;
      
      private var _select:int = -1;
      
      private var _selectCell:OfferQuickCell;
      
      private var _shopInfoList:Vector.<ShopItemInfo>;
      
      private var _itemTempLateID:Array;
      
      public function OfferQuickBuyFrame()
      {
         _shopInfoList = new Vector.<ShopItemInfo>();
         _itemTempLateID = [11252,11257,11258,11259,11260];
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creatComponentByStylename("offer.quickBox");
         _selectNumber = ComponentFactory.Instance.creatCustomObject("offer.numberSelecter");
         var _tipsTextBg:Image = ComponentFactory.Instance.creatComponentByStylename("offer.TipsTextBg");
         var _totalTipText:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("offer.TotalTipsText");
         _totalTipText.text = LanguageMgr.GetTranslation("ddt.QuickFrame.TotalTipText");
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("offer.TotalText");
         _itemGroup = new SelectedButtonGroup();
         addToContent(_moneyTxt);
         addToContent(_selectNumber);
         addToContent(_tipsTextBg);
         addToContent(_totalTipText);
         addToContent(_moneyTxt);
         createCell();
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_response);
         _selectNumber.addEventListener("change",_numberChange);
         _selectNumber.addEventListener("number_close",_numberClose);
         _selectNumber.addEventListener("number_enter",_numberEnter);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
         _selectNumber.removeEventListener("change",_numberChange);
         _selectNumber.removeEventListener("number_close",_numberClose);
         _selectNumber.removeEventListener("number_enter",_numberEnter);
      }
      
      public function set offShopList(pValue:Vector.<ShopItemInfo>) : void
      {
         _shopInfoList = pValue;
      }
      
      public function get offShopList() : Vector.<ShopItemInfo>
      {
         return _shopInfoList;
      }
      
      private function createCell() : void
      {
         var i:int = 0;
         var cell:* = null;
         _list.beginChanges();
         for(i = 0; i < _itemTempLateID.length; )
         {
            cell = new OfferQuickCell();
            cell.info = ItemManager.Instance.getTemplateById(_itemTempLateID[i]);
            cell.addEventListener("click",_itemClick);
            _itemGroup.addSelectItem(cell);
            _list.addChild(cell);
            i++;
         }
         _list.commitChanges();
      }
      
      private function removeListChildEvent() : void
      {
         var i:int = 0;
         for(i = 0; i < _list.numChildren; )
         {
            _list.getChildAt(i).removeEventListener("click",_itemClick);
            i++;
         }
      }
      
      private function _numberChange(e:Event) : void
      {
         money = _selectNumber.number * _shopInfoList[select].getItemPrice(1).gesteValue;
      }
      
      private function _numberClose(e:Event) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      private function _numberEnter(e:Event) : void
      {
         buy();
         ObjectUtils.disposeObject(this);
      }
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            buy();
         }
         ObjectUtils.disposeObject(this);
      }
      
      private function _itemClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _selectCell = e.currentTarget as OfferQuickCell;
         select = _list.getChildIndex(_selectCell);
         _selectNumber.number = 1;
      }
      
      private function buy() : void
      {
         var i:int = 0;
         if(PlayerManager.Instance.Self.ConsortiaID == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.offer.noConsortia"));
            return;
         }
         if(PlayerManager.Instance.Self.consortiaInfo.ShopLevel < _shopInfoList[select].ShopID - 10)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.consortiashop.ConsortiaShopItem.checkMoney"));
            return;
         }
         if(PlayerManager.Instance.Self.Offer < _shopInfoList[select].getItemPrice(1).gesteValue)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.offer.noOffer"));
            return;
         }
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var dresses:Array = [];
         var skins:Array = [];
         var places:Array = [];
         for(i = 0; i < _selectNumber.number; )
         {
            items.push(_shopInfoList[select].GoodsID);
            types.push(1);
            colors.push("");
            dresses.push(false);
            skins.push("");
            places.push(-1);
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
      
      public function set money(value:int) : void
      {
         _money = value;
         _moneyTxt.text = String(_money) + " " + LanguageMgr.GetTranslation("offer");
      }
      
      public function get money() : int
      {
         return _money;
      }
      
      public function set select(value:int) : void
      {
         if(_select == value)
         {
            return;
         }
         _select = value;
         _itemGroup.selectIndex = _select;
         _numberChange(null);
      }
      
      public function get select() : int
      {
         return _select;
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
         select = number;
      }
      
      override public function dispose() : void
      {
         removeListChildEvent();
         removeEvents();
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
         if(_selectNumber)
         {
            ObjectUtils.disposeObject(_selectNumber);
         }
         _selectNumber = null;
         if(_selectCell)
         {
            ObjectUtils.disposeObject(_selectCell);
         }
         _selectCell = null;
         if(_itemGroup)
         {
            ObjectUtils.disposeObject(_itemGroup);
         }
         _itemGroup = null;
         var _loc3_:int = 0;
         var _loc2_:* = _cellItems;
         for each(var cell in _cellItems)
         {
            ObjectUtils.disposeObject(cell);
         }
         _cellItems = null;
         _shopInfoList = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
