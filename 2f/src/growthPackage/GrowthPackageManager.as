package growthPackage
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import growthPackage.event.GrowthPackageEvent;
   import growthPackage.model.GrowthPackageModel;
   import growthPackage.view.GrowthPackageFrame;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class GrowthPackageManager extends EventDispatcher
   {
      
      public static var indexMax:int = 9;
      
      private static var _instance:GrowthPackageManager;
       
      
      private var _model:GrowthPackageModel;
      
      private var growthPackageIsOpen:Boolean;
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      public function GrowthPackageManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : GrowthPackageManager{return null;}
      
      public function get model() : GrowthPackageModel{return null;}
      
      public function setup() : void{}
      
      private function initEvent() : void{}
      
      private function __growthPackageHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function updateData(param1:PackageIn) : void{}
      
      private function isOpenHandler(param1:PackageIn) : void{}
      
      public function templateDataSetup(param1:Array) : void{}
      
      private function __iconCloseHandler(param1:GrowthPackageEvent) : void{}
      
      public function showEnterIcon() : void{}
      
      public function disposeEnterIcon() : void{}
      
      public function onClickIcon(param1:MouseEvent) : void{}
      
      private function __dataLoaderCompleteHandler(param1:LoaderEvent) : void{}
      
      public function showBuyFrame() : void{}
      
      private function __onBuyFrameResponse(param1:FrameEvent) : void{}
      
      private function onCompleteHandler() : void{}
      
      public function showFrame() : void{}
      
      public function loadUIModule(param1:Function = null, param2:Array = null) : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
   }
}
