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
      
      protected function __onOpenView(event:DrgnBoatEvent) : void
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
      
      private function onUimoduleLoadProgress(event:UIModuleEvent) : void
      {
         var tmp:Number = NaN;
         if(event.module == "drgnBoatframe" || event.module == "drgnBoatgame" || event.module == "ddtroom")
         {
            tmp = event.loader.progress;
            tmp = tmp > 0.99?0.99:Number(tmp);
            UIModuleSmallLoading.Instance.progress = tmp * 100;
         }
      }
      
      private function loadFrameCompleteHandler(event:UIModuleEvent) : void
      {
         var frame:* = null;
         if(event.module == "drgnBoatframe")
         {
            _loadResCount = Number(_loadResCount) + 1;
         }
         if(event.module == "drgnBoatgame")
         {
            _loadResCount = Number(_loadResCount) + 1;
         }
         if(event.module == "ddtroom")
         {
            _loadResCount = Number(_loadResCount) + 1;
         }
         if(_loadResCount >= 3)
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadFrameCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            frame = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.race.drgnBoatFrame");
            LayerManager.Instance.addToLayer(frame,3,true,1);
            UIModuleLoader.Instance.addUIModlue("drgnBoatgame");
            UIModuleLoader.Instance.addUIModlue("drgnBoatframe");
         }
      }
   }
}
