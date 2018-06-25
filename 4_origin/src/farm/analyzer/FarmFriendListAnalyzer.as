package farm.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import farm.modelx.FramFriendStateInfo;
   import farm.modelx.SimpleLandStateInfo;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   
   public class FarmFriendListAnalyzer extends DataAnalyzer
   {
       
      
      public var list:DictionaryData;
      
      public function FarmFriendListAnalyzer(onCompleteCall:Function)
      {
         list = new DictionaryData();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var friendStateInfo:* = null;
         var landStateVec:* = undefined;
         var items2:* = null;
         var simpleLandStateInfo:* = null;
         var xml:XML = XML(data);
         var items:XMLList = xml.Item;
         var _loc13_:int = 0;
         var _loc12_:* = items;
         for each(var item in items)
         {
            friendStateInfo = new FramFriendStateInfo();
            friendStateInfo.id = item.@UserID;
            friendStateInfo.isFeed = item.@isFeed == "true"?true:false;
            landStateVec = new Vector.<SimpleLandStateInfo>();
            items2 = item.Item;
            var _loc11_:int = 0;
            var _loc10_:* = items2;
            for each(var item2 in items2)
            {
               simpleLandStateInfo = new SimpleLandStateInfo();
               simpleLandStateInfo.seedId = item2.@SeedID;
               simpleLandStateInfo.AccelerateDate = item2.@AcclerateDate;
               simpleLandStateInfo.plantTime = DateUtils.decodeDated(item2.@GrowTime);
               simpleLandStateInfo.isStolen = item2.@IsCanStolen == "true"?true:false;
               landStateVec.push(simpleLandStateInfo);
            }
            friendStateInfo.setLandStateVec = landStateVec;
            list.add(friendStateInfo.id,friendStateInfo);
         }
         onAnalyzeComplete();
      }
   }
}
