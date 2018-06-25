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
      
      public function getRankGift(rank:int) : ItemTemplateInfo
      {
         if(rank < 0 || RankGift == null || RankGift.length == 0)
         {
            return null;
         }
         var gifts:Array = RankGift.split(",");
         if(rank >= gifts.length)
         {
            return null;
         }
         return ItemManager.Instance.getTemplateById(parseInt(gifts[rank]));
      }
      
      public function getBeginData() : String
      {
         var arr:Array = [];
         arr = (StartDate.split(" ")[0] as String).split("-");
         var str:String = arr[0] + "." + arr[1] + "." + arr[2];
         return str;
      }
      
      public function getEndData() : String
      {
         var arr:Array = [];
         arr = (EndDate.split(" ")[0] as String).split("-");
         var str:String = arr[0] + "." + arr[1] + "." + arr[2];
         return str;
      }
   }
}
