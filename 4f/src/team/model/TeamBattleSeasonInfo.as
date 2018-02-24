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
      
      public function TeamBattleSeasonInfo(){super();}
      
      public function getRankGift(param1:int) : ItemTemplateInfo{return null;}
      
      public function getBeginData() : String{return null;}
      
      public function getEndData() : String{return null;}
   }
}
