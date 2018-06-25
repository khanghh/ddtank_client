package DDPlay{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.SocketManager;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class DDPlayManaer extends EventDispatcher   {            public static const UPDATE_SCORE:String = "update_score";            private static var loadComplete:Boolean = false;            private static var useFirst:Boolean = true;            private static var _instance:DDPlayManaer;                   public var isOpen:Boolean;            public var DDPlayScore:int;            public var DDPlayMoney:int;            public var exchangeFold:int;            public var beginDate:Date;            public var endDate:Date;            private var _ddPlayView:DDPlayView;            public function DDPlayManaer(ddplay:DDPlayInstance, target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : DDPlayManaer { return null; }
            public function setup() : void { }
            private function initEvent() : void { }
            protected function __addDDPlayBtn(event:CrazyTankSocketEvent) : void { }
            private function openOrClose(pkg:PackageIn) : void { }
            public function createDDPlayBtn() : void { }
            public function deleteDDPlayBtn() : void { }
            public function show() : void { }
            protected function __onClose(event:Event) : void { }
            private function __progressShow(event:UIModuleEvent) : void { }
            private function __complainShow(event:UIModuleEvent) : void { }
            private function showDDPlayView() : void { }
   }}class DDPlayInstance{          function DDPlayInstance() { super(); }
}