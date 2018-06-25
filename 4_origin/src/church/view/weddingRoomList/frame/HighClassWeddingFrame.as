package church.view.weddingRoomList.frame
{
   import bagAndInfo.cell.BaseCell;
   import church.controller.ChurchRoomListController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ChurchRoomInfo;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class HighClassWeddingFrame extends BaseAlerFrame
   {
       
      
      private var _controller:ChurchRoomListController;
      
      private var _alertInfo:AlertInfo;
      
      private var _flower:Bitmap;
      
      private var _bgLeftTop:ScaleBitmapImage;
      
      private var _bgLeftBottom:ScaleBitmapImage;
      
      private var _roomCreateRoomNameTitle:Bitmap;
      
      private var _churchKeepsake:Bitmap;
      
      private var _txtCreateRoomName:FilterFrameText;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _chkCreateRoomPassword:SelectedIconButton;
      
      private var _chkCreateRoomIsGuest:SelectedIconButton;
      
      private var _selectedIconButtonTxt1:FilterFrameText;
      
      private var _selectedIconButtonTxt2:FilterFrameText;
      
      private var _txtCreateRoomPassword:TextInput;
      
      private var _bgRight:Bitmap;
      
      private var _weddingBigBtn:SelectedButton;
      
      private var _weddingMidBtn:SelectedButton;
      
      private var _weddingSmallBtn:SelectedButton;
      
      private var _descTxt:FilterFrameText;
      
      private var _hbox:HBox;
      
      private var _sizeSelectGroup:SelectedButtonGroup;
      
      private var _cellHBox:HBox;
      
      private var _cells:Array;
      
      private var _isSaleWedding:Boolean;
      
      private var _WeddingMoney:String;
      
      private var _WdddingMoneyArr:Array;
      
      private var _weddingSmalllMoneyTxt:FilterFrameText;
      
      private var _weddingMidMoneyTxt:FilterFrameText;
      
      private var _weddingBigMoneyTxt:FilterFrameText;
      
      public function HighClassWeddingFrame()
      {
         super();
         _cells = [];
      }
      
      public function setController(controller:ChurchRoomListController) : void
      {
         _controller = controller;
      }
      
      public function initView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("church.weddingRoom.frame.CreateRoomFrame.titleText");
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _flower = ComponentFactory.Instance.creatBitmap("asset.churchroomlist.flowers");
         var _loc1_:* = 0.9;
         _flower.scaleY = _loc1_;
         _flower.scaleX = _loc1_;
         PositionUtils.setPos(_flower,"WeddingRoomCreateView.titleFlowers.pos");
         addToContent(_flower);
         _bgLeftTop = ComponentFactory.Instance.creatComponentByStylename("church.main.createWeddingRoomFrameLeftTopBg");
         addToContent(_bgLeftTop);
         _bgLeftBottom = ComponentFactory.Instance.creatComponentByStylename("church.keepsakeBg");
         addToContent(_bgLeftBottom);
         _roomCreateRoomNameTitle = ComponentFactory.Instance.creatBitmap("asset.church.roomCreateRoomNameTitleAsset");
         addToContent(_roomCreateRoomNameTitle);
         _churchKeepsake = ComponentFactory.Instance.creatBitmap("church.keepsake");
         addToContent(_churchKeepsake);
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
         _bgRight = ComponentFactory.Instance.creat("church.rightBg");
         addToContent(_bgRight);
         _hbox = ComponentFactory.Instance.creatComponentByStylename("church.sizeHBox");
         addToContent(_hbox);
         _WdddingMoneyArr = _WeddingMoney.split(",");
         _weddingSmallBtn = ComponentFactory.Instance.creatComponentByStylename("church.weddingSmallBtn");
         _weddingSmalllMoneyTxt = ComponentFactory.Instance.creat("church.main.WeddingRoomCreateView.weddingSmalllMoneyTxt");
         _weddingSmalllMoneyTxt.text = _WdddingMoneyArr[0] + LanguageMgr.GetTranslation("money");
         _weddingSmalllMoneyTxt.filters = ComponentFactory.Instance.creatFilters("lightFilter");
         addToContent(_weddingSmalllMoneyTxt);
         _weddingMidBtn = ComponentFactory.Instance.creatComponentByStylename("church.weddingMidBtn");
         _weddingMidMoneyTxt = ComponentFactory.Instance.creat("church.main.WeddingRoomCreateView.weddingMidMoneyTxt");
         _weddingMidMoneyTxt.text = _WdddingMoneyArr[1] + LanguageMgr.GetTranslation("money");
         _weddingMidMoneyTxt.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         addToContent(_weddingMidMoneyTxt);
         _weddingBigBtn = ComponentFactory.Instance.creatComponentByStylename("church.weddingBigBtn");
         _weddingBigMoneyTxt = ComponentFactory.Instance.creat("church.main.WeddingRoomCreateView.weddingBigMoneyTxt");
         _weddingBigMoneyTxt.text = _WdddingMoneyArr[2] + LanguageMgr.GetTranslation("money");
         _weddingBigMoneyTxt.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         addToContent(_weddingBigMoneyTxt);
         _hbox.addChild(_weddingSmallBtn);
         _hbox.addChild(_weddingMidBtn);
         _hbox.addChild(_weddingBigBtn);
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("church.descTxt");
         addToContent(_descTxt);
         _descTxt.text = LanguageMgr.GetTranslation("church.highClassWeddingDesc");
         _sizeSelectGroup = new SelectedButtonGroup();
         _sizeSelectGroup.addSelectItem(_weddingSmallBtn);
         _sizeSelectGroup.addSelectItem(_weddingMidBtn);
         _sizeSelectGroup.addSelectItem(_weddingBigBtn);
         _sizeSelectGroup.selectIndex = 0;
         _cellHBox = ComponentFactory.Instance.creatComponentByStylename("church.cellHBox");
         addToContent(_cellHBox);
         updateReward();
         addEvents();
      }
      
      public function get isSaleWedding() : Boolean
      {
         return _isSaleWedding;
      }
      
      public function set isSaleWedding(value:Boolean) : void
      {
         _isSaleWedding = value;
      }
      
      private function addEvents() : void
      {
         addEventListener("response",onFrameResponse);
         _weddingBigBtn.addEventListener("click",onIsGuest1);
         _weddingMidBtn.addEventListener("click",onIsGuest2);
         _weddingSmallBtn.addEventListener("click",onIsGuest3);
         _chkCreateRoomPassword.addEventListener("click",onRoomPasswordCheck);
         _chkCreateRoomIsGuest.addEventListener("click",onIsGuest);
         _sizeSelectGroup.addEventListener("change",__changeHandler);
      }
      
      private function onIsGuest1(event:MouseEvent) : void
      {
         _weddingSmalllMoneyTxt.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _weddingMidMoneyTxt.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _weddingBigMoneyTxt.filters = ComponentFactory.Instance.creatFilters("lightFilter");
      }
      
      private function onIsGuest2(event:MouseEvent) : void
      {
         _weddingSmalllMoneyTxt.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _weddingMidMoneyTxt.filters = ComponentFactory.Instance.creatFilters("lightFilter");
         _weddingBigMoneyTxt.filters = ComponentFactory.Instance.creatFilters("grayFilter");
      }
      
      private function onIsGuest3(event:MouseEvent) : void
      {
         _weddingSmalllMoneyTxt.filters = ComponentFactory.Instance.creatFilters("lightFilter");
         _weddingMidMoneyTxt.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _weddingBigMoneyTxt.filters = ComponentFactory.Instance.creatFilters("grayFilter");
      }
      
      protected function __changeHandler(event:Event) : void
      {
         SoundManager.instance.play("008");
         updateReward();
      }
      
      private function updateReward() : void
      {
         var i:int = 0;
         var bg:* = null;
         var cell:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = _cells;
         for each(var tCell in _cells)
         {
            ObjectUtils.disposeObject(tCell);
            tCell = null;
         }
         var giftBoxArr:Array = ServerConfigManager.instance.getSeniorMarryGift();
         var giftBoxId:int = giftBoxArr[_sizeSelectGroup.selectIndex];
         var rewardArr:Array = BossBoxManager.instance.inventoryItemList[giftBoxId];
         for(i = 0; i <= rewardArr.length - 1; )
         {
            bg = ComponentFactory.Instance.creat("church.itmeBg");
            cell = new BaseCell(bg,ItemManager.Instance.getTemplateById(rewardArr[i].TemplateId));
            cell.setContentSize(57,57);
            cell.PicPos = new Point(15,15);
            _cellHBox.addChild(cell);
            _cells.push(cell);
            i++;
         }
      }
      
      private function onIsGuest(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
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
         var needMoney:Array = _WdddingMoneyArr;
         if(PlayerManager.Instance.Self.Money < needMoney[_sizeSelectGroup.selectIndex])
         {
            LeavePageManager.showFillFrame();
            return;
         }
         if(!checkRoom())
         {
            return;
         }
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
         var roomInfo:ChurchRoomInfo = new ChurchRoomInfo();
         roomInfo.roomName = _txtCreateRoomName.text;
         roomInfo.password = _txtCreateRoomPassword.text;
         roomInfo.canInvite = _chkCreateRoomIsGuest.selected;
         roomInfo.discription = LanguageMgr.GetTranslation("church.weddingRoom.frame.CreateRoomFrame._remark_txt",groomName,brideName);
         roomInfo.seniorType = _sizeSelectGroup.selectIndex + 1;
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
      
      private function removeEvents() : void
      {
         removeEventListener("response",onFrameResponse);
         _chkCreateRoomPassword.removeEventListener("click",onRoomPasswordCheck);
         _chkCreateRoomIsGuest.removeEventListener("click",onIsGuest);
         _sizeSelectGroup.removeEventListener("change",__changeHandler);
         _weddingBigBtn.removeEventListener("click",onIsGuest1);
         _weddingMidBtn.removeEventListener("click",onIsGuest2);
         _weddingSmallBtn.removeEventListener("click",onIsGuest3);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_flower);
         _flower = null;
         ObjectUtils.disposeObject(_bgLeftTop);
         _bgLeftTop = null;
         ObjectUtils.disposeObject(_bgLeftBottom);
         _bgLeftBottom = null;
         ObjectUtils.disposeObject(_roomCreateRoomNameTitle);
         _roomCreateRoomNameTitle = null;
         ObjectUtils.disposeObject(_churchKeepsake);
         _churchKeepsake = null;
         ObjectUtils.disposeObject(_txtCreateRoomName);
         _txtCreateRoomName = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_chkCreateRoomPassword);
         _chkCreateRoomPassword = null;
         ObjectUtils.disposeObject(_chkCreateRoomIsGuest);
         _chkCreateRoomIsGuest = null;
         ObjectUtils.disposeObject(_selectedIconButtonTxt1);
         _selectedIconButtonTxt1 = null;
         ObjectUtils.disposeObject(_selectedIconButtonTxt2);
         _selectedIconButtonTxt2 = null;
         ObjectUtils.disposeObject(_txtCreateRoomPassword);
         _txtCreateRoomPassword = null;
         ObjectUtils.disposeObject(_bgRight);
         _bgRight = null;
         ObjectUtils.disposeObject(_weddingBigBtn);
         _weddingBigBtn = null;
         ObjectUtils.disposeObject(_weddingMidBtn);
         _weddingMidBtn = null;
         ObjectUtils.disposeObject(_weddingSmallBtn);
         _weddingSmallBtn = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_sizeSelectGroup);
         _sizeSelectGroup = null;
         ObjectUtils.disposeObject(_cellHBox);
         _cellHBox = null;
         if(_weddingSmalllMoneyTxt)
         {
            ObjectUtils.disposeObject(_weddingSmalllMoneyTxt);
         }
         _weddingSmalllMoneyTxt = null;
         if(_weddingMidMoneyTxt)
         {
            ObjectUtils.disposeObject(_weddingMidMoneyTxt);
         }
         _weddingMidMoneyTxt = null;
         if(_weddingBigMoneyTxt)
         {
            ObjectUtils.disposeObject(_weddingBigMoneyTxt);
         }
         _weddingBigMoneyTxt = null;
         super.dispose();
      }
      
      public function get WeddingMoney() : String
      {
         return _WeddingMoney;
      }
      
      public function set WeddingMoney(value:String) : void
      {
         _WeddingMoney = value;
      }
   }
}
