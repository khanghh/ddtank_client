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
      
      public function FarmFriendListAnalyzer(param1:Function)
      {
         list = new DictionaryData();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc9_:* = null;
         var _loc3_:* = undefined;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc8_:XML = XML(param1);
         var _loc4_:XMLList = _loc8_.Item;
         var _loc13_:int = 0;
         var _loc12_:* = _loc4_;
         for each(var _loc5_ in _loc4_)
         {
            _loc9_ = new FramFriendStateInfo();
            _loc9_.id = _loc5_.@UserID;
            _loc9_.isFeed = _loc5_.@isFeed == "true"?true:false;
            _loc3_ = new Vector.<SimpleLandStateInfo>();
            _loc7_ = _loc5_.Item;
            var _loc11_:int = 0;
            var _loc10_:* = _loc7_;
            for each(var _loc2_ in _loc7_)
            {
               _loc6_ = new SimpleLandStateInfo();
               _loc6_.seedId = _loc2_.@SeedID;
               _loc6_.AccelerateDate = _loc2_.@AcclerateDate;
               _loc6_.plantTime = DateUtils.decodeDated(_loc2_.@GrowTime);
               _loc6_.isStolen = _loc2_.@IsCanStolen == "true"?true:false;
               _loc3_.push(_loc6_);
            }
            _loc9_.setLandStateVec = _loc3_;
            list.add(_loc9_.id,_loc9_);
         }
         onAnalyzeComplete();
      }
   }
}
