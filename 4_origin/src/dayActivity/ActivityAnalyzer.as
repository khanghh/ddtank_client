package dayActivity
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class ActivityAnalyzer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<ActivityData>;
      
      public function ActivityAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var itemData:* = null;
         itemList = new Vector.<ActivityData>();
         XML.ignoreWhitespace = true;
         var xml:XML = new XML(data);
         var len:int = xml.item.length();
         var xmllist:XMLList = xml..item;
         for(i = 0; i < xmllist.length(); )
         {
            itemData = new ActivityData();
            ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
            itemList.push(itemData);
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
