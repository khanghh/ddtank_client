package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class ConsortiaTaskRankAnalyzer extends DataAnalyzer
   {
       
      
      private var _dataList:Array;
      
      public function ConsortiaTaskRankAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      public function get dataList() : Array
      {
         return _dataList;
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var len:int = 0;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         _dataList = [];
         if(xml.@value == "true")
         {
            xmllist = xml.children();
            len = xmllist.length();
            for(i = 0; i < len; )
            {
               info = {};
               info.id = int(xmllist[i].@ID);
               info.name = String(xmllist[i].@NicName);
               info.rank = i + 1;
               info.percent = Number(xmllist[i].@Percentage);
               info.contribute = Number(xmllist[i].@AwardRichesoffer);
               _dataList.push(info);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
   }
}
