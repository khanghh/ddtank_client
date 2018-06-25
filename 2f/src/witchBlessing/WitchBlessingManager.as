package witchBlessing{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.SocketManager;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;   import witchBlessing.data.WitchBlessingModel;      public class WitchBlessingManager extends EventDispatcher   {            private static var _instance:WitchBlessingManager;            public static const WITCHBLESSING_SHOWFRAME:String = "witchblessingshowframe";            public static const WITCHBLESSING_HIDE:String = "witchblessinghide";            public static var loadComplete:Boolean = false;                   private var _model:WitchBlessingModel;            public function WitchBlessingManager(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : WitchBlessingManager { return null; }
            public function setup() : void { }
            public function get model() : WitchBlessingModel { return null; }
            public function isOpen() : Boolean { return false; }
            public function templateDataSetup(dataList:Array) : void { }
            private function __witchBlessingHandle(e:CrazyTankSocketEvent) : void { }
            private function enterView(pkg:PackageIn) : void { }
            public function testEnter() : void { }
            public function isOpenIcon(pkg:PackageIn) : void { }
            public function onClickIcon() : void { }
            private function showMainView() : void { }
            protected function __onClose(event:Event) : void { }
            private function __progressShow(event:UIModuleEvent) : void { }
            private function __completeShow(event:UIModuleEvent) : void { }
            public function hide() : void { }
   }}