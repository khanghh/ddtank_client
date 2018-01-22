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
         var _loc1_:Image = ComponentFactory.Instance.creatComponentByStylename("offer.TipsTextBg");
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("offer.TotalTipsText");
         _loc2_.text = LanguageMgr.GetTranslation("ddt.QuickFrame.TotalTipText");
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("offer.TotalText");
         _itemGroup = new SelectedButtonGroup();
         addToContent(_moneyTxt);
         addToContent(_selectNumber);
         addToContent(_loc1_);
         addToContent(_loc2_);
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
      
      public function set offShopList(param1:Vector.<ShopItemInfo>) : void
      {
         _shopInfoList = param1;
      }
      
      public function get offShopList() : Vector.<ShopItemInfo>
      {
         return _shopInfoList;
      }
      
      private function createCell() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _list.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < _itemTempLateID.length)
         {
            _loc1_ = new OfferQuickCell();
            _loc1_.info = ItemManager.Instance.getTemplateById(_itemTempLateID[_loc2_]);
            _loc1_.addEventListener("click",_itemClick);
            _itemGroup.addSelectItem(_loc1_);
            _list.addChild(_loc1_);
            _loc2_++;
         }
         _list.commitChanges();
      }
      
      private function removeListChildEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _list.numChildren)
         {
            _list.getChildAt(_loc1_).removeEventListener("click",_itemClick);
            _loc1_++;
         }
      }
      
      private function _numberChange(param1:Event) : void
      {
         money = _selectNumber.number * _shopInfoList[select].getItemPrice(1).gesteValue;
      }
      
      private function _numberClose(param1:Event) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      private function _numberEnter(param1:Event) : void
      {
         buy();
         ObjectUtils.disposeObject(this);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            buy();
         }
         ObjectUtils.disposeObject(this);
      }
      
      private function _itemClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _selectCell = param1.currentTarget as OfferQuickCell;
         select = _list.getChildIndex(_selectCell);
         _selectNumber.number = 1;
      }
      
      private function buy() : void
      {
         var _loc7_:int = 0;
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
         var _loc1_:Array = [];
         var _loc5_:Array = [];
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc6_:Array = [];
         var _loc4_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _selectNumber.number)
         {
            _loc1_.push(_shopInfoList[select].GoodsID);
            _loc5_.push(1);
            _loc2_.push("");
            _loc3_.push(false);
            _loc6_.push("");
            _loc4_.push(-1);
            _loc7_++;
         }
         SocketManager.Instance.out.sendBuyGoods(_loc1_,_loc5_,_loc2_,_loc4_,_loc3_,_loc6_,0);
      }
      
      private function _responseI(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(param1.target);
      }
      
      public function set money(param1:int) : void
      {
         _money = param1;
         _moneyTxt.text = String(_money) + " " + LanguageMgr.GetTranslation("offer");
      }
      
      public function get money() : int
      {
         return _money;
      }
      
      public function set select(param1:int) : void
      {
         if(_select == param1)
         {
            return;
         }
         _select = param1;
         _itemGroup.selectIndex = _select;
         _numberChange(null);
      }
      
      public function get select() : int
      {
         return _select;
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
         select = param1;
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
         for each(var _loc1_ in _cellItems)
         {
            ObjectUtils.disposeObject(_loc1_);
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
