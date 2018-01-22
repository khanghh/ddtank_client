package bank.analyzer
{
   import bank.data.BankInvestmentItemData;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   
   public class BankInvestmentDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function BankInvestmentDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:XML = new XML(param1);
         _data = new DictionaryData();
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new BankInvestmentItemData();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               _data[_loc4_.ID] = _loc4_;
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
         _data = null;
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
