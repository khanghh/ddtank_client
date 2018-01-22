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
      
      public function LoaderChristmasUIModule(param1:PrivateClass)
      {
         super();
      }
      
      public static function get Instance() : LoaderChristmasUIModule
      {
         if(LoaderChristmasUIModule._instance == null)
         {
            LoaderChristmasUIModule._instance = new LoaderChristmasUIModule(new PrivateClass());
         }
         return LoaderChristmasUIModule._instance;
      }
      
      public function loadUIModule(param1:Function = null, param2:Array = null) : void
      {
         _func = param1;
         _funcParams = param2;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("christmas");
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "christmas")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            if(null != _func)
            {
               _func.apply(null,_funcParams);
            }
            _func = null;
            _funcParams = null;
         }
      }
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "christmas")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      public function loadMap() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(ChristmasCoreController.instance.mapPath,4);
         _loc1_.addEventListener("complete",onChristmasMapSrcLoadedComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function onChristmasMapSrcLoadedComplete(param1:Event) : void
      {
         if(StateManager.getState("christmasroom") == null)
         {
            UIModuleSmallLoading.Instance.addEventListener("close",__loadingIsCloseRoom);
         }
         StateManager.setState("christmasroom");
      }
      
      private function __loadingIsCloseRoom(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.removeEventListener("close",__loadingIsCloseRoom);
      }
      
      public function getChristmasResource() : String
      {
         return PathManager.SITE_MAIN + "image/scene/christmas/";
      }
      
      public function getMapRes() : String
      {
         return "tank.christmas.Map";
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
