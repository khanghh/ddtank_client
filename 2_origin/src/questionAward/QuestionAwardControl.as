package questionAward
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.MouseEvent;
   import questionAward.view.QuestionAwardFrame;
   
   public class QuestionAwardControl
   {
      
      private static var _instance:QuestionAwardControl;
       
      
      private var _frame:QuestionAwardFrame;
      
      private var _answerCache:String;
      
      public function QuestionAwardControl()
      {
         super();
      }
      
      public static function get instance() : QuestionAwardControl
      {
         if(_instance == null)
         {
            _instance = new QuestionAwardControl();
         }
         return _instance;
      }
      
      public function openView() : void
      {
         __loadingResourceHandler();
      }
      
      private function __loadingResourceHandler() : void
      {
         new HelperUIModuleLoad().loadUIModule(["questionAward"],function():void
         {
            __openViewHandler();
         });
      }
      
      private function __openViewHandler() : void
      {
         _answerCache = "";
         _frame = ComponentFactory.Instance.creatComponentByStylename("questionAward.Frame");
         if(_frame)
         {
            LayerManager.Instance.addToLayer(_frame,3,true,1);
            _frame.initControl = this;
            initEvent();
         }
      }
      
      public function sendAnswer() : void
      {
         QuestionAwardManager.instance.sendAnswer(_answerCache.slice(0,_answerCache.length - 1));
         _answerCache = "";
         dispose();
      }
      
      private function initEvent() : void
      {
         if(_frame)
         {
            _frame.addEventListener("response",__responseHandler);
            _frame.nextBtn.addEventListener("click",__nextBtnClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_frame)
         {
            _frame.removeEventListener("response",__responseHandler);
            _frame.nextBtn.removeEventListener("click",__nextBtnClickHandler);
         }
      }
      
      private function __nextBtnClickHandler(evt:MouseEvent) : void
      {
         var answer:* = null;
         SoundManager.instance.playButtonSound();
         if(_frame)
         {
            answer = _frame.curQuestionView.getAnswer();
            if(answer == "" || answer.length <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("questionAward.selectAnswer.noSelectMsg"));
               return;
            }
            _answerCache = _answerCache + (answer + "|");
            _frame.createNextQuestion();
         }
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            if(_frame)
            {
               ObjectUtils.disposeObject(_frame);
               _frame = null;
               dispose();
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_frame)
         {
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
      }
   }
}
