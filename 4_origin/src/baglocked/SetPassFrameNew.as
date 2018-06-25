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
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class SetPassFrameNew extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _completeBtn7:TextButton;
      
      private var _subtitle:Image;
      
      private var _text7_0:FilterFrameText;
      
      private var _text7_1:FilterFrameText;
      
      private var _text7_2:FilterFrameText;
      
      private var _text7_3:FilterFrameText;
      
      private var _text7_4:FilterFrameText;
      
      private var _text7_5:FilterFrameText;
      
      private var _textInput7_1:TextInput;
      
      private var _textInput7_2:TextInput;
      
      public function SetPassFrameNew()
      {
         super();
      }
      
      public function __onTextEnter(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            if(_completeBtn7.enable)
            {
               __completeBtn7Click(null);
            }
         }
      }
      
      public function set bagLockedController(value:BagLockedController) : void
      {
         _bagLockedController = value;
      }
      
      override public function dispose() : void
      {
         remvoeEvent();
         _bagLockedController = null;
         ObjectUtils.disposeObject(_subtitle);
         _subtitle = null;
         ObjectUtils.disposeObject(_text7_0);
         _text7_0 = null;
         ObjectUtils.disposeObject(_text7_1);
         _text7_1 = null;
         ObjectUtils.disposeObject(_text7_2);
         _text7_2 = null;
         ObjectUtils.disposeObject(_text7_3);
         _text7_3 = null;
         ObjectUtils.disposeObject(_text7_4);
         _text7_4 = null;
         ObjectUtils.disposeObject(_text7_5);
         _text7_5 = null;
         ObjectUtils.disposeObject(_textInput7_1);
         _textInput7_1 = null;
         ObjectUtils.disposeObject(_textInput7_2);
         _textInput7_2 = null;
         ObjectUtils.disposeObject(_completeBtn7);
         _completeBtn7 = null;
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.bagLockedBtn");
         _subtitle = ComponentFactory.Instance.creat("baglocked.subtitle");
         addToContent(_subtitle);
         _text7_0 = ComponentFactory.Instance.creat("baglocked.text7_0");
         _text7_0.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.setted");
         addToContent(_text7_0);
         _text7_1 = ComponentFactory.Instance.creat("baglocked.text7_1");
         _text7_1.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.inputTextInfo1");
         addToContent(_text7_1);
         _text7_2 = ComponentFactory.Instance.creat("baglocked.text7_2");
         _text7_2.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.inputTextInfo2");
         addToContent(_text7_2);
         _text7_3 = ComponentFactory.Instance.creat("baglocked.text7_3");
         _text7_3.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.inputTextInfo3");
         addToContent(_text7_3);
         _text7_4 = ComponentFactory.Instance.creat("baglocked.text7_4");
         _text7_4.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.inputTextInfo2");
         addToContent(_text7_4);
         _text7_5 = ComponentFactory.Instance.creat("baglocked.text7_5");
         _text7_5.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame1.inputTextInfo4");
         addToContent(_text7_5);
         _textInput7_1 = ComponentFactory.Instance.creat("baglocked.textInput7_1");
         addToContent(_textInput7_1);
         _textInput7_2 = ComponentFactory.Instance.creat("baglocked.textInput7_2");
         addToContent(_textInput7_2);
         _completeBtn7 = ComponentFactory.Instance.creat("baglocked.completeBtn7");
         _completeBtn7.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.complete");
         addToContent(_completeBtn7);
         _textInput7_1.textField.tabIndex = 0;
         _textInput7_2.textField.tabIndex = 1;
         _completeBtn7.enable = false;
         addEvent();
      }
      
      private function __completeBtn7Click(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_textInput7_1.text == _textInput7_2.text)
         {
            _bagLockedController.bagLockedInfo.psw = _textInput7_1.text;
            _bagLockedController.setPassFrameNewController();
            _bagLockedController.closeSetPassFrameNew();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.diffrent"));
         }
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
      
      private function __textChange(event:Event) : void
      {
         if(_textInput7_1.textField.length >= 6 && _textInput7_2.textField.length >= 6)
         {
            _completeBtn7.enable = true;
         }
         else
         {
            _completeBtn7.enable = false;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _textInput7_1.textField.addEventListener("change",__textChange);
         _textInput7_1.textField.addEventListener("keyDown",__onTextEnter);
         _textInput7_2.textField.addEventListener("change",__textChange);
         _textInput7_2.textField.addEventListener("keyDown",__onTextEnter);
         _completeBtn7.addEventListener("click",__completeBtn7Click);
      }
      
      private function remvoeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _textInput7_1.textField.removeEventListener("change",__textChange);
         _textInput7_1.textField.removeEventListener("keyDown",__onTextEnter);
         _textInput7_2.textField.removeEventListener("change",__textChange);
         _textInput7_2.textField.removeEventListener("keyDown",__onTextEnter);
         _completeBtn7.removeEventListener("click",__completeBtn7Click);
      }
   }
}
