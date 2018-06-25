package rescue.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import rescue.data.RescueRewardInfo;
   
   public class RescueRewardAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function RescueRewardAnalyzer(onCompleteCall:Function)
      {
         list = [];
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var rewardInfo:* = null;
         var xml:XML = XML(data);
         var items:XMLList = xml.Item;
         var _loc7_:int = 0;
         var _loc6_:* = items;
         for each(var item in items)
         {
            rewardInfo = new RescueRewardInfo();
            ObjectUtils.copyPorpertiesByXML(rewardInfo,item);
            list.push(rewardInfo);
         }
         onAnalyzeComplete();
      }
   }
}
