package ddt.data.analyze
{
   import beadSystem.model.AdvanceBeadInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import road7th.data.DictionaryData;
   
   public class AdvanceBeadAnalyzer extends DataAnalyzer
   {
       
      
      public var list:DictionaryData;
      
      public function AdvanceBeadAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:XML = new XML(param1);
         list = new DictionaryData();
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..RuneAdvance;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new AdvanceBeadInfo();
               _loc4_.advancedTempId = int(_loc3_[_loc5_].@AdvancedTempId);
               _loc4_.runeName = _loc3_[_loc5_].@RuneName;
               _loc4_.advanceDesc = _loc3_[_loc5_].@AdvanceDesc;
               _loc4_.mainMaterials = _loc3_[_loc5_].@MainMaterials;
               _loc4_.quality = int(_loc3_[_loc5_].@Quality);
               _loc4_.maxLevelTempRunId = int(_loc3_[_loc5_].@MaxLevelTempRunId);
               _loc4_.auxiliaryMaterials = _loc3_[_loc5_].@AuxiliaryMaterials;
               list.add(_loc4_.advancedTempId,_loc4_);
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
