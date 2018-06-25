package campbattle.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class CampBattleAwardsDataAnalyzer extends DataAnalyzer
   {
       
      
      public var _dataList:Array;
      
      public function CampBattleAwardsDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var itemInfo:* = null;
         var arr:* = null;
         _dataList = [];
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               itemInfo = new CampBattleAwardsGoodsInfo();
               ObjectUtils.copyPorpertiesByXML(itemInfo,xmllist[i]);
               arr = _dataList[itemInfo.ID - 1];
               if(!arr)
               {
                  arr = [];
               }
               arr.push(itemInfo);
               _dataList[itemInfo.ID - 1] = arr;
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
   }
}
