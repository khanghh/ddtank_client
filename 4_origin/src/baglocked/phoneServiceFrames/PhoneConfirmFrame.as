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
   
   public class PhoneConfirmFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _description1:FilterFrameText;
      
      private var _description2:FilterFrameText;
      
      private var _phoneInput:TextInput;
      
      private var _phoneReInput:TextInput;
      
      private var _tips:FilterFrameText;
      
      private var _nextBtn:TextButton;
      
      private var type:int;
      
      public function PhoneConfirmFrame()
      {
         super();
      }
      
      public function init2(param1:int) : void
      {
         type = param1;
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.changePhoneTxt");
         _description1 = ComponentFactory.Instance.creatComponentByStylename("baglocked.whiteTxt");
         PositionUtils.setPos(_description1,"bagLocked.phoneInputTxtPos");
         _description1.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.inputNewPhoneNum");
         addToContent(_description1);
         _description2 = ComponentFactory.Instance.creatComponentByStylename("baglocked.whiteTxt");
         PositionUtils.setPos(_description2,"bagLocked.phoneReInputTxtPos");
         _description2.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.reInputNewPhoneNum");
         addToContent(_description2);
         _phoneInput = ComponentFactory.Instance.creatComponentByStylename("baglocked.newPhoneTextInput");
         _phoneInput.textField.restrict = "0-9";
         addToContent(_phoneInput);
         _phoneReInput = ComponentFactory.Instance.creatComponentByStylename("baglocked.newPhoneTextReInput");
         _phoneReInput.textField.restrict = "0-9";
         addToContent(_phoneReInput);
         _tips = ComponentFactory.Instance.creatComponentByStylename("baglocked.deepRedTxt");
         PositionUtils.setPos(_tips,"bagLocked.phoneTipPos");
         _tips.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.tip3");
         addToContent(_tips);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _nextBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.next");
         PositionUtils.setPos(_nextBtn,"bagLocked.nextBtnPos2");
         addToContent(_nextBtn);
         addEvent();
      }
      
      protected function __nextBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_phoneInput.text.length != 11)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.phoneLengthWrong"));
            return;
         }
         if(_phoneInput.text != _phoneReInput.text)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.phoneReInputWrong"));
            return;
         }
         switch(int(type))
         {
            case 0:
               SocketManager.Instance.out.getBackLockPwdByPhone(4,_phoneInput.text);
               break;
            case 1:
               SocketManager.Instance.out.getBackLockPwdByQuestion(2,_phoneInput.text);
         }
         BagLockedController.Instance.phoneNum = _phoneInput.text;
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
         if(_description1)
         {
            ObjectUtils.disposeObject(_description1);
         }
         _description1 = null;
         if(_description2)
         {
            ObjectUtils.disposeObject(_description2);
         }
         _description2 = null;
         if(_phoneInput)
         {
            ObjectUtils.disposeObject(_phoneInput);
         }
         _phoneInput = null;
         if(_phoneReInput)
         {
            ObjectUtils.disposeObject(_phoneReInput);
         }
         _phoneReInput = null;
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
