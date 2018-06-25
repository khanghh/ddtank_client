package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import consortiaDomain.ConsortiaDomainManager;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class ConsortionBankFrame extends Frame
   {
       
      
      private var _bg:MutipleImage;
      
      private var _titleTxt:FilterFrameText;
      
      private var _bankbagView:ConsortionBankBagView;
      
      public function ConsortionBankFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("tank.consortia.consortiabank.ConsortiaBankView.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.bank.bg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.consortionBankFrame.titleText");
         _titleTxt.text = LanguageMgr.GetTranslation("consortion.consortionBankFrame.titleText");
         _bankbagView = ComponentFactory.Instance.creatCustomObject("consortionBankBagView");
         addToContent(_bg);
         addToContent(_titleTxt);
         addToContent(_bankbagView);
         _bankbagView.isNeedCard(false);
         _bankbagView.info = PlayerManager.Instance.Self;
         ConsortiaDomainManager.CAN_USE_K = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      override public function dispose() : void
      {
         ConsortionModelManager.Instance.clearReference();
         removeEvent();
         if(_bankbagView)
         {
            _bankbagView.dispose();
         }
         _bankbagView = null;
         super.dispose();
         _bg = null;
         _titleTxt = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ConsortiaDomainManager.CAN_USE_K = true;
      }
   }
}
