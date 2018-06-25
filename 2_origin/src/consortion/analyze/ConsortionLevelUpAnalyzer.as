package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaLevelInfo;
   
   public class ConsortionLevelUpAnalyzer extends DataAnalyzer
   {
       
      
      public var levelUpData:Vector.<ConsortiaLevelInfo>;
      
      public function ConsortionLevelUpAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         levelUpData = new Vector.<ConsortiaLevelInfo>();
         if(xml.@value == "true")
         {
            xmllist = XML(xml)..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new ConsortiaLevelInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               levelUpData.push(info);
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
