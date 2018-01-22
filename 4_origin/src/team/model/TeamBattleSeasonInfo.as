package team.model
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   
   public class TeamBattleSeasonInfo
   {
       
      
      public var SeasonId:int;
      
      public var RankGift:String;
      
      public var StartDate:String;
      
      public var EndDate:String;
      
      public function TeamBattleSeasonInfo()
      {
         super();
      }
      
      public function getRankGift(param1:int) : ItemTemplateInfo
      {
         if(param1 < 0 || RankGift == null || RankGift.length == 0)
         {
            return null;
         }
         var _loc2_:Array = RankGift.split(",");
         if(param1 >= _loc2_.length)
         {
            return null;
         }
         return ItemManager.Instance.getTemplateById(parseInt(_loc2_[param1]));
      }
      
      public function getBeginData() : String
      {
         var _loc2_:Array = [];
         _loc2_ = (StartDate.split(" ")[0] as String).split("-");
         var _loc1_:String = _loc2_[0] + "." + _loc2_[1] + "." + _loc2_[2];
         return _loc1_;
      }
      
      public function getEndData() : String
      {
         var _loc2_:Array = [];
         _loc2_ = (EndDate.split(" ")[0] as String).split("-");
         var _loc1_:String = _loc2_[0] + "." + _loc2_[1] + "." + _loc2_[2];
         return _loc1_;
      }
   }
}
