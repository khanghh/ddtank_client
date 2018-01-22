package lanternriddles.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.QuestionInfo;
   import ddtmatch.data.DDTMatchQuestionInfo;
   import lanternriddles.data.LanternInfo;
   import road7th.data.DictionaryData;
   
   public class LanternDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:Object;
      
      private var _ddtMatchData:Object;
      
      public var questionList:DictionaryData;
      
      public var allQuestion:Array;
      
      public function LanternDataAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get data() : Object{return null;}
      
      public function get ddtMatchData() : Object{return null;}
   }
}
