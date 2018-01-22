package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class UpGradeLackRichesFrame extends Frame
   {
       
      
      private var _bg:MutipleImage;
      
      private var _ok:TextButton;
      
      private var _cancel:TextButton;
      
      public function UpGradeLackRichesFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("AlertDialog.Info");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeLackRichesFrame.bg");
         _ok = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeLackRichesFrame.ok");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeLackRichesFrame.cancel");
         addToContent(_bg);
         addToContent(_ok);
         addToContent(_cancel);
         _ok.text = LanguageMgr.GetTranslation("ok");
         _cancel.text = LanguageMgr.GetTranslation("cancel");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _ok.addEventListener("click",__okHandler);
         _cancel.addEventListener("click",__cancelHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _ok.removeEventListener("click",__okHandler);
         _cancel.removeEventListener("click",__cancelHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __okHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ConsortionModelManager.Instance.alertTaxFrame();
         dispose();
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _bg = null;
         _ok = null;
         _cancel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
