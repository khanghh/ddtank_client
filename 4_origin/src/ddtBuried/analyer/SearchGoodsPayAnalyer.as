package ddtBuried.analyer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddtBuried.data.SearchGoodsData;
   
   public class SearchGoodsPayAnalyer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<SearchGoodsData>;
      
      public function SearchGoodsPayAnalyer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var itemData:* = null;
         itemList = new Vector.<SearchGoodsData>();
         var xml:XML = new XML(data);
         var xmllist:XMLList = xml.item;
         for(i = 0; i < xmllist.length(); )
         {
            itemData = new SearchGoodsData();
            ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
            itemList.push(itemData);
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
