package entertainmentMode
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.SocketManager;
   import entertainmentMode.view.EntertainmentModeView;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class EntertainmentModeControl extends EventDispatcher
   {
      
      private static var _instance:EntertainmentModeControl;
       
      
      private var _frameView:EntertainmentModeView;
      
      public function EntertainmentModeControl(){super();}
      
      public static function get instance() : EntertainmentModeControl{return null;}
      
      public function setup() : void{}
      
      private function __showHandler(param1:Event) : void{}
      
      public function __hideHandler(param1:Event) : void{}
   }
}
