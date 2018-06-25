package questionAward.data
{
   public class QuestionAwardIterator implements QuestionIterator
   {
       
      
      private var _questionVec:Vector.<QuestionDataBaseInfo>;
      
      private var _position:int = 0;
      
      public function QuestionAwardIterator(questionList:Vector.<QuestionDataBaseInfo>)
      {
         super();
         _questionVec = questionList;
      }
      
      public function hasNext() : Boolean
      {
         if(_position >= _questionVec.length || _questionVec[_position] == null)
         {
            return false;
         }
         return true;
      }
      
      public function Next() : Object
      {
         var dataBaseInfo:QuestionDataBaseInfo = _questionVec[_position] as QuestionDataBaseInfo;
         _position = _position + 1;
         return dataBaseInfo;
      }
   }
}
