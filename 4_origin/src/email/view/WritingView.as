package email.view
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.bag.BagFrames;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.list.DropList;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import consortion.ConsortionModelManager;
   import ddt.command.QuickBuyFrame;
   import ddt.data.email.EmailInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.EmailEvent;
   import ddt.events.PkgEvent;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import ddt.view.FriendDropListTarget;
   import ddt.view.chat.ChatFriendListPanel;
   import email.manager.MailControl;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import road7th.utils.StringHelper;
   
   public class WritingView extends Frame implements IAcceptDrag
   {
       
      
      private var _bag:Frame;
      
      private var _selectInfo:EmailInfo;
      
      private var isChargeMail:Boolean = false;
      
      private var _hours:uint;
      
      private var _titleIsManMade:Boolean = false;
      
      private var _friendList:ChatFriendListPanel;
      
      private var _writingViewBG:MovieClip;
      
      private var _receiver:FriendDropListTarget;
      
      private var _senderTip:FilterFrameText;
      
      private var _topicTip:FilterFrameText;
      
      private var _dropList:DropList;
      
      private var _topic:TextInput;
      
      private var _content:TextArea;
      
      private var _friendsBtn:TextButton;
      
      private var _houerBtnGroup:SelectedButtonGroup;
      
      private var _oneHouerBtn:SelectedCheckButton;
      
      private var _sixHouerBtn:SelectedCheckButton;
      
      private var _payForBtn:SelectedCheckButton;
      
      private var _moneyInput:TextInput;
      
      private var _sendBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var bagContent:BagFrames;
      
      private var _type:int;
      
      private var _diamonds:DiamondOfWriting;
      
      private var _payTipTxt1:FilterFrameText;
      
      private var _payTipTxt2:FilterFrameText;
      
      private var _lowestPrice:Number;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _currentHourBtn:SelectedButton;
      
      public function WritingView()
      {
         super();
         initView();
         addEvent();
         BagAndInfoManager.Instance.hideBagAndInfo();
      }
      
      private function initView() : void
      {
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("tank.view.emailII.writingView.titleTxt");
         var _loc2_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("email.writeBG1");
         addToContent(_loc2_);
         _writingViewBG = ClassUtils.CreatInstance("asset.email.writeViewBg");
         PositionUtils.setPos(_writingViewBG,"writingView.BGPos");
         addToContent(_writingViewBG);
         var _loc3_:Image = ComponentFactory.Instance.creatComponentByStylename("email.writeLine");
         addToContent(_loc3_);
         _senderTip = ComponentFactory.Instance.creatComponentByStylename("email.geterTipTxt");
         _senderTip.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.geterTip");
         addToContent(_senderTip);
         _topicTip = ComponentFactory.Instance.creatComponentByStylename("email.topicTipTxtII");
         _topicTip.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.topicTip");
         addToContent(_topicTip);
         _receiver = ComponentFactory.Instance.creat("email.receiverInput");
         addToContent(_receiver);
         _dropList = ComponentFactory.Instance.creatComponentByStylename("droplist.SimpleDropList");
         _dropList.targetDisplay = _receiver;
         _dropList.x = _receiver.x;
         _dropList.y = _receiver.y + _receiver.height;
         _topic = ComponentFactory.Instance.creat("email.writeTopicInput");
         _topic.textField.maxChars = 16;
         addToContent(_topic);
         _content = ComponentFactory.Instance.creatComponentByStylename("email.writeContent");
         _content.textField.maxChars = 200;
         addToContent(_content);
         _friendsBtn = ComponentFactory.Instance.creat("email.friendsBtn");
         _friendsBtn.text = LanguageMgr.GetTranslation("tank.view.emailII.writingView.friendlist");
         addToContent(_friendsBtn);
         var _loc4_:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("email.writeBG3");
         addToContent(_loc4_);
         _houerBtnGroup = new SelectedButtonGroup();
         _oneHouerBtn = ComponentFactory.Instance.creatComponentByStylename("email.oneHouerBtn");
         _oneHouerBtn.text = LanguageMgr.GetTranslation("tank.view.emailII.writingView.onehour");
         setTip(_oneHouerBtn,LanguageMgr.GetTranslation("tank.view.emailII.WritingView.backTime"));
         addToContent(_oneHouerBtn);
         _houerBtnGroup.addSelectItem(_oneHouerBtn);
         _oneHouerBtn.enable = false;
         _sixHouerBtn = ComponentFactory.Instance.creatComponentByStylename("email.sixHouerBtn");
         _sixHouerBtn.text = LanguageMgr.GetTranslation("tank.view.emailII.writingView.sixhour");
         setTip(_sixHouerBtn,LanguageMgr.GetTranslation("tank.view.emailII.WritingView.backTime2"));
         addToContent(_sixHouerBtn);
         _houerBtnGroup.addSelectItem(_sixHouerBtn);
         _sixHouerBtn.enable = false;
         _payForBtn = ComponentFactory.Instance.creatComponentByStylename("email.payForBtn");
         addToContent(_payForBtn);
         _payForBtn.enable = false;
         _payTipTxt1 = ComponentFactory.Instance.creatComponentByStylename("email.moneyInputTip1");
         _payTipTxt1.text = LanguageMgr.GetTranslation("tank.view.emailII.writingView.paytip1");
         addToContent(_payTipTxt1);
         _payTipTxt2 = ComponentFactory.Instance.creatComponentByStylename("email.moneyInputTip2");
         _payTipTxt2.text = LanguageMgr.GetTranslation("tank.view.emailII.writingView.paytip2");
         addToContent(_payTipTxt2);
         _moneyInput = ComponentFactory.Instance.creat("email.moneyInput");
         _moneyInput.beginChanges();
         _moneyInput.text = "";
         _moneyInput.textField.restrict = "0-9";
         _moneyInput.textField.maxChars = 9;
         _moneyInput.visible = true;
         _moneyInput.commitChanges();
         addToContent(_moneyInput);
         _sendBtn = ComponentFactory.Instance.creat("email.sendBtn");
         _sendBtn.text = LanguageMgr.GetTranslation("send");
         addToContent(_sendBtn);
         _cancelBtn = ComponentFactory.Instance.creat("email.cancelBtn");
         _cancelBtn.text = LanguageMgr.GetTranslation("cancel");
         addToContent(_cancelBtn);
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.email.diamondTipImg");
         addToContent(_loc1_);
         _friendList = new ChatFriendListPanel();
         _friendList.setup(selectName);
         _bag = ComponentFactory.Instance.creat("email.emialBagFrame");
         _bag.titleText = LanguageMgr.GetTranslation("tank.view.emailII.BagFrame.selectBag");
         addToContent(_bag);
         bagContent = ComponentFactory.Instance.creat("email.bagContent");
         bagContent.emailBagView.setBagType(1);
         bagContent.emailBagView.tableEnable = false;
         bagContent.emailBagView.isNeedCard(false);
         bagContent.emailBagView.cardbtnVible = false;
         bagContent.emailBagView.tableEnable = true;
         bagContent.emailBagView.initBeadButton();
         bagContent.emailBagView.switchButtomVisible(true);
         bagContent.emailBagView.cellDoubleClickEnable = false;
         _bag.addToContent(bagContent);
         bagContent.graySortBtn();
         bagContent.emailBagView.sortBagEnable = false;
         bagContent.emailBagView.breakBtnEnable = false;
         bagContent.emailBagView.breakBtnFilter = ComponentFactory.Instance.creatFilters("grayFilter");
         _diamonds = new DiamondOfWriting();
         addToContent(_diamonds);
         PositionUtils.setPos(_diamonds,"writingView.diaPos");
      }
      
      private function setTip(param1:SelectedCheckButton, param2:String) : void
      {
         param1.tipStyle = "ddt.view.tips.OneLineTip";
         param1.tipDirctions = "0";
         param1.tipData = param2;
         param1.tipGapV = 5;
      }
      
      private function addEvent() : void
      {
         _receiver.addEventListener("change",__onReceiverChange);
         _receiver.addEventListener("focusIn",__onReceiverChange);
         StageReferance.stage.addEventListener("click",__hideDropList);
         _content.textField.addEventListener("change",__sound);
         _content.textField.addEventListener("textInput",__taInput);
         _friendsBtn.addEventListener("click",__friendListView);
         _oneHouerBtn.addEventListener("click",__selectHourListener);
         _sixHouerBtn.addEventListener("click",__selectHourListener);
         _payForBtn.addEventListener("click",__selectMoneyType);
         _moneyInput.textField.addEventListener("change",__moneyChange);
         _sendBtn.addEventListener("click",__send);
         _cancelBtn.addEventListener("click",__close);
         SocketManager.Instance.addEventListener(PkgEvent.format(116),__sendEmailBack);
         addEventListener("keyDown",__StopEnter);
         addEventListener("addedToStage",addToStageListener);
         addEventListener("response",__frameClose);
         _diamonds.addEventListener("showBagframe",__showBag);
         _diamonds.addEventListener("hideBagframe",__hideBag);
         _diamonds.addEventListener("draginAnniex",__doDragIn);
         _diamonds.addEventListener("dragoutAnniex",__doDragOut);
         bagContent.emailBagView.addEventListener("tabChange",__onBagTabChanged);
      }
      
      protected function __onBagTabChanged(param1:Event) : void
      {
         if(bagContent.emailBagView.bagType == 21)
         {
            bagContent.emailBagView.switchButtomVisible(false);
            bagContent.emailBagView.enableBeadFunctionBtns(false);
         }
         else
         {
            bagContent.emailBagView.switchButtomVisible(true);
         }
      }
      
      private function __hideDropList(param1:MouseEvent) : void
      {
         if(param1.target is FriendDropListTarget)
         {
            return;
         }
         if(_dropList && _dropList.parent)
         {
            _dropList.parent.removeChild(_dropList);
         }
      }
      
      private function __onReceiverChange(param1:Event) : void
      {
         if(_receiver.text == "")
         {
            _dropList.dataList = null;
            return;
         }
         var _loc2_:Array = PlayerManager.Instance.onlineFriendList.concat(PlayerManager.Instance.offlineFriendList).concat(ConsortionModelManager.Instance.model.onlineConsortiaMemberList).concat(ConsortionModelManager.Instance.model.offlineConsortiaMemberList);
         _dropList.dataList = filterRepeatInArray(filterSearch(_loc2_,_receiver.text));
      }
      
      private function filterRepeatInArray(param1:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(_loc4_ == 0)
            {
               _loc2_.push(param1[_loc4_]);
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_[_loc3_].NickName != param1[_loc4_].NickName)
               {
                  if(_loc3_ == _loc2_.length - 1)
                  {
                     _loc2_.push(param1[_loc4_]);
                  }
                  _loc3_++;
                  continue;
               }
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function filterSearch(param1:Array, param2:String) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_].NickName.indexOf(param2) != -1)
            {
               _loc3_.push(param1[_loc4_]);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function removeEvent() : void
      {
         _friendsBtn.removeEventListener("click",__friendListView);
         _oneHouerBtn.removeEventListener("click",__selectHourListener);
         _sixHouerBtn.removeEventListener("click",__selectHourListener);
         _payForBtn.removeEventListener("click",__selectMoneyType);
         _moneyInput.textField.removeEventListener("change",__moneyChange);
         _sendBtn.removeEventListener("click",__send);
         _cancelBtn.removeEventListener("click",__close);
         SocketManager.Instance.removeEventListener(PkgEvent.format(116),__sendEmailBack);
         removeEventListener("keyDown",__StopEnter);
         removeEventListener("addedToStage",addToStageListener);
         removeEventListener("response",__frameClose);
         _diamonds.removeEventListener("showBagframe",__showBag);
         _diamonds.removeEventListener("hideBagframe",__hideBag);
         _diamonds.removeEventListener("draginAnniex",__doDragIn);
         _diamonds.removeEventListener("dragoutAnniex",__doDragOut);
         bagContent.emailBagView.removeEventListener("tabChange",__onBagTabChanged);
      }
      
      public function set selectInfo(param1:EmailInfo) : void
      {
         _selectInfo = param1;
      }
      
      public function isHasWrite() : Boolean
      {
         if(!StringHelper.isNullOrEmpty(FilterWordManager.filterWrod(_receiver.text)))
         {
            return true;
         }
         if(!StringHelper.isNullOrEmpty(FilterWordManager.filterWrod(_topic.text)))
         {
            return true;
         }
         if(!StringHelper.isNullOrEmpty(FilterWordManager.filterWrod(_content.text)))
         {
            return true;
         }
         if(_diamonds.annex)
         {
            return true;
         }
         return false;
      }
      
      private function selectName(param1:String, param2:int = 0) : void
      {
         _receiver.text = param1;
         _friendList.setVisible = false;
      }
      
      public function dragDrop(param1:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            return;
         }
         param1.action = "move";
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc2_ && param1.action != "split")
         {
            if(_diamonds.annex == null)
            {
               _diamonds.dragDrop(param1);
               if(param1.target)
               {
                  return;
               }
            }
            param1.action = "none";
         }
      }
      
      public function reset() : void
      {
         _receiver.text = "";
         _topic.text = "";
         _content.text = "";
         _moneyInput.text = "";
         _diamonds.annex = null;
         _payForBtn.enable = false;
         _oneHouerBtn.enable = false;
         _sixHouerBtn.enable = false;
         _currentHourBtn = null;
         _hours = 1;
         setDiamondMoneyType();
      }
      
      private function btnSound() : void
      {
         SoundManager.instance.play("043");
      }
      
      private function getFirstDiamond() : DiamondOfWriting
      {
         if(_diamonds.annex)
         {
            return _diamonds;
         }
         return null;
      }
      
      public function closeWin() : void
      {
         if(isHasWrite())
         {
            if(_confirmFrame == null)
            {
               _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.view.emailII.WritingView.tip"),LanguageMgr.GetTranslation("tank.view.emailII.WritingView.isEdit"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               _confirmFrame.addEventListener("response",__confirmResponse);
            }
         }
         else if(_type == 0)
         {
            okCancel();
            dispatchEvent(new EmailEvent("closeWritingFrame"));
         }
      }
      
      public function okCancel() : void
      {
         btnSound();
         reset();
         _diamonds.setBagUnlock();
         if(_friendList && _friendList.parent)
         {
            _friendList.setVisible = false;
         }
         _bag.visible = false;
         MailControl.Instance.changeState("read");
      }
      
      private function payEnable(param1:Boolean) : void
      {
         _topic.enable = !param1;
         var _loc2_:* = param1;
         _payForBtn.selected = _loc2_;
         _loc2_ = _loc2_;
         _payForBtn.enable = _loc2_;
         _loc2_ = _loc2_;
         _payForBtn.buttonMode = _loc2_;
         _loc2_ = _loc2_;
         _payForBtn.mouseEnabled = _loc2_;
         _payForBtn.mouseChildren = _loc2_;
         _moneyInput.enable = param1;
         _moneyInput.text = "";
         isChargeMail = _payForBtn.selected;
      }
      
      private function atLeastOneDiamond() : Boolean
      {
         if(_diamonds.annex)
         {
            return true;
         }
         return false;
      }
      
      private function setDiamondMoneyType() : void
      {
         _diamonds.chargedImg.visible = false;
         _diamonds.centerMC.visible = true;
         if(_diamonds.annex && isChargeMail)
         {
            _diamonds.centerMC.visible = false;
            _diamonds.chargedImg.visible = true;
         }
         else if(_diamonds.annex && !isChargeMail)
         {
            _diamonds.centerMC.visible = false;
         }
         else
         {
            _diamonds.centerMC.setFrame(1);
         }
         switchHourBtnState(isChargeMail);
      }
      
      private function switchHourBtnState(param1:Boolean) : void
      {
         _oneHouerBtn.selected = false;
         _sixHouerBtn.selected = false;
         _oneHouerBtn.enable = param1;
         _sixHouerBtn.enable = param1;
         if(param1)
         {
            _currentHourBtn = _oneHouerBtn;
            _currentHourBtn.selected = true;
         }
      }
      
      private function __selectHourListener(param1:MouseEvent) : void
      {
         btnSound();
         if(_currentHourBtn)
         {
            _currentHourBtn.selected = false;
         }
         _currentHourBtn = param1.currentTarget as SelectedButton;
         _currentHourBtn.selected = true;
         if(_currentHourBtn == _oneHouerBtn)
         {
            _hours = 1;
         }
         else
         {
            _hours = 6;
         }
      }
      
      private function __selectMoneyType(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         isChargeMail = _payForBtn.selected;
         if(isChargeMail)
         {
            _moneyInput.enable = true;
            _loc2_ = getFirstDiamond();
            if(StringUtils.trim(_moneyInput.text) == "" && !isNaN(_loc2_.annex.FloorPrice))
            {
               _lowestPrice = _loc2_._cell.goodsCount * _loc2_.annex.FloorPrice;
               _moneyInput.text = String(_loc2_._cell.goodsCount * _loc2_.annex.FloorPrice);
            }
         }
         else
         {
            _moneyInput.enable = false;
            _moneyInput.text = "";
         }
         btnSound();
         _topic.enable = !_payForBtn.selected;
         if(_payForBtn.selected)
         {
            _moneyInput.setFocus();
            var _loc3_:* = true;
            _payForBtn.buttonMode = _loc3_;
            _loc3_ = _loc3_;
            _payForBtn.mouseEnabled = _loc3_;
            _payForBtn.mouseChildren = _loc3_;
         }
         setDiamondMoneyType();
      }
      
      private function __moneyChange(param1:Event) : void
      {
         if(_moneyInput.text.charAt(0) == "0")
         {
            _moneyInput.text = "";
         }
         param1.preventDefault();
      }
      
      private function __send(param1:MouseEvent) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         btnSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(FilterWordManager.IsNullorEmpty(_receiver.text))
         {
            _receiver.text = "";
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.WritingView.sender"));
         }
         else if(_receiver.text == PlayerManager.Instance.Self.NickName)
         {
            _receiver.text = "";
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.WritingView.NickName"));
         }
         else if(FilterWordManager.IsNullorEmpty(_topic.text) && !getFirstDiamond())
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.WritingView.topic"));
         }
         else if(PlayerManager.Instance.Self.Gold < 100)
         {
            _loc5_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            _loc5_.moveEnable = false;
            _loc5_.addEventListener("response",__quickBuyResponse);
         }
         else if(_content.text.length > 200)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.WritingView.contentLength"));
         }
         else
         {
            if(isChargeMail && !Number(_moneyInput.text))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.WritingView.money_txt"));
               return;
            }
            if(isChargeMail && !atLeastOneDiamond())
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.WritingView.annex"));
               return;
            }
            if(isChargeMail && (Number(_moneyInput.text) < _lowestPrice || Number(_moneyInput.text) <= 0))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.email.view.WritingView.Lowest",String(_lowestPrice)));
               return;
            }
            if(!isChargeMail && int(_moneyInput.text) > PlayerManager.Instance.Self.Money)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            _loc4_ = {};
            _loc4_.NickName = _receiver.text;
            if(FilterWordManager.IsNullorEmpty(_topic.text))
            {
               _topic.text = getFirstDiamond().annex.Name;
            }
            _loc4_.Title = FilterWordManager.filterWrod(_topic.text);
            _loc4_.Content = FilterWordManager.filterWrod(_content.text);
            _loc4_.SendedMoney = Number(_moneyInput.text);
            _loc4_.isPay = isChargeMail;
            if(isChargeMail)
            {
               _loc4_.hours = _hours;
               _loc6_ = getFirstDiamond();
               _loc4_.Title = _loc6_.annex.Name;
            }
            else
            {
               _loc4_.SendedMoney = 0;
            }
            _loc3_ = [];
            if(_diamonds.annex)
            {
               _loc2_ = _diamonds.annex as InventoryItemInfo;
               _loc3_.push(_loc2_);
               _loc4_["Annex0"] = _loc2_.BagType.toString() + "," + _loc2_.Place.toString();
            }
            _loc4_.Count = _diamonds._cell.goodsCount;
            MailControl.Instance.sendEmail(_loc4_);
            MailControl.Instance.onSendAnnex(_loc3_);
            _sendBtn.enable = false;
         }
      }
      
      private function __quickBuyResponse(param1:FrameEvent) : void
      {
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__quickBuyResponse);
         _loc2_.dispose();
         if(_loc2_.parent)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
         _loc2_ = null;
         if(param1.responseCode == 3)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _loc3_.itemID = 11233;
            _loc3_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            LayerManager.Instance.addToLayer(_loc3_,2,true,1);
         }
      }
      
      private function __friendListView(param1:MouseEvent) : void
      {
         btnSound();
         var _loc2_:Point = _friendsBtn.localToGlobal(new Point(0,0));
         _friendList.x = _loc2_.x + _friendsBtn.width;
         _friendList.y = _loc2_.y;
         _friendList.setVisible = true;
      }
      
      private function __taInput(param1:TextEvent) : void
      {
         if(_content.text.length > 300)
         {
            param1.preventDefault();
         }
      }
      
      private function __sendEmailBack(param1:PkgEvent) : void
      {
         _sendBtn.enable = true;
      }
      
      private function __StopEnter(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            param1.stopImmediatePropagation();
         }
         else if(param1.keyCode == 27)
         {
            param1.stopImmediatePropagation();
            SoundManager.instance.play("008");
            closeWin();
         }
      }
      
      private function addToStageListener(param1:Event) : void
      {
         reset();
         _receiver.text = !!_selectInfo?_selectInfo.Sender:"";
         _topic.text = "";
         _content.text = "";
         _moneyInput.text = "";
         _moneyInput.enable = false;
         _bag.visible = true;
         if(stage)
         {
            stage.focus = this;
         }
         _diamonds.annex = null;
      }
      
      private function __showBag(param1:EmailEvent) : void
      {
         var _loc2_:DiamondOfWriting = param1.target as DiamondOfWriting;
         if(_loc2_.annex == null || _bag.parent == null)
         {
            _bag.visible = true;
         }
      }
      
      private function __hideBag(param1:EmailEvent) : void
      {
         _bag.visible = false;
      }
      
      private function __doDragIn(param1:EmailEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = true;
         _payForBtn.enable = _loc3_;
         _loc3_ = _loc3_;
         _payForBtn.buttonMode = _loc3_;
         _loc3_ = _loc3_;
         _payForBtn.mouseEnabled = _loc3_;
         _payForBtn.mouseChildren = _loc3_;
         if(_topic.text == "" || !_titleIsManMade)
         {
            _loc2_ = getFirstDiamond();
            if(_loc2_)
            {
               _topic.text = _loc2_.annex.Name;
               _titleIsManMade = false;
            }
            else
            {
               _topic.text = "";
               _titleIsManMade = false;
            }
         }
         setDiamondMoneyType();
      }
      
      private function __doDragOut(param1:EmailEvent) : void
      {
         if(atLeastOneDiamond())
         {
            _payForBtn.enable = true;
         }
         else
         {
            payEnable(false);
            _topic.text = "";
         }
         setDiamondMoneyType();
      }
      
      private function __sound(param1:Event) : void
      {
         _titleIsManMade = true;
      }
      
      private function __frameClose(param1:FrameEvent) : void
      {
         btnSound();
         closeWin();
      }
      
      private function __close(param1:MouseEvent) : void
      {
         btnSound();
         closeWin();
      }
      
      private function __confirmResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirmResponse);
         _confirmFrame.dispose();
         _confirmFrame = null;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(_type == 0)
            {
               okCancel();
            }
            dispatchEvent(new EmailEvent("closeWritingFrame"));
         }
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function setName(param1:String) : void
      {
         _receiver.text = param1;
      }
      
      override public function dispose() : void
      {
         _diamonds.setBagUnlock();
         removeEvent();
         if(_bag)
         {
            ObjectUtils.disposeObject(_bag);
         }
         _bag = null;
         if(bagContent)
         {
            bagContent.dispose();
         }
         bagContent = null;
         ObjectUtils.disposeObject(_payTipTxt1);
         _payTipTxt1 = null;
         ObjectUtils.disposeObject(_payTipTxt2);
         _payTipTxt2 = null;
         ObjectUtils.disposeObject(_friendList);
         _friendList = null;
         ObjectUtils.disposeObject(_writingViewBG);
         _writingViewBG = null;
         ObjectUtils.disposeObject(_receiver);
         _receiver = null;
         ObjectUtils.disposeObject(_dropList);
         _dropList = null;
         ObjectUtils.disposeObject(_topic);
         _topic = null;
         ObjectUtils.disposeObject(_friendsBtn);
         _friendsBtn = null;
         ObjectUtils.disposeObject(_houerBtnGroup);
         _houerBtnGroup = null;
         ObjectUtils.disposeObject(_oneHouerBtn);
         _oneHouerBtn = null;
         ObjectUtils.disposeObject(_sixHouerBtn);
         _sixHouerBtn = null;
         ObjectUtils.disposeObject(_payForBtn);
         _payForBtn = null;
         ObjectUtils.disposeObject(_moneyInput);
         _moneyInput = null;
         ObjectUtils.disposeObject(_sendBtn);
         _sendBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_confirmFrame);
         _confirmFrame = null;
         ObjectUtils.disposeObject(_diamonds);
         _diamonds = null;
         ObjectUtils.disposeObject(_selectInfo);
         _selectInfo = null;
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
         if(_senderTip)
         {
            ObjectUtils.disposeObject(_senderTip);
         }
         _senderTip = null;
         if(_topicTip)
         {
            ObjectUtils.disposeObject(_topicTip);
         }
         _topicTip = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
         dispatchEvent(new EmailEvent("disposed"));
      }
   }
}
