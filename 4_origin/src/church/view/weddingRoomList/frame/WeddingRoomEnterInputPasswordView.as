package church.view.weddingRoomList.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.ChurchRoomInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class WeddingRoomEnterInputPasswordView extends BaseAlerFrame
   {
       
      
      private var _churchRoomInfo:ChurchRoomInfo;
      
      private var _alertInfo:AlertInfo;
      
      private var _passwordLabel:FilterFrameText;
      
      private var _txtPassword:TextInput;
      
      public function WeddingRoomEnterInputPasswordView()
      {
         super();
         initialize();
      }
      
      protected function initialize() : void
      {
         setView();
         setEvent();
      }
      
      public function set churchRoomInfo(value:ChurchRoomInfo) : void
      {
         _churchRoomInfo = value;
      }
      
      private function setView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("AlertDialog.Info");
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         this.enterEnable = true;
         _passwordLabel = ComponentFactory.Instance.creat("church.main.roomEnterRoomPasswordLabelAsset");
         _passwordLabel.text = LanguageMgr.GetTranslation("tank.roomlist.RoomListIIPassInput.write");
         addToContent(_passwordLabel);
         _txtPassword = ComponentFactory.Instance.creat("church.main.roomEnterRoomPasswordTextAsset");
         _txtPassword.displayAsPassword = true;
         _txtPassword.maxChars = 6;
         _txtPassword.setFocus();
         addToContent(_txtPassword);
      }
      
      private function removeView() : void
      {
         _alertInfo = null;
         if(_passwordLabel)
         {
            if(_passwordLabel.parent)
            {
               _passwordLabel.parent.removeChild(_passwordLabel);
            }
            _passwordLabel.dispose();
         }
         _passwordLabel = null;
         if(_txtPassword)
         {
            if(_txtPassword.parent)
            {
               _txtPassword.parent.removeChild(_txtPassword);
            }
            _txtPassword.dispose();
         }
         _txtPassword = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function setEvent() : void
      {
         addEventListener("response",onFrameResponse);
         _txtPassword.addEventListener("keyDown",onKeyDown);
         _txtPassword.addEventListener("change",onTxtPasswordChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",onFrameResponse);
         _txtPassword.removeEventListener("keyDown",onKeyDown);
         _txtPassword.removeEventListener("change",onTxtPasswordChange);
      }
      
      private function onKeyDown(evt:KeyboardEvent) : void
      {
         if(evt.keyCode == 13)
         {
            enterRoomConfirm();
         }
      }
      
      private function onTxtPasswordChange(evt:Event) : void
      {
         if(_txtPassword.text != "")
         {
            submitButtonEnable = true;
         }
         else
         {
            submitButtonEnable = false;
         }
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
         submitButtonEnable = false;
         SoundManager.instance.play("008");
         if(_txtPassword.text == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIIPassInput.write"));
            return;
         }
         var type:int = 0;
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
         SocketManager.Instance.out.sendEnterRoom(_churchRoomInfo.id,_txtPassword.text,type);
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         _txtPassword.setFocus();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         removeView();
      }
   }
}
