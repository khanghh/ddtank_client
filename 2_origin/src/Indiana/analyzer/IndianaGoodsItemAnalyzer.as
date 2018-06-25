package Indiana.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class IndianaGoodsItemAnalyzer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<IndianaGoodsItemInfo>;
      
      public function IndianaGoodsItemAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var itemData:* = null;
         var i:int = 0;
         XML.ignoreWhitespace = true;
         itemList = new Vector.<IndianaGoodsItemInfo>();
         var xml:XML = new XML(data);
         var len:int = xml.item.length();
         var xmllist:XMLList = xml..Item;
         for(i = 0; i < xmllist.length(); )
         {
            itemData = new IndianaGoodsItemInfo();
            ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
            itemList.push(itemData);
            i++;
         }
         onAnalyzeComplete();
      }
      
      public function get data() : Vector.<IndianaGoodsItemInfo>
      {
         return itemList;
      }
   }
}
