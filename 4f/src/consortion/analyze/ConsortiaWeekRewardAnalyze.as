package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import road7th.data.DictionaryData;
   
   public class ConsortiaWeekRewardAnalyze extends DataAnalyzer
   {
       
      
      private var _dataList:DictionaryData;
      
      public function ConsortiaWeekRewardAnalyze(param1:Function){super(null);}
      
      public function get dataList() : DictionaryData{return null;}
      
      override public function analyze(param1:*) : void{}
   }
}
