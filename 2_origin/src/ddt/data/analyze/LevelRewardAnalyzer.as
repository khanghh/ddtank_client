package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.utils.Dictionary;
   import trainer.data.LevelRewardInfo;
   
   public class LevelRewardAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      public function LevelRewardAnalyzer(onCompleteCall:Function)
      {
         list = new Dictionary();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var level:int = 0;
         var rewardItems:* = null;
         var rewardItemList:* = null;
         var rewardInfo:* = null;
         var xml:XML = XML(data);
         var rewards:XMLList = xml.reward;
         var _loc13_:int = 0;
         var _loc12_:* = rewards;
         for each(var item in rewards)
         {
            level = item.@level;
            rewardItems = new Dictionary();
            rewardItemList = item.rewardItem;
            var _loc11_:int = 0;
            var _loc10_:* = rewardItemList;
            for each(var i in rewardItemList)
            {
               rewardInfo = new LevelRewardInfo();
               rewardInfo.sort = int(i.@sort);
               rewardInfo.title = String(i.@title);
               rewardInfo.content = String(i.@content);
               rewardInfo.girlItems = String(i.@items).split("|")[0].split(",");
               rewardInfo.boyItems = String(i.@items).split("|")[1].split(",");
               rewardItems[rewardInfo.sort] = rewardInfo;
            }
            list[level] = rewardItems;
         }
         onAnalyzeComplete();
      }
   }
}
