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
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   
   public class QuestionConfirmFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _bg:ScaleBitmapImage;
      
      private var _question1:FilterFrameText;
      
      private var _answer1:FilterFrameText;
      
      private var _questionTxt1:FilterFrameText;
      
      private var _answerInput1:TextInput;
      
      private var _question2:FilterFrameText;
      
      private var _answer2:FilterFrameText;
      
      private var _questionTxt2:FilterFrameText;
      
      private var _answerInput2:TextInput;
      
      private var _tips:FilterFrameText;
      
      private var _nextBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      public function QuestionConfirmFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.questionConfirm");
         _bg = ComponentFactory.Instance.creatComponentByStylename("baglocked.questionConfirmBG");
         addToContent(_bg);
         _question1 = ComponentFactory.Instance.creatComponentByStylename("baglocked.question1");
         _question1.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.question1");
         addToContent(_question1);
         _answer1 = ComponentFactory.Instance.creatComponentByStylename("baglocked.answer1");
         _answer1.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.answer1");
         addToContent(_answer1);
         _questionTxt1 = ComponentFactory.Instance.creatComponentByStylename("baglocked.questionTxt1");
         _questionTxt1.text = PlayerManager.Instance.Self.questionOne;
         addToContent(_questionTxt1);
         _answerInput1 = ComponentFactory.Instance.creatComponentByStylename("baglocked.answerTextInput1");
         addToContent(_answerInput1);
         _question2 = ComponentFactory.Instance.creatComponentByStylename("baglocked.question2");
         _question2.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.question2");
         addToContent(_question2);
         _answer2 = ComponentFactory.Instance.creatComponentByStylename("baglocked.answer2");
         _answer2.text = LanguageMgr.GetTranslation("baglocked.SetPassFrame2.answer2");
         addToContent(_answer2);
         _questionTxt2 = ComponentFactory.Instance.creatComponentByStylename("baglocked.questionTxt2");
         _questionTxt2.text = PlayerManager.Instance.Self.questionTwo;
         addToContent(_questionTxt2);
         _answerInput2 = ComponentFactory.Instance.creatComponentByStylename("baglocked.answerTextInput2");
         addToContent(_answerInput2);
         _tips = ComponentFactory.Instance.creatComponentByStylename("baglocked.deepRedTxt");
         PositionUtils.setPos(_tips,"bagLocked.phoneTipPos2");
         _tips.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.tip21",-1);
         addToContent(_tips);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _nextBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.next");
         PositionUtils.setPos(_nextBtn,"bagLocked.nextBtnPos3");
         addToContent(_nextBtn);
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _cancelBtn.text = LanguageMgr.GetTranslation("cancel");
         PositionUtils.setPos(_cancelBtn,"bagLocked.cancelBtnPos2");
         addToContent(_cancelBtn);
         addEvent();
      }
      
      public function setRestTimes(value:int) : void
      {
         _tips.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.tip21",value);
      }
      
      protected function __nextBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.getBackLockPwdByQuestion(1,_answerInput1.text,_answerInput2.text);
      }
      
      protected function __cancelBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
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
         _nextBtn.addEventListener("click",__nextBtnClick);
         _cancelBtn.addEventListener("click",__cancelBtnClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _nextBtn.removeEventListener("click",__nextBtnClick);
         _cancelBtn.removeEventListener("click",__cancelBtnClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_question1)
         {
            ObjectUtils.disposeObject(_question1);
         }
         _question1 = null;
         if(_answer1)
         {
            ObjectUtils.disposeObject(_answer1);
         }
         _answer1 = null;
         if(_questionTxt1)
         {
            ObjectUtils.disposeObject(_questionTxt1);
         }
         _questionTxt1 = null;
         if(_answerInput1)
         {
            ObjectUtils.disposeObject(_answerInput1);
         }
         _answerInput1 = null;
         if(_question2)
         {
            ObjectUtils.disposeObject(_question2);
         }
         _question2 = null;
         if(_answer2)
         {
            ObjectUtils.disposeObject(_answer2);
         }
         _answer2 = null;
         if(_questionTxt2)
         {
            ObjectUtils.disposeObject(_questionTxt2);
         }
         _questionTxt2 = null;
         if(_answerInput2)
         {
            ObjectUtils.disposeObject(_answerInput2);
         }
         _answerInput2 = null;
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
         if(_cancelBtn)
         {
            ObjectUtils.disposeObject(_cancelBtn);
         }
         _cancelBtn = null;
         super.dispose();
      }
   }
}
