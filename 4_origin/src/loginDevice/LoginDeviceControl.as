package loginDevice
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class LoginDeviceControl extends EventDispatcher
   {
      
      private static var _instance:LoginDeviceControl;
       
      
      private var _mainView:LoginDeviceMainFrame;
      
      public function LoginDeviceControl(param1:LoginDeviceInstance)
      {
         super();
      }
      
      public static function instance() : LoginDeviceControl
      {
         if(_instance == null)
         {
            _instance = new LoginDeviceControl(new LoginDeviceInstance());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         LoginDeviceManager.instance().addEventListener("showMainView",__showMainViewHandler);
         LoginDeviceManager.instance().addEventListener("hideMainView",__hideMainViewHandler);
         LoginDeviceManager.instance().addEventListener("reward_view_update",__rewardViewUpdateHandler);
      }
      
      private function __showMainViewHandler(param1:Event) : void
      {
         _mainView = ComponentFactory.Instance.creatComponentByStylename("loginDevice.LoginDeviceMainFrame");
         _mainView.show();
      }
      
      private function __hideMainViewHandler(param1:Event) : void
      {
      }
      
      private function __rewardViewUpdateHandler(param1:LoginDeviceEvent) : void
      {
         if(_mainView)
         {
            _mainView.viewsUpdate();
         }
      }
      
      public function gotoDownDevice() : void
      {
      }
      
      public function getDownReward() : void
      {
         SocketManager.Instance.out.loginDeviceGetDownReward();
      }
      
      public function getDailyReward() : void
      {
         SocketManager.Instance.out.loginDeviceGetDailyReward();
      }
   }
}

class LoginDeviceInstance
{
    
   
   function LoginDeviceInstance()
   {
      super();
   }
}
