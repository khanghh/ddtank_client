package bagAndInfo.bag.ring.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   
   public class RingDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:Dictionary;
      
      public function RingDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var ringData:* = null;
         var xml:XML = new XML(data);
         _data = new Dictionary();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            RingSystemData.TotalLevel = xmllist.length();
            for(i = 0; i < RingSystemData.TotalLevel; )
            {
               ringData = new RingSystemData();
               ObjectUtils.copyPorpertiesByXML(ringData,xmllist[i]);
               _data[ringData.Level] = ringData;
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
      
      public function get data() : Dictionary
      {
         return _data;
      }
   }
}
