package guildMemberWeek.loader
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.controls.Frame;
   import ddt.view.UIModuleSmallLoading;
   
   public class LoaderGuildMemberWeekUIModule extends Frame
   {
      
      private static var _instance:LoaderGuildMemberWeekUIModule;
       
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      private var _LoadResourseOK:Boolean = false;
      
      public function LoaderGuildMemberWeekUIModule(pct:PrivateClass)
      {
         super();
      }
      
      public static function get Instance() : LoaderGuildMemberWeekUIModule
      {
         if(LoaderGuildMemberWeekUIModule._instance == null)
         {
            LoaderGuildMemberWeekUIModule._instance = new LoaderGuildMemberWeekUIModule(new PrivateClass());
         }
         return LoaderGuildMemberWeekUIModule._instance;
      }
      
      public function loadUIModule(complete:Function = null, completeParams:Array = null) : void
      {
         _func = complete;
         _funcParams = completeParams;
         if(!_LoadResourseOK)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            UIModuleLoader.Instance.addUIModuleImp("guildMemberWeek");
         }
         else
         {
            if(null != _func)
            {
               _func.apply(null,_funcParams);
            }
            _func = null;
            _funcParams = null;
         }
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         _LoadResourseOK = true;
         if(event.module == "guildMemberWeek")
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
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
