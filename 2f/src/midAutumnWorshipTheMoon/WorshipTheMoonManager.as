package midAutumnWorshipTheMoon{   import com.pickgliss.utils.ObjectUtils;   import ddt.CoreManager;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.HelperUIModuleLoad;   import flash.utils.ByteArray;   import hall.HallStateView;   import hallIcon.HallIconManager;   import midAutumnWorshipTheMoon.model.WorshipTheMoonAwardsBoxInfo;   import midAutumnWorshipTheMoon.model.WorshipTheMoonModel;   import midAutumnWorshipTheMoon.view.WorshipTheMoonEnterButton;      public class WorshipTheMoonManager extends CoreManager   {            public static const SHOW_FRAME:String = "wship_show";            public static const HIDE:String = "wship_hide";            public static const DISPOSE_FRAME:String = "wship_dispose_frame";            public static const DISPOSE:String = "wship_dispose";            private static var instance:WorshipTheMoonManager;                   private var _showFrameBtn:WorshipTheMoonEnterButton;            private var _hall:HallStateView;            public var _isOpen:Boolean = false;            public var showBuyCountFram:Boolean = true;            public var dataTime:String = "";            public var dataEndTime:String = "";            public function WorshipTheMoonManager(single:inner) { super(); }
            public static function getInstance() : WorshipTheMoonManager { return null; }
            override protected function start() : void { }
            public function init(hall:HallStateView = null) : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            protected function onResultIsActivityOpen(e:PkgEvent) : void { }
            public function worshipTheMoonIcon(flag:Boolean) : void { }
            public function showFrame() : void { }
            private function onLoaded() : void { }
            protected function onResultAwardsList(e:PkgEvent) : void { }
            protected function onResultFreeCounts(e:PkgEvent) : void { }
            protected function onResultWorshipTheMoon(e:PkgEvent) : void { }
            public function requireFreeCount() : void { }
            public function requireAwardsList() : void { }
            public function requireWorshipTheMoon(counts:int) : void { }
            public function requireWorship200AwardBox() : void { }
            public function hide() : void { }
            public function disposeMainFrame() : void { }
            public function dispose() : void { }
   }}class inner{          function inner() { super(); }
}