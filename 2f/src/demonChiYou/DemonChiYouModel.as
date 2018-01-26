package demonChiYou
{
   public class DemonChiYouModel
   {
      
      public static const ACTIVE_NOT_OPEN:int = 1;
      
      public static const ACTIVE_OPEN_BOSS_ALIVE:int = 2;
      
      public static const ACTIVE_OVER_BOSS_ALIVE:int = 3;
      
      public static const ACTIVE_OVER_BOSS_DIE:int = 4;
      
      public static const ACTIVE_OVER_ROLL_OVER:int = 5;
      
      public static const ACTIVE_OVER_BUY_OVER:int = 6;
      
      public static const TOTAL_LEFT_SELECT_SEC:int = 30;
      
      public static const ROLL_COST_ARR:Array = [5,10,15,20,25,30,35,40,45];
       
      
      public var rankInfo:RankInfo;
      
      public var bossState:int = 1;
      
      public var bossMaxBlood:int;
      
      public var bossBlood:int;
      
      public var rewardBoxIDArr:Array;
      
      public var startDate:Date;
      
      public var endDate:Date;
      
      public var bossDieTime:Date;
      
      public var isOpen:Boolean = false;
      
      public var shopInfoArr:Array;
      
      public var leftSelectSec:int = 30;
      
      public function DemonChiYouModel(){super();}
   }
}
