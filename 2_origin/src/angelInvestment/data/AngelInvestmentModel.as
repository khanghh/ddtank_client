package angelInvestment.data
{
   import road7th.data.DictionaryData;
   
   public class AngelInvestmentModel
   {
       
      
      private var _data:DictionaryData;
      
      public function AngelInvestmentModel()
      {
         super();
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
      
      public function set data(param1:DictionaryData) : void
      {
         _data = param1;
      }
   }
}
