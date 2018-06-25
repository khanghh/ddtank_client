package loginDevice{   import com.pickgliss.ui.ComponentFactory;   import ddt.manager.PathManager;   import ddt.manager.SocketManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.net.URLRequest;   import flash.net.navigateToURL;      public class LoginDeviceControl extends EventDispatcher   {            private static var _instance:LoginDeviceControl;                   private var _mainView:LoginDeviceMainFrame;            public function LoginDeviceControl(instance:LoginDeviceInstance) { super(); }
            public static function instance() : LoginDeviceControl { return null; }
            public function setup() : void { }
            private function __showMainViewHandler(e:Event) : void { }
            private function __hideMainViewHandler(e:Event) : void { }
            private function __rewardViewUpdateHandler(e:LoginDeviceEvent) : void { }
            public function gotoDownDevice() : void { }
            public function getDownReward() : void { }
            public function getDailyReward() : void { }
   }}class LoginDeviceInstance{          function LoginDeviceInstance() { super(); }
}