package store.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   import store.data.EvolutionData;
   
   public class EvolutionDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function EvolutionDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            _data = new DictionaryData();
            _loc3_ = _loc2_..Item;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length())
            {
               _loc5_ = new EvolutionData();
               ObjectUtils.copyPorpertiesByXML(_loc5_,_loc3_[_loc4_]);
               _data.add(_loc5_.Level,_loc5_);
               _loc4_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
         }
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
