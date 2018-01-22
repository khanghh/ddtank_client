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
         var _loc4_:int = 0;
         var _loc3_:Date = LastLoginDate;
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc1_:Number = (_loc2_.valueOf() - _loc3_.valueOf()) / 3600000;
         _loc4_ = _loc1_ < 1?-1:Number(Math.floor(_loc1_));
         if(_loc1_ < 1)
         {
            minute = _loc1_ * 60;
            if(minute <= 0)
            {
               minute = 1;
            }
         }
         if(_loc1_ > 24 && _loc1_ < 720)
         {
            day = Math.floor(_loc1_ / 24);
         }
         return _loc4_;
      }
   }
}
