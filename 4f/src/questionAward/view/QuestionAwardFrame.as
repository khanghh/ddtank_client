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
      
      public function QuestionAwardFrame(){super();}
      
      public function set initControl(param1:QuestionAwardControl) : void{}
      
      override protected function init() : void{}
      
      private function createFirstPage() : void{}
      
      private function __answerBtmClickHandler(param1:MouseEvent) : void{}
      
      public function get nextBtn() : TextButton{return null;}
      
      private function createView() : void{}
      
      public function createNextQuestion() : void{}
      
      public function get curQuestionView() : QuestionViewBase{return null;}
      
      private function createItem() : QuestionViewBase{return null;}
      
      override protected function addChildren() : void{}
      
      override public function dispose() : void{}
   }
}
