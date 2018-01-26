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
      
      public function LoaderKingDivisionUIModule(param1:PrivateClass){super();}
      
      public static function get Instance() : LoaderKingDivisionUIModule{return null;}
      
      public function loadUIModule(param1:Function = null, param2:Array = null) : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
