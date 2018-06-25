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
      
      public function LoaderChristmasUIModule(pct:PrivateClass)
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
      
      public function loadUIModule(complete:Function = null, completeParams:Array = null) : void
      {
         _func = complete;
         _funcParams = completeParams;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("christmas");
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "christmas")
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
      
      private function onUimoduleLoadProgress(event:UIModuleEvent) : void
      {
         if(event.module == "christmas")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      public function loadMap() : void
      {
         var mapLoader:BaseLoader = LoadResourceManager.Instance.createLoader(ChristmasCoreController.instance.mapPath,4);
         mapLoader.addEventListener("complete",onChristmasMapSrcLoadedComplete);
         LoadResourceManager.Instance.startLoad(mapLoader);
      }
      
      private function onChristmasMapSrcLoadedComplete(e:Event) : void
      {
         if(StateManager.getState("christmasroom") == null)
         {
            UIModuleSmallLoading.Instance.addEventListener("close",__loadingIsCloseRoom);
         }
         StateManager.setState("christmasroom");
      }
      
      private function __loadingIsCloseRoom(e:Event) : void
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
