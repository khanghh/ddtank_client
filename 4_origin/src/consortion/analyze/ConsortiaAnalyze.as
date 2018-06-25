package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.rank.RankData;
   
   public class ConsortiaAnalyze extends DataAnalyzer
   {
       
      
      private var _dataList:Array;
      
      public function ConsortiaAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      public function get dataList() : Array
      {
         return _dataList;
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var itemData:* = null;
         _dataList = [];
         var xml:XML = new XML(data);
         var xmllist:XMLList = xml.Item;
         for(i = 0; i < xmllist.length(); )
         {
            itemData = new RankData();
            ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
            _dataList.push(itemData);
            i++;
         }
         _dataList.sortOn("Rank",16);
         var _loc8_:int = 0;
         var _loc7_:* = _dataList;
         for each(var obj in _dataList)
         {
            trace("======>" + obj.Rank);
         }
         onAnalyzeComplete();
      }
   }
}
