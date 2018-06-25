package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import petsBag.data.PetsFormData;
   
   public class PetsFormDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<PetsFormData>;
      
      public function PetsFormDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         _list = new Vector.<PetsFormData>();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new PetsFormData();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _list.push(info);
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
      
      public function get list() : Vector.<PetsFormData>
      {
         return _list;
      }
   }
}
