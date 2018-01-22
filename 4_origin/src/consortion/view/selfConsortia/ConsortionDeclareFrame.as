package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.TextArea;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import road7th.utils.StringHelper;
   
   public class ConsortionDeclareFrame extends Frame
   {
       
      
      private var _bg:Scale9CornerImage;
      
      private var _input:TextArea;
      
      private var _ok:TextButton;
      
      private var _cancel:TextButton;
      
      public function ConsortionDeclareFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaDeclarationFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.ConsortionDeclareFrameBG");
         _input = ComponentFactory.Instance.creatComponentByStylename("consortion.declareFrame.input");
         _ok = ComponentFactory.Instance.creatComponentByStylename("consortion.declareFrame.ok");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("consortion.declareFrame.cancel");
         addToContent(_bg);
         addToContent(_input);
         addToContent(_ok);
         addToContent(_cancel);
         _ok.text = LanguageMgr.GetTranslation("ok");
         _cancel.text = LanguageMgr.GetTranslation("cancel");
         _ok.enable = false;
         _input.text = PlayerManager.Instance.Self.consortiaInfo.Description;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         addEventListener("addedToStage",__addToStageHandler);
         _ok.addEventListener("click",__okHandler);
         _cancel.addEventListener("click",__cancelHandler);
         _input.addEventListener("change",__inputChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         removeEventListener("addedToStage",__addToStageHandler);
         _ok.removeEventListener("click",__okHandler);
         _cancel.removeEventListener("click",__cancelHandler);
         _input.removeEventListener("change",__inputChangeHandler);
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         _input.textField.setFocus();
         _input.textField.setSelection(_input.text.length,_input.text.length);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
         if(param1.responseCode == 2)
         {
            sendDeclar();
         }
      }
      
      private function __okHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendDeclar();
      }
      
      private function sendDeclar() : void
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTF(StringHelper.trim(_input.text));
         if(_loc2_.length > 300)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaDeclarationFrame.long"));
            return;
         }
         if(FilterWordManager.isGotForbiddenWords(_input.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaAfficheFrame"));
            return;
         }
         var _loc1_:String = FilterWordManager.filterWrod(_input.text);
         _loc1_.replace("\r","");
         _loc1_.replace("\n","");
         _loc1_ = StringHelper.trim(_loc1_);
         SocketManager.Instance.out.sendConsortiaUpdateDescription(_loc1_);
         dispose();
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function __inputChangeHandler(param1:Event) : void
      {
         StringHelper.checkTextFieldLength(_input.textField,300);
         if(_input.text != PlayerManager.Instance.Self.consortiaInfo.Description)
         {
            _ok.enable = true;
         }
         else
         {
            _ok.enable = false;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _bg.dispose();
         _bg = null;
         _input = null;
         _ok = null;
         _cancel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
