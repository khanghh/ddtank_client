package drgnBoatBuild
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class DrgnBoatFriendsAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function DrgnBoatFriendsAnalyzer(onCompleteCall:Function)
      {
         list = [];
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var friendStateInfo:* = null;
         var xml:XML = XML(data);
         var items:XMLList = xml.Item;
         var _loc7_:int = 0;
         var _loc6_:* = items;
         for each(var item in items)
         {
            friendStateInfo = new DrgnBoatBuildCellInfo();
            friendStateInfo.id = item.@ID;
            friendStateInfo.stage = item.@Stage;
            friendStateInfo.progress = item.@Process;
            list.push(friendStateInfo);
         }
         onAnalyzeComplete();
      }
   }
}
