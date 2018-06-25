package stock.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import stock.StockMgr;
   import stock.data.StockTemplateData;
   
   public final class StockAnalyzer extends DataAnalyzer
   {
       
      
      public function StockAnalyzer(onCompleteCall:Function = null)
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
            itemData = new StockTemplateData();
            ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
            tmp[itemData.StockID] = itemData;
            i++;
         }
         StockMgr.inst.model.cfgStocks = tmp;
         onAnalyzeComplete();
      }
   }
}
