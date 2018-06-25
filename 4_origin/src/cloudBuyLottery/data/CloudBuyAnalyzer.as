package cloudBuyLottery.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class CloudBuyAnalyzer extends DataAnalyzer
   {
       
      
      public var dataArr:Array;
      
      public function CloudBuyAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var itemInfo:* = null;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..ItemLog;
            dataArr = [];
            for(i = 0; i < xmllist.length(); )
            {
               itemInfo = new CloudBuyLogInfo();
               ObjectUtils.copyPorpertiesByXML(itemInfo,xmllist[i]);
               dataArr.push(itemInfo);
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
