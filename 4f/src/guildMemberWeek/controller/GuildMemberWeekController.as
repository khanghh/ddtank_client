package guildMemberWeek.controller{   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import guildMemberWeek.manager.GuildMemberWeekManager;   import road7th.comm.PackageIn;      public class GuildMemberWeekController   {            private static var _instance:GuildMemberWeekController;                   public function GuildMemberWeekController(pct:PrivateClass) { super(); }
            public static function get instance() : GuildMemberWeekController { return null; }
            public function initEvent() : void { }
            public function removeEvent() : void { }
            private function __ShowFinishFrame(event:CrazyTankSocketEvent) : void { }
            private function __ShowRankingFrame(event:CrazyTankSocketEvent) : void { }
            private function __UpTop10Data(event:CrazyTankSocketEvent) : void { }
            private function __UpAddPointBook(event:CrazyTankSocketEvent) : void { }
            private function __activityEndShowRanking(event:CrazyTankSocketEvent) : void { }
            public function _UpAddPointRecord(event:CrazyTankSocketEvent) : void { }
            public function _UpImmediatelyRecord(event:CrazyTankSocketEvent) : void { }
            public function __UpMyRanking(event:CrazyTankSocketEvent) : void { }
            private function UpTop10Data(UpType:String) : void { }
            public function CheckAddBookIsOK() : void { }
            public function upPointBookData(ItemID:int, Money:Number, ChangeMoneyShow:Boolean = true) : void { }
            public function ChangePlayerMoney() : void { }
            public function dispose() : void { }
   }}class PrivateClass{          function PrivateClass() { super(); }
}