package chickActivation{   import chickActivation.model.ChickActivationModel;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.loader.UIModuleLoader;   import ddt.events.CrazyTankSocketEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.utils.Dictionary;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class ChickActivationManager extends EventDispatcher   {            private static var _instance:ChickActivationManager;            public static const CHICKACTIVATION_SHOWFRAME:String = "ChickActivationShowFrame";                   private var _model:ChickActivationModel;            public function ChickActivationManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : ChickActivationManager { return null; }
            public function get model() : ChickActivationModel { return null; }
            public function setup() : void { }
            private function initData() : void { }
            private function __chickActivationHandler(event:CrazyTankSocketEvent) : void { }
            private function loginDataUpdate(pkg:PackageIn) : void { }
            private function dataUpdate(pkg:PackageIn) : void { }
            public function templateDataSetup(dataList:Array) : void { }
            public function checkShowIcon() : void { }
            public function showFrame() : void { }
            private function __dataLoaderCompleteHandler(event:LoaderEvent) : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
   }}