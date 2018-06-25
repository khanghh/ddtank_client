package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import petsBag.data.PetFightPropertyData;
   
   public class PetsEvolutionDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<PetFightPropertyData>;
      
      public function PetsEvolutionDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         _list = new Vector.<PetFightPropertyData>();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new PetFightPropertyData();
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
      
      public function get list() : Vector.<PetFightPropertyData>
      {
         return _list;
      }
   }
}
