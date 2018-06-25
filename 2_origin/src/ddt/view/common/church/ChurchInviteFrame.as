package ddt.view.common.church
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import flash.display.Bitmap;
   
   public class ChurchInviteFrame extends BaseAlerFrame
   {
       
      
      private var _inviteName:String;
      
      private var _roomid:int;
      
      private var _password:String;
      
      private var _sceneIndex:int;
      
      private var _name_txt:FilterFrameText;
      
      private var _bmTitle:Bitmap;
      
      private var _bmMsg:Bitmap;
      
      private var _alertInfo:AlertInfo;
      
      public function ChurchInviteFrame()
      {
         super();
         initialize();
      }
      
      private function initialize() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo();
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         addEventListener("response",onFrameResponse);
      }
      
      private function confirmSubmit() : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendEnterRoom(_roomid,_password,_sceneIndex);
         dispose();
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
               SoundManager.instance.play("008");
               confirmSubmit();
         }
      }
      
      public function set msgInfo(value:Object) : void
      {
         _inviteName = value["inviteName"];
         _roomid = value["roomID"];
         _password = value["pwd"];
         _sceneIndex = value["sceneIndex"];
         _name_txt = ComponentFactory.Instance.creatComponentByStylename("common.church.ChurchInviteFrameInfoAsset");
         _name_txt.text = _inviteName;
         addToContent(_name_txt);
         _bmTitle = ComponentFactory.Instance.creatBitmap("asset.church.churchInviteTitleAsset");
         addToContent(_bmTitle);
         _bmMsg = ComponentFactory.Instance.creatBitmap("asset.church.churchInviteMsgAsset");
         addToContent(_bmMsg);
         _bmMsg.x = _name_txt.textWidth + _name_txt.x + 10;
         var fwidth:int = _name_txt.textWidth + _bmMsg.width + 60;
         width = fwidth;
         _bmTitle.x = (fwidth - _bmTitle.width) / 2 - 30;
      }
      
      public function show() : void
      {
         if(!BuriedManager.Instance.isOpening)
         {
            LayerManager.Instance.addToLayer(this,0,true,1);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("response",onFrameResponse);
         _alertInfo = null;
         ObjectUtils.disposeObject(_name_txt);
         _name_txt = null;
         ObjectUtils.disposeObject(_bmTitle);
         _bmTitle = null;
         ObjectUtils.disposeObject(_bmMsg);
         _bmMsg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
