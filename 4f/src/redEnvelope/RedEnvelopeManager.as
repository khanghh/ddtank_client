package redEnvelope{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.CoreManager;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.utils.HelperUIModuleLoad;   import ddt.view.chat.ChatData;   import hallIcon.HallIconManager;   import redEnvelope.data.RedInfo;   import redEnvelope.model.RedEnvelopeModel;   import redEnvelope.view.RedEnvelopeMainFrame;   import road7th.comm.PackageIn;      public class RedEnvelopeManager extends CoreManager   {            private static var _instance:RedEnvelopeManager;                   public var model:RedEnvelopeModel;            private var _main:RedEnvelopeMainFrame;            public var openFlag:Boolean = true;            public var itemInfoList:Array;            public var checkCanClick:Boolean = true;            public function RedEnvelopeManager() { super(); }
            public static function get instance() : RedEnvelopeManager { return null; }
            public function templateDataSetup(dataList:Array) : void { }
            override protected function start() : void { }
            private function onLoaded() : void { }
            public function setup() : void { }
            public function closeFrame() : void { }
            private function __sendHandler(e:PkgEvent) : void { }
            private function __getRedRecord(e:PkgEvent) : void { }
            private function __onOpenOrClose(e:PkgEvent) : void { }
            private function __onInitData(e:PkgEvent) : void { }
            public function updataEnterIcon(flag:Boolean) : void { }
   }}