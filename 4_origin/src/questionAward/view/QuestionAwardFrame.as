package questionAward.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import questionAward.QuestionAwardControl;
   import questionAward.QuestionAwardManager;
   import questionAward.data.QuestionAwardInfo;
   import questionAward.data.QuestionDataBaseInfo;
   import questionAward.data.QuestionIterator;
   
   public class QuestionAwardFrame extends Frame
   {
       
      
      private var _frameBg:Bitmap;
      
      private var _questionInfo:QuestionAwardInfo;
      
      private var _questionIterator:QuestionIterator;
      
      private var _viewSpri:Sprite;
      
      private var _nextBtn:TextButton;
      
      private var _curQuestionView:QuestionViewBase;
      
      private var _control:QuestionAwardControl;
      
      private var _firstPageTitle:FilterFrameText;
      
      private var _answerBtn:SimpleBitmapButton;
      
      public function QuestionAwardFrame()
      {
         _questionInfo = QuestionAwardManager.instance.getQuestionAwardInfo();
         _questionIterator = _questionInfo.createQuestionIterator();
         super();
      }
      
      public function set initControl(param1:QuestionAwardControl) : void
      {
         _control = param1;
      }
      
      override protected function init() : void
      {
         super.init();
         _viewSpri = new Sprite();
         _frameBg = ComponentFactory.Instance.creat("asset.questionAward.Bg");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("questionAward.nextButton");
         if(_questionInfo != null)
         {
            titleText = _questionInfo.title;
         }
         else
         {
            titleText = LanguageMgr.GetTranslation("questionAward.titleTxt");
         }
         createFirstPage();
      }
      
      private function createFirstPage() : void
      {
         _firstPageTitle = ComponentFactory.Instance.creatComponentByStylename("questionAward.titleTxt");
         PositionUtils.setPos(_firstPageTitle,"questionAward.firstPage.titleTxtPos");
         _viewSpri.addChild(_firstPageTitle);
         _firstPageTitle.text = LanguageMgr.GetTranslation("questionAward.firstPageTitleTxt");
         _answerBtn = ComponentFactory.Instance.creatComponentByStylename("questionAward.firstPage.answerBtn");
         _viewSpri.addChild(_answerBtn);
         _nextBtn.visible = false;
         if(_answerBtn)
         {
            _answerBtn.addEventListener("click",__answerBtmClickHandler);
         }
      }
      
      private function __answerBtmClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_answerBtn)
         {
            _answerBtn.removeEventListener("click",__answerBtmClickHandler);
         }
         _nextBtn.visible = true;
         createView();
      }
      
      public function get nextBtn() : TextButton
      {
         return _nextBtn;
      }
      
      private function createView() : void
      {
         if(_curQuestionView)
         {
            ObjectUtils.disposeObject(_curQuestionView);
         }
         _curQuestionView = null;
         _viewSpri.removeChildren();
         _curQuestionView = createItem();
         if(_curQuestionView)
         {
            _viewSpri.addChild(_curQuestionView);
         }
         else
         {
            _nextBtn.enable = false;
            _control.sendAnswer();
         }
      }
      
      public function createNextQuestion() : void
      {
         createView();
      }
      
      public function get curQuestionView() : QuestionViewBase
      {
         return _curQuestionView;
      }
      
      private function createItem() : QuestionViewBase
      {
         var _loc1_:QuestionDataBaseInfo = null;
         var _loc2_:QuestionViewBase = null;
         if(_questionIterator && _questionIterator.hasNext())
         {
            _loc1_ = _questionIterator.Next() as QuestionDataBaseInfo;
            _loc2_ = QuestionAwardFactory.instance.createQuestionView(_loc1_);
         }
         return _loc2_;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_frameBg)
         {
            addToContent(_frameBg);
         }
         if(_nextBtn)
         {
            addToContent(_nextBtn);
            _nextBtn.text = LanguageMgr.GetTranslation("questionAward.nextBtn.txt");
         }
         if(_viewSpri)
         {
            addToContent(_viewSpri);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_frameBg)
         {
            ObjectUtils.disposeObject(_frameBg);
         }
         _frameBg = null;
         if(_nextBtn)
         {
            ObjectUtils.disposeObject(_nextBtn);
         }
         _nextBtn = null;
         if(_viewSpri)
         {
            ObjectUtils.disposeObject(_viewSpri);
            _viewSpri = null;
         }
         if(_firstPageTitle)
         {
            ObjectUtils.disposeObject(_firstPageTitle);
         }
         _firstPageTitle = null;
         if(_answerBtn)
         {
            ObjectUtils.disposeObject(_answerBtn);
         }
         _answerBtn = null;
         _questionInfo = null;
         _questionIterator = null;
      }
   }
}
