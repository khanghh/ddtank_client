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
         var bg:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("email.writeBG1");
         addToContent(bg);
         _writingViewBG = ClassUtils.CreatInstance("asset.email.writeViewBg");
         PositionUtils.setPos(_writingViewBG,"writingView.BGPos");
         addToContent(_writingViewBG);
         var xuLine:Image = ComponentFactory.Instance.creatComponentByStylename("email.writeLine");
         addToContent(xuLine);
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
         var bg1:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("email.writeBG3");
         addToContent(bg1);
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
         var diamondTipImg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.email.diamondTipImg");
         addToContent(diamondTipImg);
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
      
      private function setTip(btn:SelectedCheckButton, data:String) : void
      {
         btn.tipStyle = "ddt.view.tips.OneLineTip";
         btn.tipDirctions = "0";
         btn.tipData = data;
         btn.tipGapV = 5;
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
      
      protected function __onBagTabChanged(event:Event) : void
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
      
      private function __hideDropList(event:MouseEvent) : void
      {
         if(event.target is FriendDropListTarget)
         {
            return;
         }
         if(_dropList && _dropList.parent)
         {
            _dropList.parent.removeChild(_dropList);
         }
      }
      
      private function __onReceiverChange(event:Event) : void
      {
         if(_receiver.text == "")
         {
            _dropList.dataList = null;
            return;
         }
         var list:Array = PlayerManager.Instance.onlineFriendList.concat(PlayerManager.Instance.offlineFriendList).concat(ConsortionModelManager.Instance.model.onlineConsortiaMemberList).concat(ConsortionModelManager.Instance.model.offlineConsortiaMemberList);
         _dropList.dataList = filterRepeatInArray(filterSearch(list,_receiver.text));
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
      
      public function set selectInfo(value:EmailInfo) : void
      {
         _selectInfo = value;
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
      
      private function selectName(nick:String, id:int = 0) : void
      {
         _receiver.text = nick;
         _friendList.setVisible = false;
      }
      
      public function dragDrop(effect:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            return;
         }
         effect.action = "move";
         var info:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(info && effect.action != "split")
         {
            if(_diamonds.annex == null)
            {
               _diamonds.dragDrop(effect);
               if(effect.target)
               {
                  return;
               }
            }
            effect.action = "none";
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
      
      private function payEnable(b:Boolean) : void
      {
         _topic.enable = !b;
         var _loc2_:* = b;
         _payForBtn.selected = _loc2_;
         _loc2_ = _loc2_;
         _payForBtn.enable = _loc2_;
         _loc2_ = _loc2_;
         _payForBtn.buttonMode = _loc2_;
         _loc2_ = _loc2_;
         _payForBtn.mouseEnabled = _loc2_;
         _payForBtn.mouseChildren = _loc2_;
         _moneyInput.enable = b;
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
      
      private function switchHourBtnState(isChargeMail:Boolean) : void
      {
         _oneHouerBtn.selected = false;
         _sixHouerBtn.selected = false;
         _oneHouerBtn.enable = isChargeMail;
         _sixHouerBtn.enable = isChargeMail;
         if(isChargeMail)
         {
            _currentHourBtn = _oneHouerBtn;
            _currentHourBtn.selected = true;
         }
      }
      
      private function __selectHourListener(e:MouseEvent) : void
      {
         btnSound();
         if(_currentHourBtn)
         {
            _currentHourBtn.selected = false;
         }
         _currentHourBtn = e.currentTarget as SelectedButton;
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
      
      private function __selectMoneyType(e:MouseEvent) : void
      {
         var diamond:* = null;
         isChargeMail = _payForBtn.selected;
         if(isChargeMail)
         {
            _moneyInput.enable = true;
            diamond = getFirstDiamond();
            if(StringUtils.trim(_moneyInput.text) == "" && !isNaN(diamond.annex.FloorPrice))
            {
               _lowestPrice = diamond._cell.goodsCount * diamond.annex.FloorPrice;
               _moneyInput.text = String(diamond._cell.goodsCount * diamond.annex.FloorPrice);
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
      
      private function __moneyChange(e:Event) : void
      {
         if(_moneyInput.text.charAt(0) == "0")
         {
            _moneyInput.text = "";
         }
         e.preventDefault();
      }
      
      private function __send(event:MouseEvent) : void
      {
         var alert:* = null;
         var param:* = null;
         var diamond:* = null;
         var annexArr:* = null;
         var tempDiamond:* = null;
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
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            alert.moveEnable = false;
            alert.addEventListener("response",__quickBuyResponse);
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
            param = {};
            param.NickName = _receiver.text;
            if(FilterWordManager.IsNullorEmpty(_topic.text))
            {
               _topic.text = getFirstDiamond().annex.Name;
            }
            param.Title = FilterWordManager.filterWrod(_topic.text);
            param.Content = FilterWordManager.filterWrod(_content.text);
            param.SendedMoney = Number(_moneyInput.text);
            param.isPay = isChargeMail;
            if(isChargeMail)
            {
               param.hours = _hours;
               diamond = getFirstDiamond();
               param.Title = diamond.annex.Name;
            }
            else
            {
               param.SendedMoney = 0;
            }
            annexArr = [];
            if(_diamonds.annex)
            {
               tempDiamond = _diamonds.annex as InventoryItemInfo;
               if(tempDiamond.CategoryID != 74)
               {
                  annexArr.push(tempDiamond);
                  param["Annex0"] = tempDiamond.BagType.toString() + "," + tempDiamond.Place.toString();
               }
               else
               {
                  param["Annex0"] = 100.toString() + "," + tempDiamond.ItemID.toString();
               }
            }
            param.Count = _diamonds._cell.goodsCount;
            MailControl.Instance.sendEmail(param);
            MailControl.Instance.onSendAnnex(annexArr);
            _sendBtn.enable = false;
         }
      }
      
      private function __quickBuyResponse(evt:FrameEvent) : void
      {
         var quickBuy:* = null;
         SoundManager.instance.play("008");
         var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__quickBuyResponse);
         frame.dispose();
         if(frame.parent)
         {
            frame.parent.removeChild(frame);
         }
         frame = null;
         if(evt.responseCode == 3)
         {
            quickBuy = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            quickBuy.itemID = 11233;
            quickBuy.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            LayerManager.Instance.addToLayer(quickBuy,2,true,1);
         }
      }
      
      private function __friendListView(event:MouseEvent) : void
      {
         btnSound();
         var pos:Point = _friendsBtn.localToGlobal(new Point(0,0));
         _friendList.x = pos.x + _friendsBtn.width;
         _friendList.y = pos.y;
         _friendList.setVisible = true;
      }
      
      private function __taInput(event:TextEvent) : void
      {
         if(_content.text.length > 300)
         {
            event.preventDefault();
         }
      }
      
      private function __sendEmailBack(e:PkgEvent) : void
      {
         _sendBtn.enable = true;
      }
      
      private function __StopEnter(e:KeyboardEvent) : void
      {
         if(e.keyCode == 13)
         {
            e.stopImmediatePropagation();
         }
         else if(e.keyCode == 27)
         {
            e.stopImmediatePropagation();
            SoundManager.instance.play("008");
            closeWin();
         }
      }
      
      private function addToStageListener(event:Event) : void
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
      
      private function __showBag(event:EmailEvent) : void
      {
         var diamond:DiamondOfWriting = event.target as DiamondOfWriting;
         if(diamond.annex == null || _bag.parent == null)
         {
            _bag.visible = true;
         }
      }
      
      private function __hideBag(event:EmailEvent) : void
      {
         _bag.visible = false;
      }
      
      private function __doDragIn(e:EmailEvent) : void
      {
         var diamond:* = null;
         var _loc3_:* = true;
         _payForBtn.enable = _loc3_;
         _loc3_ = _loc3_;
         _payForBtn.buttonMode = _loc3_;
         _loc3_ = _loc3_;
         _payForBtn.mouseEnabled = _loc3_;
         _payForBtn.mouseChildren = _loc3_;
         if(_topic.text == "" || !_titleIsManMade)
         {
            diamond = getFirstDiamond();
            if(diamond)
            {
               _topic.text = diamond.annex.Name;
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
      
      private function __doDragOut(e:EmailEvent) : void
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
      
      private function __sound(event:Event) : void
      {
         _titleIsManMade = true;
      }
      
      private function __frameClose(event:FrameEvent) : void
      {
         btnSound();
         closeWin();
      }
      
      private function __close(event:MouseEvent) : void
      {
         btnSound();
         closeWin();
      }
      
      private function __confirmResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirmResponse);
         _confirmFrame.dispose();
         _confirmFrame = null;
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            if(_type == 0)
            {
               okCancel();
            }
            dispatchEvent(new EmailEvent("closeWritingFrame"));
         }
      }
      
      public function set type(value:int) : void
      {
         _type = value;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function setName(value:String) : void
      {
         _receiver.text = value;
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
