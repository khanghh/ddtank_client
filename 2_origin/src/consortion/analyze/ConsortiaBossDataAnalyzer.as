package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import consortion.data.ConsortiaBossConfigVo;
   
   public class ConsortiaBossDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _dataList:Array;
      
      public function ConsortiaBossDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         _dataList = [];
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new ConsortiaBossConfigVo();
               info.level = xmllist[i].@Level;
               info.callBossRich = xmllist[i].@CostRich;
               info.extendTimeRich = xmllist[i].@ProlongRich;
               _dataList.push(info);
               i++;
            }
            _dataList.sortOn("level",16);
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get dataList() : Array
      {
         return _dataList;
      }
   }
}
