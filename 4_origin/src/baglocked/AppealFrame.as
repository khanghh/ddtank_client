package baglocked
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class AppealFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _appealMap:MovieClip;
      
      private var _closeBtn:TextButton;
      
      public function AppealFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.appeal");
         _appealMap = ComponentFactory.Instance.creat("baglocked.appeal");
         addToContent(_appealMap);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         PositionUtils.setPos(_closeBtn,"bagLocked.closeBtnPos");
         _closeBtn.text = LanguageMgr.GetTranslation("close");
         addToContent(_closeBtn);
         addEvent();
      }
      
      protected function __closeBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.close();
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               _bagLockedController.close();
         }
      }
      
      public function set bagLockedController(param1:BagLockedController) : void
      {
         _bagLockedController = param1;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _closeBtn.addEventListener("click",__closeBtnClick);
      }
      
      private function remvoeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _closeBtn.removeEventListener("click",__closeBtnClick);
      }
      
      override public function dispose() : void
      {
         if(_appealMap)
         {
            ObjectUtils.disposeObject(_appealMap);
         }
         _appealMap = null;
         if(_closeBtn)
         {
            ObjectUtils.disposeObject(_closeBtn);
         }
         _closeBtn = null;
         super.dispose();
      }
   }
}
