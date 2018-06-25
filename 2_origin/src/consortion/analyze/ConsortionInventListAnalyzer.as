package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaInventData;
   
   public class ConsortionInventListAnalyzer extends DataAnalyzer
   {
       
      
      public var inventList:Vector.<ConsortiaInventData>;
      
      public var totalCount:int;
      
      public function ConsortionInventListAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var cData:* = null;
         inventList = new Vector.<ConsortiaInventData>();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            totalCount = int(xml.@total);
            xmllist = XML(xml)..Item;
            for(i = 0; i < xmllist.length(); )
            {
               cData = new ConsortiaInventData();
               ObjectUtils.copyPorpertiesByXML(cData,xmllist[i]);
               inventList.push(cData);
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
