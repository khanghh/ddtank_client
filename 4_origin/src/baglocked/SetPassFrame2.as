package baglocked
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class SetPassFrame2 extends Frame
   {
       
      
      private var _backBtn1:TextButton;
      
      private var _bagLockedController:BagLockedController;
      
      private var _bag_Combox1:ComboBox;
      
      private var _bag_Combox2:ComboBox;
      
      private var _nextBtn2:TextButton;
      
      private var _subtitle:Image;
      
      private var _textInfo2_1:FilterFrameText;
      
      private var _textInfo2_2:FilterFrameText;
      
      private var _textInfo2_3:FilterFrameText;
      
      private var _textInfo2_4:FilterFrameText;
      
      private var _textInfo2_5:FilterFrameText;
      
      private var _textInfo2_6:FilterFrameText;
      
      private var _textinput2_1:TextInput;
      
      private var _textinput2_2:TextInput;
      
      private var _titText2_0:FilterFrameText;
      
      private var _textInfo2_7:FilterFrameText;
      
      private var _isSkip:Boolean;
      
      public function SetPassFrame2()
      {
         super();
      }
      
      public function __onTextEnter(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            if(_nextBtn2.enable)
            {
               __nextBtn2Click(null);
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
         ObjectUtils.disposeObject(_titText2_0);
         _titText2_0 = null;
         ObjectUtils.disposeObject(_textInfo2_1);
         _textInfo2_1 = null;
         ObjectUtils.disposeObject(_textInfo2_2);
         _textInfo2_2 = null;
         ObjectUtils.disposeObject(_textInfo2_3);
         _textInfo2_3 = null;
         ObjectUtils.disposeObject(_textInfo2_4);
         _textInfo2_4 = null;
         ObjectUtils.disposeObject(_textInfo2_5);
         _textInfo2_5 = null;
         ObjectUtils.disposeObject(_textInfo2_6);
         _textInfo2_6 = null;
         ObjectUtils.disposeObject(_textInfo2_7);
         _textInfo2_7 = null;
         ObjectUtils.disposeObject(_textinput2_1);
         _textinput2_1 = null;
         ObjectUtils.disposeObject(_textinput2_2);
         _textinput2_2 = null;
         ObjectUtils.disposeObject(_bag_Combox1);
         _bag_Combox1 = null;
         ObjectUtils.disposeObject(_bag_Combox2);
         _bag_Combox2 = null;
         ObjectUtils.disposeObject(_backBtn1);
         _backBtn1 = null;
         ObjectUtils.disposeObject(_nextBtn2);
         _nextBtn2 = null;
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         _textinput2_1.setFocus();
         if(_bagLockedController.bagLockedInfo.questionOne.length > 0 || _bagLockedController.bagLockedInfo.isSelectCustomQuestion1 == true)
         {
            _bag_Combox1.textField.text = _bagLockedController.bagLockedInfo.questionOne;
         }
         if(_bagLockedController.bagLockedInfo.questionTwo.length > 0 || _bagLockedController.bagLockedInfo.isSelectCustomQuestion2 == true)
         {
            _bag_Combox2.textField.text = _bagLockedController.bagLockedInfo.questionTwo;
         }
         if(_bagLockedController.bagLockedInfo.answerOne.length > 0)
         {
            _textinput2_1.text = _bagLockedController.bagLockedInfo.answerOne;
         }
         if(_bagLockedController.bagLockedInfo.answerTwo.length > 0)
         {
            _textinput2_2.text = _bagLockedController.bagLockedInfo.answerTwo;
         }
         if(_textinput2_1.text.length > 0 && _textinput2_2.text.length > 0)
         {
            _nextBtn2.enable = true;
            _isSkip = true;
         }
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.guide");
         _subtitle = ComponentFactory.Instance.creat("baglocked.subtitle");
         addToContent(_subtitle);
         _titText2_0 = ComponentFactory.Instance.creat("baglocked.text2_0");
         _titText2_0.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.titText2");
         addToContent(_titText2_0);
         _textInfo2_1 = ComponentFactory.Instance.creat("baglocked.text2_1");
         _textInfo2_1.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.question1");
         addToContent(_textInfo2_1);
         _textInfo2_2 = ComponentFactory.Instance.creat("baglocked.text2_2");
         _textInfo2_2.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.answer1");
         addToContent(_textInfo2_2);
         _textInfo2_3 = ComponentFactory.Instance.creat("baglocked.text2_3");
         _textInfo2_3.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.inputTextInfo1");
         addToContent(_textInfo2_3);
         _textInfo2_4 = ComponentFactory.Instance.creat("baglocked.text2_4");
         _textInfo2_4.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.question2");
         addToContent(_textInfo2_4);
         _textInfo2_5 = ComponentFactory.Instance.creat("baglocked.text2_5");
         _textInfo2_5.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.answer2");
         addToContent(_textInfo2_5);
         _textInfo2_6 = ComponentFactory.Instance.creat("baglocked.text2_6");
         _textInfo2_6.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.inputTextInfo1");
         addToContent(_textInfo2_6);
         _textInfo2_7 = ComponentFactory.Instance.creat("baglocked.text2_7");
         _textInfo2_7.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.textInfo2_7");
         addToContent(_textInfo2_7);
         _textinput2_1 = ComponentFactory.Instance.creat("baglocked.textInput2_1");
         addToContent(_textinput2_1);
         _textinput2_2 = ComponentFactory.Instance.creat("baglocked.textInput2_2");
         addToContent(_textinput2_2);
         _backBtn1 = ComponentFactory.Instance.creat("baglocked.backBtn1");
         _backBtn1.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.preview");
         addToContent(_backBtn1);
         _nextBtn2 = ComponentFactory.Instance.creat("baglocked.nextBtn2");
         _nextBtn2.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.next");
         addToContent(_nextBtn2);
         _bag_Combox1 = ComponentFactory.Instance.creat("baglocked.bag_Combox1");
         _bag_Combox1.selctedPropName = "text";
         _bag_Combox1.textField.text = LanguageMgr.GetTranslation("feedback.view.FeedbackSubmitSp.comBoxText");
         _bag_Combox1.beginChanges();
         _bag_Combox1.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.question1"));
         _bag_Combox1.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.question2"));
         _bag_Combox1.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.question3"));
         _bag_Combox1.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.question4"));
         _bag_Combox1.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.question5"));
         _bag_Combox1.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.question6"));
         _bag_Combox1.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.customer"));
         _bag_Combox1.listPanel.list.updateListView();
         _bag_Combox1.commitChanges();
         _bag_Combox2 = ComponentFactory.Instance.creat("baglocked.bag_Combox2");
         _bag_Combox2.selctedPropName = "text";
         _bag_Combox2.textField.text = LanguageMgr.GetTranslation("feedback.view.FeedbackSubmitSp.comBoxText");
         _bag_Combox2.beginChanges();
         _bag_Combox2.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.question1"));
         _bag_Combox2.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.question2"));
         _bag_Combox2.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.question3"));
         _bag_Combox2.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.question4"));
         _bag_Combox2.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.question5"));
         _bag_Combox2.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.question6"));
         _bag_Combox2.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.customer"));
         _bag_Combox2.listPanel.list.updateListView();
         _bag_Combox2.commitChanges();
         addToContent(_bag_Combox2);
         addToContent(_bag_Combox1);
         _textinput2_1.textField.tabIndex = 0;
         _textinput2_2.textField.tabIndex = 1;
         _textinput2_1.text = "";
         _textinput2_2.text = "";
         _nextBtn2.enable = false;
         addEvent();
      }
      
      private function __backBtn1Click(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.bagLockedInfo.questionOne = _bag_Combox1.textField.text;
         _bagLockedController.bagLockedInfo.questionTwo = _bag_Combox2.textField.text;
         _bagLockedController.bagLockedInfo.answerOne = _textinput2_1.text;
         _bagLockedController.bagLockedInfo.answerTwo = _textinput2_2.text;
         _bagLockedController.openSetPassFrame1();
         _bagLockedController.closeSetPassFrame2();
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               _bagLockedController.bagLockedInfo = null;
               _bagLockedController.close();
         }
      }
      
      private function __listItemClick(event:Event) : void
      {
         var selectCustomBool:Boolean = false;
         var selectFlag:Boolean = false;
         SoundManager.instance.play("008");
         var combox:ComboBox = event.currentTarget as ComboBox;
         if(combox.currentSelectedIndex == combox.listPanel.vectorListModel.elements.length - 1)
         {
            stage.focus = combox.textField;
            combox.textField.type = "input";
            combox.textField.autoSize = "none";
            combox.textField.maxChars = 14;
            combox.textField.width = 200;
            combox.textField.text = "";
            combox.textField.selectable = true;
            combox.textField.wordWrap = false;
            combox.textField.multiline = false;
            selectCustomBool = true;
         }
         else
         {
            combox.textField.type = "dynamic";
            combox.textField.selectable = false;
            combox.textField.mouseEnabled = false;
         }
         selectFlag = true;
         if(combox == _bag_Combox1)
         {
            _bagLockedController.bagLockedInfo.isSelectCustomQuestion1 = selectCustomBool;
            _bagLockedController.bagLockedInfo.isSelectQuestion1 = selectFlag;
         }
         else
         {
            _bagLockedController.bagLockedInfo.isSelectCustomQuestion2 = selectCustomBool;
            _bagLockedController.bagLockedInfo.isSelectQuestion2 = selectFlag;
         }
      }
      
      private function __nextBtn2Click(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_bagLockedController.bagLockedInfo.isSelectQuestion1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.selectQustion"));
            return;
         }
         if(!_bagLockedController.bagLockedInfo.isSelectQuestion2)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.selectQustion"));
            return;
         }
         if(StringUtils.trim(_bag_Combox1.textField.text) == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.inputCompletely"));
            return;
         }
         if(StringUtils.trim(_bag_Combox2.textField.text) == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.inputCompletely"));
            return;
         }
         if(_bag_Combox1.textField.text == _bag_Combox2.textField.text)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.cantRepeat"));
            return;
         }
         _bagLockedController.bagLockedInfo.questionOne = _bag_Combox1.textField.text;
         _bagLockedController.bagLockedInfo.questionTwo = _bag_Combox2.textField.text;
         _bagLockedController.bagLockedInfo.answerOne = _textinput2_1.text;
         _bagLockedController.bagLockedInfo.answerTwo = _textinput2_2.text;
         _bagLockedController.openSetPassFrame3();
         _bagLockedController.closeSetPassFrame2();
      }
      
      private function __textChange(event:Event) : void
      {
         var str1:String = _textinput2_1.text;
         var str2:String = _textinput2_2.text;
         if(StringUtils.trim(str1) != "" && StringUtils.trim(str2) != "")
         {
            _nextBtn2.enable = true;
         }
         else
         {
            _nextBtn2.enable = false;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _textinput2_1.textField.addEventListener("change",__textChange);
         _textinput2_2.textField.addEventListener("change",__textChange);
         _textinput2_1.textField.addEventListener("keyDown",__onTextEnter);
         _textinput2_2.textField.addEventListener("keyDown",__onTextEnter);
         _backBtn1.addEventListener("click",__backBtn1Click);
         _nextBtn2.addEventListener("click",__nextBtn2Click);
         _bag_Combox1.addEventListener("stateChange",__listItemClick);
         _bag_Combox2.addEventListener("stateChange",__listItemClick);
         _bag_Combox1.addEventListener("click",__ComboxClick);
         _bag_Combox2.addEventListener("click",__ComboxClick);
      }
      
      private function __ComboxClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function remvoeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _textinput2_1.textField.removeEventListener("change",__textChange);
         _textinput2_2.textField.removeEventListener("change",__textChange);
         _textinput2_1.textField.removeEventListener("keyDown",__onTextEnter);
         _textinput2_2.textField.removeEventListener("keyDown",__onTextEnter);
         _backBtn1.removeEventListener("click",__backBtn1Click);
         _nextBtn2.removeEventListener("click",__nextBtn2Click);
         _bag_Combox1.removeEventListener("change",__listItemClick);
         _bag_Combox2.removeEventListener("change",__listItemClick);
         _bag_Combox1.removeEventListener("click",__ComboxClick);
         _bag_Combox2.removeEventListener("click",__ComboxClick);
      }
   }
}
