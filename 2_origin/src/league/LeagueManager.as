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
      
      public function LeagueManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : LeagueManager
      {
         if(_instance == null)
         {
            _instance = new LeagueManager();
         }
         return _instance;
      }
      
      override protected function start() : void
      {
         dispatchEvent(new Event("leagueOpenView"));
      }
      
      public function initLeagueStartNoticeEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(42),onLeagueNotice);
      }
      
      private function onLeagueNotice(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:int = _loc2_.readByte();
         if(_loc3_ == 1)
         {
            restCount = _loc2_.readInt();
            maxCount = _loc2_.readInt();
            isOpen = true;
            if(StateManager.currentStateType == "main" || StateManager.currentStateType == "roomlist" || StateManager.currentStateType == "dungeon" || StateManager.currentStateType == "dungeonRoom" || StateManager.currentStateType == "matchRoom" || StateManager.currentStateType == "challengeRoom" || StateManager.currentStateType == "login")
            {
               if(BagStore.instance.storeOpenAble)
               {
                  return;
               }
            }
         }
         else if(_loc3_ == 2)
         {
            restCount = -1;
            maxCount = -1;
            isOpen = false;
            if(deleLeaIcon != null)
            {
               deleLeaIcon();
            }
            DdtActivityIconManager.Instance.currObj = null;
         }
         else if(_loc3_ == 3)
         {
            restCount = _loc2_.readInt();
         }
      }
   }
}
