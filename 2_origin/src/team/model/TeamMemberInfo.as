package team.model
{
   import ddt.data.player.BasePlayer;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   
   public class TeamMemberInfo extends BasePlayer
   {
       
      
      public var activeScore:int;
      
      public var weekActiveScore:int;
      
      public var totalActiveScore:int;
      
      public var seasonActiveScore:int;
      
      public var teamSocre:int;
      
      public var totalTiems:int;
      
      public var isSignToday:Boolean;
      
      public var isSelected:Boolean;
      
      public var type:int = 1;
      
      public var RatifierName:String;
      
      public var minute:int;
      
      public var day:int;
      
      public function TeamMemberInfo()
      {
         super();
      }
      
      public function get isSelf() : Boolean
      {
         return ID == PlayerManager.Instance.Self.ID;
      }
      
      public function get OffLineHour() : int
      {
         if(NickName == PlayerManager.Instance.Self.NickName || playerState.StateID != 0)
         {
            return -2;
         }
         var totalHours:int = 0;
         var oldDate:Date = LastLoginDate;
         var nowDate:Date = TimeManager.Instance.Now();
         var hours:Number = (nowDate.valueOf() - oldDate.valueOf()) / 3600000;
         totalHours = hours < 1?-1:Number(Math.floor(hours));
         if(hours < 1)
         {
            minute = hours * 60;
            if(minute <= 0)
            {
               minute = 1;
            }
         }
         if(hours > 24 && hours < 720)
         {
            day = Math.floor(hours / 24);
         }
         return totalHours;
      }
   }
}
