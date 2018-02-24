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
      
      public function LoaderClass(param1:PrivateClass){super();}
      
      public static function get Instance() : LoaderClass{return null;}
      
      public function loadUIModule(param1:Function = null, param2:Array = null, param3:String = "", param4:String = "") : void{}
      
      private function loaderTwoUIModule() : void{}
      
      private function daleyTime() : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
