package campbattle.data
{
   public class CampBattleAwardsGoodsInfo
   {
       
      
      public var ID:int;
      
      public var MinRank:int;
      
      public var MaxRank:int;
      
      public var IsCamp:Boolean;
      
      public var ItemID:int;
      
      public var Valid:int;
      
      public var Count:int = 1;
      
      public var StrengthLevel:int;
      
      public var AttackCompose:int;
      
      public var DefendCompose:int;
      
      public var AgilityCompose:int;
      
      public var LuckCompose:int;
      
      public var IsBind:Boolean;
      
      public function CampBattleAwardsGoodsInfo(param1:int = 0, param2:int = 0)
      {
         super();
         ID = param1;
         ItemID = param2;
      }
   }
}
