package sanXiao.model
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class SanXiaoStoreItemAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function SanXiaoStoreItemAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         list = [];
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new SXStoreItemData();
               info.count = int(xmllist[i].@Count);
               info.id = int(xmllist[i].@ID);
               info.TempleteID = int(xmllist[i].@ItemID);
               info.price = int(xmllist[i].@Price);
               info.total = int(xmllist[i].@LimitCount);
               info.remain = info.total;
               info.isBind = xmllist[i].@IsBind == "true"?true:false;
               info.Valid = int(xmllist[i].@Valid);
               list.push(info);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
