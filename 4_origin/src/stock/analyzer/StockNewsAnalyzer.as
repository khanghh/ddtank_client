package stock.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import stock.StockMgr;
   import stock.data.StockNewsTemplateData;
   
   public class StockNewsAnalyzer extends DataAnalyzer
   {
       
      
      public function StockNewsAnalyzer(onCompleteCall:Function = null)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var itemData:* = null;
         var tmp:Dictionary = new Dictionary();
         var xml:XML = new XML(data);
         var len:int = xml.Item.length();
         var xmllist:XMLList = xml.Item;
         for(i = 0; i < len; )
         {
            itemData = new StockNewsTemplateData();
            ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
            tmp[itemData.NewsId] = itemData;
            i++;
         }
         StockMgr.inst.model.cfgStockNews = tmp;
         onAnalyzeComplete();
      }
   }
}
