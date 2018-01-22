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
      
      private function onFrameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
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
      
      public function set msgInfo(param1:Object) : void
      {
         _inviteName = param1["inviteName"];
         _roomid = param1["roomID"];
         _password = param1["pwd"];
         _sceneIndex = param1["sceneIndex"];
         _name_txt = ComponentFactory.Instance.creatComponentByStylename("common.church.ChurchInviteFrameInfoAsset");
         _name_txt.text = _inviteName;
         addToContent(_name_txt);
         _bmTitle = ComponentFactory.Instance.creatBitmap("asset.church.churchInviteTitleAsset");
         addToContent(_bmTitle);
         _bmMsg = ComponentFactory.Instance.creatBitmap("asset.church.churchInviteMsgAsset");
         addToContent(_bmMsg);
         _bmMsg.x = _name_txt.textWidth + _name_txt.x + 10;
         var _loc2_:int = _name_txt.textWidth + _bmMsg.width + 60;
         width = _loc2_;
         _bmTitle.x = (_loc2_ - _bmTitle.width) / 2 - 30;
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
