package battleGroud.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   
   public class BattleWeeklyAwardAnalyzer extends DataAnalyzer
   {
       
      
      private var _dataList:Array;
      
      public function BattleWeeklyAwardAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      public function get dataList() : Array
      {
         return _dataList;
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         _dataList = [];
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml.item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new InventoryItemInfo();
               info.TemplateID = int(xmllist[i].@TemplateID);
               ItemManager.fill(info);
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _dataList.push(info);
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
