package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaWeekRewardPlayerVo;
   
   public class ConsortiaRichRankAnalyze extends DataAnalyzer
   {
       
      
      private var _dataList:Array;
      
      public function ConsortiaRichRankAnalyze(onCompleteCall:Function)
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
         var i:int = 0;
         var vo:* = null;
         _dataList = [];
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml.Item;
            for(i = 0; i < xmllist.length(); )
            {
               vo = new ConsortiaWeekRewardPlayerVo();
               ObjectUtils.copyPorpertiesByXML(vo,xmllist[i]);
               _dataList.push(vo);
               i++;
            }
            _dataList.sortOn("Rank",16);
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeComplete();
            onAnalyzeError();
         }
      }
   }
}
