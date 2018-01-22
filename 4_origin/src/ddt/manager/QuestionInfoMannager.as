package ddt.manager
{
   import com.pickgliss.loader.LoaderManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.QuestionInfo;
   import ddt.data.analyze.QuestionInfoAnalyze;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.view.common.QuestionGoogsView;
   import road7th.data.DictionaryData;
   
   public class QuestionInfoMannager
   {
      
      private static var _instance:QuestionInfoMannager;
       
      
      private var _questionList:DictionaryData;
      
      private var _allQuestion:Array;
      
      private var _questionTotal:int;
      
      private var _questionCurrentNum:int;
      
      private var _correctQuestionNum:int;
      
      private var _questionCatalogID:int;
      
      private var _questionID:int;
      
      private var _questionGoogsView:QuestionGoogsView;
      
      private var _perKey:int;
      
      public function QuestionInfoMannager()
      {
         super();
         _questionList = new DictionaryData();
      }
      
      public static function get Instance() : QuestionInfoMannager
      {
         if(_instance == null)
         {
            _instance = new QuestionInfoMannager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(31),__AnswerBoxQuestion);
      }
      
      public function analyzer(param1:QuestionInfoAnalyze) : void
      {
         _allQuestion = param1.allQuestion;
         showGoogsView();
      }
      
      private function __AnswerBoxQuestion(param1:PkgEvent) : void
      {
         _questionCatalogID = param1.pkg.readInt();
         _questionID = param1.pkg.readInt();
         _questionTotal = param1.pkg.readInt();
         _questionCurrentNum = param1.pkg.readInt();
         _correctQuestionNum = param1.pkg.readInt();
         if(!_allQuestion)
         {
            LoaderManager.Instance.startLoad(LoaderCreate.Instance.creatAllQuestionInfoLoader());
            return;
         }
         showGoogsView();
      }
      
      private function showGoogsView() : void
      {
         if(!_questionGoogsView)
         {
            _questionGoogsView = ComponentFactory.Instance.creatComponentByStylename("ddt.view.common.QuestionGoogsFrame");
            LayerManager.Instance.addToLayer(_questionGoogsView,2,false,1);
         }
         _questionGoogsView.setQuestionInfo(getQuestionInfo(),_questionTotal,_questionCurrentNum,_correctQuestionNum);
      }
      
      private function getQuestionInfo() : QuestionInfo
      {
         return _allQuestion[_questionCatalogID][_questionID];
      }
      
      public function sendRespond(param1:int) : void
      {
         _questionCurrentNum = Number(_questionCurrentNum) + 1;
         SocketManager.Instance.out.sendQuestionReply(param1);
         hideQuestionFrame();
      }
      
      private function hideQuestionFrame() : void
      {
         if(_questionCurrentNum == _questionTotal)
         {
            if(_questionGoogsView && _questionGoogsView.parent)
            {
               _questionGoogsView.parent.removeChild(_questionGoogsView);
               _questionGoogsView.dispose();
               _questionGoogsView = null;
            }
         }
      }
   }
}
