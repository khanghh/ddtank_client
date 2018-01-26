package questionAward.view
{
   import questionAward.data.QuestionDataBaseInfo;
   
   public class QuestionAwardFactory
   {
      
      private static var _instance:QuestionAwardFactory;
       
      
      public function QuestionAwardFactory(param1:QuestionAwardFactoryEnforcer){super();}
      
      public static function get instance() : QuestionAwardFactory{return null;}
      
      public function createQuestionView(param1:QuestionDataBaseInfo) : QuestionViewBase{return null;}
      
      private function createSelectview(param1:QuestionDataBaseInfo) : QuestionViewBase{return null;}
      
      private function createAnswerView(param1:QuestionDataBaseInfo) : QuestionViewBase{return null;}
   }
}

class QuestionAwardFactoryEnforcer
{
    
   
   function QuestionAwardFactoryEnforcer(){super();}
}
