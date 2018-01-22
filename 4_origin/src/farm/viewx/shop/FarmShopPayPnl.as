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
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.showCancel = false;
         _loc1_.submitLabel = LanguageMgr.GetTranslation("ddt.farms.shopPayButton");
         _loc1_.title = LanguageMgr.GetTranslation("ddt.farms.shopPayTitle");
         _loc1_.bottomGap = 33;
         this.info = _loc1_;
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
      
      protected function selectedBandHander(param1:MouseEvent) : void
      {
         setSeleBtnFalse();
         _selectedBtn.enable = true;
         if(_isXun)
         {
            _selectedXunzBtn.selected = true;
         }
         _isBand = true;
      }
      
      private function selectedXunzHander(param1:MouseEvent) : void
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
      
      protected function seletedHander(param1:MouseEvent) : void
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
      
      public function set goodsID(param1:int) : void
      {
         if(_shopPayItem)
         {
            _shopPayItem.dispose();
         }
         _goodsID = param1;
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
      
      private function applyGray(param1:DisplayObject) : void
      {
         var _loc2_:Array = [];
         _loc2_ = _loc2_.concat([0.3086,0.6094,0.082,0,0]);
         _loc2_ = _loc2_.concat([0.3086,0.6094,0.082,0,0]);
         _loc2_ = _loc2_.concat([0.3086,0.6094,0.082,0,0]);
         _loc2_ = _loc2_.concat([0,0,0,1,0]);
         applyFilter(param1,_loc2_);
      }
      
      private function applyFilter(param1:DisplayObject, param2:Array) : void
      {
         var _loc4_:ColorMatrixFilter = new ColorMatrixFilter(param2);
         var _loc3_:Array = [];
         _loc3_.push(_loc4_);
         param1.filters = _loc3_;
      }
      
      private function alertMoney() : void
      {
         var _loc1_:String = "";
         if(_isXun)
         {
            _spendValue = _shopItemInfo.getItemPrice(1).ddtMoneyValue * _payNum;
            _loc1_ = String(_spendValue) + LanguageMgr.GetTranslation("medalMoney");
         }
         else
         {
            _spendValue = _shopItemInfo.getItemPrice(1).bothMoneyValue * _payNum;
            if(_isBand)
            {
               _loc1_ = String(_spendValue) + LanguageMgr.GetTranslation("ddtMoney");
            }
            else
            {
               _loc1_ = String(_spendValue) + LanguageMgr.GetTranslation("money");
            }
         }
         _alertTips2.text = _loc1_;
      }
      
      protected function creatItemCell() : ShopItemCell
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,75,75);
         _loc1_.graphics.endFill();
         return CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
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
      
      protected function __selectedChange(param1:Event) : void
      {
         SoundManager.instance.play("008");
         alertMoney();
      }
      
      private function __txtInputCheck(param1:Event) : void
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
      
      protected function __framePesponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc1_:* = null;
         var _loc9_:int = 0;
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
            _loc2_ = [];
            _loc7_ = [];
            _loc3_ = [];
            _loc5_ = [];
            _loc8_ = [];
            _loc6_ = [];
            _loc1_ = [];
            _loc9_ = 0;
            while(_loc9_ < _payNum)
            {
               _loc2_.push(_shopItemInfo.GoodsID);
               _loc7_.push(1);
               _loc3_.push("");
               _loc5_.push(false);
               _loc8_.push("");
               _loc6_.push(-1);
               _loc1_.push(_isBand);
               _loc9_++;
            }
            SocketManager.Instance.out.sendBuyGoods(_loc2_,_loc7_,_loc3_,_loc6_,_loc5_,_loc8_,0,null,_loc1_);
         }
         else
         {
            CheckMoneyUtils.instance.checkMoney(_isBand,_spendValue,onCheckComplete);
         }
      }
      
      protected function onCheckComplete() : void
      {
         var _loc8_:int = 0;
         var _loc2_:Array = [];
         var _loc6_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc7_:Array = [];
         var _loc5_:Array = [];
         var _loc1_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < _payNum)
         {
            _loc2_.push(_shopItemInfo.GoodsID);
            _loc6_.push(1);
            _loc3_.push("");
            _loc4_.push(false);
            _loc7_.push("");
            _loc5_.push(-1);
            _loc1_.push(CheckMoneyUtils.instance.isBind);
            _loc8_++;
         }
         SocketManager.Instance.out.sendBuyGoods(_loc2_,_loc6_,_loc3_,_loc5_,_loc4_,_loc7_,0,null,_loc1_);
      }
      
      private function __response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__response);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            LeavePageManager.leaveToFillPath();
         }
         _loc2_.dispose();
      }
      
      private function okFastPurchaseGold() : void
      {
         var _loc1_:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _loc1_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _loc1_.itemID = 11233;
         LayerManager.Instance.addToLayer(_loc1_,2,true,1);
      }
      
      private function __selectPayNum(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
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
