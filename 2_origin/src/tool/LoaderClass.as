package tool
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.view.UIModuleSmallLoading;
   import flash.utils.setTimeout;
   
   public class LoaderClass
   {
      
      private static var _instance:LoaderClass;
       
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      private var _type:String;
      
      private var _type1:String;
      
      public function LoaderClass(prc:PrivateClass)
      {
         super();
      }
      
      public static function get Instance() : LoaderClass
      {
         if(LoaderClass._instance == null)
         {
            LoaderClass._instance = new LoaderClass(new PrivateClass());
         }
         return LoaderClass._instance;
      }
      
      public function loadUIModule(complete:Function = null, completeParams:Array = null, types:String = "", types1:String = "") : void
      {
         _func = complete;
         _funcParams = completeParams;
         _type = types;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp(_type);
         loaderTwoUIModule();
         if(types1 != "")
         {
            _type1 = types1;
            setTimeout(daleyTime,2000);
         }
      }
      
      private function loaderTwoUIModule() : void
      {
         if(_type == "magicHouse")
         {
            UIModuleLoader.Instance.addUIModuleImp("ddtbead");
         }
      }
      
      private function daleyTime() : void
      {
         UIModuleLoader.Instance.addUIModuleImp(_type1);
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module != _type)
         {
            return;
         }
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
