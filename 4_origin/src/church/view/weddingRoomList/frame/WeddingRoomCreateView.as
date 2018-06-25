package church.view.weddingRoomList.frame
{
   import church.controller.ChurchRoomListController;
   import church.model.ChurchRoomListModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ChurchRoomInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import store.HelpFrame;
   
   public class WeddingRoomCreateView extends BaseAlerFrame
   {
       
      
      private var _controller:ChurchRoomListController;
      
      private var _model:ChurchRoomListModel;
      
      private var _bgLeftTop:ScaleBitmapImage;
      
      private var _bgLeftBottom:ScaleBitmapImage;
      
      private var _bgRight:Scale9CornerImage;
      
      private var _alertInfo:AlertInfo;
      
      private var _roomCreateRoomNameTitle:Bitmap;
      
      private var _roomCreateIntro:Bitmap;
      
      private var _roomCreateTimeTitle:Bitmap;
      
      private var _roomCreateIntroMaxChBg:Bitmap;
      
      private var _txtCreateRoomName:FilterFrameText;
      
      private var _chkCreateRoomPassword:SelectedIconButton;
      
      private var _chkCreateRoomIsGuest:SelectedIconButton;
      
      private var _txtCreateRoomPassword:TextInput;
      
      private var _roomCreateNormalSelectedBtn:SelectedButton;
      
      private var _roomNormalMoneyTxt:FilterFrameText;
      
      private var _roomCreateTimeLuxurySelectedBtn:SelectedButton;
      
      private var _roomTimeLuxuryMoneyTxt:FilterFrameText;
      
      private var _roomCreateTimeGroup:SelectedButtonGroup;
      
      private var _roomCreateIntroMaxChLabel:FilterFrameText;
      
      private var _txtRoomCreateIntro:TextArea;
      
      private var _flower:Bitmap;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _selectedIconButtonTxt1:FilterFrameText;
      
      private var _selectedIconButtonTxt2:FilterFrameText;
      
      private var _discountIcon:ScaleLeftRightImage;
      
      private var _discountIconII:ScaleLeftRightImage;
      
      private var _discountTxt:FilterFrameText;
      
      private var _discountTxtII:FilterFrameText;
      
      private var _help:BaseButton;
      
      public function WeddingRoomCreateView()
      {
         super();
         initialize();
      }
      
      public function setController(controller:ChurchRoomListController, model:ChurchRoomListModel) : void
      {
         _controller = controller;
         _model = model;
      }
      
      protected function initialize() : void
      {
         setView();
         setEvent();
      }
      
      private function setView() : void
      {
         var disc:Number = NaN;
         var temp:* = null;
         var disc2:Number = NaN;
         var temp2:* = null;
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("church.weddingRoom.frame.CreateRoomFrame.titleText");
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _flower = ComponentFactory.Instance.creatBitmap("asset.churchroomlist.flowers");
         var _loc8_:* = 0.9;
         _flower.scaleY = _loc8_;
         _flower.scaleX = _loc8_;
         PositionUtils.setPos(_flower,"WeddingRoomCreateView.titleFlowers.pos");
         addToContent(_flower);
         _bgLeftTop = ComponentFactory.Instance.creatComponentByStylename("church.main.createWeddingRoomFrameLeftTopBg");
         addToContent(_bgLeftTop);
         _bgLeftBottom = ComponentFactory.Instance.creatComponentByStylename("church.main.createWeddingRoomFrameLeftBottomBg");
         addToContent(_bgLeftBottom);
         _roomCreateRoomNameTitle = ComponentFactory.Instance.creatBitmap("asset.church.roomCreateRoomNameTitleAsset");
         addToContent(_roomCreateRoomNameTitle);
         _roomCreateTimeTitle = ComponentFactory.Instance.creatBitmap("asset.church.roomCreateTimeTitleAsset");
         addToContent(_roomCreateTimeTitle);
         _txtCreateRoomName = ComponentFactory.Instance.creat("church.main.txtCreateRoomName");
         _txtCreateRoomName.text = LanguageMgr.GetTranslation("hurch.weddingRoom.frame.CreateRoomFrame.name_txt",PlayerManager.Instance.Self.NickName,PlayerManager.Instance.Self.SpouseName);
         _bg1 = ComponentFactory.Instance.creat("church.main.createRoomFrameBG");
         addToContent(_bg1);
         addToContent(_txtCreateRoomName);
         _chkCreateRoomPassword = ComponentFactory.Instance.creat("church.main.chkCreateRoomPassword");
         addToContent(_chkCreateRoomPassword);
         _chkCreateRoomIsGuest = ComponentFactory.Instance.creat("church.main.chkCreateRoomIsGuest");
         addToContent(_chkCreateRoomIsGuest);
         _selectedIconButtonTxt1 = ComponentFactory.Instance.creat("church.main.WeddingRoomCreateView.SelectedIconButtonTxt1");
         _selectedIconButtonTxt1.text = LanguageMgr.GetTranslation("church.main.WeddingRoomCreateView.SelectedIconButtonTxt1.text");
         _chkCreateRoomPassword.addChild(_selectedIconButtonTxt1);
         _selectedIconButtonTxt2 = ComponentFactory.Instance.creat("church.main.WeddingRoomCreateView.SelectedIconButtonTxt2");
         _selectedIconButtonTxt2.text = LanguageMgr.GetTranslation("church.main.WeddingRoomCreateView.SelectedIconButtonTxt2.text");
         _chkCreateRoomIsGuest.addChild(_selectedIconButtonTxt2);
         _txtCreateRoomPassword = ComponentFactory.Instance.creat("church.main.txtCreateRoomPassword");
         _txtCreateRoomPassword.displayAsPassword = true;
         _txtCreateRoomPassword.enable = false;
         _txtCreateRoomPassword.maxChars = 6;
         addToContent(_txtCreateRoomPassword);
         _roomCreateNormalSelectedBtn = ComponentFactory.Instance.creat("church.normal.WeddingBtn");
         addToContent(_roomCreateNormalSelectedBtn);
         _roomCreateNormalSelectedBtn.filters = ComponentFactory.Instance.creatFilters("lightFilter");
         _roomNormalMoneyTxt = ComponentFactory.Instance.creat("church.main.WeddingRoomCreateView.roomNormalMoneyTxt");
         _roomNormalMoneyTxt.text = PlayerManager.Instance.merryDiscountArr[0] + LanguageMgr.GetTranslation("money");
         _roomNormalMoneyTxt.filters = ComponentFactory.Instance.creatFilters("lightFilter");
         addToContent(_roomNormalMoneyTxt);
         if(int(PlayerManager.Instance.merryDiscountArr[0]) < int(ServerConfigManager.instance.weddingMoney[0]))
         {
            _discountIcon = ComponentFactory.Instance.creatComponentByStylename("ddtchurchroomlist.discount.image");
            addToContent(_discountIcon);
            _discountTxt = ComponentFactory.Instance.creatComponentByStylename("ddtchurchroomlist.discount.imageTxt");
            addToContent(_discountTxt);
            _discountTxt.x = _discountIcon.x + 1;
            _discountTxt.y = _discountIcon.y + 2;
            _discountTxt.width = _discountIcon.width;
            disc = PlayerManager.Instance.merryDiscountArr[0] / ServerConfigManager.instance.weddingMoney[0] * 10;
            if(disc.toString().length == 1)
            {
               temp = disc.toString();
            }
            else
            {
               temp = disc.toFixed(1);
            }
            _discountTxt.text = LanguageMgr.GetTranslation("ddt.vipView.discountIconTxt",temp);
         }
         _roomCreateTimeLuxurySelectedBtn = ComponentFactory.Instance.creat("church.luxury.WeddingBtn");
         addToContent(_roomCreateTimeLuxurySelectedBtn);
         _roomCreateTimeLuxurySelectedBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _roomTimeLuxuryMoneyTxt = ComponentFactory.Instance.creat("church.main.WeddingRoomCreateView.roomTimeLuxuryMoneyTxt");
         _roomTimeLuxuryMoneyTxt.text = PlayerManager.Instance.merryDiscountArr[1] + LanguageMgr.GetTranslation("money");
         _roomTimeLuxuryMoneyTxt.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         addToContent(_roomTimeLuxuryMoneyTxt);
         if(int(PlayerManager.Instance.merryDiscountArr[1]) < int(ServerConfigManager.instance.weddingMoney[1]))
         {
            _discountIconII = ComponentFactory.Instance.creatComponentByStylename("ddtchurchroomlist.discount.image.II");
            addToContent(_discountIconII);
            _discountTxtII = ComponentFactory.Instance.creatComponentByStylename("ddtchurchroomlist.discount.imageTxt");
            addToContent(_discountTxtII);
            _discountTxtII.x = _discountIconII.x + 1;
            _discountTxtII.y = _discountIconII.y + 2;
            _discountTxtII.width = _discountIconII.width;
            disc2 = PlayerManager.Instance.merryDiscountArr[1] / ServerConfigManager.instance.weddingMoney[1] * 10;
            if(disc2.toString().length == 1)
            {
               temp2 = disc2.toString();
            }
            else
            {
               temp2 = disc2.toFixed(1);
            }
            _discountTxtII.text = LanguageMgr.GetTranslation("ddt.vipView.discountIconTxt",temp2);
         }
         _roomCreateTimeGroup = new SelectedButtonGroup(false);
         _roomCreateTimeGroup.addSelectItem(_roomCreateNormalSelectedBtn);
         _roomCreateTimeGroup.addSelectItem(_roomCreateTimeLuxurySelectedBtn);
         _roomCreateTimeGroup.selectIndex = 0;
         _roomCreateIntro = ComponentFactory.Instance.creatBitmap("asset.church.roomCreateIntroAsset");
         addToContent(_roomCreateIntro);
         _roomCreateIntroMaxChLabel = ComponentFactory.Instance.creat("asset.church.main.roomCreateIntroMaxChLabelAsset");
         addToContent(_roomCreateIntroMaxChLabel);
         _bgRight = ComponentFactory.Instance.creat("church.main.createRoomFrameRightBg");
         addToContent(_bgRight);
         _help = ComponentFactory.Instance.creat("asset.church.help.btn");
         addToContent(_help);
         var groomName:String = "";
         var brideName:String = "";
         if(PlayerManager.Instance.Self.Sex)
         {
            groomName = PlayerManager.Instance.Self.NickName;
            brideName = PlayerManager.Instance.Self.SpouseName;
         }
         else
         {
            groomName = PlayerManager.Instance.Self.SpouseName;
            brideName = PlayerManager.Instance.Self.NickName;
         }
         _txtRoomCreateIntro = ComponentFactory.Instance.creat("church.view.weddingRoomList.frame.WeddingRoomCreateViewField");
         _txtRoomCreateIntro.text = LanguageMgr.GetTranslation("church.weddingRoom.frame.CreateRoomFrame._remark_txt",groomName,brideName);
         _txtRoomCreateIntro.maxChars = 400;
         addToContent(_txtRoomCreateIntro);
         var charCut:int = _txtRoomCreateIntro.maxChars - _txtRoomCreateIntro.text.length;
         _roomCreateIntroMaxChLabel.text = LanguageMgr.GetTranslation("church.churchScene.frame.ModifyDiscriptionFrame.spare") + " " + (String(charCut <= 0?0:charCut)) + LanguageMgr.GetTranslation("church.churchScene.frame.ModifyDiscriptionFrame.word");
      }
      
      private function removeView() : void
      {
         _alertInfo = null;
         if(_flower)
         {
            if(_flower.parent)
            {
               _flower.parent.removeChild(_flower);
            }
            _flower.bitmapData.dispose();
            _flower.bitmapData = null;
         }
         _flower = null;
         if(_bgLeftTop)
         {
            ObjectUtils.disposeObject(_bgLeftTop);
         }
         _bgLeftTop = null;
         if(_bgLeftBottom)
         {
            ObjectUtils.disposeObject(_bgLeftBottom);
         }
         _bgLeftBottom = null;
         if(_roomNormalMoneyTxt)
         {
            ObjectUtils.disposeObject(_roomNormalMoneyTxt);
         }
         _roomNormalMoneyTxt = null;
         if(_roomTimeLuxuryMoneyTxt)
         {
            ObjectUtils.disposeObject(_roomTimeLuxuryMoneyTxt);
         }
         _roomTimeLuxuryMoneyTxt = null;
         if(_roomCreateRoomNameTitle)
         {
            if(_roomCreateRoomNameTitle.parent)
            {
               _roomCreateRoomNameTitle.parent.removeChild(_roomCreateRoomNameTitle);
            }
            _roomCreateRoomNameTitle.bitmapData.dispose();
            _roomCreateRoomNameTitle.bitmapData = null;
         }
         _roomCreateRoomNameTitle = null;
         if(_roomCreateIntro)
         {
            if(_roomCreateIntro.parent)
            {
               _roomCreateIntro.parent.removeChild(_roomCreateIntro);
            }
            _roomCreateIntro.bitmapData.dispose();
            _roomCreateIntro.bitmapData = null;
         }
         _roomCreateIntro = null;
         if(_roomCreateTimeTitle)
         {
            if(_roomCreateTimeTitle.parent)
            {
               _roomCreateTimeTitle.parent.removeChild(_roomCreateTimeTitle);
            }
            _roomCreateTimeTitle.bitmapData.dispose();
            _roomCreateTimeTitle.bitmapData = null;
         }
         _roomCreateTimeTitle = null;
         if(_txtCreateRoomName)
         {
            if(_txtCreateRoomName.parent)
            {
               _txtCreateRoomName.parent.removeChild(_txtCreateRoomName);
            }
            _txtCreateRoomName.dispose();
         }
         _txtCreateRoomName = null;
         if(_bg1)
         {
            ObjectUtils.disposeObject(_bg1);
         }
         _bg1 = null;
         if(_chkCreateRoomPassword)
         {
            if(_chkCreateRoomPassword.parent)
            {
               _chkCreateRoomPassword.parent.removeChild(_chkCreateRoomPassword);
            }
            _chkCreateRoomPassword.dispose();
         }
         _chkCreateRoomPassword = null;
         if(_txtCreateRoomPassword)
         {
            if(_txtCreateRoomPassword.parent)
            {
               _txtCreateRoomPassword.parent.removeChild(_txtCreateRoomPassword);
            }
            _txtCreateRoomPassword.dispose();
         }
         _txtCreateRoomPassword = null;
         if(_roomCreateNormalSelectedBtn)
         {
            if(_roomCreateNormalSelectedBtn.parent)
            {
               _roomCreateNormalSelectedBtn.parent.removeChild(_roomCreateNormalSelectedBtn);
            }
            _roomCreateNormalSelectedBtn.dispose();
         }
         _roomCreateNormalSelectedBtn = null;
         if(_roomCreateTimeLuxurySelectedBtn)
         {
            if(_roomCreateTimeLuxurySelectedBtn.parent)
            {
               _roomCreateTimeLuxurySelectedBtn.parent.removeChild(_roomCreateTimeLuxurySelectedBtn);
            }
            _roomCreateTimeLuxurySelectedBtn.dispose();
         }
         _roomCreateTimeLuxurySelectedBtn = null;
         if(_roomCreateIntroMaxChLabel)
         {
            if(_roomCreateIntroMaxChLabel.parent)
            {
               _roomCreateIntroMaxChLabel.parent.removeChild(_roomCreateIntroMaxChLabel);
            }
            _roomCreateIntroMaxChLabel.dispose();
         }
         _roomCreateIntroMaxChLabel = null;
         if(_bgRight)
         {
            if(_bgRight.parent)
            {
               _bgRight.parent.removeChild(_bgRight);
            }
            _bgRight.dispose();
         }
         _bgRight = null;
         _txtRoomCreateIntro = null;
         if(_roomCreateTimeGroup)
         {
            _roomCreateTimeGroup.dispose();
         }
         _roomCreateTimeGroup = null;
         if(_discountIcon)
         {
            if(_discountIcon.parent)
            {
               _discountIcon.parent.removeChild(_discountIcon);
            }
            _discountIcon.dispose();
         }
         _discountIcon = null;
         if(_discountIconII)
         {
            if(_discountIconII.parent)
            {
               _discountIconII.parent.removeChild(_discountIconII);
            }
            _discountIconII.dispose();
         }
         _discountIconII = null;
         if(_discountTxt)
         {
            if(_discountTxt.parent)
            {
               _discountTxt.parent.removeChild(_discountTxt);
            }
            _discountTxt.dispose();
         }
         _discountTxt = null;
         if(_discountTxtII)
         {
            if(_discountTxtII.parent)
            {
               _discountTxtII.parent.removeChild(_discountTxtII);
            }
            _discountTxtII.dispose();
         }
         _discountTxtII = null;
         if(_selectedIconButtonTxt1)
         {
            if(_selectedIconButtonTxt1.parent)
            {
               _selectedIconButtonTxt1.parent.removeChild(_selectedIconButtonTxt1);
            }
            _selectedIconButtonTxt1.dispose();
         }
         _selectedIconButtonTxt1 = null;
         if(_selectedIconButtonTxt2)
         {
            if(_selectedIconButtonTxt2.parent)
            {
               _selectedIconButtonTxt2.parent.removeChild(_selectedIconButtonTxt2);
            }
            _selectedIconButtonTxt2.dispose();
         }
         _selectedIconButtonTxt2 = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function setEvent() : void
      {
         addEventListener("response",onFrameResponse);
         _chkCreateRoomPassword.addEventListener("click",onRoomPasswordCheck);
         _txtRoomCreateIntro.addEventListener("change",onIntroChange);
         _chkCreateRoomIsGuest.addEventListener("click",onIsGuest);
         _roomCreateNormalSelectedBtn.addEventListener("click",onIsGuest1);
         _roomCreateTimeLuxurySelectedBtn.addEventListener("click",onIsGuest2);
         _help.addEventListener("click",__onClickHelpHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",onFrameResponse);
         if(_chkCreateRoomPassword)
         {
            _chkCreateRoomPassword.removeEventListener("click",onRoomPasswordCheck);
         }
         if(_txtRoomCreateIntro)
         {
            _txtRoomCreateIntro.removeEventListener("change",onIntroChange);
         }
         if(_chkCreateRoomIsGuest)
         {
            _chkCreateRoomIsGuest.removeEventListener("click",onIsGuest);
         }
         if(_roomCreateNormalSelectedBtn)
         {
            _roomCreateNormalSelectedBtn.removeEventListener("click",onIsGuest1);
         }
         if(_roomCreateTimeLuxurySelectedBtn)
         {
            _roomCreateTimeLuxurySelectedBtn.removeEventListener("click",onIsGuest2);
         }
         if(_help)
         {
            _help.removeEventListener("click",__onClickHelpHandler);
         }
      }
      
      private function __onClickHelpHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var helpBd:DisplayObject = ComponentFactory.Instance.creat("church.HelpPrompt");
         var helpPage:HelpFrame = ComponentFactory.Instance.creat("church.HelpFrame");
         helpPage.setView(helpBd);
         helpPage.titleText = LanguageMgr.GetTranslation("ddt.church.readme");
         LayerManager.Instance.addToLayer(helpPage,1,true,1);
      }
      
      private function onIsGuest(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function onIsGuest1(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _roomCreateNormalSelectedBtn.filters = ComponentFactory.Instance.creatFilters("lightFilter");
         _roomNormalMoneyTxt.filters = ComponentFactory.Instance.creatFilters("lightFilter");
         _roomCreateTimeLuxurySelectedBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _roomTimeLuxuryMoneyTxt.filters = ComponentFactory.Instance.creatFilters("grayFilter");
      }
      
      private function onIsGuest2(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _roomCreateNormalSelectedBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _roomNormalMoneyTxt.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _roomCreateTimeLuxurySelectedBtn.filters = ComponentFactory.Instance.creatFilters("lightFilter");
         _roomTimeLuxuryMoneyTxt.filters = ComponentFactory.Instance.creatFilters("lightFilter");
      }
      
      private function onRoomPasswordCheck(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _txtCreateRoomPassword.enable = _chkCreateRoomPassword.selected;
         if(_txtCreateRoomPassword.enable)
         {
            _txtCreateRoomPassword.setFocus();
         }
         else
         {
            _txtCreateRoomPassword.text = "";
         }
      }
      
      private function onFrameResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               createRoomConfirm();
         }
      }
      
      private function createRoomConfirm() : void
      {
         if(PlayerManager.Instance.Self.Money < PlayerManager.Instance.merryDiscountArr[_roomCreateTimeGroup.selectIndex])
         {
            LeavePageManager.showFillFrame();
            return;
         }
         if(!checkRoom())
         {
            return;
         }
         var roomInfo:ChurchRoomInfo = new ChurchRoomInfo();
         roomInfo.roomName = _txtCreateRoomName.text;
         roomInfo.password = _txtCreateRoomPassword.text;
         roomInfo.valideTimes = _roomCreateTimeGroup.selectIndex + 2;
         roomInfo.canInvite = _chkCreateRoomIsGuest.selected;
         roomInfo.discription = FilterWordManager.filterWrod(_txtRoomCreateIntro.text);
         if(_roomCreateTimeGroup.selectIndex == 0)
         {
            roomInfo.seniorType = 0;
         }
         else if(_roomCreateTimeGroup.selectIndex == 1)
         {
            roomInfo.seniorType = 4;
         }
         _controller.createRoom(roomInfo);
         dispose();
      }
      
      private function checkRoom() : Boolean
      {
         if(FilterWordManager.IsNullorEmpty(_txtCreateRoomName.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.name"));
            return false;
         }
         if(FilterWordManager.isGotForbiddenWords(_txtCreateRoomName.text,"name"))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.string"));
            return false;
         }
         if(_chkCreateRoomPassword.selected && FilterWordManager.IsNullorEmpty(_txtCreateRoomPassword.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.set"));
            return false;
         }
         return true;
      }
      
      private function onIntroChange(e:Event) : void
      {
         _roomCreateIntroMaxChLabel.text = LanguageMgr.GetTranslation("church.churchScene.frame.ModifyDiscriptionFrame.spare") + (String(_txtRoomCreateIntro.maxChars - _txtRoomCreateIntro.text.length <= 0?0:Number(_txtRoomCreateIntro.maxChars - _txtRoomCreateIntro.text.length))) + LanguageMgr.GetTranslation("church.churchScene.frame.ModifyDiscriptionFrame.word");
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         removeView();
      }
   }
}
