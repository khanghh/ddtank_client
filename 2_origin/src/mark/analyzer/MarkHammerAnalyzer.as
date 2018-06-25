package mark.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import mark.data.MarkHammerTemplateData;
   
   public class MarkHammerAnalyzer extends DataAnalyzer
   {
       
      
      public var hammers:Array = null;
      
      public function MarkHammerAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var len:int = 0;
         var xmllist:* = null;
         var i:int = 0;
         var itemData:* = null;
         hammers = [];
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            len = xml.Item.length();
            xmllist = xml..Item;
            for(i = 0; i < len; )
            {
               itemData = new MarkHammerTemplateData();
               ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
               hammers.push(itemData);
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
