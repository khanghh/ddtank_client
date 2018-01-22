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
      
      public function ConsortionBankFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function __clickHandler(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
