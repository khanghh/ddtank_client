package league
{
   import ddt.CoreManager;
   import ddt.bagStore.BagStore;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddtActivityIcon.DdtActivityIconManager;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import road7th.comm.PackageIn;
   
   public class LeagueManager extends CoreManager
   {
      
      public static const LEAGUE_OPENVIEW:String = "leagueOpenView";
      
      private static var _instance:LeagueManager;
       
      
      public var maxCount:int = 30;
      
      public var restCount:int = 10;
      
      public var isOpen:Boolean = false;
      
      public var deleLeaIcon:Function;
      
      public function LeagueManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : LeagueManager{return null;}
      
      override protected function start() : void{}
      
      public function initLeagueStartNoticeEvent() : void{}
      
      private function onLeagueNotice(param1:PkgEvent) : void{}
   }
}
