package cloudBuyLottery.loader
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.view.UIModuleSmallLoading;
   
   public class LoaderUIModule
   {
      
      private static var _instance:LoaderUIModule;
       
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      private var _type:String;
      
      public function LoaderUIModule(param1:PrivateClass)
      {
         super();
      }
      
      public static function get Instance() : LoaderUIModule
      {
         if(LoaderUIModule._instance == null)
         {
            LoaderUIModule._instance = new LoaderUIModule(new PrivateClass());
         }
         return LoaderUIModule._instance;
      }
      
      public function loadUIModule(param1:Function = null, param2:Array = null, param3:String = "") : void
      {
         _func = param1;
         _funcParams = param2;
         _type = param3;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp(_type);
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == _type)
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
         if(param1.module == _type)
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
