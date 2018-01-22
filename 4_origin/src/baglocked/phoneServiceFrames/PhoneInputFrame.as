package baglocked.phoneServiceFrames
{
   import baglocked.BagLockedController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   
   public class PhoneInputFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _description:FilterFrameText;
      
      private var _numInput:TextInput;
      
      private var _tips:FilterFrameText;
      
      private var _nextBtn:TextButton;
      
      private var type:int;
      
      public function PhoneInputFrame()
      {
         super();
      }
      
      public function init2(param1:int) : void
      {
         type = param1;
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.changePhoneTxt");
         _description = ComponentFactory.Instance.creatComponentByStylename("baglocked.whiteTxt");
         PositionUtils.setPos(_description,"bagLocked.phoneDescPos");
         addToContent(_description);
         _numInput = ComponentFactory.Instance.creatComponentByStylename("baglocked.phoneTextInput");
         _numInput.textField.restrict = "0-9";
         addToContent(_numInput);
         _tips = ComponentFactory.Instance.creatComponentByStylename("baglocked.deepRedTxt");
         PositionUtils.setPos(_tips,"bagLocked.phoneTipPos");
         addToContent(_tips);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _nextBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.next");
         PositionUtils.setPos(_nextBtn,"bagLocked.nextBtnPos2");
         addToContent(_nextBtn);
         _description.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.inputFormerPhoneNum");
         _tips.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.tip1");
         addEvent();
      }
      
      protected function __nextBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_numInput.text.length != 11)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.phoneLengthWrong"));
            return;
         }
         SocketManager.Instance.out.getBackLockPwdByPhone(1,_numInput.text);
         BagLockedController.Instance.phoneNum = _numInput.text;
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
         _nextBtn.addEventListener("click",__nextBtnClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _nextBtn.removeEventListener("click",__nextBtnClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_description)
         {
            ObjectUtils.disposeObject(_description);
         }
         _description = null;
         if(_numInput)
         {
            ObjectUtils.disposeObject(_numInput);
         }
         _numInput = null;
         if(_tips)
         {
            ObjectUtils.disposeObject(_tips);
         }
         _tips = null;
         if(_nextBtn)
         {
            ObjectUtils.disposeObject(_nextBtn);
         }
         _nextBtn = null;
         super.dispose();
      }
   }
}
