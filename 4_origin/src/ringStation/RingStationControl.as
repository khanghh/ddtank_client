package ringStation
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import ringStation.view.ArmoryListItem;
   import ringStation.view.RingStationView;
   
   public class RingStationControl extends EventDispatcher
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      public static var challenge:Boolean = false;
      
      private static var _instance:RingStationControl;
       
      
      private var _ringStationView:RingStationView;
      
      public function RingStationControl()
      {
         super();
      }
      
      public static function get instance() : RingStationControl
      {
         if(!_instance)
         {
            _instance = new RingStationControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         RingStationManager.instance.addEventListener("ringStationViewOpen",__onOpenView);
      }
      
      private function __onOpenView(param1:Event) : void
      {
         if(loadComplete)
         {
            showRingStationFrame();
         }
         else if(useFirst)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__complainShow);
            UIModuleLoader.Instance.addUIModuleImp("ringstation");
         }
      }
      
      public function hide() : void
      {
         RingStationManager.instance.RoomType = 0;
         challenge = false;
         if(_ringStationView != null)
         {
            _ringStationView.dispose();
         }
         _ringStationView = null;
      }
      
      private function __complainShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "ringstation")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
            UIModuleSmallLoading.Instance.hide();
            loadComplete = true;
            useFirst = false;
            __onOpenView(null);
         }
      }
      
      private function __progressShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "ringstation")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      protected function __onClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
      }
      
      private function showRingStationFrame() : void
      {
         _ringStationView = ComponentFactory.Instance.creatComponentByStylename("ringStation.RingStationView");
         _ringStationView.show();
      }
   }
}
