package mark.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import mark.data.MarkChipTemplateData;
   
   public class MarkChipAnalyzer extends DataAnalyzer
   {
       
      
      public var chips:Dictionary = null;
      
      public function MarkChipAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var len:int = 0;
         var xmllist:* = null;
         var i:int = 0;
         var itemData:* = null;
         chips = new Dictionary();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            len = xml.Item.length();
            xmllist = xml..Item;
            for(i = 0; i < len; )
            {
               itemData = new MarkChipTemplateData();
               ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
               chips[itemData.Id] = itemData;
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
