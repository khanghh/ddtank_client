package setting
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.CEvent;
   import ddt.manager.SharedManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import setting.controll.SettingController;
   import setting.view.SettingView;
   
   public class SettingControl
   {
      
      private static var _instance:SettingControl;
       
      
      private var _settingView:SettingView;
      
      public function SettingControl()
      {
         super();
      }
      
      public static function get instance() : SettingControl
      {
         if(_instance == null)
         {
            _instance = new SettingControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SettingController.Instance.addEventListener("openview",__onOpenView);
         SettingController.Instance.addEventListener("closeview",__onCloseView);
      }
      
      private function __onOpenView(param1:CEvent) : void
      {
         new HelperUIModuleLoad().loadUIModule(["ddtsetting"],loadComplete);
      }
      
      private function loadComplete() : void
      {
         SettingController.Instance.isShow = true;
         if(!_settingView)
         {
            _settingView = ComponentFactory.Instance.creat("ddtsetting.MainFrame");
            _settingView.setShowSettingMovie();
            _settingView.addEventListener("response",__responseHandler);
            SharedManager.Instance.isSetingMovieClip = false;
            SharedManager.Instance.save();
         }
         if(!_settingView.hasEventListener("removedFromStage"))
         {
            _settingView.addEventListener("removedFromStage",onViewRemove);
         }
         LayerManager.Instance.addToLayer(_settingView,3,false,2);
      }
      
      protected function onViewRemove(param1:Event) : void
      {
         if(_settingView)
         {
            _settingView.removeEventListener("removedFromStage",onViewRemove);
         }
         _settingView = null;
      }
      
      private function __onCloseView(param1:CEvent) : void
      {
         hide();
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _settingView.doCancel();
               hide();
               break;
            case 2:
            case 3:
            case 4:
               _settingView.doConfirm();
               hide();
         }
      }
      
      public function hide() : void
      {
         SettingController.Instance.isShow = false;
         if(_settingView)
         {
            _settingView.removeEventListener("response",__responseHandler);
            _settingView.dispose();
         }
         _settingView = null;
      }
   }
}
