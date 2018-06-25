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
      
      public function LoaderUIModule(prc:PrivateClass)
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
      
      public function loadUIModule(complete:Function = null, completeParams:Array = null, types:String = "") : void
      {
         _func = complete;
         _funcParams = completeParams;
         _type = types;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp(_type);
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == _type)
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
         if(event.module == _type)
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
