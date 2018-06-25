package room.model{   import ddt.events.WebSpeedEvent;   import ddt.manager.LanguageMgr;   import flash.events.EventDispatcher;      [Event(name="stateChange",type="tank.view.game.webspeed.WebSpeedEvent")]   public class WebSpeedInfo extends EventDispatcher   {            public static const BEST:String = LanguageMgr.GetTranslation("tank.data.WebSpeedInfo.good");            public static const BETTER:String = LanguageMgr.GetTranslation("tank.data.WebSpeedInfo.find");            public static const WORST:String = LanguageMgr.GetTranslation("tank.data.WebSpeedInfo.bad");                   private var _fps:int;            private var _delay:int;            public function WebSpeedInfo(delay:int) { super(); }
            public function get fps() : int { return 0; }
            public function set fps(value:int) : void { }
            public function get delay() : int { return 0; }
            public function set delay(value:int) : void { }
            public function get stateId() : int { return 0; }
            public function get state() : String { return null; }
   }}