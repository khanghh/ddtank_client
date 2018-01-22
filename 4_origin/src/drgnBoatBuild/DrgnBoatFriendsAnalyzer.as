package drgnBoatBuild
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class DrgnBoatFriendsAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function DrgnBoatFriendsAnalyzer(param1:Function)
      {
         list = [];
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc4_:XML = XML(param1);
         var _loc2_:XMLList = _loc4_.Item;
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            _loc5_ = new DrgnBoatBuildCellInfo();
            _loc5_.id = _loc3_.@ID;
            _loc5_.stage = _loc3_.@Stage;
            _loc5_.progress = _loc3_.@Process;
            list.push(_loc5_);
         }
         onAnalyzeComplete();
      }
   }
}
