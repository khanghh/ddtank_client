package baglocked
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class DelPassFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _ddtbaglockBg:ScaleBitmapImage;
      
      private var _delBtn:TextButton;
      
      private var _deselectBtn6:TextButton;
      
      private var _text6_1:FilterFrameText;
      
      private var _text6_2:FilterFrameText;
      
      private var _text6_3:FilterFrameText;
      
      private var _text6_4:FilterFrameText;
      
      private var _text6_5:FilterFrameText;
      
      private var _text6_6:FilterFrameText;
      
      private var _text6_7:FilterFrameText;
      
      private var _textInput6_1:TextInput;
      
      private var _textInput6_2:TextInput;
      
      public function DelPassFrame()
      {
         super();
      }
      
      public function __onTextEnter(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            if(_delBtn.enable)
            {
               __delBtnClick(null);
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
         ObjectUtils.disposeObject(_text6_1);
         _text6_1 = null;
         ObjectUtils.disposeObject(_text6_2);
         _text6_2 = null;
         ObjectUtils.disposeObject(_text6_3);
         _text6_3 = null;
         ObjectUtils.disposeObject(_text6_4);
         _text6_4 = null;
         ObjectUtils.disposeObject(_text6_5);
         _text6_5 = null;
         ObjectUtils.disposeObject(_text6_6);
         _text6_6 = null;
         ObjectUtils.disposeObject(_text6_7);
         _text6_7 = null;
         ObjectUtils.disposeObject(_textInput6_1);
         _textInput6_1 = null;
         ObjectUtils.disposeObject(_textInput6_2);
         _textInput6_2 = null;
         ObjectUtils.disposeObject(_delBtn);
         _delBtn = null;
         ObjectUtils.disposeObject(_deselectBtn6);
         _deselectBtn6 = null;
         ObjectUtils.disposeObject(_ddtbaglockBg);
         _ddtbaglockBg = null;
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         _text6_3.text = PlayerManager.Instance.Self.questionOne;
         _text6_6.text = PlayerManager.Instance.Self.questionTwo;
         _text6_7.text = LanguageMgr.GetTranslation("baglocked.DelPassFrame.operationAlertInfo",PlayerManager.Instance.Self.leftTimes);
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.deletePassword");
         _ddtbaglockBg = ComponentFactory.Instance.creatComponentByStylename("ddtbaglocked.BG3");
         addToContent(_ddtbaglockBg);
         _text6_1 = ComponentFactory.Instance.creat("baglocked.text6_1");
         _text6_1.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.question1");
         addToContent(_text6_1);
         _text6_2 = ComponentFactory.Instance.creat("baglocked.text6_2");
         _text6_2.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.answer1");
         addToContent(_text6_2);
         _text6_3 = ComponentFactory.Instance.creat("baglocked.text6_3");
         addToContent(_text6_3);
         _text6_4 = ComponentFactory.Instance.creat("baglocked.text6_4");
         _text6_4.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.question2");
         addToContent(_text6_4);
         _text6_5 = ComponentFactory.Instance.creat("baglocked.text6_5");
         _text6_5.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.answer2");
         addToContent(_text6_5);
         _text6_6 = ComponentFactory.Instance.creat("baglocked.text6_6");
         addToContent(_text6_6);
         _text6_7 = ComponentFactory.Instance.creat("baglocked.text6_7");
         addToContent(_text6_7);
         _textInput6_1 = ComponentFactory.Instance.creat("baglocked.textInput6_1");
         addToContent(_textInput6_1);
         _textInput6_2 = ComponentFactory.Instance.creat("baglocked.textInput6_2");
         addToContent(_textInput6_2);
         _delBtn = ComponentFactory.Instance.creat("baglocked.delBtn");
         _delBtn.text = LanguageMgr.GetTranslation("tank.view.im.IMFriendItem.delete");
         addToContent(_delBtn);
         _deselectBtn6 = ComponentFactory.Instance.creat("baglocked.deselectBtn6");
         _deselectBtn6.text = LanguageMgr.GetTranslation("tank.view.DefyAfficheView.cancel");
         addToContent(_deselectBtn6);
         _textInput6_1.textField.tabIndex = 0;
         _textInput6_2.textField.tabIndex = 1;
         _textInput6_1.text = "";
         _textInput6_2.text = "";
         _delBtn.enable = false;
         addEvent();
      }
      
      private function __delBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.leftTimes <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.operationTimesOut"));
            _delBtn.enable = false;
            return;
         }
         PlayerManager.Instance.Self.leftTimes--;
         var leftTimes:String = PlayerManager.Instance.Self.leftTimes <= 0?"0":String(PlayerManager.Instance.Self.leftTimes);
         _text6_7.text = LanguageMgr.GetTranslation("baglocked.DelPassFrame.operationAlertInfo",leftTimes);
         _bagLockedController.bagLockedInfo.questionOne = _text6_3.text;
         _bagLockedController.bagLockedInfo.questionTwo = _text6_6.text;
         _bagLockedController.bagLockedInfo.answerOne = _textInput6_1.text;
         _bagLockedController.bagLockedInfo.answerTwo = _textInput6_2.text;
         _bagLockedController.delPassFrameController();
         refreshBtnsState();
      }
      
      private function refreshBtnsState() : void
      {
         if(PlayerManager.Instance.Self.leftTimes <= 0)
         {
            _delBtn.enable = false;
         }
      }
      
      private function __deselectBtn6Click(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.close();
      }
      
      private function __delPasswordHandler(event:BagEvent) : void
      {
         _bagLockedController.close();
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
         if(_textInput6_1.text != "" && _textInput6_2.text != "" && PlayerManager.Instance.Self.leftTimes > 0)
         {
            _delBtn.enable = true;
         }
         else
         {
            _delBtn.enable = false;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _textInput6_1.textField.addEventListener("change",__textChange);
         _textInput6_1.textField.addEventListener("keyDown",__onTextEnter);
         _textInput6_2.textField.addEventListener("change",__textChange);
         _textInput6_2.textField.addEventListener("keyDown",__onTextEnter);
         _delBtn.addEventListener("click",__delBtnClick);
         _deselectBtn6.addEventListener("click",__deselectBtn6Click);
         PlayerManager.Instance.Self.addEventListener("afterDel",__delPasswordHandler);
      }
      
      private function remvoeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _textInput6_1.textField.removeEventListener("change",__textChange);
         _textInput6_1.textField.removeEventListener("keyDown",__onTextEnter);
         _textInput6_2.textField.removeEventListener("change",__textChange);
         _textInput6_2.textField.removeEventListener("keyDown",__onTextEnter);
         _delBtn.removeEventListener("click",__delBtnClick);
         _deselectBtn6.removeEventListener("click",__deselectBtn6Click);
         PlayerManager.Instance.Self.removeEventListener("afterDel",__delPasswordHandler);
      }
   }
}
