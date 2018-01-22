package questionAward.view
{
   import questionAward.data.QuestionDataBaseInfo;
   
   public class QuestionAwardFactory
   {
      
      private static var _instance:QuestionAwardFactory;
       
      
      public function QuestionAwardFactory(param1:QuestionAwardFactoryEnforcer)
      {
         super();
      }
      
      public static function get instance() : QuestionAwardFactory
      {
         if(_instance == null)
         {
            _instance = new QuestionAwardFactory(new QuestionAwardFactoryEnforcer());
         }
         return _instance;
      }
      
      public function createQuestionView(param1:QuestionDataBaseInfo) : QuestionViewBase
      {
         var _loc3_:QuestionViewBase = null;
         var _loc2_:int = param1.type;
         switch(int(_loc2_) - 1)
         {
            case 0:
               _loc3_ = createSelectview(param1);
               break;
            case 1:
               _loc3_ = createAnswerView(param1);
         }
         return _loc3_;
      }
      
      private function createSelectview(param1:QuestionDataBaseInfo) : QuestionViewBase
      {
         if(param1.isMultiSelect)
         {
            return new QuestionMultiSelectView(param1);
         }
         return new QuestionSingleSelectionView(param1);
      }
      
      private function createAnswerView(param1:QuestionDataBaseInfo) : QuestionViewBase
      {
         return new QuestionInputView(param1);
      }
   }
}

class QuestionAwardFactoryEnforcer
{
    
   
   function QuestionAwardFactoryEnforcer()
   {
      super();
   }
}
