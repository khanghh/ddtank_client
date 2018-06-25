package ddt.view.common.church
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.utils.StringHelper;
   
   public class ChurchProposeResponseFrame extends BaseAlerFrame
   {
       
      
      private var _spouseID:int;
      
      private var _spouseName:String;
      
      private var _love:String;
      
      private var _bg:MutipleImage;
      
      private var _loveTxt:TextArea;
      
      private var _answerId:int;
      
      private var _nameText:FilterFrameText;
      
      private var _name_txt:FilterFrameText;
      
      private var _btnLookEquip:TextButton;
      
      private var _alertInfo:AlertInfo;
      
      public function ChurchProposeResponseFrame()
      {
         super();
         initialize();
      }
      
      private function initialize() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("tank.view.common.church.ProposeResponseFrame.titleText");
         _alertInfo.submitLabel = LanguageMgr.GetTranslation("accept");
         _alertInfo.cancelLabel = LanguageMgr.GetTranslation("refuse");
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         _bg = ComponentFactory.Instance.creatComponentByStylename("church.ProposeResponseAsset.bg");
         addToContent(_bg);
         _nameText = ComponentFactory.Instance.creat("common.church.txtChurchProposeResponseAsset.nameText");
         addToContent(_nameText);
         _name_txt = ComponentFactory.Instance.creat("common.church.txtChurchProposeResponseAsset");
         addToContent(_name_txt);
         _btnLookEquip = ComponentFactory.Instance.creat("common.church.btnLookEquipAsset");
         _btnLookEquip.text = LanguageMgr.GetTranslation("common.church.btnLookEquipAsset.text");
         _btnLookEquip.addEventListener("click",__lookEquip);
         addToContent(_btnLookEquip);
         _loveTxt = ComponentFactory.Instance.creat("common.church.txtChurchProposeResponseMsgAsset");
         addToContent(_loveTxt);
         addEventListener("response",onFrameResponse);
      }
      
      private function onFrameResponse(evt:FrameEvent) : void
      {
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               __cancel();
               break;
            default:
               SoundManager.instance.play("008");
               __cancel();
               break;
            case 3:
            case 4:
               SoundManager.instance.play("008");
               confirmSubmit();
         }
      }
      
      public function get answerId() : int
      {
         return _answerId;
      }
      
      public function set answerId(value:int) : void
      {
         _answerId = value;
      }
      
      public function get love() : String
      {
         return _love;
      }
      
      public function set love(value:String) : void
      {
         _love = value;
         _loveTxt.text = !!_love?_love:"";
      }
      
      public function get spouseName() : String
      {
         return _spouseName;
      }
      
      public function set spouseName(value:String) : void
      {
         _spouseName = value;
         _nameText.text = _spouseName + "，";
         _name_txt.text = LanguageMgr.GetTranslation("ddt.view.common.church.ProposeResponse");
      }
      
      public function get spouseID() : int
      {
         return _spouseID;
      }
      
      public function set spouseID(value:int) : void
      {
         _spouseID = value;
      }
      
      private function __lookEquip(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         PlayerInfoViewControl.viewByID(spouseID);
      }
      
      private function confirmSubmit() : void
      {
         SocketManager.Instance.out.sendProposeRespose(true,spouseID,answerId);
         dispose();
      }
      
      private function __cancel() : void
      {
         SocketManager.Instance.out.sendProposeRespose(false,spouseID,answerId);
         var msg:String = StringHelper.rePlaceHtmlTextField(LanguageMgr.GetTranslation("tank.view.common.church.ProposeResponseFrame.msg",spouseName));
         ChatManager.Instance.sysChatRed(msg);
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("response",onFrameResponse);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         _loveTxt = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_name_txt);
         _name_txt = null;
         ObjectUtils.disposeObject(_btnLookEquip);
         _btnLookEquip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("close"));
      }
   }
}
