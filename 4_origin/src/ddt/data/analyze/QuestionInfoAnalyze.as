package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.QuestionInfo;
   import road7th.data.DictionaryData;
   
   public class QuestionInfoAnalyze extends DataAnalyzer
   {
       
      
      public var questionList:DictionaryData;
      
      public var allQuestion:Array;
      
      public function QuestionInfoAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:XML = new XML(param1);
         allQuestion = [];
         questionList = new DictionaryData();
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new QuestionInfo();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               if(allQuestion[_loc4_.QuestionCatalogID] == null)
               {
                  allQuestion[_loc4_.QuestionCatalogID] = new DictionaryData();
               }
               allQuestion[_loc4_.QuestionCatalogID].add(_loc4_.QuestionID,_loc4_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
