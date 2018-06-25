package bagAndInfo.energyData
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class EnergyDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:Object;
      
      public function EnergyDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var energyData:* = null;
         var count:int = 0;
         var xml:XML = new XML(data);
         _data = {};
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               energyData = new EnergyData();
               ObjectUtils.copyPorpertiesByXML(energyData,xmllist[i]);
               count = xmllist[i].@Count;
               if(!_data[count])
               {
                  _data[count] = energyData;
               }
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
      
      public function get data() : Object
      {
         return _data;
      }
   }
}
