package bank.analyzer
{
   import bank.data.BankInvestmentItemData;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   
   public class BankInvestmentDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function BankInvestmentDataAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get data() : DictionaryData{return null;}
   }
}
