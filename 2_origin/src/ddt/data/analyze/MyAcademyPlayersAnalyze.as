package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerState;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   
   public class MyAcademyPlayersAnalyze extends DataAnalyzer
   {
       
      
      public var myAcademyPlayers:DictionaryData;
      
      public function MyAcademyPlayersAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:XML = new XML(param1);
         myAcademyPlayers = new DictionaryData();
         if(_loc4_.@value == "true")
         {
            _loc5_ = _loc4_..Item;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length())
            {
               _loc6_ = new FriendListPlayer();
               _loc6_.ID = _loc5_[_loc7_].@UserID;
               _loc2_ = new PlayerState(int(_loc5_[_loc7_].@State));
               _loc6_.playerState = _loc2_;
               _loc6_.apprenticeshipState = _loc5_[_loc7_].@ApprenticeshipState;
               _loc6_.IsMarried = _loc5_[_loc7_].@IsMarried;
               _loc3_ = _loc5_[_loc7_].@LastDate;
               _loc6_.lastDate = DateUtils.dealWithStringDate(_loc3_);
               ObjectUtils.copyPorpertiesByXML(_loc6_,_loc5_[_loc7_]);
               myAcademyPlayers.add(_loc6_.ID,_loc6_);
               _loc7_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc4_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
