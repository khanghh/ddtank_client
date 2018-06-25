package baglocked.phone4399
{
   import baglocked.BagLockedController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class GetConfirmFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _confirmMap:Bitmap;
      
      private var _getConfirmBtn:TextButton;
      
      public function GetConfirmFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.resetQuestion");
         _confirmMap = ComponentFactory.Instance.creat("baglocked.notice_4399");
         addToContent(_confirmMap);
         _getConfirmBtn = ComponentFactory.Instance.creatComponentByStylename("baglocked.getConfirmBtn");
         _getConfirmBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.getConfirm");
         addToContent(_getConfirmBtn);
         addEvent();
      }
      
      protected function __getConfirmBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         BagLockedController.Instance.requestConfirm(1);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               _bagLockedController.close();
         }
      }
      
      public function set bagLockedController(value:BagLockedController) : void
      {
         _bagLockedController = value;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _getConfirmBtn.addEventListener("click",__getConfirmBtnClick);
      }
      
      private function remvoeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _getConfirmBtn.removeEventListener("click",__getConfirmBtnClick);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_confirmMap);
         _confirmMap = null;
         ObjectUtils.disposeObject(_getConfirmBtn);
         _getConfirmBtn = null;
         super.dispose();
      }
   }
}
