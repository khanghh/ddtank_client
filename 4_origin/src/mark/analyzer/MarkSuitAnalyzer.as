package mark.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import mark.data.MarkSuitTemplateData;
   
   public class MarkSuitAnalyzer extends DataAnalyzer
   {
       
      
      public var suits:Dictionary = null;
      
      public function MarkSuitAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var len:int = 0;
         var xmllist:* = null;
         var i:int = 0;
         var itemData:* = null;
         suits = new Dictionary();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            len = xml.Item.length();
            xmllist = xml..Item;
            for(i = 0; i < len; )
            {
               itemData = new MarkSuitTemplateData();
               ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
               suits[itemData.Id] = itemData;
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
