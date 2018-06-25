package condiscount.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import condiscount.data.CondiscountInfo;
   
   public class CondiscountListAnalyzer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<CondiscountInfo>;
      
      public function CondiscountListAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var itemData:* = null;
         itemList = new Vector.<CondiscountInfo>();
         var xml:XML = new XML(data);
         var len:int = xml.Item.length();
         var xmllist:XMLList = xml..Item;
         for(i = 0; i < xmllist.length(); )
         {
            itemData = new CondiscountInfo();
            itemList.push(itemData);
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
