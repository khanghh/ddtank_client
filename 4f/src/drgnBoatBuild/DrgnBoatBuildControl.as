package drgnBoatBuild
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.view.UIModuleSmallLoading;
   import drgnBoatBuild.components.DrgnBoatBuildListCell;
   import drgnBoatBuild.event.DrgnBoatBuildEvent;
   import drgnBoatBuild.views.DrgnBoatBuildFrame;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class DrgnBoatBuildControl extends EventDispatcher
   {
      
      private static var _instance:DrgnBoatBuildControl;
       
      
      private var _frame:DrgnBoatBuildFrame;
      
      public function DrgnBoatBuildControl(){super();}
      
      public static function get instance() : DrgnBoatBuildControl{return null;}
      
      public function setup() : void{}
      
      protected function __onOpenView(param1:DrgnBoatBuildEvent) : void{}
      
      protected function onSmallLoadingClose(param1:Event) : void{}
      
      protected function onUIProgress(param1:UIModuleEvent) : void{}
      
      protected function createDrgnBoatBuildFrame(param1:UIModuleEvent) : void{}
      
      public function set frame(param1:DrgnBoatBuildFrame) : void{}
   }
}
