package shop.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemPrice;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ShopRechargeEquipView extends Sprite implements Disposeable
   {
       
      
      private var price:ItemPrice;
      
      private var _bg:Image;
      
      private var _frame:BaseAlerFrame;
      
      private var _chargeBtn:TextButton;
      
      private var _itemContainer:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _equipList:Array;
      
      private var _costMoneyTxt:FilterFrameText;
      
      private var _costGiftTxt:FilterFrameText;
      
      private var _playerMoneyTxt:FilterFrameText;
      
      private var _playerGiftTxt:FilterFrameText;
      
      private var _currentCountTxt:FilterFrameText;
      
      private var _affirmContinuBt:BaseButton;
      
      private var _needToPayPanelBg:Image;
      
      private var _haveOwnPanelBg:Image;
      
      private var _needToPayText:FilterFrameText;
      
      private var _haveOwnText:FilterFrameText;
      
      private var _leftTicketText:FilterFrameText;
      
      private var _rightTicketText:FilterFrameText;
      
      private var _leftGiftText:FilterFrameText;
      
      private var _rightGiftText:FilterFrameText;
      
      private var _amountOfItemTipText:FilterFrameText;
      
      private var _isBandList:Vector.<ShopRechargeEquipViewItem>;
      
      private var _playerOrderTxt:FilterFrameText;
      
      private var _costOrderTxt:FilterFrameText;
      
      public function ShopRechargeEquipView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeViewFrame");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeViewFrameBg");
         _needToPayPanelBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.NeedToPayPanelBg");
         _haveOwnPanelBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.HaveOwnPanelBg");
         _amountOfItemTipText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.AmountOfItemTipText");
         _amountOfItemTipText.text = LanguageMgr.GetTranslation("shop.RechargeView.AmountOfItemTipText");
         _needToPayText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.NeedToPayText");
         _needToPayText.text = LanguageMgr.GetTranslation("shop.RechargeView.NeedToPayText");
         _haveOwnText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.HaveOwnText");
         _haveOwnText.text = LanguageMgr.GetTranslation("shop.RechargeView.HaveOwnText");
         _leftTicketText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.LeftTicketText");
         _leftTicketText.text = LanguageMgr.GetTranslation("shop.RechargeView.TicketText");
         _leftGiftText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.LeftGiftText");
         _leftGiftText.text = LanguageMgr.GetTranslation("shop.RechargeView.GiftText");
         _rightTicketText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.RightTicketText");
         _rightTicketText.text = LanguageMgr.GetTranslation("shop.RechargeView.TicketText");
         _rightGiftText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.RightGiftText");
         _rightGiftText.text = LanguageMgr.GetTranslation("shop.RechargeView.GiftText");
         _chargeBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.RechargeBtn");
         _chargeBtn.text = LanguageMgr.GetTranslation("shop.RechargeView.RechargeBtnText");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeViewItemList");
         _itemContainer = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CartItemContainer");
         _costMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.LeftTicketNumberText");
         _costGiftTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.LeftGiftNumberText");
         _costOrderTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.LeftOrderNumberText");
         _playerMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.RightTicketNumberText");
         _playerGiftTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.RightGiftNumberText");
         _playerOrderTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.RightOrderNumberText");
         _currentCountTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeViewCurrentCount");
         _affirmContinuBt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.RechargeConfirmationBtn");
         var ai:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("tank.view.continuation.contiuationTitle"),LanguageMgr.GetTranslation("tank.view.common.AddPricePanel.xu"),LanguageMgr.GetTranslation("cancel"),false,false);
         _frame.info = ai;
         _equipList = PlayerManager.Instance.Self.OvertimeListByBody;
         _scrollPanel.vScrollProxy = 0;
         _scrollPanel.setView(_itemContainer);
         _itemContainer.spacing = 5;
         _itemContainer.strictSize = 100;
         _scrollPanel.invalidateViewport();
         _frame.moveEnable = false;
         _frame.addToContent(_bg);
         _frame.addToContent(_needToPayPanelBg);
         _frame.addToContent(_haveOwnPanelBg);
         _frame.addToContent(_amountOfItemTipText);
         _frame.addToContent(_needToPayText);
         _frame.addToContent(_haveOwnText);
         _frame.addToContent(_leftTicketText);
         _frame.addToContent(_leftGiftText);
         _frame.addToContent(_rightTicketText);
         _frame.addToContent(_rightGiftText);
         _frame.addToContent(_chargeBtn);
         _frame.addToContent(_scrollPanel);
         _frame.addToContent(_costMoneyTxt);
         _frame.addToContent(_costGiftTxt);
         _frame.addToContent(_costOrderTxt);
         _frame.addToContent(_playerMoneyTxt);
         _frame.addToContent(_playerGiftTxt);
         _frame.addToContent(_playerOrderTxt);
         _frame.addToContent(_currentCountTxt);
         _frame.addToContent(_affirmContinuBt);
         setList();
         __onPlayerPropertyChange();
         _chargeBtn.addEventListener("click",__onChargeClick);
         _frame.addEventListener("response",__frameEventHandler);
         _affirmContinuBt.addEventListener("click",_clickContinuBt);
         addChild(_frame);
      }
      
      private function __frameEventHandler(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(e.responseCode))
         {
            case 0:
            case 1:
               InventoryItemInfo.startTimer();
               dispose();
               break;
            default:
               InventoryItemInfo.startTimer();
               dispose();
               break;
            case 3:
            case 4:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
               }
               else
               {
                  payAll();
               }
         }
      }
      
      private function _clickContinuBt(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var money:int = _costMoneyTxt.text;
         var bandMoney:int = _costGiftTxt.text;
         var orderMoney:int = _costOrderTxt.text;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(money > PlayerManager.Instance.Self.Money)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         if(bandMoney > PlayerManager.Instance.Self.BandMoney)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.lackCoin"));
            return;
         }
         payAll();
      }
      
      private function __onChargeClick(e:Event) : void
      {
         LeavePageManager.leaveToFillPath();
      }
      
      private function payAll() : void
      {
         var payArr:* = null;
         var infoArr:* = null;
         var removeArr:* = null;
         var index:* = 0;
         var item:* = null;
         var i:int = 0;
         var isDress:* = false;
         var shopInfoListArr:Array = shopInfoList;
         var buyArr:Array = ShopManager.Instance.buyIt(shopInfoListWithOutDelete);
         if(shopInfoListWithOutDelete.length > 0)
         {
            payArr = [];
            infoArr = [];
            removeArr = [];
            var _loc13_:int = 0;
            var _loc12_:* = shopInfoListWithOutDelete;
            for each(var j in shopInfoListWithOutDelete)
            {
               index = uint(shopInfoListArr.indexOf(j));
               item = _itemContainer.getChildAt(index) as ShopRechargeEquipViewItem;
               infoArr.push(item.info);
               removeArr.push(item);
            }
            var _loc15_:int = 0;
            var _loc14_:* = removeArr;
            for each(var k in removeArr)
            {
               _itemContainer.removeChild(k);
            }
            _scrollPanel.invalidateViewport();
            for(i = 0; i < infoArr.length; )
            {
               isDress = infoArr[i].Place <= 30;
               payArr.push([infoArr[i].BagType,infoArr[i].Place,buyArr[i].GoodsID,buyArr[i].currentBuyType,isDress,_isBandList[i].moneType]);
               i++;
            }
            updateTxt();
            SocketManager.Instance.out.sendGoodsContinue(payArr);
            if(_itemContainer.numChildren <= 0)
            {
               dispose();
            }
            else if(shopInfoListWithOutDelete.length > 0)
            {
               showAlert();
            }
         }
         else if(shopInfoListWithOutDelete.length != 0)
         {
            showAlert();
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.continuation.contiuationFailed"));
         }
      }
      
      private function setList() : void
      {
         _equipList.sort(function(a:InventoryItemInfo, b:InventoryItemInfo):Number
         {
            var sort_arr:Array = [7,5,1,17,8,9,14,6,13,15,3,4,2];
            var a_index:uint = sort_arr.indexOf(a.CategoryID);
            var b_index:uint = sort_arr.indexOf(b.CategoryID);
            if(a_index < b_index)
            {
               return -1;
            }
            if(a_index == b_index)
            {
               return 0;
            }
            return 1;
         });
         _isBandList = new Vector.<ShopRechargeEquipViewItem>();
         var t_i:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = _equipList;
         for each(i in _equipList)
         {
            if(ShopManager.Instance.canAddPrice(i.TemplateID))
            {
               var item:ShopRechargeEquipViewItem = new ShopRechargeEquipViewItem();
               item.itemInfo = i;
               item.clieckHander = setIsBandList;
               item.id = t_i;
               _isBandList.push(item);
               item.setColor(i.Color);
               item.addEventListener("deleteitem",__onItemDelete);
               item.addEventListener("conditionchange",__onItemChange);
               _itemContainer.addChild(item);
               t_i = Number(t_i) + 1;
            }
         }
         _scrollPanel.invalidateViewport();
         updateTxt();
      }
      
      private function setIsBandList(id:int, _type:int) : void
      {
         var i:int = 0;
         var len:int = _isBandList.length;
         for(i = 0; i < len; )
         {
            if(_isBandList[i].id == id)
            {
               _isBandList[i].moneType = _type;
               return;
            }
            i++;
         }
      }
      
      private function __onItemDelete(e:Event) : void
      {
      }
      
      private function __onItemChange(e:Event) : void
      {
         updateTxt();
      }
      
      private function get shopInfoListWithOutDelete() : Array
      {
         var i:* = 0;
         var item:* = null;
         var arr:Array = [];
         _isBandList = new Vector.<ShopRechargeEquipViewItem>();
         var len:int = _itemContainer.numChildren - 1;
         for(i = uint(0); i < _itemContainer.numChildren; )
         {
            item = _itemContainer.getChildAt(len - i) as ShopRechargeEquipViewItem;
            if(item && !item.isDelete)
            {
               arr.push(item.shopItemInfo);
               _isBandList.push(item);
            }
            i++;
         }
         return arr;
      }
      
      private function get shopInfoList() : Array
      {
         var i:* = 0;
         var item:* = null;
         var arr:Array = [];
         for(i = uint(0); i < _itemContainer.numChildren; )
         {
            item = _itemContainer.getChildAt(i) as ShopRechargeEquipViewItem;
            arr.push(item.shopItemInfo);
            i++;
         }
         return arr;
      }
      
      private function updateTxt() : void
      {
         var arr:Array = shopInfoListWithOutDelete;
         var count:uint = arr.length;
         _currentCountTxt.text = String(count);
         if(count == 0)
         {
            _affirmContinuBt.enable = false;
         }
         else
         {
            _affirmContinuBt.enable = true;
         }
         _frame.submitButtonEnable = count <= 0?false:true;
         price = new ItemPrice(null,null,null);
         var t_i:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = arr;
         for each(var i in arr)
         {
            price.addItemPrice(i.getCurrentPrice(),false,_isBandList[t_i].moneType);
            t_i++;
         }
         _costMoneyTxt.text = String(price.bothMoneyValue);
         _costGiftTxt.text = String(price.bandDdtMoneyValue);
         updataTextColor();
         PlayerManager.Instance.Self.addEventListener("propertychange",__onPlayerPropertyChange,false,0,true);
      }
      
      private function __onPlayerPropertyChange(e:Event = null) : void
      {
         _playerMoneyTxt.text = String(PlayerManager.Instance.Self.Money);
         _playerGiftTxt.text = String(PlayerManager.Instance.Self.BandMoney);
         updataTextColor();
      }
      
      private function updataTextColor() : void
      {
         if(price)
         {
            if(price.bothMoneyValue > PlayerManager.Instance.Self.Money)
            {
               _costMoneyTxt.setTextFormat(ComponentFactory.Instance.model.getSet("ddtshop.DigitWarningTF"));
            }
            else
            {
               _costMoneyTxt.setTextFormat(ComponentFactory.Instance.model.getSet("ddtshop.RechargeView.NumberTextTF"));
            }
            if(price.bandDdtMoneyValue > PlayerManager.Instance.Self.BandMoney)
            {
               _costGiftTxt.setTextFormat(ComponentFactory.Instance.model.getSet("ddtshop.DigitWarningTF"));
            }
            else
            {
               _costGiftTxt.setTextFormat(ComponentFactory.Instance.model.getSet("ddtshop.RechargeView.NumberTextTF"));
            }
            _costOrderTxt.setTextFormat(ComponentFactory.Instance.model.getSet("ddtshop.RechargeView.NumberTextTF"));
         }
      }
      
      private function showAlert() : void
      {
         var frame:* = null;
         if(price.bothMoneyValue > PlayerManager.Instance.Self.Money)
         {
            frame = LeavePageManager.showFillFrame();
         }
      }
      
      public function dispose() : void
      {
         InventoryItemInfo.startTimer();
         PlayerManager.Instance.Self.removeEventListener("propertychange",__onPlayerPropertyChange);
         _frame.removeEventListener("response",__frameEventHandler);
         _chargeBtn.removeEventListener("click",__onChargeClick);
         _affirmContinuBt.removeEventListener("click",_clickContinuBt);
         _frame.dispose();
         _frame = null;
         price = null;
         _bg = null;
         ObjectUtils.disposeObject(_amountOfItemTipText);
         _amountOfItemTipText = null;
         ObjectUtils.disposeObject(_needToPayPanelBg);
         _needToPayPanelBg = null;
         ObjectUtils.disposeObject(_haveOwnPanelBg);
         _haveOwnPanelBg = null;
         ObjectUtils.disposeObject(_needToPayText);
         _needToPayText = null;
         ObjectUtils.disposeObject(_haveOwnText);
         _haveOwnText = null;
         ObjectUtils.disposeObject(_leftTicketText);
         _leftTicketText = null;
         ObjectUtils.disposeObject(_leftGiftText);
         _leftGiftText = null;
         ObjectUtils.disposeObject(_rightTicketText);
         _rightTicketText = null;
         ObjectUtils.disposeObject(_rightGiftText);
         _rightGiftText = null;
         _chargeBtn = null;
         _itemContainer = null;
         _scrollPanel = null;
         _equipList = null;
         _costMoneyTxt = null;
         _costGiftTxt = null;
         _playerMoneyTxt = null;
         _playerGiftTxt = null;
         _currentCountTxt = null;
         _affirmContinuBt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
