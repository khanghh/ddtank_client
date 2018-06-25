package baglocked.phoneServiceFrames
{
   import baglocked.BagLockedController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import quest.TaskManager;
   
   public class BenefitOfBindingFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _BG:Bitmap;
      
      private var _startBtn:TextButton;
      
      private var _nextTimeBtn:TextButton;
      
      public function BenefitOfBindingFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.benefitOfBinding");
         _BG = ComponentFactory.Instance.creat("baglock.bindPhoneNum");
         addToContent(_BG);
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("baglocked.startBtn");
         _startBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.startToBind");
         addToContent(_startBtn);
         _nextTimeBtn = ComponentFactory.Instance.creatComponentByStylename("baglocked.nextTimeBtn");
         _nextTimeBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.nextTime");
         addToContent(_nextTimeBtn);
         addEvent();
      }
      
      protected function __startBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.close();
         TaskManager.instance.jumpToQuestByID(545);
      }
      
      protected function __nextTimeBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.close();
         if(PlayerManager.Instance.Self.questionOne == "")
         {
            _bagLockedController.openSetPassFrame1();
         }
         else
         {
            _bagLockedController.openSetPassFrameNew();
         }
         BagLockedController.Instance.removeLockPwdEvent();
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
         _startBtn.addEventListener("click",__startBtnClick);
         _nextTimeBtn.addEventListener("click",__nextTimeBtnClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _startBtn.removeEventListener("click",__startBtnClick);
         _nextTimeBtn.removeEventListener("click",__nextTimeBtnClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         _BG = null;
         if(_startBtn)
         {
            ObjectUtils.disposeObject(_startBtn);
         }
         _startBtn = null;
         if(_nextTimeBtn)
         {
            ObjectUtils.disposeObject(_nextTimeBtn);
         }
         _nextTimeBtn = null;
         super.dispose();
      }
   }
}
