package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaDutyInfo;
   
   public class ConsortionDutyListAnalyzer extends DataAnalyzer
   {
       
      
      public var dutyList:Vector.<ConsortiaDutyInfo>;
      
      public function ConsortionDutyListAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         dutyList = new Vector.<ConsortiaDutyInfo>();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = XML(xml)..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new ConsortiaDutyInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               dutyList.push(info);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
