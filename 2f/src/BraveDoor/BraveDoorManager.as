package BraveDoor{   import BraveDoor.data.BraveDoorDuplicateInfo;   import com.pickgliss.ui.controls.BaseButton;   import ddt.data.analyze.BraveDoorDuplicateAnalyzer;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.AssetModuleLoader;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import hall.HallStateView;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class BraveDoorManager extends EventDispatcher   {            private static var _instance:BraveDoorManager = null;                   private var _showFlag:Boolean = false;            private var _endDate:Date;            private var _hall:HallStateView = null;            private var _iconBtn:BaseButton = null;            private var _currentPage:int = 0;            private var _isShow:Boolean = false;            private var _duplicates:Vector.<BraveDoorDuplicateInfo>;            private var _clickNum:Number = 0;            public function BraveDoorManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : BraveDoorManager { return null; }
            public function setup() : void { }
            public function initHall(hall:HallStateView) : void { }
            protected function _isOpen(evt:PkgEvent) : void { }
            public function checkIcon() : void { }
            public function openView_Handler() : void { }
            public function show() : void { }
            private function __complainShow() : void { }
            public function setupDuplicateTemplate(infos:BraveDoorDuplicateAnalyzer) : void { }
            public function openView() : void { }
            public function getDuplicateTemInfo() : Vector.<BraveDoorDuplicateInfo> { return null; }
            protected function get duplicateTemplatePath() : String { return null; }
            public function get currentPage() : int { return 0; }
            public function set currentPage(value:int) : void { }
            public function get moduleIsShow() : Boolean { return false; }
            public function set moduleIsShow(value:Boolean) : void { }
   }}