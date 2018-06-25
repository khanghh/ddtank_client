package mark.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import mark.data.MarkTransferTemplateData;
   
   public class MarkTransferAnalyzer extends DataAnalyzer
   {
       
      
      public var transfers:Array = null;
      
      public function MarkTransferAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var len:int = 0;
         var xmllist:* = null;
         var i:int = 0;
         var itemData:* = null;
         transfers = [];
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            len = xml.Item.length();
            xmllist = xml..Item;
            for(i = 0; i < len; )
            {
               itemData = new MarkTransferTemplateData();
               ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
               transfers.push(itemData);
               i++;
            }
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
         onAnalyzeComplete();
      }
   }
}
