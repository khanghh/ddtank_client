package escort{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import ddt.CoreManager;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.PathManager;   import ddt.manager.SoundManager;   import ddt.utils.HelperUIModuleLoad;   import flash.events.Event;   import road7th.comm.PackageIn;      public class EscortManager extends CoreManager   {            public static const END:String = "escortEnd";            public static const SHOW_FRAME:String = "show_frame";            public static const ICON_RES_LOAD_COMPLETE:String = "escortIconResLoadComplete";            public static const CANCEL_GAME:String = "escortCancelGame";            public static const CAN_ENTER:String = "escortCanEnter";            public static const LEAVEMAINVIEW:String = "leaveMainView";            private static var _instance:EscortManager;                   public var pkgs:Object;            public var isShowDungeonTip:Boolean = true;            private var _isStart:Boolean;            private var _isInGame:Boolean;            private var _isLoadIconComplete:Boolean;            public function EscortManager() { super(); }
            public static function get instance() : EscortManager { return null; }
            public function get isStart() : Boolean { return false; }
            public function get isLoadIconComplete() : Boolean { return false; }
            public function setup() : void { }
            private function pkgHandler(event:CrazyTankSocketEvent) : void { }
            private function openOrCloseHandler(pkg:PackageIn) : void { }
            private function canEnterHandler(pkg:PackageIn) : void { }
            public function enterMainViewHandler() : void { }
            public function leaveMainViewHandler() : void { }
            public function get isInGame() : Boolean { return false; }
            public function set isInGame(value:Boolean) : void { }
            override protected function start() : void { }
            private function onLoaded() : void { }
            public function getPlayerResUrl(isSelf:Boolean, carType:int) : String { return null; }
            public function loadSound() : void { }
            private function loadSoundCompleteHandler(event:LoaderEvent) : void { }
   }}