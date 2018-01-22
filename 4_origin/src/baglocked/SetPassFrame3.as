package baglocked
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class SetPassFrame3 extends Frame
   {
       
      
      private var _backBtn1:TextButton;
      
      private var _bagLockedController:BagLockedController;
      
      private var _completeBtn:TextButton;
      
      private var _subtitle:Image;
      
      private var _textInfo3_1:FilterFrameText;
      
      private var _textInfo3_2:FilterFrameText;
      
      private var _textInfo3_3:FilterFrameText;
      
      private var _textInfo3_4:FilterFrameText;
      
      private var _textInfo3_5:FilterFrameText;
      
      private var _textInfo3_6:FilterFrameText;
      
      private var _textInfo3_7:FilterFrameText;
      
      private var _textinput3_1:TextInput;
      
      private var _textinput3_2:TextInput;
      
      private var _titText3_0:FilterFrameText;
      
      public function SetPassFrame3()
      {
         super();
      }
      
      public function __onTextEnter(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            if(_completeBtn.enable)
            {
               __completeBtnClick(null);
            }
         }
      }
      
      public function set bagLockedController(param1:BagLockedController) : void
      {
         _bagLockedController = param1;
      }
      
      override public function dispose() : void
      {
         remvoeEvent();
         _bagLockedController = null;
         ObjectUtils.disposeObject(_subtitle);
         _subtitle = null;
         ObjectUtils.disposeObject(_titText3_0);
         _titText3_0 = null;
         ObjectUtils.disposeObject(_textInfo3_1);
         _textInfo3_1 = null;
         ObjectUtils.disposeObject(_textInfo3_2);
         _textInfo3_2 = null;
         ObjectUtils.disposeObject(_textInfo3_3);
         _textInfo3_3 = null;
         ObjectUtils.disposeObject(_textInfo3_4);
         _textInfo3_4 = null;
         ObjectUtils.disposeObject(_textInfo3_5);
         _textInfo3_5 = null;
         ObjectUtils.disposeObject(_textInfo3_6);
         _textInfo3_6 = null;
         ObjectUtils.disposeObject(_textInfo3_7);
         _textInfo3_7 = null;
         ObjectUtils.disposeObject(_textinput3_1);
         _textinput3_1 = null;
         ObjectUtils.disposeObject(_textinput3_2);
         _textinput3_2 = null;
         ObjectUtils.disposeObject(_backBtn1);
         _backBtn1 = null;
         ObjectUtils.disposeObject(_completeBtn);
         _completeBtn = null;
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         _textInfo3_3.text = _bagLockedController.bagLockedInfo.questionOne;
         _textInfo3_6.text = _bagLockedController.bagLockedInfo.questionTwo;
         _textinput3_1.setFocus();
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.guide");
         _subtitle = ComponentFactory.Instance.creat("baglocked.subtitle");
         addToContent(_subtitle);
         _titText3_0 = ComponentFactory.Instance.creat("baglocked.text3_0");
         _titText3_0.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame3.titText3");
         addToContent(_titText3_0);
         _textInfo3_1 = ComponentFactory.Instance.creat("baglocked.text3_1");
         _textInfo3_1.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.question1");
         addToContent(_textInfo3_1);
         _textInfo3_2 = ComponentFactory.Instance.creat("baglocked.text3_2");
         _textInfo3_2.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.answer1");
         addToContent(_textInfo3_2);
         _textInfo3_3 = ComponentFactory.Instance.creat("baglocked.text3_3");
         addToContent(_textInfo3_3);
         _textInfo3_4 = ComponentFactory.Instance.creat("baglocked.text3_4");
         _textInfo3_4.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.question2");
         addToContent(_textInfo3_4);
         _textInfo3_5 = ComponentFactory.Instance.creat("baglocked.text3_5");
         _textInfo3_5.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.answer2");
         addToContent(_textInfo3_5);
         _textInfo3_6 = ComponentFactory.Instance.creat("baglocked.text3_6");
         addToContent(_textInfo3_6);
         _textInfo3_7 = ComponentFactory.Instance.creat("baglocked.text3_7");
         _textInfo3_7.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame3.textInfo3_7");
         addToContent(_textInfo3_7);
         _textinput3_1 = ComponentFactory.Instance.creat("baglocked.textInput3_1");
         addToContent(_textinput3_1);
         _textinput3_2 = ComponentFactory.Instance.creat("baglocked.textInput3_2");
         addToContent(_textinput3_2);
         _backBtn1 = ComponentFactory.Instance.creat("baglocked.backBtn1");
         _backBtn1.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.preview");
         addToContent(_backBtn1);
         _completeBtn = ComponentFactory.Instance.creat("baglocked.completeBtn");
         _completeBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.complete");
         addToContent(_completeBtn);
         _completeBtn.enable = false;
         _textinput3_1.textField.tabIndex = 0;
         _textinput3_2.textField.tabIndex = 1;
         _textinput3_1.text = "";
         _textinput3_2.text = "";
         addEvent();
      }
      
      private function __backBtn1Click(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.openSetPassFrame2();
         _bagLockedController.closeSetPassFrame3();
      }
      
      private function __completeBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_textinput3_1.text != _bagLockedController.bagLockedInfo.answerOne)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.answerDiffer"));
            return;
         }
         if(_textinput3_2.text != _bagLockedController.bagLockedInfo.answerTwo)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.answerDiffer"));
            return;
         }
         PlayerManager.Instance.Self.questionOne = _bagLockedController.bagLockedInfo.questionOne;
         PlayerManager.Instance.Self.questionTwo = _bagLockedController.bagLockedInfo.questionTwo;
         _bagLockedController.setPassComplete();
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
      
      private function __textChange(param1:Event) : void
      {
         if(_textinput3_1.text != "" && _textinput3_2.text != "")
         {
            _completeBtn.enable = true;
         }
         else
         {
            _completeBtn.enable = false;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _textinput3_1.textField.addEventListener("change",__textChange);
         _textinput3_2.textField.addEventListener("change",__textChange);
         _textinput3_1.textField.addEventListener("keyDown",__onTextEnter);
         _textinput3_2.textField.addEventListener("keyDown",__onTextEnter);
         _backBtn1.addEventListener("click",__backBtn1Click);
         _completeBtn.addEventListener("click",__completeBtnClick);
      }
      
      private function remvoeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _textinput3_1.textField.removeEventListener("change",__textChange);
         _textinput3_2.textField.removeEventListener("change",__textChange);
         _textinput3_1.textField.removeEventListener("keyDown",__onTextEnter);
         _textinput3_2.textField.removeEventListener("keyDown",__onTextEnter);
         _backBtn1.removeEventListener("click",__backBtn1Click);
         _completeBtn.removeEventListener("click",__completeBtnClick);
      }
   }
}
