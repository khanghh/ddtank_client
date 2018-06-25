package questionAward.view
{
   import questionAward.data.QuestionDataBaseInfo;
   
   public class QuestionAwardFactory
   {
      
      private static var _instance:QuestionAwardFactory;
       
      
      public function QuestionAwardFactory(enforcer:QuestionAwardFactoryEnforcer)
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
      
      public function createQuestionView(info:QuestionDataBaseInfo) : QuestionViewBase
      {
         var view:QuestionViewBase = null;
         var temType:int = info.type;
         switch(int(temType) - 1)
         {
            case 0:
               view = createSelectview(info);
               break;
            case 1:
               view = createAnswerView(info);
         }
         return view;
      }
      
      private function createSelectview(data:QuestionDataBaseInfo) : QuestionViewBase
      {
         if(data.isMultiSelect)
         {
            return new QuestionMultiSelectView(data);
         }
         return new QuestionSingleSelectionView(data);
      }
      
      private function createAnswerView(data:QuestionDataBaseInfo) : QuestionViewBase
      {
         return new QuestionInputView(data);
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
