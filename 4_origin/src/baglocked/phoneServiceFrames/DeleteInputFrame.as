package baglocked.phoneServiceFrames
{
   import baglocked.BagLockedController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   
   public class DeleteInputFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _BG:ScaleBitmapImage;
      
      private var _description:FilterFrameText;
      
      private var _inputTxt:FilterFrameText;
      
      private var _phoneInput:TextInput;
      
      private var _tips:FilterFrameText;
      
      private var _nextBtn:TextButton;
      
      private var type:int;
      
      public function DeleteInputFrame()
      {
         super();
      }
      
      public function init2(param1:int) : void
      {
         type = param1;
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.phoneConfirm");
         _BG = ComponentFactory.Instance.creatComponentByStylename("baglocked.deleteQuestionBG");
         addToContent(_BG);
         _description = ComponentFactory.Instance.creatComponentByStylename("baglocked.lightRedTxt");
         PositionUtils.setPos(_description,"bagLocked.deleteDescPos");
         addToContent(_description);
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("baglocked.whiteTxt");
         PositionUtils.setPos(_inputTxt,"bagLocked.phoneDescPos2");
         _inputTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.inputBindPhone");
         addToContent(_inputTxt);
         _phoneInput = ComponentFactory.Instance.creatComponentByStylename("baglocked.phoneTextInput");
         PositionUtils.setPos(_phoneInput,"bagLocked.deleteInputPos");
         _phoneInput.textField.restrict = "0-9";
         addToContent(_phoneInput);
         _tips = ComponentFactory.Instance.creatComponentByStylename("baglocked.deepRedTxt");
         _tips.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.tip31");
         PositionUtils.setPos(_tips,"bagLocked.phoneTipPos3");
         addToContent(_tips);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         PositionUtils.setPos(_nextBtn,"bagLocked.nextBtnPos4");
         _nextBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.next");
         addToContent(_nextBtn);
         switch(int(type))
         {
            case 0:
               _description.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.deleteDesc1");
               break;
            case 1:
               _description.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.deleteDesc2");
         }
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
         BagLockedController.Instance.phoneNum = _phoneInput.text;
         switch(int(type))
         {
            case 0:
               SocketManager.Instance.out.deletePwdQuestion(1,_phoneInput.text);
               break;
            case 1:
               SocketManager.Instance.out.deletePwdByPhone(1,_phoneInput.text);
         }
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
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         _BG = null;
         if(_description)
         {
            ObjectUtils.disposeObject(_description);
         }
         _description = null;
         if(_inputTxt)
         {
            ObjectUtils.disposeObject(_inputTxt);
         }
         _inputTxt = null;
         if(_phoneInput)
         {
            ObjectUtils.disposeObject(_phoneInput);
         }
         _phoneInput = null;
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
