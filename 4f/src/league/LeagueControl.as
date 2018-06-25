package league{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.manager.SocketManager;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import league.view.LeagueShopFrame;   import league.view.LeagueStartNoticeView;      public class LeagueControl extends EventDispatcher   {            private static var _instance:LeagueControl;                   public var militaryRank:int = -1;            private var _func:Function;            private var _funcParams:Array;            private var _lsnView:LeagueStartNoticeView;            public function LeagueControl(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : LeagueControl { return null; }
            public function setup() : void { }
            protected function __onOpenView(event:Event) : void { }
            private function doShowLeagueShopFrame() : void { }
            private function loadLeagueModule(complete:Function = null, completeParams:Array = null) : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
   }}