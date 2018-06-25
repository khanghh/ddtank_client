package dayActivity
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class ActivityRewardAnalyzer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<DayRewaidData>;
      
      public function ActivityRewardAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var itemData:* = null;
         XML.ignoreWhitespace = true;
         itemList = new Vector.<DayRewaidData>();
         var xml:XML = new XML(data);
         var len:int = xml.item.length();
         var xmllist:XMLList = xml..item;
         for(i = 0; i < xmllist.length(); )
         {
            itemData = new DayRewaidData();
            ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
            itemList.push(itemData);
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
