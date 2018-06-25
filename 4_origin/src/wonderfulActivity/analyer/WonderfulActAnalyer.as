package wonderfulActivity.analyer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.ActivityTypeData;
   
   public class WonderfulActAnalyer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<ActivityTypeData>;
      
      public function WonderfulActAnalyer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var itemData:* = null;
         itemList = new Vector.<ActivityTypeData>();
         var xml:XML = new XML(data);
         var len:int = xml.Item.length();
         var xmllist:XMLList = xml.Item;
         for(i = 0; i < xmllist.length(); )
         {
            itemData = new ActivityTypeData();
            ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
            itemList.push(itemData);
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
