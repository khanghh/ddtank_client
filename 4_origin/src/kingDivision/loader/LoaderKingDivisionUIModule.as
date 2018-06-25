package kingDivision.loader
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.view.UIModuleSmallLoading;
   
   public class LoaderKingDivisionUIModule
   {
      
      private static var _instance:LoaderKingDivisionUIModule;
       
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      public function LoaderKingDivisionUIModule(prc:PrivateClass)
      {
         super();
      }
      
      public static function get Instance() : LoaderKingDivisionUIModule
      {
         if(LoaderKingDivisionUIModule._instance == null)
         {
            LoaderKingDivisionUIModule._instance = new LoaderKingDivisionUIModule(new PrivateClass());
         }
         return LoaderKingDivisionUIModule._instance;
      }
      
      public function loadUIModule(complete:Function = null, completeParams:Array = null) : void
      {
         _func = complete;
         _funcParams = completeParams;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("kingdivision");
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "kingdivision")
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
         if(event.module == "kingdivision")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
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
