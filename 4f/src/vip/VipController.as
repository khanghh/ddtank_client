package vip{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.GradientText;   import ddt.data.player.SelfInfo;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.AssetModuleLoader;   import flash.events.EventDispatcher;   import vip.data.VipModelInfo;   import vip.view.RechargeAlertTxt;   import vip.view.VIPHelpFrame;   import vip.view.VIPRechargeAlertFrame;   import vip.view.VipFrame;   import vip.view.VipViewFrame;      public class VipController extends EventDispatcher   {            private static var _instance:VipController;                   public var info:VipModelInfo;            public var isRechargePoped:Boolean;            private var _vipFrame:VipFrame;            private var _vipViewFrame:VipViewFrame;            private var _isShow:Boolean;            private var _helpframe:VIPHelpFrame;            private var _rechargeAlertFrame:VIPRechargeAlertFrame;            private var _rechargeAlertLoad:Boolean = false;            public function VipController() { super(); }
            public static function get instance() : VipController { return null; }
            public function show() : void { }
            private function showVipFrame() : void { }
            public function showRechargeAlert() : void { }
            public function helpframeNull() : void { }
            protected function __responseHandler(event:FrameEvent) : void { }
            protected function __responseRechargeAlertHandler(event:FrameEvent) : void { }
            public function sendOpenVip(name:String, days:int, bool:Boolean = true) : void { }
            public function hide() : void { }
            public function getVipNameTxt($width:int = -1, typeVIP:int = 1) : GradientText { return null; }
            public function getVIPStrengthenEx(level:int) : Number { return 0; }
   }}