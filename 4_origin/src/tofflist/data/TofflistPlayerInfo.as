package tofflist.data
{
   import ddt.data.player.PlayerInfo;
   
   public class TofflistPlayerInfo extends PlayerInfo
   {
       
      
      public var AddDayGP:int;
      
      public var AddDayOffer:int;
      
      public var AddWeekGP:int;
      
      public var AddWeekOffer:int;
      
      public var AreaName:String;
      
      public var AddDayAchievementPoint:int;
      
      public var AddWeekAchievementPoint:int;
      
      public var GiftGp:int;
      
      public var GiftLevel:int;
      
      public var AddDayGiftGp:int;
      
      public var AddWeekGiftGp:int;
      
      public var AddWeekLeagueScore:int;
      
      public var AddDayPrestige:int;
      
      public var AddWeekPrestige:int;
      
      public var TotalPrestige:int;
      
      public var MountsLevel:int = 0;
      
      private var _mountsLevelInfo:String;
      
      public function TofflistPlayerInfo()
      {
         super();
      }
      
      public function get MountsLevelInfo() : String
      {
         return _mountsLevelInfo;
      }
      
      public function set MountLv(value:int) : void
      {
         MountsLevel = value / 10;
         _mountsLevelInfo = String(value % 10) + " Sao Lv " + (MountsLevel + 1).toString();
      }
   }
}
