package christmas.loader
{
   import christmas.ChristmasCoreController;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.controls.Frame;
   import ddt.manager.PathManager;
   import ddt.manager.StateManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   
   public class LoaderChristmasUIModule extends Frame
   {
      
      private static var _instance:LoaderChristmasUIModule;
       
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      public function LoaderChristmasUIModule(param1:PrivateClass){super();}
      
      public static function get Instance() : LoaderChristmasUIModule{return null;}
      
      public function loadUIModule(param1:Function = null, param2:Array = null) : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
      
      public function loadMap() : void{}
      
      private function onChristmasMapSrcLoadedComplete(param1:Event) : void{}
      
      private function __loadingIsCloseRoom(param1:Event) : void{}
      
      public function getChristmasResource() : String{return null;}
      
      public function getMapRes() : String{return null;}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
