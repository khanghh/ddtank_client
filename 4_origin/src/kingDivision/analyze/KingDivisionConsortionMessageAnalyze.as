package kingDivision.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import kingDivision.data.KingDivisionConsortionMessageInfo;
   
   public class KingDivisionConsortionMessageAnalyze extends DataAnalyzer
   {
       
      
      public var _list:Array;
      
      public function KingDivisionConsortionMessageAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var itemInfo:* = null;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Info;
            _list = [];
            for(i = 0; i < xmllist.length(); )
            {
               itemInfo = new KingDivisionConsortionMessageInfo();
               ObjectUtils.copyPorpertiesByXML(itemInfo,xmllist[i]);
               _list.push(itemInfo);
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
