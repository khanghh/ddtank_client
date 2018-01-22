package chickActivation
{
   import chickActivation.model.ChickActivationModel;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class ChickActivationManager extends EventDispatcher
   {
      
      private static var _instance:ChickActivationManager;
      
      public static const CHICKACTIVATION_SHOWFRAME:String = "ChickActivationShowFrame";
       
      
      private var _model:ChickActivationModel;
      
      public function ChickActivationManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : ChickActivationManager{return null;}
      
      public function get model() : ChickActivationModel{return null;}
      
      public function setup() : void{}
      
      private function initData() : void{}
      
      private function __chickActivationHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function loginDataUpdate(param1:PackageIn) : void{}
      
      private function dataUpdate(param1:PackageIn) : void{}
      
      public function templateDataSetup(param1:Array) : void{}
      
      public function checkShowIcon() : void{}
      
      public function showFrame() : void{}
      
      private function __dataLoaderCompleteHandler(param1:LoaderEvent) : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
   }
}
