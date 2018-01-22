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
      
      public function LoaderGuildMemberWeekUIModule(param1:PrivateClass){super();}
      
      public static function get Instance() : LoaderGuildMemberWeekUIModule{return null;}
      
      public function loadUIModule(param1:Function = null, param2:Array = null) : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
