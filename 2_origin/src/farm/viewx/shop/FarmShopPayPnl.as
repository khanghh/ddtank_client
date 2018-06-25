package farm.viewx.shop
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import shop.view.ShopItemCell;
   
   public class FarmShopPayPnl extends BaseAlerFrame
   {
      
      public static const GOLD:int = 1;
      
      public static const GIFT:int = 2;
      
      public static const MONEY:int = 3;
      
      private static const MaxNum:int = 50;
       
      
      private var _addBtn:BaseButton;
      
      private var _removeBtn:BaseButton;
      
      private var _alertTips:FilterFrameText;
      
      private var _payNumtxt:TextInput;
      
      private var _payNumBg:DisplayObject;
      
      private var _shopPayItem:ShopItemCell;
      
      private var _cellBg:DisplayObject;
      
      private var _goodsID:int;
      
      private var _payNum:int = 1;
      
      private var _alertTips2:FilterFrameText;
      
      private var _totalBg:Bitmap;
      
      private var _group:SelectedButtonGroup;
      
      private var _spendValue:int;
      
      private var _shopItemInfo:ShopItemInfo;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _bandMoneyTxt:FilterFrameText;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _back:MovieClip;
      
      private var _selectedXunzBtn:SelectedCheckButton;
      
      private var _isXun:Boolean;
      
      private var _xunZMoneyTxt:FilterFrameText;
      
      public function FarmShopPayPnl()
      {
         super();
         moveEnable = false;
         var alertInfo:AlertInfo = new AlertInfo();
         alertInfo.showCancel = false;
         alertInfo.submitLabel = LanguageMgr.GetTranslation("ddt.farms.shopPayButton");
         alertInfo.title = LanguageMgr.GetTranslation("ddt.farms.shopPayTitle");
         alertInfo.bottomGap = 33;
         this.info = alertInfo;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _payNumBg = ComponentFactory.Instance.creat("farm.shop.payPanelInputBg");
         addToContent(_payNumBg);
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("farm.shop.shopUpButton");
         addToContent(_addBtn);
         _removeBtn = ComponentFactory.Instance.creatComponentByStylename("farm.shop.shopDownButton");
         addToContent(_removeBtn);
         _totalBg = ComponentFactory.Instance.creatBitmap("assets.farmShop.payBg");
         addToContent(_totalBg);
         _alertTips = ComponentFactory.Instance.creatComponentByStylename("farm.text.shopPayAlertTips");
         addToContent(_alertTips);
         _alertTips2 = ComponentFactory.Instance.creatComponentByStylename("farm.text.shopPayAlertTips2");
         addToContent(_alertTips2);
         _payNumtxt = ComponentFactory.Instance.creatComponentByStylename("farm.text.shopPayNumInput");
         addToContent(_payNumtxt);
         _payNumtxt.textField.restrict = "0-9";
         _payNumtxt.text = "1";
         _payNum = 1;
         _cellBg = ComponentFactory.Instance.creat("asset.farm.baseImage5");
         PositionUtils.setPos(_cellBg,"farm.shopPayCell.point");
         addToContent(_cellBg);
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("Farm.bandMoney.Text1");
         _moneyTxt.text = LanguageMgr.GetTranslation("money");
         _moneyTxt.x = 56;
         _moneyTxt.y = 113;
         addToContent(_moneyTxt);
         _bandMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("Farm.bandMoney.Text2");
         _bandMoneyTxt.text = LanguageMgr.GetTranslation("ddtMoney");
         _bandMoneyTxt.x = 119;
         _bandMoneyTxt.y = 113;
         addToContent(_bandMoneyTxt);
         _xunZMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("Farm.bandMoney.Text2");
         _xunZMoneyTxt.text = LanguageMgr.GetTranslation("medalMoney");
         _xunZMoneyTxt.x = 224;
         _xunZMoneyTxt.y = 113;
         addToContent(_xunZMoneyTxt);
         _isBand = false;
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("com.frme.fresh.selectBtn");
         _selectedBtn.x = 29;
         _selectedBtn.y = 107;
         addToContent(_selectedBtn);
         _selectedBtn.enable = false;
         _selectedBtn.addEventListener("click",seletedHander);
         _selectedBandBtn = ComponentFactory.Instance.creatComponentByStylename("com.frme.fresh.selectbandBtn");
         _selectedBandBtn.x = 98;
         _selectedBandBtn.y = 107;
         addToContent(_selectedBandBtn);
         _selectedBandBtn.addEventListener("click",selectedBandHander);
         _selectedXunzBtn = ComponentFactory.Instance.creatComponentByStylename("com.frme.fresh.selectbandBtn");
         _selectedXunzBtn.x = 195;
         _selectedXunzBtn.y = 107;
         addToContent(_selectedXunzBtn);
         _selectedXunzBtn.addEventListener("click",selectedXunzHander);
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_selectedBandBtn);
         _group.addSelectItem(_selectedBtn);
         _alertTips.text = LanguageMgr.GetTranslation("ddt.farms.shopPayAlert");
      }
      
      protected function selectedBandHander(event:MouseEvent) : void
      {
         setSeleBtnFalse();
         _selectedBtn.enable = true;
         if(_isXun)
         {
            _selectedXunzBtn.selected = true;
         }
         _isBand = true;
      }
      
      private function selectedXunzHander(event:MouseEvent) : void
      {
         if(_selectedXunzBtn.selected)
         {
            _isXun = true;
         }
         else
         {
            _isXun = false;
         }
      }
      
      protected function seletedHander(event:MouseEvent) : void
      {
         setSeleBtnFalse();
         _selectedBandBtn.enable = true;
         if(_isXun)
         {
            _selectedXunzBtn.selected = true;
         }
         _isBand = false;
      }
      
      private function setSeleBtnFalse() : void
      {
         _selectedBandBtn.selected = false;
         _selectedBandBtn.enable = false;
         _selectedBtn.enable = false;
         _selectedBtn.selected = false;
         _selectedXunzBtn.selected = false;
         _selectedXunzBtn.enable = false;
      }
      
      public function set goodsID(value:int) : void
      {
         if(_shopPayItem)
         {
            _shopPayItem.dispose();
         }
         _goodsID = value;
         _shopItemInfo = ShopManager.Instance.getShopItemByGoodsID(_goodsID);
         if(!_shopItemInfo)
         {
            _shopItemInfo = ShopManager.Instance.getGoodsByTemplateID(_goodsID);
         }
         _shopPayItem = creatItemCell();
         PositionUtils.setPos(_shopPayItem,"farm.shopPayCell.point");
         _shopPayItem.cellSize = 50;
         _shopPayItem.info = _shopItemInfo.TemplateInfo;
         addToContent(_shopPayItem);
         _spendValue = _shopItemInfo.getItemPrice(1).ddtMoneyValue * _payNum;
         if(_spendValue > 0)
         {
            _selectedXunzBtn.enable = false;
            _selectedXunzBtn.selected = true;
            _isXun = true;
            _alertTips2.text = String(_spendValue) + " " + LanguageMgr.GetTranslation("medalMoney");
         }
         else
         {
            _selectedXunzBtn.enable = false;
            _isXun = false;
            applyGray(_selectedXunzBtn);
         }
         _spendValue = _shopItemInfo.getItemPrice(1).bothMoneyValue * _payNum;
         if(_spendValue > 0)
         {
            _selectedBtn.enable = true;
            _selectedBtn.selected = true;
            _spendValue = _shopItemInfo.getItemPrice(1).bothMoneyValue * _payNum;
            _alertTips2.text = String(_spendValue) + " " + LanguageMgr.GetTranslation("money");
         }
         else
         {
            _selectedBtn.enable = false;
            _selectedBtn.selected = false;
            applyGray(_selectedBtn);
         }
         _spendValue = _shopItemInfo.getItemPrice(1).bandDdtMoneyValue * _payNum;
         if(_spendValue > 0)
         {
            _selectedBandBtn.enable = true;
            _alertTips2.text = String(_spendValue) + " " + LanguageMgr.GetTranslation("ddtMoney");
         }
         else
         {
            _selectedBandBtn.enable = false;
            applyGray(_selectedBandBtn);
         }
      }
      
      private function applyGray(child:DisplayObject) : void
      {
         var matrix:Array = [];
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0,0,0,1,0]);
         applyFilter(child,matrix);
      }
      
      private function applyFilter(child:DisplayObject, matrix:Array) : void
      {
         var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
         var filters:Array = [];
         filters.push(filter);
         child.filters = filters;
      }
      
      private function alertMoney() : void
      {
         var alertTxt:String = "";
         if(_isXun)
         {
            _spendValue = _shopItemInfo.getItemPrice(1).ddtMoneyValue * _payNum;
            alertTxt = String(_spendValue) + LanguageMgr.GetTranslation("medalMoney");
         }
         else
         {
            _spendValue = _shopItemInfo.getItemPrice(1).bothMoneyValue * _payNum;
            if(_isBand)
            {
               alertTxt = String(_spendValue) + LanguageMgr.GetTranslation("ddtMoney");
            }
            else
            {
               alertTxt = String(_spendValue) + LanguageMgr.GetTranslation("money");
            }
         }
         _alertTips2.text = alertTxt;
      }
      
      protected function creatItemCell() : ShopItemCell
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,75,75);
         sp.graphics.endFill();
         return CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
      }
      
      private function initEvent() : void
      {
         _addBtn.addEventListener("click",__selectPayNum);
         _removeBtn.addEventListener("click",__selectPayNum);
         addEventListener("response",__framePesponse);
         _payNumtxt.addEventListener("change",__txtInputCheck);
         _group.addEventListener("change",__selectedChange);
      }
      
      private function removeEvent() : void
      {
         _selectedXunzBtn.removeEventListener("click",selectedXunzHander);
         _selectedBandBtn.removeEventListener("click",selectedBandHander);
         _selectedBtn.removeEventListener("click",seletedHander);
         _addBtn.removeEventListener("click",__selectPayNum);
         _removeBtn.removeEventListener("click",__selectPayNum);
         removeEventListener("response",__framePesponse);
         _payNumtxt.removeEventListener("change",__txtInputCheck);
         _group.removeEventListener("change",__selectedChange);
      }
      
      protected function __selectedChange(event:Event) : void
      {
         SoundManager.instance.play("008");
         alertMoney();
      }
      
      private function __txtInputCheck(e:Event) : void
      {
         _payNum = parseInt(_payNumtxt.text);
         checkInput();
         alertMoney();
      }
      
      private function checkInput() : void
      {
         if(_payNum <= 1)
         {
            _payNum = 1;
         }
         else if(_payNum > 50)
         {
            _payNum = 50;
         }
         _payNumtxt.text = _payNum.toString();
      }
      
      protected function __framePesponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
               if(_shopItemInfo)
               {
                  sendFarmShop();
               }
               dispose();
         }
      }
      
      private function sendFarmShop() : void
      {
         var alert:* = null;
         var items:* = null;
         var types:* = null;
         var colors:* = null;
         var dresses:* = null;
         var skins:* = null;
         var places:* = null;
         var bands:* = null;
         var i:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_isXun)
         {
            _spendValue = _shopItemInfo.getItemPrice(1).ddtMoneyValue * _payNum;
            if(PlayerManager.Instance.Self.DDTMoney < _spendValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.madelLack"));
               return;
            }
            items = [];
            types = [];
            colors = [];
            dresses = [];
            skins = [];
            places = [];
            bands = [];
            for(i = 0; i < _payNum; )
            {
               items.push(_shopItemInfo.GoodsID);
               types.push(1);
               colors.push("");
               dresses.push(false);
               skins.push("");
               places.push(-1);
               bands.push(_isBand);
               i++;
            }
            SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,skins,0,null,bands);
         }
         else
         {
            CheckMoneyUtils.instance.checkMoney(_isBand,_spendValue,onCheckComplete);
         }
      }
      
      protected function onCheckComplete() : void
      {
         var i:int = 0;
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var dresses:Array = [];
         var skins:Array = [];
         var places:Array = [];
         var bands:Array = [];
         for(i = 0; i < _payNum; )
         {
            items.push(_shopItemInfo.GoodsID);
            types.push(1);
            colors.push("");
            dresses.push(false);
            skins.push("");
            places.push(-1);
            bands.push(CheckMoneyUtils.instance.isBind);
            i++;
         }
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,skins,0,null,bands);
      }
      
      private function __response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.target as BaseAlerFrame;
         alert.removeEventListener("response",__response);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            LeavePageManager.leaveToFillPath();
         }
         alert.dispose();
      }
      
      private function okFastPurchaseGold() : void
      {
         var _quick:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _quick.itemID = 11233;
         LayerManager.Instance.addToLayer(_quick,2,true,1);
      }
      
      private function __selectPayNum(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = e.currentTarget;
         if(_addBtn !== _loc2_)
         {
            if(_removeBtn === _loc2_)
            {
               if(_payNum < 1)
               {
                  _payNum == 1;
               }
               else
               {
                  _payNum = Number(_payNum) - 1;
               }
            }
         }
         else
         {
            _payNum = Number(_payNum) + 1;
         }
         checkInput();
         alertMoney();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_addBtn)
         {
            ObjectUtils.disposeObject(_addBtn);
            _addBtn = null;
         }
         if(_cellBg)
         {
            ObjectUtils.disposeObject(_cellBg);
            _cellBg = null;
         }
         if(_shopPayItem)
         {
            ObjectUtils.disposeObject(_shopPayItem);
            _shopPayItem = null;
         }
         if(_payNumBg)
         {
            ObjectUtils.disposeObject(_payNumBg);
            _payNumBg = null;
         }
         if(_payNumtxt)
         {
            ObjectUtils.disposeObject(_payNumtxt);
            _payNumtxt = null;
         }
         if(_alertTips)
         {
            ObjectUtils.disposeObject(_alertTips);
            _alertTips = null;
         }
         if(_removeBtn)
         {
            ObjectUtils.disposeObject(_removeBtn);
            _removeBtn = null;
         }
         if(_selectedBandBtn)
         {
            ObjectUtils.disposeObject(_selectedBandBtn);
            _selectedBandBtn = null;
         }
         if(_selectedBtn)
         {
            ObjectUtils.disposeObject(_selectedBtn);
            _selectedBtn = null;
         }
         ObjectUtils.disposeObject(_selectedXunzBtn);
         _selectedXunzBtn = null;
         if(_group)
         {
            ObjectUtils.disposeObject(_group);
            _group = null;
         }
         if(_totalBg)
         {
            ObjectUtils.disposeObject(_totalBg);
            _totalBg = null;
         }
         if(_alertTips2)
         {
            ObjectUtils.disposeObject(_alertTips2);
            _alertTips2 = null;
         }
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
