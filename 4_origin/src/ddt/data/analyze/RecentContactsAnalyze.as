package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerState;
   import road7th.data.DictionaryData;
   
   public class RecentContactsAnalyze extends DataAnalyzer
   {
       
      
      public var recentContacts:DictionaryData;
      
      public function RecentContactsAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc3_:XML = new XML(param1);
         recentContacts = new DictionaryData();
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..Item;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               _loc5_ = new FriendListPlayer();
               ObjectUtils.copyPorpertiesByXML(_loc5_,_loc4_[_loc6_]);
               _loc2_ = new PlayerState(int(_loc3_.Item[_loc6_].@State));
               _loc5_.playerState = _loc2_;
               _loc5_.isOld = int(_loc4_[_loc6_].@OldPlayer) == 1;
               recentContacts.add(_loc5_.ID,_loc5_);
               _loc6_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
