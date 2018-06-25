package giftSystem.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.list.DropList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.NameInputDropListTarget;
   import ddt.view.chat.ChatFriendListPanel;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import giftSystem.GiftController;
   import giftSystem.GiftEvent;
   import giftSystem.GiftManager;
   import giftSystem.element.GiftCartItem;
   
   public class ClearingInterface extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _bg3:MutipleImage;
      
      private var _bg4:MutipleImage;
      
      private var _chooseFriendBtn:TextButton;
      
      private var _nameInput:NameInputDropListTarget;
      
      private var _dropList:DropList;
      
      private var _friendList:ChatFriendListPanel;
      
      private var _buyMoneyBtn:BaseButton;
      
      private var _presentBtn:BaseButton;
      
      private var _totalMoney:FilterFrameText;
      
      private var _poorMoney:FilterFrameText;
      
      private var _giftNum:FilterFrameText;
      
      private var _giftCartItem:GiftCartItem;
      
      private var _moneyIsEnough:ScaleFrameImage;
      
      private var _NeedPay:FilterFrameText;
      
      private var _HavePay:FilterFrameText;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _moneyTxt1:FilterFrameText;
      
      private var _comboBoxLabel:FilterFrameText;
      
      private var _buyTxt:FilterFrameText;
      
      private var _info:ShopItemInfo;
      
      public function ClearingInterface()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         this.titleText = LanguageMgr.GetTranslation("ddt.giftSystem.ClearingInterface.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ClearingInterface.background1");
         _bg3 = ComponentFactory.Instance.creatComponentByStylename("ddtgiftSystem.TotalMoneyPanel");
         _bg4 = ComponentFactory.Instance.creatComponentByStylename("ddtgiftSystem.TotalMoneyPanel1");
         _chooseFriendBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtgiftSystem.PresentFrame.ChooseFriendBtn");
         _chooseFriendBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.ChooseFriendButtonText");
         _comboBoxLabel = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.PresentFrame.ComboBoxLabel");
         _comboBoxLabel.text = LanguageMgr.GetTranslation("shop.PresentFrame.ComboBoxLabel");
         PositionUtils.setPos(_comboBoxLabel,"giftSystem.comboBoxLabelPos");
         _nameInput = ComponentFactory.Instance.creatCustomObject("ClearingInterface.nameInput");
         _dropList = ComponentFactory.Instance.creatComponentByStylename("droplist.SimpleDropList");
         _dropList.targetDisplay = _nameInput;
         _dropList.x = _nameInput.x;
         _dropList.y = _nameInput.y + _nameInput.height;
         _moneyIsEnough = ComponentFactory.Instance.creatComponentByStylename("ClearingInterface.isEnoughImage");
         _buyMoneyBtn = ComponentFactory.Instance.creatComponentByStylename("ClearingInterface.buyMoney");
         _presentBtn = ComponentFactory.Instance.creatComponentByStylename("ClearingInterface.present");
         _totalMoney = ComponentFactory.Instance.creatComponentByStylename("ClearingInterface.totalMoney");
         _poorMoney = ComponentFactory.Instance.creatComponentByStylename("ClearingInterface.poorMoney");
         _giftNum = ComponentFactory.Instance.creatComponentByStylename("ClearingInterface.giftNum");
         _giftCartItem = ComponentFactory.Instance.creatCustomObject("giftCartItem");
         _NeedPay = ComponentFactory.Instance.creatComponentByStylename("ddtshop.NeedToPayTip");
         _NeedPay.text = LanguageMgr.GetTranslation("shop.RechargeView.NeedToPayText");
         PositionUtils.setPos(_NeedPay,"giftSystem.NeedPayTextPos");
         _HavePay = ComponentFactory.Instance.creatComponentByStylename("ddtshop.NeedToPayTip");
         _HavePay.text = LanguageMgr.GetTranslation("shop.RechargeView.HaveOwnText");
         PositionUtils.setPos(_HavePay,"giftSystem.HavePayTextPos");
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.NeedToPayTip");
         _moneyTxt.text = LanguageMgr.GetTranslation("shop.RechargeView.TicketText");
         PositionUtils.setPos(_moneyTxt,"giftSystem.moneyPayTextPos");
         _moneyTxt1 = ComponentFactory.Instance.creatComponentByStylename("ddtshop.NeedToPayTip");
         _moneyTxt1.text = LanguageMgr.GetTranslation("shop.RechargeView.TicketText");
         PositionUtils.setPos(_moneyTxt1,"giftSystem.moneyPayTextPosOne");
         _buyTxt = ComponentFactory.Instance.creatComponentByStylename("ClearingInterface.buyText");
         _buyTxt.text = LanguageMgr.GetTranslation("shop.RechargeView.BuyText");
         _friendList = new ChatFriendListPanel();
         _friendList.setup(selectName);
         addToContent(_bg);
         addToContent(_bg3);
         addToContent(_bg4);
         addToContent(_chooseFriendBtn);
         addToContent(_nameInput);
         addToContent(_buyMoneyBtn);
         addToContent(_presentBtn);
         addToContent(_totalMoney);
         addToContent(_poorMoney);
         addToContent(_NeedPay);
         addToContent(_HavePay);
         addToContent(_moneyTxt);
         addToContent(_moneyTxt1);
         addToContent(_giftNum);
         addToContent(_giftCartItem);
         addToContent(_comboBoxLabel);
         addToContent(_buyTxt);
         _moneyIsEnough.setFrame(1);
      }
      
      private function selectName(nick:String, id:int = 0) : void
      {
         setName(nick);
         _friendList.setVisible = false;
      }
      
      public function setName(value:String) : void
      {
         _nameInput.text = value;
      }
      
      public function set info(value:ShopItemInfo) : void
      {
         if(_info == value)
         {
            return;
         }
         _info = value;
         updateMoneyType();
         _giftCartItem.info = _info;
         __numberChange(null);
      }
      
      private function updateMoneyType() : void
      {
         switch(int(_info.getItemPrice(1).PriceType) - -2)
         {
            case 0:
               _poorMoney.text = String(PlayerManager.Instance.Self.DDTMoney);
               _moneyTxt.text = LanguageMgr.GetTranslation("shop.RechargeView.GiftText");
               _moneyTxt1.text = LanguageMgr.GetTranslation("shop.RechargeView.GiftText");
               break;
            case 1:
               _poorMoney.text = String(PlayerManager.Instance.Self.Money);
               _moneyTxt.text = LanguageMgr.GetTranslation("shop.RechargeView.TicketText");
               _moneyTxt1.text = LanguageMgr.GetTranslation("shop.RechargeView.TicketText");
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _chooseFriendBtn.addEventListener("click",__showFramePanel);
         _buyMoneyBtn.addEventListener("click",__buyMoney);
         _presentBtn.addEventListener("click",__present);
         _giftCartItem.addEventListener("numberIsChange",__numberChange);
         StageReferance.stage.addEventListener("click",__hideDropList);
         _nameInput.addEventListener("change",__onReceiverChange);
         PlayerManager.Instance.Self.addEventListener("propertychange",__moneyChange);
         GiftController.Instance.addEventListener("sendGiftReturn",__sendRetrunHandler);
      }
      
      protected function __sendRetrunHandler(event:GiftEvent) : void
      {
         if(event.str == "true")
         {
            dispose();
         }
         else
         {
            _presentBtn.enable = true;
         }
      }
      
      private function __numberChange(event:Event) : void
      {
         var total:int = 0;
         var poor:int = 0;
         switch(int(_info.getItemPrice(1).PriceType) - -2)
         {
            case 0:
               total = _info.getItemPrice(1).ddtMoneyValue * _giftCartItem.number;
               poor = PlayerManager.Instance.Self.DDTMoney - total;
               break;
            case 1:
               total = _info.getItemPrice(1).bothMoneyValue * _giftCartItem.number;
               poor = PlayerManager.Instance.Self.Money - total;
         }
         _totalMoney.text = total.toString();
         if(poor < 0)
         {
            _moneyIsEnough.setFrame(2);
         }
         else
         {
            _moneyIsEnough.setFrame(1);
         }
         _giftNum.text = _giftCartItem.number.toString();
      }
      
      private function __present(event:MouseEvent) : void
      {
         var confirm:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(parseInt(_poorMoney.text) < 0)
         {
            confirm = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            confirm.moveEnable = false;
            confirm.addEventListener("response",__confirmResponse);
            return;
         }
         if(_nameInput.text == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.giftSystem.ClearingInterface.inputName"));
            return;
         }
         if(_giftCartItem.number <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.giftSystem.ClearingInterface.noEnoughMoney"));
            return;
         }
         if(_nameInput.text == PlayerManager.Instance.Self.NickName)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.giftSystem.ClearingInterface.canNotYourSelf"));
            return;
         }
         if(_info.Label == 6 && _giftCartItem.number != 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.giftSystem.ClearingInterface.limit"));
            return;
         }
         SocketManager.Instance.out.sendBuyGift(_nameInput.text,_info.GoodsID,_giftCartItem.number,1);
      }
      
      private function __buyMoney(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         LeavePageManager.leaveToFillPath();
      }
      
      private function __showFramePanel(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var pos:Point = _chooseFriendBtn.localToGlobal(new Point(0,0));
         _friendList.x = pos.x - 95;
         _friendList.y = pos.y + _chooseFriendBtn.height;
         _friendList.setVisible = true;
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _chooseFriendBtn.removeEventListener("click",__showFramePanel);
         _buyMoneyBtn.removeEventListener("click",__buyMoney);
         _presentBtn.removeEventListener("click",__present);
         _giftCartItem.removeEventListener("numberIsChange",__numberChange);
         StageReferance.stage.removeEventListener("click",__hideDropList);
         _nameInput.removeEventListener("change",__onReceiverChange);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__moneyChange);
         GiftController.Instance.removeEventListener("sendGiftReturn",__sendRetrunHandler);
      }
      
      override public function dispose() : void
      {
         if(_dropList)
         {
            ObjectUtils.disposeObject(_dropList);
         }
         _dropList = null;
         if(_friendList)
         {
            ObjectUtils.disposeObject(_friendList);
         }
         _friendList = null;
         super.dispose();
         removeEvent();
         GiftManager.Instance.rebackName = "";
         _chooseFriendBtn = null;
         _nameInput = null;
         _dropList = null;
         _buyMoneyBtn = null;
         _presentBtn = null;
         _totalMoney = null;
         _poorMoney = null;
         _giftNum = null;
         _giftCartItem = null;
         _moneyIsEnough = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      protected function __hideDropList(event:Event) : void
      {
         if(event.target is FilterFrameText)
         {
            return;
         }
         if(_dropList && _dropList.parent)
         {
            _dropList.parent.removeChild(_dropList);
         }
      }
      
      protected function __onReceiverChange(event:Event) : void
      {
         if(_nameInput.text == "")
         {
            _dropList.dataList = null;
            return;
         }
         var list:Array = PlayerManager.Instance.onlineFriendList.concat(PlayerManager.Instance.offlineFriendList).concat(ConsortionModelManager.Instance.model.onlineConsortiaMemberList).concat(ConsortionModelManager.Instance.model.offlineConsortiaMemberList);
         _dropList.dataList = filterSearch(filterRepeatInArray(list),_nameInput.text);
      }
      
      private function filterRepeatInArray(filterArr:Array) : Array
      {
         var i:int = 0;
         var j:int = 0;
         var arr:Array = [];
         for(i = 0; i < filterArr.length; )
         {
            if(i == 0)
            {
               arr.push(filterArr[i]);
            }
            j = 0;
            while(j < arr.length)
            {
               if(arr[j].NickName != filterArr[i].NickName)
               {
                  if(j == arr.length - 1)
                  {
                     arr.push(filterArr[i]);
                  }
                  j++;
                  continue;
               }
               break;
            }
            i++;
         }
         return arr;
      }
      
      private function filterSearch(list:Array, targetStr:String) : Array
      {
         var i:int = 0;
         var result:Array = [];
         for(i = 0; i < list.length; )
         {
            if(list[i].NickName.indexOf(targetStr) != -1)
            {
               result.push(list[i]);
            }
            i++;
         }
         return result;
      }
      
      protected function __moneyChange(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Money"])
         {
            __numberChange(null);
         }
      }
      
      protected function __confirmResponse(event:FrameEvent) : void
      {
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__confirmResponse);
         ObjectUtils.disposeObject(frame);
         if(frame.parent)
         {
            frame.parent.removeChild(frame);
         }
         frame = null;
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
      }
   }
}
