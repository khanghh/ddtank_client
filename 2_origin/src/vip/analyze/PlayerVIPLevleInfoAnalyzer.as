package vip.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.utils.Dictionary;
   import vip.data.VipModelInfo;
   
   public class PlayerVIPLevleInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var info:VipModelInfo;
      
      public function PlayerVIPLevleInfoAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var levels:* = null;
         var i:int = 0;
         var level:* = null;
         info = new VipModelInfo();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            info.maxExp = xml.@maxExp;
            info.ExpForEachDay = xml.@ExpForEachDay;
            info.ExpDecreaseForEachDay = xml.@ExpDecreaseForEachDay;
            info.upRuleDescription = xml.@Description;
            info.RewardDescription = xml.@RewardInfo;
            levels = xml..Levels;
            for(i = 0; i < levels.length(); )
            {
               level = new Dictionary();
               level["level"] = levels[i].@Level;
               level["ExpNeeded"] = levels[i].@ExpNeeded;
               level["Description"] = levels[i].@Description;
               info.levelInfo[i] = level;
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
