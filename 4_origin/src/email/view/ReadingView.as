package email.view
{
   import baglocked.BaglockedManager;
   import baglocked.SetPassEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.email.EmailInfo;
   import ddt.data.email.EmailInfoOfSended;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.IMManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import ddt.view.common.LevelIcon;
   import ddtBuried.BuriedManager;
   import email.MailManager;
   import email.manager.MailControl;
   import feedback.FeedbackManager;
   import feedback.data.FeedbackInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import giftSystem.GiftManager;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   import socialContact.friendBirthday.FriendBirthdayManager;
   
   public class ReadingView extends Frame
   {
       
      
      private var _info:EmailInfo;
      
      private var _readOnly:Boolean;
      
      private var _isCanReply:Boolean;
      
      private var _readBG:MutipleImage;
      
      private var _readViewBg:MovieClip;
      
      private var _prompt:FilterFrameText;
      
      private var _senderTip:FilterFrameText;
      
      private var _topicTip:FilterFrameText;
      
      private var _sender:FilterFrameText;
      
      private var _topic:FilterFrameText;
      
      private var _content:TextArea;
      
      private var _personalImgBg:MovieImage;
      
      private var _leftTopBtnGroup:SelectedButtonGroup;
      
      private var _emailListButton:SelectedTextButton;
      
      private var _noReadButton:SelectedTextButton;
      
      private var _sendedButton:SelectedTextButton;
      
      private var _leftPageBtn:BaseButton;
      
      private var _rightPageBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _dianquanTxt:FilterFrameText;
      
      private var _selectAllBtn:TextButton;
      
      private var _deleteBtn:TextButton;
      
      private var _reciveMailBtn:TextButton;
      
      private var _reply_btn:TextButton;
      
      private var _close_btn:TextButton;
      
      private var _write_btn:TextButton;
      
      private var _help_btn:BaseButton;
      
      private var _diamonds:Array;
      
      private var _list:EmailListView;
      
      private var _diamondHBox:HBox;
      
      private var _addFriend:TextButton;
      
      private var _rebackGiftBtn:TextButton;
      
      private var _presentGiftBtn:TextButton;
      
      private var _playerview:RoomCharacter;
      
      private var _levelIcon:LevelIcon;
      
      private var _tempInfo:PlayerInfo;
      
      private const _PRESENTGIFT:int = 16;
      
      private var _complainBtn:TextButton;
      
      private var _complainAlert:BaseAlerFrame;
      
      private var _alertFrame:BaseAlerFrame;
      
      private var _sendBtn:TextButton;
      
      public function ReadingView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:* = 0;
         titleText = LanguageMgr.GetTranslation("tank.view.common.BellowStripViewII.email");
         _readBG = ComponentFactory.Instance.creatComponentByStylename("email.readBG");
         addToContent(_readBG);
         _readViewBg = ClassUtils.CreatInstance("asset.email.readViewBg");
         PositionUtils.setPos(_readViewBg,"readingViewBG.pos");
         addToContent(_readViewBg);
         addLeftTopBtnGroup();
         var _loc1_:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("email.PageCountBg");
         addToContent(_loc1_);
         _leftPageBtn = ComponentFactory.Instance.creat("email.leftPageBtn");
         addToContent(_leftPageBtn);
         _rightPageBtn = ComponentFactory.Instance.creat("email.rightPageBtn");
         addToContent(_rightPageBtn);
         _pageTxt = ComponentFactory.Instance.creat("email.pageTxt");
         _pageTxt.text = "1/1";
         addToContent(_pageTxt);
         _dianquanTxt = ComponentFactory.Instance.creat("email.pageTxt");
         _dianquanTxt.text = "";
         _dianquanTxt.x = 640;
         _dianquanTxt.y = 375;
         addToContent(_dianquanTxt);
         _selectAllBtn = ComponentFactory.Instance.creat("email.selectAllBtn");
         _selectAllBtn.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.textBtnFont1");
         addToContent(_selectAllBtn);
         _deleteBtn = ComponentFactory.Instance.creat("email.deleteBtn");
         _deleteBtn.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.textBtnFont2");
         addToContent(_deleteBtn);
         _reciveMailBtn = ComponentFactory.Instance.creat("email.reciveMailBtn");
         _reciveMailBtn.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.textBtnFont3");
         addToContent(_reciveMailBtn);
         _prompt = ComponentFactory.Instance.creatComponentByStylename("email.promptTxt");
         _prompt.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.prompt");
         addToContent(_prompt);
         _prompt.visible = false;
         _senderTip = ComponentFactory.Instance.creatComponentByStylename("email.senderTipTxt");
         _senderTip.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.senderTip");
         addToContent(_senderTip);
         _topicTip = ComponentFactory.Instance.creatComponentByStylename("email.topicTipTxt");
         _topicTip.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.topicTip");
         addToContent(_topicTip);
         var _loc2_:Image = ComponentFactory.Instance.creatComponentByStylename("email.VerticalLine");
         addToContent(_loc2_);
         _sender = ComponentFactory.Instance.creat("email.senderTxt");
         _sender.maxChars = 36;
         addToContent(_sender);
         _topic = ComponentFactory.Instance.creat("email.topicTxt");
         _topic.maxChars = 22;
         addToContent(_topic);
         _content = ComponentFactory.Instance.creatComponentByStylename("email.content");
         addToContent(_content);
         _diamondHBox = ComponentFactory.Instance.creat("emial.diamondHbox");
         addToContent(_diamondHBox);
         _diamonds = [];
         _loc3_ = uint(0);
         while(_loc3_ < 5)
         {
            _diamonds[_loc3_] = new DiamondOfReading();
            _diamonds[_loc3_].index = _loc3_;
            _diamondHBox.addChild(_diamonds[_loc3_]);
            _loc3_++;
         }
         _diamondHBox.refreshChildPos();
         _reply_btn = ComponentFactory.Instance.creat("email.replyBtn");
         _reply_btn.text = LanguageMgr.GetTranslation("reply_btn.label");
         addToContent(_reply_btn);
         _write_btn = ComponentFactory.Instance.creat("email.writeBtn");
         _write_btn.text = LanguageMgr.GetTranslation("write_btn.label");
         addToContent(_write_btn);
         _close_btn = ComponentFactory.Instance.creat("email.closeBtn");
         addToContent(_close_btn);
         _close_btn.text = LanguageMgr.GetTranslation("cancel");
         _help_btn = HelpFrameUtils.Instance.simpleHelpButton(this,"email.helpPageBtn",null,LanguageMgr.GetTranslation("tank.view.emailII.ReadingView.useHelp"),"email.helpPageWord",400,485,true,true,{"submitLabel":LanguageMgr.GetTranslation("close")});
         _list = ComponentFactory.Instance.creat("email.emailListView");
         addToContent(_list);
         isCanReply = false;
         _personalImgBg = ComponentFactory.Instance.creat("emial.personalImgBg");
         addToContent(_personalImgBg);
         _personalImgBg.visible = false;
         _addFriend = ComponentFactory.Instance.creatComponentByStylename("email.addFriendBtn");
         _addFriend.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.textBtnFont4");
         _addFriend.enable = false;
         addToContent(_addFriend);
         _sendBtn = ComponentFactory.Instance.creatComponentByStylename("email.payForFriendBtn");
         _sendBtn.text = LanguageMgr.GetTranslation("shop.view.present");
         _sendBtn.visible = false;
         addToContent(_sendBtn);
         _rebackGiftBtn = ComponentFactory.Instance.creatComponentByStylename("email.rebackGiftBtn");
         _rebackGiftBtn.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.rebackGiftBtn");
         addToContent(_rebackGiftBtn);
         _rebackGiftBtn.visible = false;
         _presentGiftBtn = ComponentFactory.Instance.creatComponentByStylename("email.giveGiftBtn");
         _presentGiftBtn.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.presentGiftBtn");
         addToContent(_presentGiftBtn);
         _presentGiftBtn.visible = false;
         if(PathManager.solveFeedbackEnable())
         {
            _complainBtn = ComponentFactory.Instance.creatComponentByStylename("email.complainbtn");
            _complainBtn.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.textBtnFont5");
            addToContent(_complainBtn);
            _complainBtn.visible = false;
         }
      }
      
      private function addLeftTopBtnGroup() : void
      {
         _leftTopBtnGroup = new SelectedButtonGroup();
         _emailListButton = ComponentFactory.Instance.creat("emailListBtn");
         _emailListButton.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.selectBtnFont1");
         _leftTopBtnGroup.addSelectItem(_emailListButton);
         addToContent(_emailListButton);
         _noReadButton = ComponentFactory.Instance.creat("noReadBtn");
         _noReadButton.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.selectBtnFont2");
         _leftTopBtnGroup.addSelectItem(_noReadButton);
         addToContent(_noReadButton);
         _sendedButton = ComponentFactory.Instance.creat("sendedBtn");
         _sendedButton.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.selectBtnFont3");
         _leftTopBtnGroup.addSelectItem(_sendedButton);
         addToContent(_sendedButton);
         _leftTopBtnGroup.selectIndex = 0;
         MailControl.Instance.curShowPage = "mail";
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         _emailListButton.addEventListener("click",__selectMailTypeListener);
         _noReadButton.addEventListener("click",__selectMailTypeListener);
         _sendedButton.addEventListener("click",__selectMailTypeListener);
         _leftPageBtn.addEventListener("click",__lastPage);
         _rightPageBtn.addEventListener("click",__nextPage);
         _selectAllBtn.addEventListener("click",__selectAllListener);
         _deleteBtn.addEventListener("click",__deleteSelectListener);
         _reciveMailBtn.addEventListener("click",__receiveExListener);
         _sendBtn.addEventListener("click",payforfriendHander);
         _reply_btn.addEventListener("click",__reply);
         _close_btn.addEventListener("click",__close);
         _write_btn.addEventListener("click",__write);
         _addFriend.addEventListener("click",__addFriend);
         _rebackGiftBtn.addEventListener("click",__rebackGift);
         _presentGiftBtn.addEventListener("click",_clickPresent);
         if(PathManager.solveFeedbackEnable())
         {
            _complainBtn.addEventListener("click",__complainhandler);
         }
         if(_content)
         {
            _content.addEventListener("link",__contentLinkHandler);
            _content.addEventListener("mouseOver",__contentRollOverHandler);
         }
      }
      
      private function __contentLinkHandler(param1:TextEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:Array = param1.text.split(":");
         if(!_loc2_ || _loc2_.length <= 0)
         {
            return;
         }
         MailManager.Instance.readingViewLinkHandler(_loc2_);
      }
      
      private function __contentRollOverHandler(param1:MouseEvent) : void
      {
         Mouse.cursor = "auto";
      }
      
      private function payforfriendHander(param1:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!_info)
         {
            return;
         }
         if(!BuriedManager.Instance.checkMoney(false,Math.abs(_info.Money)))
         {
            if(_info.Type == 81)
            {
               SocketManager.Instance.out.isAcceptPayShop(true,_info.ID);
            }
            else if(_info.Type == 83)
            {
               SocketManager.Instance.out.isAcceptPayAuc(true,_info.ID);
            }
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _emailListButton.removeEventListener("click",__selectMailTypeListener);
         _noReadButton.removeEventListener("click",__selectMailTypeListener);
         _sendedButton.removeEventListener("click",__selectMailTypeListener);
         _leftPageBtn.removeEventListener("click",__lastPage);
         _rightPageBtn.removeEventListener("mouseDown",__nextPage);
         _selectAllBtn.removeEventListener("click",__selectAllListener);
         _deleteBtn.removeEventListener("click",__deleteSelectListener);
         _reciveMailBtn.removeEventListener("click",__receiveExListener);
         _sendBtn.removeEventListener("click",payforfriendHander);
         _reply_btn.removeEventListener("click",__reply);
         _close_btn.removeEventListener("click",__close);
         _write_btn.removeEventListener("click",__write);
         _addFriend.removeEventListener("click",__addFriend);
         _rebackGiftBtn.removeEventListener("click",__rebackGift);
         _presentGiftBtn.removeEventListener("click",_clickPresent);
         if(PathManager.solveFeedbackEnable())
         {
            _complainBtn.addEventListener("click",__complainhandler);
         }
         if(_content)
         {
            _content.removeEventListener("link",__contentLinkHandler);
            _content.removeEventListener("mouseOver",__contentRollOverHandler);
         }
      }
      
      private function __complainhandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _complainAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("email.complain.confim"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
         _complainAlert.addEventListener("response",__frameResponse);
      }
      
      protected function __frameResponse(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(FeedbackManager.instance.examineTime())
               {
                  _loc2_ = new FeedbackInfo();
                  _loc2_.question_title = LanguageMgr.GetTranslation("email.complain.lan");
                  _loc2_.question_content = _info.Content;
                  _loc2_.occurrence_date = DateUtils.dateFormat(new Date());
                  _loc2_.question_type = 8;
                  _loc2_.report_user_name = _info.Sender;
                  FeedbackManager.instance.submitFeedbackInfo(_loc2_);
                  break;
               }
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.SystemsAnalysis"));
               break;
         }
         _complainAlert.removeEventListener("response",__frameResponse);
         _complainAlert.dispose();
         _complainAlert = null;
      }
      
      public function set info(param1:EmailInfo) : void
      {
         _info = param1;
         if(!_info)
         {
            _sendBtn.visible = false;
            _dianquanTxt.text = "";
         }
         if(_info)
         {
            if(_info.Type == 81 || _info.Type == 83)
            {
               _sendBtn.visible = true;
               _dianquanTxt.text = int(_info.Money) + LanguageMgr.GetTranslation("ddt.money");
            }
            else
            {
               _sendBtn.visible = false;
               _dianquanTxt.text = "";
            }
         }
         if(_info is EmailInfoOfSended)
         {
            updateSended();
            return;
         }
         update();
         if(_info && (_info.Type == 1 || _info.Type == 101 || _info.Type == 10))
         {
            IMManager.Instance.saveRecentContactsID(_info.SenderID);
         }
      }
      
      private function updateSended() : void
      {
         _prompt.visible = false;
         var _loc1_:EmailInfoOfSended = _info as EmailInfoOfSended;
         if(_loc1_.Type == 59)
         {
            _sender.text = LanguageMgr.GetTranslation("tank.view.common.ConsortiaIcon.self");
         }
         else
         {
            _sender.text = !!_loc1_?_loc1_.Receiver:"";
         }
         _topic.text = !!_loc1_?_loc1_.Title:"";
         setContentText(_loc1_);
         _content.htmlText = !!_loc1_?_loc1_.Content:"";
         _content.textField.text = _content.textField.text + ("\n" + _loc1_.AnnexRemark);
         _list.updateInfo(_info);
      }
      
      private function setContentText(param1:*) : void
      {
         if(param1)
         {
            if(param1.Content.indexOf("http") != -1)
            {
               _content.htmlText = param1.Content;
            }
            else
            {
               _content.textField.mouseEnabled = false;
               _content.text = param1.Content;
            }
         }
         else
         {
            var _loc2_:String = "";
            _content.text = _loc2_;
            _content.htmlText = _loc2_;
         }
      }
      
      private function update() : void
      {
         if(_info && (_info.Type == 0 || _info.Type == 6 || _info.Type == 1 || _info.Type == 7 || _info.Type == 10 || _info.Type > 100 || _info.Type == 59 || _info.Type == 67))
         {
            if(_info.Sender != PlayerManager.Instance.Self.NickName)
            {
               _addFriend.enable = true;
            }
            _prompt.visible = true;
         }
         else
         {
            _prompt.visible = false;
            _addFriend.enable = false;
         }
         if(_info && (_info.ReceiverID != _info.SenderID && _info.Type == 1 || _info.Type == 59 || _info.Type == 67 || _info.Type == 101))
         {
            if(PathManager.solveFeedbackEnable())
            {
               _complainBtn.visible = true;
            }
         }
         else if(PathManager.solveFeedbackEnable())
         {
            _complainBtn.visible = false;
         }
         _sender.text = !!_info?_info.Sender:"";
         _topic.text = !!_info?_info.Title:"";
         if(_info && (_info.Type == 110 || _info.Type == 58))
         {
            _content.textField.mouseEnabled = true;
            _content.htmlText = _info.Content;
         }
         else
         {
            setContentText(_info);
         }
         _personalImgBg.visible = false;
         clearPersonalImage();
         if(_info)
         {
            prepareShow();
         }
         var _loc3_:int = 0;
         var _loc2_:* = _diamonds;
         for each(var _loc1_ in _diamonds)
         {
            _loc1_.info = _info;
         }
         _list.updateInfo(_info);
         upRebackGift();
         _upPresentGift();
      }
      
      private function upRebackGift() : void
      {
         if(_info)
         {
            if(_info.MailType == 1 && _info.Type != 55 && _info.Type != 61)
            {
               _rebackGiftBtn.visible = true;
               if(PlayerManager.Instance.Self.Grade >= 16)
               {
                  _rebackGiftBtn.enable = true;
               }
               else
               {
                  _rebackGiftBtn.enable = false;
               }
            }
            else
            {
               _rebackGiftBtn.visible = false;
            }
         }
         else
         {
            _rebackGiftBtn.visible = false;
         }
      }
      
      private function _upPresentGift() : void
      {
         if(_info && _info.MailType == 0 && _info.Type == 60)
         {
            _presentGiftBtn.visible = true;
         }
         else
         {
            _presentGiftBtn.visible = false;
         }
         if(PlayerManager.Instance.Self.Grade >= 16)
         {
            _presentGiftBtn.enable = true;
         }
         else
         {
            _presentGiftBtn.enable = false;
         }
      }
      
      private function clearPersonalImage() : void
      {
         _tempInfo = null;
         if(_playerview)
         {
            _playerview.dispose();
            _playerview = null;
         }
         if(_levelIcon)
         {
            _levelIcon.dispose();
            _levelIcon = null;
         }
      }
      
      private function prepareShow() : void
      {
         _tempInfo = PlayerManager.Instance.findPlayer(_info.UserID,PlayerManager.Instance.Self.ZoneID);
         if(_info.Money > 0 && _info.UserID != PlayerManager.Instance.Self.ID && _info.UserID != 0)
         {
            _personalImgBg.visible = true;
            if(!PlayerManager.Instance.hasInFriendList(_info.UserID) && !PlayerManager.Instance.hasInClubPlays(_info.UserID) && !PlayerManager.Instance.hasInMailTempList(_info.UserID))
            {
               SocketManager.Instance.out.sendItemEquip(_info.UserID);
               _tempInfo.addEventListener("propertychange",showPersonal);
               return;
            }
            showBegain();
         }
         else
         {
            _personalImgBg.visible = false;
         }
      }
      
      private function showPersonal(param1:PlayerPropertyEvent) : void
      {
         var _loc2_:DictionaryData = new DictionaryData();
         _tempInfo.removeEventListener("propertychange",showPersonal);
         _loc2_[_info.UserID] = _tempInfo;
         PlayerManager.Instance.mailTempList = _loc2_;
         showBegain();
      }
      
      private function showBegain() : void
      {
         _tempInfo.WeaponID = int(_tempInfo.Style.split(",")[7 - 1].split("|")[0]);
         _playerview = CharactoryFactory.createCharacter(_tempInfo,"room") as RoomCharacter;
         _playerview.showGun = _tempInfo.Style.split(",")[7 - 1].split("|")[1] == "undefined"?false:true;
         _playerview.setShowLight(true,null);
         _playerview.show(true,-1);
         _playerview.stopAnimation();
         showComplete();
      }
      
      private function showComplete() : void
      {
         PositionUtils.setPos(_playerview,"email.playerviewPos");
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(0);
         _loc1_.graphics.drawRect(0,0,124,140);
         _loc1_.graphics.endFill();
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("email.playerviewMaskPos");
         _loc1_.x = _loc2_.x;
         _loc1_.y = _loc2_.y;
         _playerview.mask = _loc1_;
         addToContent(_loc1_);
         addToContent(_playerview);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("email.levelIcon");
         _levelIcon.setSize(0);
         _levelIcon.setInfo(_tempInfo.Grade,_tempInfo.ddtKingGrade,_tempInfo.Repute,_tempInfo.WinCount,_tempInfo.TotalCount,_tempInfo.FightPower,_tempInfo.Offer,false);
         _levelIcon.mouseEnabled = false;
         _levelIcon.mouseChildren = false;
         _levelIcon.buttonMode = false;
         addToContent(_levelIcon);
      }
      
      public function setListView(param1:Array, param2:int, param3:int, param4:Boolean = false) : void
      {
         _list.update(param1,param4);
         _pageTxt.text = param3.toString() + "/" + param2.toString();
      }
      
      public function switchBtnsVisible(param1:Boolean) : void
      {
         _selectAllBtn.visible = param1;
         _deleteBtn.visible = param1;
         _reciveMailBtn.visible = param1;
      }
      
      private function btnSound() : void
      {
         SoundManager.instance.play("043");
      }
      
      public function set readOnly(param1:Boolean) : void
      {
         var _loc2_:* = 0;
         _loc2_ = uint(0);
         while(_loc2_ < 5)
         {
            (_diamonds[_loc2_] as DiamondOfReading).readOnly = param1;
            (_diamonds[_loc2_] as DiamondOfReading).visible = !param1;
            _loc2_++;
         }
      }
      
      function set isCanReply(param1:Boolean) : void
      {
         if(_info is EmailInfoOfSended)
         {
            return;
         }
         _reply_btn.enable = param1;
      }
      
      private function closeWin() : void
      {
         MailControl.Instance.hide();
      }
      
      public function personalHide() : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_complainAlert)
         {
            _complainAlert.removeEventListener("response",__frameResponse);
            _complainAlert.dispose();
         }
         _complainAlert = null;
         if(_readViewBg)
         {
            ObjectUtils.disposeObject(_readViewBg);
         }
         _readViewBg = null;
         if(_prompt)
         {
            ObjectUtils.disposeObject(_prompt);
         }
         _prompt = null;
         if(_sender)
         {
            ObjectUtils.disposeObject(_sender);
         }
         _sender = null;
         if(_topic)
         {
            ObjectUtils.disposeObject(_topic);
         }
         _topic = null;
         if(_personalImgBg)
         {
            ObjectUtils.disposeObject(_personalImgBg);
         }
         _personalImgBg = null;
         if(_leftTopBtnGroup)
         {
            ObjectUtils.disposeObject(_leftTopBtnGroup);
         }
         _leftTopBtnGroup = null;
         if(_emailListButton)
         {
            ObjectUtils.disposeObject(_emailListButton);
         }
         _emailListButton = null;
         if(_noReadButton)
         {
            ObjectUtils.disposeObject(_noReadButton);
         }
         _noReadButton = null;
         if(_sendedButton)
         {
            ObjectUtils.disposeObject(_sendedButton);
         }
         _sendedButton = null;
         if(_leftPageBtn)
         {
            ObjectUtils.disposeObject(_leftPageBtn);
         }
         _leftPageBtn = null;
         if(_rightPageBtn)
         {
            ObjectUtils.disposeObject(_rightPageBtn);
         }
         _rightPageBtn = null;
         if(_pageTxt)
         {
            ObjectUtils.disposeObject(_pageTxt);
         }
         _pageTxt = null;
         if(_selectAllBtn)
         {
            ObjectUtils.disposeObject(_selectAllBtn);
         }
         _selectAllBtn = null;
         if(_deleteBtn)
         {
            ObjectUtils.disposeObject(_deleteBtn);
         }
         _deleteBtn = null;
         if(_reciveMailBtn)
         {
            ObjectUtils.disposeObject(_reciveMailBtn);
         }
         _reciveMailBtn = null;
         if(_reply_btn)
         {
            ObjectUtils.disposeObject(_reply_btn);
         }
         _reply_btn = null;
         if(_close_btn)
         {
            ObjectUtils.disposeObject(_close_btn);
         }
         _close_btn = null;
         if(_write_btn)
         {
            ObjectUtils.disposeObject(_write_btn);
         }
         _write_btn = null;
         if(_help_btn)
         {
            ObjectUtils.disposeObject(_help_btn);
         }
         _help_btn = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_diamondHBox)
         {
            ObjectUtils.disposeObject(_diamondHBox);
         }
         _diamondHBox = null;
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
         if(_rebackGiftBtn)
         {
            ObjectUtils.disposeObject(_rebackGiftBtn);
         }
         _rebackGiftBtn = null;
         if(_presentGiftBtn)
         {
            ObjectUtils.disposeObject(_presentGiftBtn);
         }
         _presentGiftBtn = null;
         if(_addFriend)
         {
            ObjectUtils.disposeObject(_addFriend);
         }
         _addFriend = null;
         if(_complainBtn)
         {
            ObjectUtils.disposeObject(_complainBtn);
         }
         _complainBtn = null;
         _diamonds = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function __selectMailTypeListener(param1:MouseEvent) : void
      {
         _personalImgBg.visible = false;
         btnSound();
         if(param1.currentTarget == _emailListButton)
         {
            MailControl.Instance.curShowPage = "mail";
            _senderTip.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.senderTip");
            MailControl.Instance.changeType("all mails");
         }
         else if(param1.currentTarget == _noReadButton)
         {
            MailControl.Instance.curShowPage = "not_read";
            _senderTip.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.senderTip");
            MailControl.Instance.changeType("no read mails");
         }
         else if(param1.currentTarget == _sendedButton)
         {
            MailControl.Instance.curShowPage = "sent";
            _senderTip.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.geterTip");
            MailControl.Instance.changeType("sended mails");
         }
      }
      
      private function __lastPage(param1:MouseEvent) : void
      {
         SoundManager.instance.play("045");
         MailControl.Instance.setPage(true,_list.canChangePage());
         MailManager.Instance.changeSelected(null);
      }
      
      private function __nextPage(param1:MouseEvent) : void
      {
         SoundManager.instance.play("045");
         MailControl.Instance.setPage(false,_list.canChangePage());
         MailManager.Instance.changeSelected(null);
      }
      
      private function __selectAllListener(param1:MouseEvent) : void
      {
         btnSound();
         _list.switchSeleted();
      }
      
      private function __deleteSelectListener(param1:MouseEvent) : void
      {
         btnSound();
         var _loc2_:Array = _list.getSelectedMails();
         if(_loc2_.length > 0)
         {
            if(hightGoods(_loc2_))
            {
               ok();
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.ReadingView.deleteSelectListener"));
         }
      }
      
      private function hightGoods(param1:Array) : Boolean
      {
         var _loc6_:int = 0;
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc5_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc10_:int = 0;
         var _loc9_:* = param1;
         for each(var _loc7_ in param1)
         {
            if(_loc7_.Money > 0 || _loc7_.BindMoney > 0 || _loc7_.Medal > 0)
            {
               _loc2_ = true;
            }
            _loc6_ = 1;
            while(_loc6_ <= 5)
            {
               _loc8_ = "Annex" + _loc6_;
               if(_loc7_.hasOwnProperty(_loc8_))
               {
                  _loc4_ = _loc7_[_loc8_] as InventoryItemInfo;
                  if(_loc4_ && _loc7_.Type != 81 && _loc7_.Type != 83)
                  {
                     if(!_loc2_)
                     {
                        _loc2_ = true;
                     }
                  }
                  if(EquipType.isValuableEquip(_loc4_))
                  {
                     _loc5_ = false;
                     _loc3_ = true;
                     break;
                  }
               }
               _loc6_++;
            }
         }
         if(_loc3_)
         {
            if(PlayerManager.Instance.Self.bagPwdState)
            {
               if(!PlayerManager.Instance.Self.bagLocked)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.EmailIIStripView.delectEmailInfo"));
               }
               else
               {
                  BaglockedManager.Instance.addEventListener("cancelBtn",__cancelBtn);
                  BaglockedManager.Instance.show();
               }
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.EmailIIStripView.delectEmailInfo"));
            }
         }
         else if(_loc2_)
         {
            if(PlayerManager.Instance.Self.bagPwdState)
            {
               if(!PlayerManager.Instance.Self.bagLocked)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.EmailIIStripView.delectEmailInfo"));
               }
               else
               {
                  BaglockedManager.Instance.addEventListener("cancelBtn",__cancelBtn);
                  BaglockedManager.Instance.show();
               }
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.EmailIIStripView.delectEmailInfo"));
            }
         }
         else if(PlayerManager.Instance.Self.bagPwdState)
         {
            if(!PlayerManager.Instance.Self.bagLocked)
            {
               ok();
            }
            else
            {
               BaglockedManager.Instance.addEventListener("cancelBtn",__cancelBtn);
               BaglockedManager.Instance.show();
            }
         }
         else
         {
            ok();
         }
         return _loc5_;
      }
      
      private function __cancelBtn(param1:SetPassEvent) : void
      {
         BaglockedManager.Instance.removeEventListener("cancelBtn",__cancelBtn);
         disposeAlert();
      }
      
      private function showAlert() : void
      {
         if(_alertFrame == null)
         {
            _alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.tip"),LanguageMgr.GetTranslation("tank.view.emailII.EmailIIStripView.delectEmail"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,1);
            _alertFrame.addEventListener("response",__simpleAlertResponse);
         }
      }
      
      private function disposeAlert() : void
      {
         if(_alertFrame)
         {
            _alertFrame.removeEventListener("response",__simpleAlertResponse);
            _alertFrame.dispose();
         }
         _alertFrame = null;
      }
      
      private function __simpleAlertResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _alertFrame.removeEventListener("response",__simpleAlertResponse);
         ObjectUtils.disposeObject(_alertFrame);
         if(_alertFrame.parent)
         {
            _alertFrame.parent.removeChild(_alertFrame);
         }
         if(param1.responseCode == 4 || param1.responseCode == 0 || param1.responseCode == 1)
         {
            cancel();
         }
         else if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            ok();
         }
         KeyboardShortcutsManager.Instance.prohibitNewHandMail(true);
      }
      
      private function cancel() : void
      {
         btnSound();
         disposeAlert();
      }
      
      private function ok() : void
      {
         var _loc2_:* = 0;
         btnSound();
         disposeAlert();
         _personalImgBg.visible = false;
         var _loc1_:Array = _list.getSelectedMails();
         _loc2_ = uint(0);
         while(_loc2_ < _loc1_.length)
         {
            MailControl.Instance.deleteEmail(_loc1_[_loc2_]);
            MailControl.Instance.removeMail(_loc1_[_loc2_]);
            MailManager.Instance.changeSelected(null);
            _loc2_++;
         }
      }
      
      private function __receiveExListener(param1:MouseEvent) : void
      {
         var _loc8_:* = 0;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc7_:* = null;
         btnSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc5_:Array = _list.getSelectedMails();
         if(_loc5_.length > 0 || _info)
         {
            if(_loc5_.length > 0)
            {
               _loc8_ = uint(0);
               while(_loc8_ < _loc5_.length)
               {
                  if(!((_loc5_[_loc8_] as EmailInfo).Type > 100 && (_loc5_[_loc8_] as EmailInfo).Money > 0))
                  {
                     _loc6_ = _loc5_[_loc8_] as EmailInfo;
                     if(!_loc6_.IsRead)
                     {
                        _loc4_ = _loc6_.SendTime;
                        _loc3_ = new Date(Number(_loc4_.substr(0,4)),_loc4_.substr(5,2) - 1,Number(_loc4_.substr(8,2)),Number(_loc4_.substr(11,2)),Number(_loc4_.substr(14,2)),Number(_loc4_.substr(17,2)));
                        _loc6_.ValidDate = 72 + (TimeManager.Instance.Now().time - _loc3_.time) / 3600000;
                        _loc6_.IsRead = true;
                        _list.updateInfo(_loc6_);
                     }
                     MailControl.Instance.getAnnexToBag(_loc5_[_loc8_],0);
                  }
                  _loc8_++;
               }
            }
            if(_info)
            {
               if(_info.Type > 100 && _info.Money > 0)
               {
                  if(_info.Money > 0)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.email.readingEmail.payEmail"));
                  }
                  return;
               }
               if(!_info.IsRead)
               {
                  _loc2_ = _info.SendTime;
                  _loc7_ = new Date(Number(_loc2_.substr(0,4)),_loc2_.substr(5,2) - 1,Number(_loc2_.substr(8,2)),Number(_loc2_.substr(11,2)),Number(_loc2_.substr(14,2)),Number(_loc2_.substr(17,2)));
                  _info.ValidDate = 72 + (TimeManager.Instance.Now().time - _loc7_.time) / 3600000;
               }
               MailControl.Instance.getAnnexToBag(_info,0);
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.ReadingView.deleteSelectListener"));
         }
      }
      
      private function __reply(param1:MouseEvent) : void
      {
         btnSound();
         MailControl.Instance.changeState("reply");
      }
      
      private function __close(param1:MouseEvent) : void
      {
         btnSound();
         closeWin();
      }
      
      private function __write(param1:MouseEvent) : void
      {
         btnSound();
         MailControl.Instance.changeState("write");
      }
      
      private function __addFriend(param1:MouseEvent) : void
      {
         if(_info)
         {
            IMManager.Instance.addFriend(_info.Sender);
         }
         SoundManager.instance.play("008");
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0)
         {
            btnSound();
            closeWin();
         }
      }
      
      protected function __rebackGift(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         GiftManager.Instance.show();
         MailControl.Instance.hide();
      }
      
      private function _clickPresent(param1:MouseEvent) : void
      {
         var _loc2_:String = _info.Content;
         _loc2_ = _loc2_.substring(_loc2_.search(/\[/) + 1,_loc2_.search("]"));
         FriendBirthdayManager.Instance.friendName = _loc2_;
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         GiftManager.Instance.show();
         MailControl.Instance.hide();
      }
   }
}
