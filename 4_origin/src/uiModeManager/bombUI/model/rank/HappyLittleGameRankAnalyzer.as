package uiModeManager.bombUI.model.rank
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   
   public class HappyLittleGameRankAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function HappyLittleGameRankAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var rewardData:* = null;
         var xmllist:* = null;
         var i:int = 0;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            _data = new DictionaryData();
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               rewardData = new RankRewardData();
               ObjectUtils.copyPorpertiesByXML(rewardData,xmllist[i]);
               _data.add(rewardData.TemplateId,rewardData);
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
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
