package guildMemberWeek.controller
{
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   import road7th.comm.PackageIn;
   
   public class GuildMemberWeekController
   {
      
      private static var _instance:GuildMemberWeekController;
       
      
      public function GuildMemberWeekController(param1:PrivateClass){super();}
      
      public static function get instance() : GuildMemberWeekController{return null;}
      
      public function initEvent() : void{}
      
      public function removeEvent() : void{}
      
      private function __ShowFinishFrame(param1:CrazyTankSocketEvent) : void{}
      
      private function __ShowRankingFrame(param1:CrazyTankSocketEvent) : void{}
      
      private function __UpTop10Data(param1:CrazyTankSocketEvent) : void{}
      
      private function __UpAddPointBook(param1:CrazyTankSocketEvent) : void{}
      
      private function __activityEndShowRanking(param1:CrazyTankSocketEvent) : void{}
      
      public function _UpAddPointRecord(param1:CrazyTankSocketEvent) : void{}
      
      public function _UpImmediatelyRecord(param1:CrazyTankSocketEvent) : void{}
      
      public function __UpMyRanking(param1:CrazyTankSocketEvent) : void{}
      
      private function UpTop10Data(param1:String) : void{}
      
      public function CheckAddBookIsOK() : void{}
      
      public function upPointBookData(param1:int, param2:Number, param3:Boolean = true) : void{}
      
      public function ChangePlayerMoney() : void{}
      
      public function dispose() : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
