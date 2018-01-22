package bank.data
{
   import road7th.data.DictionaryData;
   
   public class BankInvestmentModel
   {
       
      
      private var _data:DictionaryData;
      
      private var _list:Array;
      
      public function BankInvestmentModel()
      {
         super();
         _list = [];
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
      
      public function set data(param1:DictionaryData) : void
      {
         _data = param1;
      }
      
      public function get list() : Array
      {
         return _list;
      }
      
      public function set list(param1:Array) : void
      {
         _list = param1;
      }
   }
}
