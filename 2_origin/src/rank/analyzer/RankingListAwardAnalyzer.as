package rank.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import rank.data.RankAwardInfo;
   
   public class RankingListAwardAnalyzer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<RankAwardInfo>;
      
      public var lastUpdateTime:String;
      
      public function RankingListAwardAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         XML.ignoreWhitespace = true;
         itemList = new Vector.<RankAwardInfo>();
         var _loc3_:XML = new XML(param1);
         var _loc5_:int = _loc3_.Item.length();
         var _loc4_:XMLList = _loc3_..Item;
         lastUpdateTime = _loc3_.@lastUpdateTime;
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length())
         {
            _loc2_ = new RankAwardInfo();
            _loc2_.activeParam1 = _loc4_[_loc6_].@ActiveParam1;
            _loc2_.activeParam2 = _loc4_[_loc6_].@ActiveParam2;
            _loc2_.activeType = _loc4_[_loc6_].@ActiveType;
            _loc2_.activeValue = _loc4_[_loc6_].@ActiveValue;
            _loc2_.itemName = _loc4_[_loc6_].@ItemName;
            _loc2_.nickName = _loc4_[_loc6_].@NickName;
            _loc2_.subType = _loc4_[_loc6_].@SubType;
            _loc2_.userID = _loc4_[_loc6_].@UserID;
            _loc2_.rank = _loc4_[_loc6_].@Rank;
            itemList.push(_loc2_);
            _loc6_++;
         }
         onAnalyzeComplete();
      }
   }
}
