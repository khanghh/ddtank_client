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
      
      public function DrgnBoatBuildControl()
      {
         super();
      }
      
      public static function get instance() : DrgnBoatBuildControl
      {
         if(!_instance)
         {
            _instance = new DrgnBoatBuildControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         DrgnBoatBuildManager.instance.addEventListener("drgnBoatOpenView",__onOpenView);
      }
      
      protected function __onOpenView(param1:DrgnBoatBuildEvent) : void
      {
         if(!_frame)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",onSmallLoadingClose);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",createDrgnBoatBuildFrame);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUIProgress);
            UIModuleLoader.Instance.addUIModuleImp("drgnBoatBuild");
         }
         else
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.DrgnBoatBuildFrame");
            LayerManager.Instance.addToLayer(_frame,3,true,1);
         }
      }
      
      protected function onSmallLoadingClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",onSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",createDrgnBoatBuildFrame);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUIProgress);
      }
      
      protected function onUIProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "drgnBoatBuild")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      protected function createDrgnBoatBuildFrame(param1:UIModuleEvent) : void
      {
         if(param1.module != "drgnBoatBuild")
         {
            return;
         }
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",onSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",createDrgnBoatBuildFrame);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUIProgress);
         _frame = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.DrgnBoatBuildFrame");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      public function set frame(param1:DrgnBoatBuildFrame) : void
      {
         _frame = param1;
      }
   }
}
