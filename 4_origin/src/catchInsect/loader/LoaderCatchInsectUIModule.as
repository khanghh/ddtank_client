package catchInsect.loader
{
   import catchInsect.CatchInsectControl;
   import catchInsect.CatchInsectManager;
   import catchInsect.event.InsectEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.controls.Frame;
   import ddt.manager.StateManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   
   public class LoaderCatchInsectUIModule extends Frame
   {
      
      private static var _instance:LoaderCatchInsectUIModule;
       
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      public function LoaderCatchInsectUIModule()
      {
         super();
      }
      
      public static function get Instance() : LoaderCatchInsectUIModule
      {
         if(!_instance)
         {
            _instance = new LoaderCatchInsectUIModule();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         CatchInsectManager.instance.addEventListener("catchInsectOpenView",__onOpenView);
         CatchInsectManager.instance.addEventListener("catchInsectLoadMap",__onLoadMap);
      }
      
      protected function __onOpenView(event:InsectEvent) : void
      {
         var func:* = null;
         if(int(event.data) == 1)
         {
            func = CatchInsectControl.instance.doOpenCatchInsectFrame;
         }
         else
         {
            func = CatchInsectManager.instance.reConnectLoadUiComplete;
         }
         loadUIModule(func);
      }
      
      private function loadUIModule(complete:Function = null, completeParams:Array = null) : void
      {
         _func = complete;
         _funcParams = completeParams;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("catchInsect");
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "catchInsect")
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
         if(event.module == "catchInsect")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      protected function __onLoadMap(event:InsectEvent) : void
      {
         var mapLoader:BaseLoader = LoadResourceManager.Instance.createLoader(CatchInsectManager.instance.mapPath,4);
         mapLoader.addEventListener("complete",onCatchInsectMapSrcLoadedComplete);
         LoadResourceManager.Instance.startLoad(mapLoader);
      }
      
      private function onCatchInsectMapSrcLoadedComplete(e:Event) : void
      {
         if(StateManager.getState("catchInsect") == null)
         {
            UIModuleSmallLoading.Instance.addEventListener("close",__loadingIsCloseRoom);
         }
         StateManager.setState("catchInsect");
      }
      
      private function __loadingIsCloseRoom(e:Event) : void
      {
         UIModuleSmallLoading.Instance.removeEventListener("close",__loadingIsCloseRoom);
      }
      
      public function getMapRes() : String
      {
         return "asset.catchInsect.map";
      }
   }
}
