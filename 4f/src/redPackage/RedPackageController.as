package redPackage{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.CoreController;   import ddt.events.CEvent;   import ddt.utils.HelperUIModuleLoad;   import redPackage.view.RedPackageConsortiaGainFrame;   import redPackage.view.RedPackageConsortiaGainedRecordFrame;   import redPackage.view.RedPackageConsortiaSelectFrame;   import redPackage.view.RedPackageConsortiaSendFrame;      public class RedPackageController extends CoreController   {            private static var instance:RedPackageController;                   private var _manager:RedPackageManager;            private var _redPkgConsortiaSelectFrame:RedPackageConsortiaSelectFrame;            private var _redPkgConsortiaSendFrame:RedPackageConsortiaSendFrame;            private var _redPkgConsortiaGainFrame:RedPackageConsortiaGainFrame;            private var _redPkgConsortiaGainedRecordFrame:RedPackageConsortiaGainedRecordFrame;            public function RedPackageController(single:inner) { super(); }
            public static function getInstance() : RedPackageController { return null; }
            public function setup() : void { }
            private function onShowHandler(e:CEvent) : void { }
            private function onLoaded() : void { }
            private function onUpdateGainView(e:CEvent) : void { }
            private function onUpdateGainRecordView(e:CEvent) : void { }
            private function onConsortiaGain() : void { }
            private function onConsortiaSend() : void { }
            private function onConsortiaSelect() : void { }
   }}class inner{          function inner() { super(); }
}