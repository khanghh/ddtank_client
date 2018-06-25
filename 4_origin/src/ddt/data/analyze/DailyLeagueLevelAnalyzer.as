package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.DailyLeagueLevelInfo;
   
   public class DailyLeagueLevelAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function DailyLeagueLevelAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         list = [];
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new DailyLeagueLevelInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               list.push(info);
               i++;
            }
            list.sortOn("Score",16);
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
