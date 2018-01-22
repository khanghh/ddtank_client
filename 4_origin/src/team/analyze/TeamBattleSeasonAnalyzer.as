package team.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   import team.model.TeamBattleSeasonInfo;
   
   public class TeamBattleSeasonAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function TeamBattleSeasonAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         _data = new DictionaryData();
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new TeamBattleSeasonInfo();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               _data.add(_loc4_.SeasonId,_loc4_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
         }
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
