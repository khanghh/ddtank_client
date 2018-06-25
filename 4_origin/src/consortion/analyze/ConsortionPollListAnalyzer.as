package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortionPollInfo;
   
   public class ConsortionPollListAnalyzer extends DataAnalyzer
   {
       
      
      public var pollList:Vector.<ConsortionPollInfo>;
      
      public function ConsortionPollListAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         pollList = new Vector.<ConsortionPollInfo>();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = XML(xml)..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new ConsortionPollInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               pollList.push(info);
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
