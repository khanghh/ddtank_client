package petsBag.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   
   public class PetAtlasAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function PetAtlasAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var item:* = null;
         _data = new DictionaryData();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml.item;
            for(i = 0; i < xmllist.length(); )
            {
               item = new PetAtlasInfo();
               ObjectUtils.copyPorpertiesByXML(item,xmllist[i]);
               _data.add(item.ID,item);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
   }
}
