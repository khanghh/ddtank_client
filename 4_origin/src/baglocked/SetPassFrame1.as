package baglocked
{
   import baglocked.data.BagLockedInfo;
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
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class SetPassFrame1 extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _inputTextInfo1_1:FilterFrameText;
      
      private var _inputTextInfo1_2:FilterFrameText;
      
      private var _inputTextInfo1_3:FilterFrameText;
      
      private var _inputTextInfo1_4:FilterFrameText;
      
      private var _inputTextInfo1_5:FilterFrameText;
      
      private var _nextBtn1:TextButton;
      
      private var _subtitle:Image;
      
      private var _textinput1:TextInput;
      
      private var _textinput2:TextInput;
      
      private var _titText1_0:FilterFrameText;
      
      public function SetPassFrame1()
      {
         super();
      }
      
      public function __onTextEnter(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            if(_nextBtn1.enable)
            {
               __nextBtn1Click(null);
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
         ObjectUtils.disposeObject(_titText1_0);
         _titText1_0 = null;
         ObjectUtils.disposeObject(_inputTextInfo1_1);
         _inputTextInfo1_1 = null;
         ObjectUtils.disposeObject(_inputTextInfo1_2);
         _inputTextInfo1_2 = null;
         ObjectUtils.disposeObject(_textinput1);
         _textinput1 = null;
         ObjectUtils.disposeObject(_inputTextInfo1_3);
         _inputTextInfo1_3 = null;
         ObjectUtils.disposeObject(_inputTextInfo1_4);
         _inputTextInfo1_4 = null;
         ObjectUtils.disposeObject(_textinput2);
         _textinput2 = null;
         ObjectUtils.disposeObject(_inputTextInfo1_5);
         _inputTextInfo1_5 = null;
         ObjectUtils.disposeObject(_nextBtn1);
         _nextBtn1 = null;
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         if(_bagLockedController.bagLockedInfo.psw.length > 0)
         {
            var _loc1_:* = _bagLockedController.bagLockedInfo.psw;
            _textinput2.text = _loc1_;
            _textinput1.text = _loc1_;
            _nextBtn1.enable = true;
         }
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.guide");
         _subtitle = ComponentFactory.Instance.creat("baglocked.subtitle");
         addToContent(_subtitle);
         _titText1_0 = ComponentFactory.Instance.creat("baglocked.text1_0");
         _titText1_0.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.titText1");
         addToContent(_titText1_0);
         _inputTextInfo1_1 = ComponentFactory.Instance.creat("baglocked.text1_1");
         _inputTextInfo1_1.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.inputTextInfo1");
         addToContent(_inputTextInfo1_1);
         _inputTextInfo1_2 = ComponentFactory.Instance.creat("baglocked.text1_2");
         _inputTextInfo1_2.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.inputTextInfo2");
         addToContent(_inputTextInfo1_2);
         _inputTextInfo1_3 = ComponentFactory.Instance.creat("baglocked.text1_3");
         _inputTextInfo1_3.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.inputTextInfo3");
         addToContent(_inputTextInfo1_3);
         _inputTextInfo1_4 = ComponentFactory.Instance.creat("baglocked.text1_4");
         _inputTextInfo1_4.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.inputTextInfo2");
         addToContent(_inputTextInfo1_4);
         _inputTextInfo1_5 = ComponentFactory.Instance.creat("baglocked.text1_5");
         _inputTextInfo1_5.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.inputTextInfo4");
         addToContent(_inputTextInfo1_5);
         _textinput1 = ComponentFactory.Instance.creat("baglocked.textInput1");
         _textinput1.textField.tabIndex = 0;
         addToContent(_textinput1);
         _textinput2 = ComponentFactory.Instance.creat("baglocked.textInput2");
         _textinput2.textField.tabIndex = 1;
         addToContent(_textinput2);
         _nextBtn1 = ComponentFactory.Instance.creat("baglocked.nextBtn1");
         _nextBtn1.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.next");
         _nextBtn1.enable = false;
         addToContent(_nextBtn1);
         addEvent();
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               _bagLockedController.bagLockedInfo = null;
               _bagLockedController.close();
         }
      }
      
      private function __nextBtn1Click(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(_textinput1.text == _textinput2.text)
         {
            _loc2_ = new BagLockedInfo();
            _bagLockedController.bagLockedInfo.psw = _textinput1.text;
            _bagLockedController.openSetPassFrame2();
            _bagLockedController.closeSetPassFrame1();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.diffrent"));
         }
      }
      
      private function __textChange(param1:Event) : void
      {
         if(_textinput1.textField.length >= 6 && _textinput2.textField.length >= 6)
         {
            _nextBtn1.enable = true;
         }
         else
         {
            _nextBtn1.enable = false;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _textinput1.textField.addEventListener("change",__textChange);
         _textinput2.textField.addEventListener("change",__textChange);
         _textinput1.textField.addEventListener("keyDown",__onTextEnter);
         _textinput2.textField.addEventListener("keyDown",__onTextEnter);
         _nextBtn1.addEventListener("click",__nextBtn1Click);
      }
      
      private function remvoeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _textinput1.textField.removeEventListener("change",__textChange);
         _textinput2.textField.removeEventListener("change",__textChange);
         _textinput1.textField.removeEventListener("keyDown",__onTextEnter);
         _textinput2.textField.removeEventListener("keyDown",__onTextEnter);
         _nextBtn1.removeEventListener("click",__nextBtn1Click);
      }
   }
}
