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
      
      public function RingStationControl(){super();}
      
      public static function get instance() : RingStationControl{return null;}
      
      public function setup() : void{}
      
      private function __onOpenView(param1:Event) : void{}
      
      public function hide() : void{}
      
      private function __complainShow(param1:UIModuleEvent) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function showRingStationFrame() : void{}
   }
}
