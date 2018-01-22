package shop.view
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.greensock.TimelineMax;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.greensock.events.TweenEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.ItemEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.manager.ShopBuyManager;
   import shop.manager.ShopGiftsManager;
   
   public class ShopGoodItem extends Sprite implements ISelectable, Disposeable
   {
      
      public static const PAYTYPE_DDT_MONEY:uint = 1;
      
      public static const PAYTYPE_MONEY:uint = 2;
      
      public static const YELLOW_BOY:uint = 3;
      
      public static const BURIED_STONE:uint = 4;
      
      public static const MEDAL:uint = 6;
      
      private static const LIMIT_LABEL:uint = 6;
       
      
      protected var _payPaneGivingBtn:BaseButton;
      
      protected var _payPaneBuyBtn:BaseButton;
      
      protected var _itemBg:ScaleFrameImage;
      
      protected var _itemCellBg:Image;
      
      private var _shopItemCellBg:Bitmap;
      
      protected var _itemCell:ShopItemCell;
      
      protected var _itemCellBtn:Sprite;
      
      protected var _itemCountTxt:FilterFrameText;
      
      protected var _itemNameTxt:FilterFrameText;
      
      protected var _itemPriceTxt:FilterFrameText;
      
      protected var _labelIcon:ScaleFrameImage;
      
      protected var _payType:ScaleFrameImage;
      
      protected var _selected:Boolean;
      
      protected var _shopItemInfo:ShopItemInfo;
      
      protected var _shopItemCellTypeBg:ScaleFrameImage;
      
      private var _payPaneBuyBtnHotArea:Sprite;
      
      protected var _dotLine:Image;
      
      protected var _timeline:TimelineMax;
      
      protected var _isMouseOver:Boolean;
      
      protected var _lightMc:MovieClip;
      
      protected var _payPaneaskBtn:BaseButton;
      
      private var _shopPresentClearingFrame:ShopPresentClearingFrame;
      
      public function ShopGoodItem()
      {
         super();
         initContent();
         addEvent();
      }
      
      public function get payPaneGivingBtn() : BaseButton
      {
         return _payPaneGivingBtn;
      }
      
      public function get payPaneBuyBtn() : BaseButton
      {
         return _payPaneBuyBtn;
      }
      
      public function get payPaneaskBtn() : BaseButton
      {
         return _payPaneaskBtn;
      }
      
      public function get itemBg() : ScaleFrameImage
      {
         return _itemBg;
      }
      
      public function get itemCell() : ShopItemCell
      {
         return _itemCell;
      }
      
      public function get itemCellBtn() : Sprite
      {
         return _itemCellBtn;
      }
      
      public function get dotLine() : Image
      {
         return _dotLine;
      }
      
      protected function initContent() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemBg");
         _itemCellBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemCellBg");
         _dotLine = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemDotLine");
         _payType = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodPayTypeLabel");
         _payType.mouseChildren = false;
         _payType.mouseEnabled = false;
         _payPaneGivingBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PayPaneGivingBtn");
         _payPaneBuyBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PayPaneBuyBtn");
         _payPaneaskBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PayPaneAskBtn");
         _payPaneBuyBtnHotArea = new Sprite();
         _payPaneBuyBtnHotArea.graphics.beginFill(0,0);
         _payPaneBuyBtnHotArea.graphics.drawRect(0,0,_payPaneBuyBtn.width,_payPaneBuyBtn.height);
         PositionUtils.setPos(_payPaneBuyBtnHotArea,_payPaneBuyBtn);
         _itemNameTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemName");
         _itemPriceTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemPrice");
         _itemCountTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemCount");
         _itemCell = creatItemCell();
         PositionUtils.setPos(_itemCell,"ddtshop.ShopGoodItemCellPos");
         _labelIcon = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodLabelIcon");
         _labelIcon.mouseChildren = false;
         _labelIcon.mouseEnabled = false;
         _shopItemCellTypeBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.ShopItemCellTypeBg");
         _itemCellBtn = new Sprite();
         _itemCellBtn.buttonMode = true;
         _itemCellBtn.addChild(_itemCell);
         _itemCellBtn.addChild(_shopItemCellTypeBg);
         _itemBg.setFrame(1);
         _itemCellBg.setFrame(1);
         _labelIcon.setFrame(1);
         _payType.setFrame(1);
         addChild(_itemBg);
         addChild(_itemCellBg);
         addChild(_dotLine);
         addChild(_payPaneGivingBtn);
         addChild(_payPaneBuyBtn);
         addChild(_payPaneaskBtn);
         addChild(_payPaneBuyBtnHotArea);
         addChild(_payType);
         addChild(_itemCellBtn);
         addChild(_labelIcon);
         addChild(_itemNameTxt);
         addChild(_itemPriceTxt);
         addChild(_itemCountTxt);
         _timeline = new TimelineMax();
         _timeline.addEventListener("complete",__timelineComplete);
         var _loc2_:TweenLite = TweenLite.to(_labelIcon,0.25,{
            "alpha":0,
            "y":"-30"
         });
         _timeline.append(_loc2_);
         var _loc1_:TweenLite = TweenLite.to(_itemCountTxt,0.25,{
            "alpha":0,
            "y":"-30"
         });
         _timeline.append(_loc1_,-0.25);
         var _loc3_:TweenMax = TweenMax.from(_shopItemCellTypeBg,0.1,{
            "autoAlpha":0,
            "y":"5"
         });
         _timeline.append(_loc3_,-0.2);
         _timeline.stop();
      }
      
      protected function creatItemCell() : ShopItemCell
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,75,75);
         _loc1_.graphics.endFill();
         return CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
      }
      
      public function get shopItemInfo() : ShopItemInfo
      {
         return _shopItemInfo;
      }
      
      public function set shopItemInfo(param1:ShopItemInfo) : void
      {
         if(_shopItemInfo)
         {
            _shopItemInfo.removeEventListener("change",__updateShopItem);
         }
         if(param1 == null)
         {
            _shopItemInfo = null;
            _itemCell.info = null;
         }
         else
         {
            _shopItemInfo = param1;
            _itemCell.info = param1.TemplateInfo;
            _itemCell.tipInfo = param1;
         }
         if(_itemCell.info != null)
         {
            _itemCell.visible = true;
            _itemCellBtn.visible = true;
            _itemCellBtn.buttonMode = true;
            _payType.visible = true;
            _itemPriceTxt.visible = true;
            _itemNameTxt.visible = true;
            _itemCountTxt.visible = true;
            _payPaneGivingBtn.visible = true;
            _payPaneBuyBtn.visible = true;
            _payPaneaskBtn.visible = true;
            _itemNameTxt.text = String(_itemCell.info.Name);
            _itemCell.tipInfo = param1;
            initPrice();
            if(_shopItemInfo.ShopID == 1)
            {
               _itemBg.setFrame(1);
               _itemCellBg.setFrame(1);
            }
            else
            {
               _itemBg.setFrame(2);
               _itemCellBg.setFrame(2);
            }
            if(EquipType.dressAble(_shopItemInfo.TemplateInfo))
            {
               _shopItemCellTypeBg.setFrame(1);
            }
            else
            {
               _shopItemCellTypeBg.setFrame(2);
            }
            _labelIcon.visible = _shopItemInfo.Label == 0?false:true;
            _labelIcon.setFrame(_shopItemInfo.Label);
            _shopItemInfo.addEventListener("change",__updateShopItem);
         }
         else
         {
            _itemBg.setFrame(1);
            _itemCellBg.setFrame(1);
            _itemCellBtn.visible = false;
            _labelIcon.visible = false;
            _payType.visible = false;
            _itemPriceTxt.visible = false;
            _itemNameTxt.visible = false;
            _itemCountTxt.visible = false;
            _payPaneGivingBtn.visible = false;
            _payPaneBuyBtn.visible = false;
            _payPaneaskBtn.visible = false;
         }
         updateCount();
         updateBtn();
      }
      
      private function updateBtn() : void
      {
         if(!_shopItemInfo)
         {
            return;
         }
         if(PlayerManager.Instance.Self.Grade < _shopItemInfo.LimitGrade)
         {
            _payPaneBuyBtn.enable = false;
            _payPaneBuyBtnHotArea.mouseEnabled = true;
         }
         else
         {
            _payPaneBuyBtn.enable = true;
            _payPaneBuyBtnHotArea.mouseEnabled = false;
         }
      }
      
      private function __updateShopItem(param1:Event) : void
      {
         updateCount();
      }
      
      private function checkType() : int
      {
         if(_shopItemInfo)
         {
            return _shopItemInfo.ShopID == 1?1:2;
         }
         return 1;
      }
      
      protected function initPrice() : void
      {
         switch(int(_shopItemInfo.getItemPrice(1).PriceType) - -9)
         {
            case 0:
               _payType.setFrame(1);
               _itemPriceTxt.text = String(_shopItemInfo.getItemPrice(1).bandDdtMoneyValue);
               _payPaneGivingBtn.visible = false;
               break;
            case 1:
               _payType.setFrame(2);
               _itemPriceTxt.text = String(_shopItemInfo.getItemPrice(1).moneyValue);
               break;
            default:
               _payType.setFrame(2);
               _itemPriceTxt.text = String(_shopItemInfo.getItemPrice(1).moneyValue);
               break;
            case 3:
               _payType.setFrame(1);
               _itemPriceTxt.text = String(_shopItemInfo.getItemPrice(1).ddtMoneyValue);
               _payPaneGivingBtn.visible = false;
               _payPaneaskBtn.visible = false;
               break;
            default:
               _payType.setFrame(1);
               _itemPriceTxt.text = String(_shopItemInfo.getItemPrice(1).ddtMoneyValue);
               _payPaneGivingBtn.visible = false;
               _payPaneaskBtn.visible = false;
               break;
            default:
               _payType.setFrame(1);
               _itemPriceTxt.text = String(_shopItemInfo.getItemPrice(1).ddtMoneyValue);
               _payPaneGivingBtn.visible = false;
               _payPaneaskBtn.visible = false;
               break;
            default:
               _payType.setFrame(1);
               _itemPriceTxt.text = String(_shopItemInfo.getItemPrice(1).ddtMoneyValue);
               _payPaneGivingBtn.visible = false;
               _payPaneaskBtn.visible = false;
               break;
            case 7:
               _payType.setFrame(6);
               _itemPriceTxt.text = String(_shopItemInfo.getItemPrice(1).ddtMoneyValue);
               _payPaneGivingBtn.visible = false;
               _payPaneaskBtn.visible = false;
               break;
            case 8:
               _payType.setFrame(2);
               _itemPriceTxt.text = String(_shopItemInfo.getItemPrice(1).bothMoneyValue);
         }
      }
      
      private function updateCount() : void
      {
         if(_shopItemInfo)
         {
            if(_shopItemInfo.Label && _shopItemInfo.Label == 6)
            {
               if(_itemBg && _labelIcon && _itemCountTxt)
               {
                  _itemCountTxt.text = String(_shopItemInfo.LimitCount);
               }
            }
            else if(_itemBg && _labelIcon && _itemCountTxt)
            {
               _itemCountTxt.visible = false;
               _itemCountTxt.text = "0";
            }
         }
      }
      
      protected function addEvent() : void
      {
         _payPaneBuyBtn.addEventListener("click",__payPanelClick);
         _payPaneBuyBtnHotArea.addEventListener("mouseOver",__payPaneBuyBtnOver);
         _payPaneBuyBtnHotArea.addEventListener("mouseOut",__payPaneBuyBtnOut);
         _payPaneGivingBtn.addEventListener("click",__payPanelClick);
         _payPaneaskBtn.addEventListener("click",__payPanelClick);
         _itemCellBtn.addEventListener("click",__itemClick);
         _itemCellBtn.addEventListener("mouseOver",__itemMouseOver);
         _itemCellBtn.addEventListener("mouseOut",__itemMouseOut);
         _itemBg.addEventListener("mouseOver",__itemMouseOver);
         _itemBg.addEventListener("mouseOut",__itemMouseOut);
      }
      
      protected function removeEvent() : void
      {
         _payPaneBuyBtn.removeEventListener("click",__payPanelClick);
         _payPaneBuyBtnHotArea.removeEventListener("mouseOver",__payPaneBuyBtnOver);
         _payPaneBuyBtnHotArea.removeEventListener("mouseOut",__payPaneBuyBtnOut);
         _payPaneGivingBtn.removeEventListener("click",__payPanelClick);
         _payPaneaskBtn.removeEventListener("click",__payPanelClick);
         _itemCellBtn.removeEventListener("click",__itemClick);
         _itemCellBtn.removeEventListener("mouseOver",__itemMouseOver);
         _itemCellBtn.removeEventListener("mouseOut",__itemMouseOut);
         _itemBg.removeEventListener("mouseOver",__itemMouseOver);
         _itemBg.removeEventListener("mouseOut",__itemMouseOut);
      }
      
      private function payPanAskHander(param1:MouseEvent) : void
      {
         _shopPresentClearingFrame = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.ShopPresentClearingFrame");
         _shopPresentClearingFrame.show();
         _shopPresentClearingFrame.setType(2);
         _shopPresentClearingFrame.presentBtn.addEventListener("click",presentBtnClick);
         _shopPresentClearingFrame.addEventListener("response",shopPresentClearingFrameResponseHandler);
      }
      
      protected function shopPresentClearingFrameResponseHandler(param1:FrameEvent) : void
      {
         _shopPresentClearingFrame.removeEventListener("response",shopPresentClearingFrameResponseHandler);
         if(_shopPresentClearingFrame.presentBtn)
         {
            _shopPresentClearingFrame.presentBtn.removeEventListener("click",presentBtnClick);
         }
         if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 4)
         {
            _shopPresentClearingFrame.dispose();
            _shopPresentClearingFrame = null;
         }
      }
      
      protected function presentBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:String = _shopPresentClearingFrame.nameInput.text;
         if(_loc2_ == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.askPay"));
            return;
         }
         if(FilterWordManager.IsNullorEmpty(_loc2_))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.askSpace"));
            return;
         }
         _shopPresentClearingFrame.presentBtn.removeEventListener("click",presentBtnClick);
         _shopPresentClearingFrame.removeEventListener("response",shopPresentClearingFrameResponseHandler);
         _shopPresentClearingFrame.dispose();
         _shopPresentClearingFrame = null;
      }
      
      protected function __payPaneBuyBtnOver(param1:MouseEvent) : void
      {
         if(_shopItemInfo && _shopItemInfo.LimitGrade > PlayerManager.Instance.Self.Grade)
         {
            _payPaneBuyBtn.tipStyle = "ddt.view.tips.OneLineTip";
            _payPaneBuyBtn.tipData = LanguageMgr.GetTranslation("ddt.shop.LimitGradeBuy",_shopItemInfo.LimitGrade);
            _payPaneBuyBtn.tipDirctions = "3,7,6";
            ShowTipManager.Instance.showTip(_payPaneBuyBtn);
         }
      }
      
      protected function __payPaneBuyBtnOut(param1:MouseEvent) : void
      {
         ShowTipManager.Instance.removeTip(_payPaneBuyBtn);
      }
      
      protected function __payPanelClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(_shopItemInfo && _shopItemInfo.LimitCount == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.countOver"));
            return;
         }
         if(_shopItemInfo != null)
         {
            SoundManager.instance.play("008");
            if(_shopItemInfo.isDiscount == 2 && ShopManager.Instance.getDisCountShopItemByGoodsID(_shopItemInfo.GoodsID) == null)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.shop.discount.exit"));
               return;
            }
            if(param1.currentTarget == _payPaneGivingBtn)
            {
               ShopGiftsManager.Instance.buy(_shopItemInfo.GoodsID,_shopItemInfo.isDiscount == 2,2);
            }
            else if(param1.currentTarget == _payPaneBuyBtn)
            {
               ShopBuyManager.Instance.buy(_shopItemInfo.GoodsID,_shopItemInfo.isDiscount,_shopItemInfo.getItemPrice(1).PriceType);
            }
            else
            {
               ShopBuyManager.Instance.buy(_shopItemInfo.GoodsID,_shopItemInfo.isDiscount,3);
            }
         }
         dispatchEvent(new ItemEvent("itemSelect",_shopItemInfo,0));
      }
      
      protected function __payPaneGetBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("shop.view.ShopRightView.getSimpleAlert.title"),LanguageMgr.GetTranslation("shop.view.ShopRightView.getSimpleAlert.msg"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
         _loc2_.addEventListener("response",__onResponse);
         dispatchEvent(new ItemEvent("itemSelect",_shopItemInfo,0));
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc8_:int = 0;
         SoundManager.instance.play("008");
         var _loc4_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc4_.removeEventListener("response",__onResponse);
         _loc4_.dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            _loc2_ = [];
            _loc7_ = [];
            _loc3_ = [];
            _loc5_ = [];
            _loc6_ = [];
            _loc8_ = 0;
            while(_loc8_ < 1)
            {
               _loc2_.push(_shopItemInfo.GoodsID);
               _loc7_.push(1);
               _loc3_.push("");
               _loc5_.push("");
               _loc6_.push("");
               _loc8_++;
            }
            SocketManager.Instance.out.sendBuyGoods(_loc2_,_loc7_,_loc3_,_loc6_,_loc5_);
         }
      }
      
      protected function __itemClick(param1:MouseEvent) : void
      {
         if(!_shopItemInfo)
         {
            return;
         }
         if(PlayerManager.Instance.Self.Grade < _shopItemInfo.LimitGrade)
         {
            return;
         }
         SoundManager.instance.play("008");
         if(_shopItemInfo.LimitCount == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.countOver"));
            return;
         }
         dispatchEvent(new ItemEvent("itemClick",_shopItemInfo,1));
      }
      
      protected function __itemMouseOver(param1:MouseEvent) : void
      {
         if(!_itemCell.info)
         {
            return;
         }
         if(_lightMc)
         {
            addChild(_lightMc);
         }
         parent.addChild(this);
         _isMouseOver = true;
         _timeline.play();
      }
      
      protected function __itemMouseOut(param1:MouseEvent) : void
      {
         ObjectUtils.disposeObject(_lightMc);
         if(!_shopItemInfo)
         {
            return;
         }
         _isMouseOver = false;
         __timelineComplete();
      }
      
      public function setItemLight(param1:MovieClip) : void
      {
         if(_lightMc == param1)
         {
            return;
         }
         _lightMc = param1;
         _lightMc.mouseChildren = false;
         _lightMc.mouseEnabled = false;
         _lightMc.gotoAndPlay(1);
      }
      
      protected function __timelineComplete(param1:TweenEvent = null) : void
      {
         if(_timeline.currentTime < _timeline.totalDuration)
         {
            return;
         }
         if(_isMouseOver)
         {
            return;
         }
         _timeline.reverse();
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         _itemBg.setFrame(!!_selected?3:checkType());
         _itemCellBg.setFrame(!!_selected?3:checkType());
         _itemNameTxt.setFrame(!!param1?2:1);
         _itemPriceTxt.setFrame(!!param1?2:1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_shopItemInfo)
         {
            _shopItemInfo.removeEventListener("change",__updateShopItem);
         }
         ObjectUtils.disposeAllChildren(this);
         if(_timeline)
         {
            _timeline.removeEventListener("complete",__timelineComplete);
            _timeline = null;
         }
         if(_lightMc)
         {
            ObjectUtils.disposeObject(_lightMc);
            _lightMc = null;
         }
         if(_itemBg)
         {
            ObjectUtils.disposeObject(_itemBg);
            _itemBg = null;
         }
         if(_itemCellBg)
         {
            ObjectUtils.disposeObject(_itemCellBg);
            _itemCellBg = null;
         }
         if(_shopItemCellBg)
         {
            ObjectUtils.disposeObject(_shopItemCellBg);
            _shopItemCellBg = null;
         }
         if(_payPaneaskBtn)
         {
            ObjectUtils.disposeObject(_payPaneaskBtn);
         }
         _payPaneaskBtn = null;
         if(_payPaneGivingBtn)
         {
            ObjectUtils.disposeObject(_payPaneGivingBtn);
         }
         _payPaneGivingBtn = null;
         if(_payPaneBuyBtn)
         {
            ObjectUtils.disposeObject(_payPaneBuyBtn);
         }
         _payPaneBuyBtn = null;
         if(_dotLine)
         {
            ObjectUtils.disposeObject(_dotLine);
            _dotLine = null;
         }
         if(_itemCell)
         {
            ObjectUtils.disposeObject(_itemCell);
            _itemCell = null;
         }
         if(_shopItemCellTypeBg)
         {
            ObjectUtils.disposeObject(_shopItemCellTypeBg);
            _shopItemCellTypeBg = null;
         }
         if(_payPaneBuyBtnHotArea)
         {
            ObjectUtils.disposeObject(_payPaneBuyBtnHotArea);
            _payPaneBuyBtnHotArea = null;
         }
         if(_itemCountTxt)
         {
            _itemCountTxt = null;
         }
         if(_itemNameTxt)
         {
            _itemNameTxt = null;
         }
         if(_itemPriceTxt)
         {
            _itemPriceTxt = null;
         }
         if(_labelIcon)
         {
            _labelIcon = null;
         }
         if(_payType)
         {
            _payType = null;
         }
         if(_itemCellBtn)
         {
            _itemCellBtn = null;
         }
         if(_shopItemInfo)
         {
            _shopItemInfo = null;
         }
         if(_payPaneGivingBtn)
         {
            _payPaneGivingBtn = null;
         }
         if(_payPaneBuyBtn)
         {
            _payPaneBuyBtn = null;
         }
      }
   }
}
