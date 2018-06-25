package ddt.view.common.church
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class ChurchDialogueAgreePropose extends BaseAlerFrame
   {
       
      
      private var _bg:Bitmap;
      
      public var isShowed:Boolean = true;
      
      private var _alertInfo:AlertInfo;
      
      private var _msgInfo:String;
      
      private var _name_txt:FilterFrameText;
      
      private var _contentTxt:FilterFrameText;
      
      public function ChurchDialogueAgreePropose()
      {
         super();
         initialize();
      }
      
      public function get msgInfo() : String
      {
         return _msgInfo;
      }
      
      public function set msgInfo(value:String) : void
      {
         _msgInfo = value;
         _name_txt.text = _msgInfo;
         isShowed = false;
      }
      
      private function initialize() : void
      {
         cancelButtonStyle = "church.simplebt1";
         submitButtonStyle = "church.simplebt2";
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("tank.view.common.church.ProposeResponseFrame.titleText");
         _alertInfo.submitLabel = LanguageMgr.GetTranslation("tank.view.common.church.DialogueAgreePropose.okLabel");
         _alertInfo.cancelLabel = LanguageMgr.GetTranslation("tank.view.common.church.DialogueAgreePropose.cancelLabel");
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _bg = ComponentFactory.Instance.creatBitmap("asset.church.AgreeProposeAsset");
         addToContent(_bg);
         _name_txt = ComponentFactory.Instance.creat("common.church.churchDialogueAgreeProposeUserNameAsset");
         addToContent(_name_txt);
         _contentTxt = ComponentFactory.Instance.creat("common.church.churchDialogueAgreePropose.contentText");
         _contentTxt.text = LanguageMgr.GetTranslation("common.church.churchDialogueAgreePropose.contentText.text");
         addToContent(_contentTxt);
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
               SoundManager.instance.play("008");
               confirmSubmit();
         }
      }
      
      private function confirmSubmit() : void
      {
         SoundManager.instance.play("008");
         StateManager.setState("ddtchurchroomlist");
         dispose();
      }
      
      public function show() : void
      {
         SoundManager.instance.play("018");
         LayerManager.Instance.addToLayer(this,3,true,1);
         isShowed = true;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("response",onFrameResponse);
         _alertInfo = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_name_txt);
         _name_txt = null;
         if(_contentTxt)
         {
            ObjectUtils.disposeObject(_contentTxt);
         }
         _contentTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("close"));
      }
   }
}
