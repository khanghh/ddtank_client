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
      
      public function QuestionInfoAnalyze(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
