package dayActivity
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class ActivePointAnalzer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<DayActiveData>;
      
      public function ActivePointAnalzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var itemData:* = null;
         itemList = new Vector.<DayActiveData>();
         XML.ignoreWhitespace = true;
         var xml:XML = new XML(data);
         var len:int = xml.item.length();
         var xmllist:XMLList = xml..item;
         for(i = 0; i < xmllist.length(); )
         {
            itemData = new DayActiveData();
            ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
            itemData.setLong();
            itemList.push(itemData);
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
