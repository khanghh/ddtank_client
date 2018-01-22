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
      
      public function LoaderClass(param1:PrivateClass)
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
      
      public function loadUIModule(param1:Function = null, param2:Array = null, param3:String = "", param4:String = "") : void
      {
         _func = param1;
         _funcParams = param2;
         _type = param3;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp(_type);
         loaderTwoUIModule();
         if(param4 != "")
         {
            _type1 = param4;
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
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module != _type)
         {
            return;
         }
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
