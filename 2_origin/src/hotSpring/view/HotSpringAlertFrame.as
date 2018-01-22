package hotSpring.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class HotSpringAlertFrame extends Frame
   {
       
      
      private var _scrollPanel:ScrollPanel;
      
      private var _bg:Bitmap;
      
      private var _okBtn:TextButton;
      
      public function HotSpringAlertFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.hall.ChooseHallView.hotWellAlert");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("hall.hotSpringAlertPanel");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("hall.hotSpringBtn");
         addToContent(_scrollPanel);
         _okBtn.text = LanguageMgr.GetTranslation("ok");
         addToContent(_okBtn);
         escEnable = true;
      }
      
      private function initEvents() : void
      {
         _okBtn.addEventListener("click",__onClick);
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function removeEvents() : void
      {
         _okBtn.removeEventListener("click",__onClick);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         super.dispose();
      }
   }
}
