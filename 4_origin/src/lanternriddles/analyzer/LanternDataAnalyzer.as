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
      
      public function LanternDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var questionData:* = null;
         var count:int = 0;
         var questionData1:* = null;
         var count1:int = 0;
         var xml:XML = new XML(data);
         _data = {};
         _ddtMatchData = {};
         allQuestion = [];
         questionList = new DictionaryData();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new QuestionInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               if(allQuestion[info.QuestionCatalogID] == null)
               {
                  allQuestion[info.QuestionCatalogID] = new DictionaryData();
               }
               allQuestion[info.QuestionCatalogID].add(info.QuestionID,info);
               questionData = new LanternInfo();
               ObjectUtils.copyPorpertiesByXML(questionData,xmllist[i]);
               count = xmllist[i].@QuestionID;
               if(!_data[count])
               {
                  _data[count] = questionData;
               }
               questionData1 = new DDTMatchQuestionInfo();
               ObjectUtils.copyPorpertiesByXML(questionData1,xmllist[i]);
               count1 = xmllist[i].@QuestionID;
               if(!_ddtMatchData[count1])
               {
                  _ddtMatchData[count1] = questionData1;
               }
               i++;
            }
            onAnalyzeComplete();
         }
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get ddtMatchData() : Object
      {
         return _ddtMatchData;
      }
   }
}
