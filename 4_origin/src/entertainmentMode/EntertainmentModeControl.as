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
      
      public function EntertainmentModeControl()
      {
         super();
      }
      
      public static function get instance() : EntertainmentModeControl
      {
         if(!_instance)
         {
            _instance = new EntertainmentModeControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         EntertainmentModeManager.instance.addEventListener("showMainView",__showHandler);
         EntertainmentModeManager.instance.addEventListener("hideMainView",__hideHandler);
      }
      
      private function __showHandler(e:Event) : void
      {
         _frameView = ComponentFactory.Instance.creatComponentByStylename("entertainment.EntertainmentModeView");
         SocketManager.Instance.out.sendSceneLogin(8);
         _frameView.show();
      }
      
      public function __hideHandler(e:Event) : void
      {
         if(_frameView != null)
         {
            _frameView.dispose();
         }
         _frameView = null;
      }
   }
}
