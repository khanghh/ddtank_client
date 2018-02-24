package catchInsect.loader
{
   import catchInsect.CatchInsectControl;
   import catchInsect.CatchInsectManager;
   import catchInsect.event.InsectEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.controls.Frame;
   import ddt.manager.StateManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   
   public class LoaderCatchInsectUIModule extends Frame
   {
      
      private static var _instance:LoaderCatchInsectUIModule;
       
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      public function LoaderCatchInsectUIModule(){super();}
      
      public static function get Instance() : LoaderCatchInsectUIModule{return null;}
      
      public function setup() : void{}
      
      protected function __onOpenView(param1:InsectEvent) : void{}
      
      private function loadUIModule(param1:Function = null, param2:Array = null) : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
      
      protected function __onLoadMap(param1:InsectEvent) : void{}
      
      private function onCatchInsectMapSrcLoadedComplete(param1:Event) : void{}
      
      private function __loadingIsCloseRoom(param1:Event) : void{}
      
      public function getMapRes() : String{return null;}
   }
}
