package mark.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import mark.data.MarkSetTemplateData;
   
   public class MarkSetAnalyzer extends DataAnalyzer
   {
       
      
      public var sets:Dictionary = null;
      
      public function MarkSetAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var len:int = 0;
         var xmllist:* = null;
         var i:int = 0;
         var itemData:* = null;
         sets = new Dictionary();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            len = xml.Item.length();
            xmllist = xml..Item;
            for(i = 0; i < len; )
            {
               itemData = new MarkSetTemplateData();
               ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
               sets[itemData.SetId] = itemData;
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
