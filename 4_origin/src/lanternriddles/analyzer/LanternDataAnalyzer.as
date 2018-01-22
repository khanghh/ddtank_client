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
      
      public function LanternDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc7_:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc6_:XML = new XML(param1);
         _data = {};
         _ddtMatchData = {};
         allQuestion = [];
         questionList = new DictionaryData();
         if(_loc6_.@value == "true")
         {
            _loc7_ = _loc6_..Item;
            _loc9_ = 0;
            while(_loc9_ < _loc7_.length())
            {
               _loc8_ = new QuestionInfo();
               ObjectUtils.copyPorpertiesByXML(_loc8_,_loc7_[_loc9_]);
               if(allQuestion[_loc8_.QuestionCatalogID] == null)
               {
                  allQuestion[_loc8_.QuestionCatalogID] = new DictionaryData();
               }
               allQuestion[_loc8_.QuestionCatalogID].add(_loc8_.QuestionID,_loc8_);
               _loc2_ = new LanternInfo();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc7_[_loc9_]);
               _loc4_ = _loc7_[_loc9_].@QuestionID;
               if(!_data[_loc4_])
               {
                  _data[_loc4_] = _loc2_;
               }
               _loc3_ = new DDTMatchQuestionInfo();
               ObjectUtils.copyPorpertiesByXML(_loc3_,_loc7_[_loc9_]);
               _loc5_ = _loc7_[_loc9_].@QuestionID;
               if(!_ddtMatchData[_loc5_])
               {
                  _ddtMatchData[_loc5_] = _loc3_;
               }
               _loc9_++;
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
