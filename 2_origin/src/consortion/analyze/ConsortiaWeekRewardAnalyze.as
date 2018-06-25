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
      
      public function ConsortiaWeekRewardAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      public function get dataList() : DictionaryData
      {
         return _dataList;
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var rank:int = 0;
         var info:* = null;
         _dataList = new DictionaryData();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml.Item;
            for(i = 0; i < xmllist.length(); )
            {
               rank = xmllist[i].@Rank;
               info = new InventoryItemInfo();
               info.TemplateID = int(xmllist[i].@TemplateID);
               ItemManager.fill(info);
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               info.IsBinds = xmllist[i].@IsBind == "true";
               _dataList[rank] = info;
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
   }
}
