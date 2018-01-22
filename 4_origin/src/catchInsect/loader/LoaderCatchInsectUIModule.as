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
      
      protected function __onOpenView(param1:InsectEvent) : void
      {
         var _loc2_:* = null;
         if(int(param1.data) == 1)
         {
            _loc2_ = CatchInsectControl.instance.doOpenCatchInsectFrame;
         }
         else
         {
            _loc2_ = CatchInsectManager.instance.reConnectLoadUiComplete;
         }
         loadUIModule(_loc2_);
      }
      
      private function loadUIModule(param1:Function = null, param2:Array = null) : void
      {
         _func = param1;
         _funcParams = param2;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("catchInsect");
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "catchInsect")
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
         if(param1.module == "catchInsect")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      protected function __onLoadMap(param1:InsectEvent) : void
      {
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(CatchInsectManager.instance.mapPath,4);
         _loc2_.addEventListener("complete",onCatchInsectMapSrcLoadedComplete);
         LoadResourceManager.Instance.startLoad(_loc2_);
      }
      
      private function onCatchInsectMapSrcLoadedComplete(param1:Event) : void
      {
         if(StateManager.getState("catchInsect") == null)
         {
            UIModuleSmallLoading.Instance.addEventListener("close",__loadingIsCloseRoom);
         }
         StateManager.setState("catchInsect");
      }
      
      private function __loadingIsCloseRoom(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.removeEventListener("close",__loadingIsCloseRoom);
      }
      
      public function getMapRes() : String
      {
         return "asset.catchInsect.map";
      }
   }
}
