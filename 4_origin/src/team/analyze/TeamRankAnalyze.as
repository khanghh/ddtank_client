package team.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import team.TeamManager;
   import team.model.TeamRankInfo;
   import team.model.TeamRankListData;
   
   public class TeamRankAnalyze extends DataAnalyzer
   {
       
      
      public var data:TeamRankListData;
      
      public function TeamRankAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc9_:int = 0;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc8_:* = null;
         var _loc4_:XML = new XML(param1);
         this.data = new TeamRankListData();
         this.data.lastUpdateTime = _loc4_.@date;
         var _loc3_:Array = [];
         if(TeamManager.instance.model.currentAreaName == null || TeamManager.instance.model.currentAreaName == "")
         {
            TeamManager.instance.model.currentAreaName = _loc4_.@AreaName;
         }
         if(_loc4_.@value == "true")
         {
            _loc5_ = _loc4_..RankSegment;
            _loc9_ = 0;
            while(_loc9_ < _loc5_.length())
            {
               _loc7_ = _loc5_[_loc9_]..Item;
               _loc2_ = [];
               _loc6_ = 0;
               while(_loc6_ < _loc7_.length())
               {
                  _loc8_ = new TeamRankInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc8_,_loc7_[_loc6_]);
                  _loc2_.push(_loc8_);
                  _loc6_++;
               }
               _loc3_[_loc9_] = _loc2_;
               _loc9_++;
            }
            this.data.list = _loc3_;
            onAnalyzeComplete();
         }
         else
         {
            message = _loc4_.@message;
            onAnalyzeError();
         }
      }
   }
}
