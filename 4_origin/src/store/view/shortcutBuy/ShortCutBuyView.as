package store.view.shortcutBuy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemPrice;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ShortCutBuyView extends Sprite implements Disposeable
   {
      
      public static const ADD_NUMBER_Y:int = 40;
      
      public static const ADD_TOTALTEXT_Y:int = 20;
       
      
      private var _templateItemIDList:Array;
      
      private var _moneySelectBtn:SelectedCheckButton;
      
      private var _giftSelectBtn:SelectedCheckButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _list:ShortcutBuyList;
      
      private var _num:NumberSelecter;
      
      private var priceStr:String;
      
      private var totalText:FilterFrameText;
      
      private var totalTextBg:Image;
      
      private var msg:FilterFrameText;
      
      private var bg:MutipleImage;
      
      private var _showRadioBtn:Boolean = true;
      
      private var _memoryItemID:int;
      
      private var _firstShow:Boolean = true;
      
      private var _selecetMoney:SelectedCheckButton;
      
      private var _selecetBandMoney:SelectedCheckButton;
      
      private var _isBand:Boolean;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _bandMoneyTxt:FilterFrameText;
      
      public function ShortCutBuyView(param1:Array, param2:Boolean)
      {
         super();
         _templateItemIDList = param1;
         _showRadioBtn = param2;
         init();
         initEvents();
      }
      
      private function init() : void
      {
         bg = ComponentFactory.Instance.creatComponentByStylename("store.ShortCutViewBG");
         addChild(bg);
         _moneySelectBtn = ComponentFactory.Instance.creatComponentByStylename("store.MoneySelectBtn");
         addChild(_moneySelectBtn);
         _giftSelectBtn = ComponentFactory.Instance.creatComponentByStylename("store.GiftSelectBtn");
         addChild(_giftSelectBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_moneySelectBtn);
         _btnGroup.addSelectItem(_giftSelectBtn);
         _btnGroup.selectIndex = 0;
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("vip.core.bandMoney");
         _moneyTxt.x = 62;
         _moneyTxt.y = 199;
         _moneyTxt.text = LanguageMgr.GetTranslation("money");
         addChild(_moneyTxt);
         _bandMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("vip.core.bandMoney");
         _bandMoneyTxt.x = 221;
         _bandMoneyTxt.y = 199;
         _bandMoneyTxt.text = LanguageMgr.GetTranslation("ddtMoney");
         addChild(_bandMoneyTxt);
         _selecetMoney = ComponentFactory.Instance.creatComponentByStylename("com.quickBuyFrame.selectBtn");
         _selecetMoney.selected = true;
         _selecetMoney.enable = false;
         _selecetMoney.x = 94;
         _selecetMoney.y = 190;
         _selecetMoney.addEventListener("click",selecetedHander);
         addChild(_selecetMoney);
         _isBand = false;
         _selecetBandMoney = ComponentFactory.Instance.creatComponentByStylename("com.ShortCutBuyView.selectbandBtn");
         _selecetBandMoney.addEventListener("click",selectedBandHander);
         addChild(_selecetBandMoney);
         var _loc2_:* = _showRadioBtn;
         _giftSelectBtn.visible = _loc2_;
         _loc2_ = _loc2_;
         _moneySelectBtn.visible = _loc2_;
         bg.visible = _loc2_;
         _list = ComponentFactory.Instance.creatCustomObject("ddtstore.ShortcutBuyList");
         _list.setup(_templateItemIDList);
         _memoryItemID = SharedManager.Instance.StoreBuyInfo[PlayerManager.Instance.Self.ID.toString()];
         var _loc1_:ShopItemInfo = ShopManager.Instance.getShopItemByGoodsID(_memoryItemID);
         if(_loc1_ && _templateItemIDList.indexOf(_loc1_.TemplateID) > -1)
         {
            _list.selectedItemID = _loc1_.TemplateID;
         }
         else
         {
            _list.selectedItemID = _templateItemIDList[0];
         }
         if(_loc1_ && _loc1_.getItemPrice(1).IsBandDDTMoneyType && _templateItemIDList.indexOf(_loc1_.TemplateID) > -1)
         {
            _btnGroup.selectIndex = 1;
         }
         addChild(_list);
         _num = ComponentFactory.Instance.creatComponentByStylename("ddtstore.ShortcutBuyFrame.AmountNumberSelecter");
         _num.y = _list.y + _list.height + 40;
         addChild(_num);
         totalTextBg = ComponentFactory.Instance.creatComponentByStylename("ddstore.ShortcutBuyFrame.TipsTextBg");
         addChild(totalTextBg);
         msg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.ShortcutBuyFrame.TipsText");
         msg.text = LanguageMgr.GetTranslation("store.ShortcutBuyFrame.TotalCostTipText");
         addChild(msg);
         totalText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.ShortcutBuyFrame.TotalText");
         totalText.y = _num.y + _num.height + 20;
         msg.y = totalText.y;
         addChild(totalText);
         updateCost();
      }
      
      protected function selectedBandHander(param1:MouseEvent) : void
      {
         if(_selecetBandMoney.selected)
         {
            _isBand = true;
            _selecetBandMoney.enable = false;
            _selecetMoney.selected = false;
            _selecetMoney.enable = true;
         }
         else
         {
            _isBand = false;
         }
         updateCost();
      }
      
      protected function selecetedHander(param1:MouseEvent) : void
      {
         if(_selecetMoney.selected)
         {
            _isBand = false;
            _selecetBandMoney.selected = false;
            _selecetBandMoney.enable = true;
            _selecetMoney.enable = false;
         }
         else
         {
            _isBand = true;
         }
         updateCost();
      }
      
      private function initEvents() : void
      {
         _list.addEventListener("select",selectHandler);
         _moneySelectBtn.addEventListener("select",selectHandler);
         _moneySelectBtn.addEventListener("click",clickHandlerDian);
         _giftSelectBtn.addEventListener("select",selectHandler);
         _giftSelectBtn.addEventListener("click",clickHandlerLi);
         _num.addEventListener("change",selectHandler);
      }
      
      private function removeEvents() : void
      {
         _list.removeEventListener("select",selectHandler);
         _moneySelectBtn.removeEventListener("select",selectHandler);
         _moneySelectBtn.removeEventListener("click",clickHandlerDian);
         _giftSelectBtn.removeEventListener("select",selectHandler);
         _giftSelectBtn.removeEventListener("click",clickHandlerLi);
         _num.removeEventListener("change",selectHandler);
      }
      
      public function get isBand() : Boolean
      {
         return _isBand;
      }
      
      private function _numberClose(param1:Event) : void
      {
         dispatchEvent(param1);
      }
      
      private function clickHandlerDian(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_isBand)
         {
            priceStr = "0 " + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.bandStipple");
         }
         else
         {
            priceStr = "0 " + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.stipple");
         }
         _firstShow = false;
         updateCost();
      }
      
      private function clickHandlerLi(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         priceStr = "0" + LanguageMgr.GetTranslation("tank.gameover.takecard.gifttoken");
         _firstShow = false;
         updateCost();
      }
      
      private function selectHandler(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         updateCost();
         dispatchEvent(new Event("change"));
      }
      
      private function updateCost() : void
      {
         if(_firstShow)
         {
            priceStr = "0" + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.stipple");
         }
         if(currentShopItem != null)
         {
            priceStr = totalPrice.toString(_isBand);
         }
         totalText.text = priceStr;
      }
      
      public function get List() : ShortcutBuyList
      {
         return _list;
      }
      
      public function get currentShopItem() : ShopItemInfo
      {
         var _loc1_:* = null;
         if(_moneySelectBtn.selected)
         {
            _loc1_ = ShopManager.Instance.getMoneyShopItemByTemplateID(_list.selectedItemID);
         }
         else
         {
            _loc1_ = ShopManager.Instance.getGiftShopItemByTemplateID(_list.selectedItemID);
         }
         return _loc1_;
      }
      
      public function get currentNum() : int
      {
         return _num.currentValue;
      }
      
      public function get totalPrice() : ItemPrice
      {
         var _loc1_:ItemPrice = new ItemPrice(null,null,null);
         if(currentShopItem && _num.currentValue > 0)
         {
            _loc1_ = currentShopItem.getItemPrice(1).multiply(_num.currentValue);
         }
         return _loc1_;
      }
      
      public function get totalMoney() : int
      {
         return totalPrice.bothMoneyValue;
      }
      
      public function get totalDDTMoney() : int
      {
         return totalPrice.ddtMoneyValue;
      }
      
      public function get totalNum() : int
      {
         return _num.currentValue;
      }
      
      public function save() : void
      {
         SharedManager.Instance.StoreBuyInfo[PlayerManager.Instance.Self.ID] = currentShopItem.GoodsID;
         SharedManager.Instance.save();
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_moneySelectBtn)
         {
            ObjectUtils.disposeObject(_moneySelectBtn);
         }
         _moneySelectBtn = null;
         if(_giftSelectBtn)
         {
            ObjectUtils.disposeObject(_giftSelectBtn);
         }
         _giftSelectBtn = null;
         if(_btnGroup)
         {
            ObjectUtils.disposeObject(_btnGroup);
         }
         _btnGroup = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_num)
         {
            ObjectUtils.disposeObject(_num);
         }
         _num = null;
         if(totalText)
         {
            ObjectUtils.disposeObject(totalText);
         }
         totalText = null;
         if(bg)
         {
            ObjectUtils.disposeObject(bg);
         }
         bg = null;
         if(totalTextBg)
         {
            ObjectUtils.disposeObject(totalTextBg);
         }
         totalTextBg = null;
         if(msg)
         {
            ObjectUtils.disposeObject(msg);
         }
         msg = null;
         _templateItemIDList = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
