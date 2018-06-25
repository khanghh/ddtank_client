package newYearRice{   import com.pickgliss.ui.core.Component;   import ddt.CoreManager;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.HelperUIModuleLoad;   import flash.display.Bitmap;   import flash.events.Event;   import hallIcon.HallIconManager;   import newYearRice.model.NewYearRiceModel;   import road7th.comm.PackageIn;      public class NewYearRiceManager extends CoreManager   {            private static var _instance:NewYearRiceManager;            public static const NEWYEARRICE_OPENFRAME:String = "newyearrice_openframe";            public static const NEWYEARRICE_INVITE:String = "newyearrice_invite";            public static var IsOpenFrame:Boolean = false;            private static var loadComplete:Boolean = false;            private static var useFirst:Boolean = true;                   private var _model:NewYearRiceModel;            public function NewYearRiceManager(pct:PrivateClass) { super(); }
            public static function get instance() : NewYearRiceManager { return null; }
            public function setup() : void { }
            private function pkgHandler(e:CrazyTankSocketEvent) : void { }
            private function openOrclose(pkg:PackageIn = null) : void { }
            private function yearFoodRoomInvitePlayer(pkg:PackageIn) : void { }
            private function openInviteView() : void { }
            private function onLoadComplete() : void { }
            private function openNewYearRiceView(pkg:PackageIn) : void { }
            override protected function start() : void { }
            private function sendCheckNewYearRiceInfoHandler() : void { }
            private function initOpenFrame() : void { }
            public function showEnterIcon(flag:Boolean) : void { }
            public function returnComponent(cell:Bitmap, tipName:String) : Component { return null; }
            public function get model() : NewYearRiceModel { return null; }
            public function templateDataSetup(dataList:Array) : void { }
   }}class PrivateClass{          function PrivateClass() { super(); }
}