package questionAward.data
{
   public class QuestionAwardIterator implements QuestionIterator
   {
       
      
      private var _questionVec:Vector.<QuestionDataBaseInfo>;
      
      private var _position:int = 0;
      
      public function QuestionAwardIterator(param1:Vector.<QuestionDataBaseInfo>){super();}
      
      public function hasNext() : Boolean{return false;}
      
      public function Next() : Object{return null;}
   }
}
