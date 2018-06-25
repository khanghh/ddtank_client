package hall{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PlayerManager;   import flash.display.MovieClip;   import flash.events.EventDispatcher;   import flash.events.TimerEvent;   import flash.utils.Timer;      public class GameLoadingManager extends EventDispatcher   {            private static var _instance:GameLoadingManager;                   private var _loadingMc:MovieClip;            private var _timer:Timer;            public function GameLoadingManager() { super(); }
            public static function get Instance() : GameLoadingManager { return null; }
            public function show() : void { }
            public function createRoomComplete() : void { }
            protected function __onHide(event:TimerEvent) : void { }
            public function hide() : void { }
   }}