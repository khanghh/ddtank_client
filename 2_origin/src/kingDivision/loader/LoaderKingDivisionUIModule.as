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
      
      public function LoaderKingDivisionUIModule(param1:PrivateClass)
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
      
      public function loadUIModule(param1:Function = null, param2:Array = null) : void
      {
         _func = param1;
         _funcParams = param2;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("kingdivision");
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "kingdivision")
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
         if(param1.module == "kingdivision")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
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
