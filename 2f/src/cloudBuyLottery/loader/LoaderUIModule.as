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
      
      public function LoaderUIModule(param1:PrivateClass){super();}
      
      public static function get Instance() : LoaderUIModule{return null;}
      
      public function loadUIModule(param1:Function = null, param2:Array = null, param3:String = "") : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
