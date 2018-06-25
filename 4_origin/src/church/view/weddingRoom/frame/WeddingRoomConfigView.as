package church.view.weddingRoom.frame
{
   import church.ChurchManager;
   import church.controller.ChurchRoomController;
   import church.model.ChurchRoomModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class WeddingRoomConfigView extends BaseAlerFrame
   {
       
      
      private var _controller:ChurchRoomController;
      
      private var _model:ChurchRoomModel;
      
      private var _alertInfo:AlertInfo;
      
      private var _configRoomFrameTopBg:ScaleBitmapImage;
      
      private var _configRoomFrameBottomBg:Scale9CornerImage;
      
      private var _roomNameTitle:Bitmap;
      
      private var _roomIntroTitle:Bitmap;
      
      private var _txtConfigRoomName:FilterFrameText;
      
      private var _chkConfigRoomPassword:SelectedIconButton;
      
      private var _txtConfigRoomPassword:TextInput;
      
      private var _txtConfigRoomIntro:TextArea;
      
      private var _configIntroMaxChBg:Bitmap;
      
      private var _roomConfigIntroMaxChLabel:FilterFrameText;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _selectedIconButtonTxt:FilterFrameText;
      
      public function WeddingRoomConfigView()
      {
         super();
         initialize();
      }
      
      public function get controller() : ChurchRoomController
      {
         return _controller;
      }
      
      public function set controller(value:ChurchRoomController) : void
      {
         _controller = value;
      }
      
      protected function initialize() : void
      {
         setView();
         setEvent();
      }
      
      private function setView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("church.churchScene.frame.ModifyRoomInfoFrame.titleText");
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _configRoomFrameTopBg = ComponentFactory.Instance.creat("church.weddingRoom.configRoomFrameTopBg");
         addToContent(_configRoomFrameTopBg);
         _configRoomFrameBottomBg = ComponentFactory.Instance.creat("church.weddingRoom.configRoomFrameBottomBg");
         addToContent(_configRoomFrameBottomBg);
         _roomNameTitle = ComponentFactory.Instance.creatBitmap("asset.church.roomCreateRoomNameTitleAsset");
         var posIII:Point = ComponentFactory.Instance.creat("church.room.RoomNameTitlePos");
         _roomNameTitle.x = posIII.x;
         _roomNameTitle.y = posIII.y;
         addToContent(_roomNameTitle);
         _roomIntroTitle = ComponentFactory.Instance.creatBitmap("asset.church.roomCreateIntroAsset");
         var pos:Point = ComponentFactory.Instance.creatCustomObject("church.room.CreateIntroPos");
         _roomIntroTitle.x = pos.x;
         _roomIntroTitle.y = pos.y;
         addToContent(_roomIntroTitle);
         _txtConfigRoomName = ComponentFactory.Instance.creat("church.weddingRoom.txtConfigRoomName");
         _bg1 = ComponentFactory.Instance.creat("church.main.txtConfigRoomNameBG");
         addToContent(_bg1);
         addToContent(_txtConfigRoomName);
         _chkConfigRoomPassword = ComponentFactory.Instance.creat("church.weddingRoom.chkConfigRoomPassword");
         addToContent(_chkConfigRoomPassword);
         _selectedIconButtonTxt = ComponentFactory.Instance.creat("church.main.WeddingRoomConfigView.SelectedIconButtonTxt");
         _selectedIconButtonTxt.text = LanguageMgr.GetTranslation("church.main.WeddingRoomCreateView.SelectedIconButtonTxt1.text");
         _chkConfigRoomPassword.addChild(_selectedIconButtonTxt);
         _txtConfigRoomPassword = ComponentFactory.Instance.creat("church.weddingRoom.txtConfigRoomPassword");
         _txtConfigRoomPassword.displayAsPassword = true;
         _txtConfigRoomPassword.enable = false;
         _txtConfigRoomPassword.maxChars = 6;
         addToContent(_txtConfigRoomPassword);
         _txtConfigRoomIntro = ComponentFactory.Instance.creat("church.weddingRoom.txtConfigRoomIntro");
         _txtConfigRoomIntro.maxChars = 300;
         addToContent(_txtConfigRoomIntro);
         _roomConfigIntroMaxChLabel = ComponentFactory.Instance.creat("church.weddingRoom.roomConfigIntroMaxChLabelAsset");
         addToContent(_roomConfigIntroMaxChLabel);
         getRoomInfo();
      }
      
      private function setEvent() : void
      {
         addEventListener("response",onFrameResponse);
         _chkConfigRoomPassword.addEventListener("click",onRoomPasswordCheck);
         _txtConfigRoomIntro.addEventListener("change",onRemarkChange);
      }
      
      private function getRoomInfo() : void
      {
         _txtConfigRoomName.text = ChurchManager.instance.currentRoom.roomName;
         _txtConfigRoomIntro.text = ChurchManager.instance.currentRoom.discription;
         onRemarkChange();
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
               confirmSubmit();
         }
      }
      
      private function confirmSubmit() : void
      {
         if(!checkRoom())
         {
            return;
         }
         var str:String = FilterWordManager.filterWrod(_txtConfigRoomIntro.text);
         ChurchManager.instance.currentRoom.roomName = _txtConfigRoomName.text;
         ChurchManager.instance.currentRoom.discription = str;
         _controller.modifyDiscription(_txtConfigRoomName.text,_chkConfigRoomPassword.selected,_txtConfigRoomPassword.text,str);
         dispose();
      }
      
      private function checkRoom() : Boolean
      {
         if(StringUtils.isEmpty(_txtConfigRoomName.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.name"));
            return false;
         }
         if(FilterWordManager.isGotForbiddenWords(_txtConfigRoomName.text,"name"))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.string"));
            return false;
         }
         if(_chkConfigRoomPassword.selected && FilterWordManager.IsNullorEmpty(_txtConfigRoomPassword.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.set"));
            _txtConfigRoomPassword.setFocus();
            return false;
         }
         return true;
      }
      
      private function onRoomPasswordCheck(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _txtConfigRoomPassword.enable = _chkConfigRoomPassword.selected;
         if(_txtConfigRoomPassword.enable)
         {
            _txtConfigRoomPassword.setFocus();
         }
         else
         {
            _txtConfigRoomPassword.text = "";
         }
      }
      
      private function onRemarkChange(e:Event = null) : void
      {
         _roomConfigIntroMaxChLabel.text = LanguageMgr.GetTranslation("church.churchScene.frame.ModifyDiscriptionFrame.spare") + (String(_txtConfigRoomIntro.maxChars - _txtConfigRoomIntro.text.length)) + LanguageMgr.GetTranslation("church.churchScene.frame.ModifyDiscriptionFrame.word");
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function removeView() : void
      {
         _alertInfo = null;
         if(_configRoomFrameTopBg)
         {
            if(_configRoomFrameTopBg.parent)
            {
               _configRoomFrameTopBg.parent.removeChild(_configRoomFrameTopBg);
            }
            _configRoomFrameTopBg.dispose();
         }
         _configRoomFrameTopBg = null;
         if(_configRoomFrameBottomBg)
         {
            if(_configRoomFrameBottomBg.parent)
            {
               _configRoomFrameBottomBg.parent.removeChild(_configRoomFrameBottomBg);
            }
            _configRoomFrameBottomBg.dispose();
         }
         _configRoomFrameBottomBg = null;
         if(_roomNameTitle)
         {
            if(_roomNameTitle.parent)
            {
               _roomNameTitle.parent.removeChild(_roomNameTitle);
            }
            _roomNameTitle.bitmapData.dispose();
            _roomNameTitle.bitmapData = null;
         }
         _roomNameTitle = null;
         if(_roomIntroTitle)
         {
            if(_roomIntroTitle.parent)
            {
               _roomIntroTitle.parent.removeChild(_roomIntroTitle);
            }
            _roomIntroTitle.bitmapData.dispose();
            _roomIntroTitle.bitmapData = null;
         }
         _roomIntroTitle = null;
         if(_txtConfigRoomName)
         {
            if(_txtConfigRoomName.parent)
            {
               _txtConfigRoomName.parent.removeChild(_txtConfigRoomName);
            }
            _txtConfigRoomName.dispose();
         }
         _txtConfigRoomName = null;
         if(_bg1)
         {
            ObjectUtils.disposeObject(_bg1);
         }
         _bg1 = null;
         if(_chkConfigRoomPassword)
         {
            if(_chkConfigRoomPassword.parent)
            {
               _chkConfigRoomPassword.parent.removeChild(_chkConfigRoomPassword);
            }
            _chkConfigRoomPassword.dispose();
         }
         _chkConfigRoomPassword = null;
         if(_selectedIconButtonTxt)
         {
            if(_selectedIconButtonTxt.parent)
            {
               _selectedIconButtonTxt.parent.removeChild(_selectedIconButtonTxt);
            }
            _selectedIconButtonTxt.dispose();
         }
         _selectedIconButtonTxt = null;
         if(_txtConfigRoomPassword)
         {
            if(_txtConfigRoomPassword.parent)
            {
               _txtConfigRoomPassword.parent.removeChild(_txtConfigRoomPassword);
            }
            _txtConfigRoomPassword.dispose();
         }
         _txtConfigRoomPassword = null;
         ObjectUtils.disposeObject(_txtConfigRoomIntro);
         _txtConfigRoomIntro = null;
         if(_roomConfigIntroMaxChLabel)
         {
            if(_roomConfigIntroMaxChLabel.parent)
            {
               _roomConfigIntroMaxChLabel.parent.removeChild(_roomConfigIntroMaxChLabel);
            }
            _roomConfigIntroMaxChLabel.dispose();
         }
         _roomConfigIntroMaxChLabel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         dispatchEvent(new Event("close"));
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",onFrameResponse);
         if(_chkConfigRoomPassword)
         {
            _chkConfigRoomPassword.removeEventListener("click",onRoomPasswordCheck);
         }
         if(_txtConfigRoomIntro)
         {
            _txtConfigRoomIntro.removeEventListener("change",onRemarkChange);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         removeView();
         super.dispose();
      }
   }
}
