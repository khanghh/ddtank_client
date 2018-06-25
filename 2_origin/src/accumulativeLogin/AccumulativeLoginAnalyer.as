package accumulativeLogin
{
   import accumulativeLogin.data.AccumulativeLoginRewardData;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   
   public class AccumulativeLoginAnalyer extends DataAnalyzer
   {
       
      
      private var _accumulativeloginDataDic:Dictionary;
      
      public function AccumulativeLoginAnalyer(onCompleteCall:Function)
      {
         super(onCompleteCall);
         _accumulativeloginDataDic = new Dictionary();
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var dataArr:* = null;
         var i:int = 0;
         var rewardData:* = null;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            dataArr = [];
            for(i = 0; i < xmllist.length(); )
            {
               rewardData = new AccumulativeLoginRewardData();
               ObjectUtils.copyPorpertiesByXML(rewardData,xmllist[i]);
               dataArr.push(rewardData);
               i++;
            }
            var _loc9_:int = 0;
            var _loc8_:* = dataArr;
            for each(var accData in dataArr)
            {
               if(!_accumulativeloginDataDic[accData.Count])
               {
                  _accumulativeloginDataDic[accData.Count] = [];
               }
               _accumulativeloginDataDic[accData.Count].push(accData);
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
      
      public function get accumulativeloginDataDic() : Dictionary
      {
         return _accumulativeloginDataDic;
      }
   }
}
