package oldPlayerRegress.view.itemView
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   
   public class WelFrameView extends Frame
   {
       
      
      private var _frameBg:Scale9CornerImage;
      
      private var _frameInfo:FilterFrameText;
      
      public function WelFrameView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.regress.welView.Privilege");
         _frameBg = ComponentFactory.Instance.creatComponentByStylename("regress.privilege.FrameBg");
         _frameInfo = ComponentFactory.Instance.creatComponentByStylename("regress.privilege.frameInfo");
         _frameInfo.text = LanguageMgr.GetTranslation("ddt.regress.welview.PrivilegeFrameInfo");
         addToContent(_frameBg);
         addToContent(_frameInfo);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_frameBg)
         {
            _frameBg.dispose();
            _frameBg = null;
         }
      }
   }
}
