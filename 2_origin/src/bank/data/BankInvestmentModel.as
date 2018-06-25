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
      
      public function set data(value:DictionaryData) : void
      {
         _data = value;
      }
      
      public function get list() : Array
      {
         return _list;
      }
      
      public function set list(value:Array) : void
      {
         _list = value;
      }
   }
}
