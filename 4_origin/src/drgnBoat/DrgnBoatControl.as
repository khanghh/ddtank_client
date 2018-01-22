package drgnBoat
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.view.UIModuleSmallLoading;
   import drgnBoat.event.DrgnBoatEvent;
   import drgnBoat.views.DrgnBoatFrame;
   import flash.events.EventDispatcher;
   
   public class DrgnBoatControl extends EventDispatcher
   {
      
      private static var _instance:DrgnBoatControl;
       
      
      private var _loadResCount:int;
      
      public function DrgnBoatControl()
      {
         super();
      }
      
      public static function get instance() : DrgnBoatControl
      {
         if(!_instance)
         {
            _instance = new DrgnBoatControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         DrgnBoatManager.instance.addEventListener("drgnBoatOpenView",__onOpenView);
      }
      
      protected function __onOpenView(param1:DrgnBoatEvent) : void
      {
         loadDrgnBoatModule();
      }
      
      private function loadDrgnBoatModule() : void
      {
         _loadResCount = 0;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadFrameCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("drgnBoatframe");
         UIModuleLoader.Instance.addUIModuleImp("drgnBoatgame");
         UIModuleLoader.Instance.addUIModuleImp("ddtroom");
      }
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void
      {
         var _loc2_:Number = NaN;
         if(param1.module == "drgnBoatframe" || param1.module == "drgnBoatgame" || param1.module == "ddtroom")
         {
            _loc2_ = param1.loader.progress;
            _loc2_ = _loc2_ > 0.99?0.99:Number(_loc2_);
            UIModuleSmallLoading.Instance.progress = _loc2_ * 100;
         }
      }
      
      private function loadFrameCompleteHandler(param1:UIModuleEvent) : void
      {
         var _loc2_:* = null;
         if(param1.module == "drgnBoatframe")
         {
            _loadResCount = Number(_loadResCount) + 1;
         }
         if(param1.module == "drgnBoatgame")
         {
            _loadResCount = Number(_loadResCount) + 1;
         }
         if(param1.module == "ddtroom")
         {
            _loadResCount = Number(_loadResCount) + 1;
         }
         if(_loadResCount >= 3)
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadFrameCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.race.drgnBoatFrame");
            LayerManager.Instance.addToLayer(_loc2_,3,true,1);
            UIModuleLoader.Instance.addUIModlue("drgnBoatgame");
            UIModuleLoader.Instance.addUIModlue("drgnBoatframe");
         }
      }
   }
}
