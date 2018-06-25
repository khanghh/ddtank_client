package goldmine{   import com.pickgliss.ui.controls.BaseButton;   import ddt.CoreManager;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.utils.HelperUIModuleLoad;   import flash.events.IEventDispatcher;   import goldmine.model.GoldmineModel;   import hall.IHallStateView;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class GoldmineManager extends CoreManager   {            public static const SHOW_VIEW:String = "goldmine_showview";            public static const ClOSE_VIEW:String = "goldmine_closeview";            public static const USE_GOLDMINE:String = "goldmine_use";            private static var _instance:GoldmineManager;                   private var _isOpen:Boolean = false;            private var _icon:BaseButton;            private var _hall:IHallStateView;            private var _dateStart:Date;            private var _dateEnd:Date;            private var _model:GoldmineModel;            public function GoldmineManager(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : GoldmineManager { return null; }
            public function get dateStart() : Date { return null; }
            public function get dateEnd() : Date { return null; }
            public function get model() : GoldmineModel { return null; }
            public function setup() : void { }
            private function initEvent() : void { }
            private function __onIsOpen(e:PkgEvent) : void { }
            private function __onInit(e:PkgEvent) : void { }
            private function __onUse(e:PkgEvent) : void { }
            public function testUse(gold:int = 8666) : void { }
            public function updataEnterIcon(flag:Boolean) : void { }
            override protected function start() : void { }
   }}