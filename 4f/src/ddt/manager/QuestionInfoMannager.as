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
      
      public function QuestionInfoMannager(){super();}
      
      public static function get Instance() : QuestionInfoMannager{return null;}
      
      public function setup() : void{}
      
      public function analyzer(param1:QuestionInfoAnalyze) : void{}
      
      private function __AnswerBoxQuestion(param1:PkgEvent) : void{}
      
      private function showGoogsView() : void{}
      
      private function getQuestionInfo() : QuestionInfo{return null;}
      
      public function sendRespond(param1:int) : void{}
      
      private function hideQuestionFrame() : void{}
   }
}
