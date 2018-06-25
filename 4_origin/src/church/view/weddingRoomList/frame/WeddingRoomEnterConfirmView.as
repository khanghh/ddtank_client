package church.view.weddingRoomList.frame
{
   import church.controller.ChurchRoomListController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.ChurchRoomInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class WeddingRoomEnterConfirmView extends BaseAlerFrame
   {
       
      
      private var _controller:ChurchRoomListController;
      
      private var _churchRoomInfo:ChurchRoomInfo;
      
      private var _bg:Scale9CornerImage;
      
      private var _bmpRoomName:FilterFrameText;
      
      private var _bmpGroom:FilterFrameText;
      
      private var _bmpBride:FilterFrameText;
      
      private var _bmpCount:FilterFrameText;
      
      private var _flower:Bitmap;
      
      private var _bmpSpareTime:FilterFrameText;
      
      private var _bmpLineBox:ScaleBitmapImage;
      
      private var _bmpDescription:FilterFrameText;
      
      private var _bmpLine1:Bitmap;
      
      private var _imgLine:MutipleImage;
      
      private var _imgLine3:Image;
      
      private var _imgLine4:Image;
      
      private var _imgLine5:Image;
      
      private var _roomNameText:FilterFrameText;
      
      private var _groomText:FilterFrameText;
      
      private var _grideText:FilterFrameText;
      
      private var _countText:FilterFrameText;
      
      private var _spareTime:FilterFrameText;
      
      private var _alertInfo:AlertInfo;
      
      private var _txtDescription:TextArea;
      
      private var _textDescriptionBg:Sprite;
      
      private var _weddingRoomEnterInputPasswordView:WeddingRoomEnterInputPasswordView;
      
      private var _titleTxt:FilterFrameText;
      
      public function WeddingRoomEnterConfirmView()
      {
         super();
         initialize();
      }
      
      protected function initialize() : void
      {
         setView();
         setEvent();
      }
      
      public function set controller(value:ChurchRoomListController) : void
      {
         _controller = value;
      }
      
      public function set churchRoomInfo(value:ChurchRoomInfo) : void
      {
         _churchRoomInfo = value;
         _roomNameText.text = _churchRoomInfo.roomName;
         _groomText.text = _churchRoomInfo.groomName;
         _grideText.text = _churchRoomInfo.brideName;
         _countText.text = _churchRoomInfo.currentNum.toString();
         var hour:int = (_churchRoomInfo.valideTimes * 60 - (TimeManager.Instance.Now().time / 60000 - _churchRoomInfo.creactTime.time / 60000)) / 60;
         if(hour >= 0)
         {
            hour = Math.floor(hour);
         }
         else
         {
            hour = Math.ceil(hour);
         }
         var min:int = (int(_churchRoomInfo.valideTimes * 60 - (TimeManager.Instance.Now().time / 60000 - _churchRoomInfo.creactTime.time / 60000))) % 60;
         if(hour < 0 || min < 0)
         {
            _spareTime.text = LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.time");
         }
         else
         {
            _spareTime.text = hour.toString() + LanguageMgr.GetTranslation("hours") + min.toString() + LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.minute");
         }
         _txtDescription.text = _churchRoomInfo.discription;
      }
      
      private function setView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo();
         _alertInfo.moveEnable = false;
         _alertInfo.submitLabel = LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.into");
         info = _alertInfo;
         this.escEnable = true;
         _flower = ComponentFactory.Instance.creatBitmap("asset.churchroomlist.flowers");
         var _loc1_:* = 0.9;
         _flower.scaleY = _loc1_;
         _flower.scaleX = _loc1_;
         PositionUtils.setPos(_flower,"WeddingRoomEnterConfirmView.titleFlowers.pos");
         addToContent(_flower);
         _titleTxt = ComponentFactory.Instance.creat("ddtchurchroomlist.frame.WeddingRoomEnterConfirmView.titleText");
         _titleTxt.text = LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.titleText");
         addToContent(_titleTxt);
         _bg = ComponentFactory.Instance.creat("church.main.roomEnterConfirmBg");
         addToContent(_bg);
         _bmpRoomName = ComponentFactory.Instance.creat("church.main.WeddingRoomEnterConfirmView.roomNameTxt");
         _bmpRoomName.text = LanguageMgr.GetTranslation("church.main.WeddingRoomEnterConfirmView.roomNameTxt");
         addToContent(_bmpRoomName);
         _bmpGroom = ComponentFactory.Instance.creat("church.main.WeddingRoomEnterConfirmView.bridegroomTxt");
         _bmpGroom.text = LanguageMgr.GetTranslation("church.main.WeddingRoomEnterConfirmView.bridegroomTxt");
         addToContent(_bmpGroom);
         _bmpBride = ComponentFactory.Instance.creat("church.main.WeddingRoomEnterConfirmView.brideTxt");
         _bmpBride.text = LanguageMgr.GetTranslation("church.main.WeddingRoomEnterConfirmView.brideTxt");
         addToContent(_bmpBride);
         _bmpCount = ComponentFactory.Instance.creat("church.main.WeddingRoomEnterConfirmView.numberTxt");
         _bmpCount.text = LanguageMgr.GetTranslation("church.main.WeddingRoomEnterConfirmView.numberTxt");
         addToContent(_bmpCount);
         _bmpSpareTime = ComponentFactory.Instance.creat("church.main.WeddingRoomEnterConfirmView.timeTxt");
         _bmpSpareTime.text = LanguageMgr.GetTranslation("church.main.WeddingRoomEnterConfirmView.timeTxt");
         addToContent(_bmpSpareTime);
         _bmpLineBox = ComponentFactory.Instance.creatComponentByStylename("church.roomEnterLineBoxAsset");
         addToContent(_bmpLineBox);
         _bmpDescription = ComponentFactory.Instance.creat("church.main.WeddingRoomEnterConfirmView.describeTxt");
         _bmpDescription.text = LanguageMgr.GetTranslation("church.main.WeddingRoomEnterConfirmView.describeTxt");
         addToContent(_bmpDescription);
         _imgLine = ComponentFactory.Instance.creatComponentByStylename("church.roomEnterLineAsset");
         addToContent(_imgLine);
         _roomNameText = ComponentFactory.Instance.creat("church.main.roomEnterRoomNameTextAsset");
         addToContent(_roomNameText);
         _groomText = ComponentFactory.Instance.creat("church.main.roomEnterGroomTextAsset");
         addToContent(_groomText);
         _grideText = ComponentFactory.Instance.creat("church.main.roomEnterBrideTextAsset");
         addToContent(_grideText);
         _countText = ComponentFactory.Instance.creat("church.main.roomEnterCountTextAsset");
         addToContent(_countText);
         _spareTime = ComponentFactory.Instance.creat("church.main.roomEnterSpareTimeTextAsset");
         addToContent(_spareTime);
         _txtDescription = ComponentFactory.Instance.creat("church.view.weddingRoomList.frame.txtRoomEnterDescriptionAsset");
         addToContent(_txtDescription);
      }
      
      private function setEvent() : void
      {
         addEventListener("response",onFrameResponse);
      }
      
      private function onFrameResponse(evt:FrameEvent) : void
      {
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               enterRoomConfirm();
         }
      }
      
      private function enterRoomConfirm() : void
      {
         var type:int = 0;
         SoundManager.instance.play("008");
         if(_churchRoomInfo.isLocked)
         {
            _weddingRoomEnterInputPasswordView = ComponentFactory.Instance.creat("church.main.weddingRoomList.WeddingRoomEnterInputPasswordView");
            _weddingRoomEnterInputPasswordView.churchRoomInfo = _churchRoomInfo;
            _weddingRoomEnterInputPasswordView.submitButtonEnable = false;
            _weddingRoomEnterInputPasswordView.show();
         }
         else
         {
            if(_churchRoomInfo.seniorType == 0)
            {
               type = 1;
            }
            else if(_churchRoomInfo.seniorType == 4)
            {
               type = 3;
            }
            else
            {
               type = 2;
            }
            SocketManager.Instance.out.sendEnterRoom(_churchRoomInfo.id,"",type);
         }
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",onFrameResponse);
      }
      
      private function removeView() : void
      {
         if(_titleTxt)
         {
            if(_titleTxt.parent)
            {
               _titleTxt.parent.removeChild(_titleTxt);
            }
            _titleTxt.dispose();
         }
         _titleTxt = null;
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
         if(_bg)
         {
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
            _bg.dispose();
         }
         _bg = null;
         if(_bmpRoomName)
         {
            if(_bmpRoomName.parent)
            {
               _bmpRoomName.parent.removeChild(_bmpRoomName);
            }
         }
         _bmpRoomName = null;
         if(_bmpGroom)
         {
            if(_bmpGroom.parent)
            {
               _bmpGroom.parent.removeChild(_bmpGroom);
            }
         }
         _bmpGroom = null;
         if(_bmpBride)
         {
            if(_bmpBride.parent)
            {
               _bmpBride.parent.removeChild(_bmpBride);
            }
         }
         _bmpBride = null;
         if(_bmpCount)
         {
            if(_bmpCount.parent)
            {
               _bmpCount.parent.removeChild(_bmpCount);
            }
         }
         _bmpCount = null;
         if(_bmpSpareTime)
         {
            if(_bmpSpareTime.parent)
            {
               _bmpSpareTime.parent.removeChild(_bmpSpareTime);
            }
         }
         _bmpSpareTime = null;
         if(_bmpLineBox)
         {
            if(_bmpLineBox.parent)
            {
               _bmpLineBox.parent.removeChild(_bmpLineBox);
            }
         }
         _bmpLineBox = null;
         if(_bmpDescription)
         {
            if(_bmpDescription.parent)
            {
               _bmpDescription.parent.removeChild(_bmpDescription);
            }
         }
         _bmpDescription = null;
         if(_imgLine)
         {
            if(_imgLine.parent)
            {
               _imgLine.parent.removeChild(_imgLine);
            }
         }
         _imgLine = null;
         if(_roomNameText)
         {
            if(_roomNameText.parent)
            {
               _roomNameText.parent.removeChild(_roomNameText);
            }
            _roomNameText.dispose();
         }
         _roomNameText = null;
         if(_groomText)
         {
            if(_groomText.parent)
            {
               _groomText.parent.removeChild(_groomText);
            }
            _groomText.dispose();
         }
         _groomText = null;
         if(_grideText)
         {
            if(_grideText.parent)
            {
               _grideText.parent.removeChild(_grideText);
            }
            _grideText.dispose();
         }
         _grideText = null;
         if(_countText)
         {
            if(_countText.parent)
            {
               _countText.parent.removeChild(_countText);
            }
            _countText.dispose();
         }
         _countText = null;
         if(_spareTime)
         {
            if(_spareTime.parent)
            {
               _spareTime.parent.removeChild(_spareTime);
            }
            _spareTime.dispose();
         }
         _spareTime = null;
         _alertInfo = null;
         _txtDescription = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         removeView();
      }
   }
}
