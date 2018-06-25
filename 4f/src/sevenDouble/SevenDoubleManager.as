package sevenDouble{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.loader.UIModuleLoader;   import ddt.CoreManager;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.PathManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelperUIModuleLoad;   import flash.events.Event;   import flash.events.IEventDispatcher;   import road7th.comm.PackageIn;      public class SevenDoubleManager extends CoreManager   {            public static const SHOW_FRAME:String = "showFrame";            public static const END:String = "sevenDoubleEnd";            public static const ICON_RES_LOAD_COMPLETE:String = "sevenDoubleIconResLoadComplete";            public static const CAN_ENTER:String = "sevenDoubleCanEnter";            public static const LEAVEMAINVIEW:String = "leaveMainView";            private static var _instance:SevenDoubleManager;                   public var pkgs:Object;            public var isShowDungeonTip:Boolean = true;            private var _isStart:Boolean;            private var _isLoadIconComplete:Boolean;            private var _isInGame:Boolean;            public function SevenDoubleManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : SevenDoubleManager { return null; }
            public function get isInGame() : Boolean { return false; }
            public function set isInGame(value:Boolean) : void { }
            public function get isStart() : Boolean { return false; }
            public function get isLoadIconComplete() : Boolean { return false; }
            public function setup() : void { }
            private function pkgHandler(event:CrazyTankSocketEvent) : void { }
            private function canEnterHandler(pkg:PackageIn) : void { }
            private function openOrCloseHandler(pkg:PackageIn) : void { }
            public function enterMainViewHandler() : void { }
            public function leaveMainViewHandler() : void { }
            public function loadIcon() : void { }
            private function loadIconCompleteHandler(event:UIModuleEvent) : void { }
            override protected function start() : void { }
            private function onLoaded() : void { }
            public function getPlayerResUrl(isSelf:Boolean, carType:int) : String { return null; }
            public function loadSound() : void { }
            private function loadSoundCompleteHandler(event:LoaderEvent) : void { }
   }}