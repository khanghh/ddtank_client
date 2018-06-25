package growthPackage{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.view.UIModuleSmallLoading;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.events.MouseEvent;   import growthPackage.event.GrowthPackageEvent;   import growthPackage.model.GrowthPackageModel;   import growthPackage.view.GrowthPackageFrame;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class GrowthPackageManager extends EventDispatcher   {            public static var indexMax:int = 9;            private static var _instance:GrowthPackageManager;                   private var _model:GrowthPackageModel;            private var growthPackageIsOpen:Boolean;            private var _func:Function;            private var _funcParams:Array;            public function GrowthPackageManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : GrowthPackageManager { return null; }
            public function get model() : GrowthPackageModel { return null; }
            public function setup() : void { }
            private function initEvent() : void { }
            private function __growthPackageHandler(event:CrazyTankSocketEvent) : void { }
            private function updateData(pkg:PackageIn) : void { }
            private function isOpenHandler(pkg:PackageIn) : void { }
            public function templateDataSetup(dataList:Array) : void { }
            private function __iconCloseHandler(evt:GrowthPackageEvent) : void { }
            public function showEnterIcon() : void { }
            public function disposeEnterIcon() : void { }
            public function onClickIcon(e:MouseEvent) : void { }
            private function __dataLoaderCompleteHandler(event:LoaderEvent) : void { }
            public function showBuyFrame() : void { }
            private function __onBuyFrameResponse(evt:FrameEvent) : void { }
            private function onCompleteHandler() : void { }
            public function showFrame() : void { }
            public function loadUIModule(complete:Function = null, completeParams:Array = null) : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
   }}