package lanternriddles
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import lanternriddles.event.LanternEvent;
   import lanternriddles.view.LanternRiddlesView;
   
   public class LanternRiddlesControl extends EventDispatcher
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      private static var _instance:LanternRiddlesControl;
       
      
      private var _lanternView:LanternRiddlesView;
      
      public function LanternRiddlesControl()
      {
         super();
      }
      
      public static function get instance() : LanternRiddlesControl
      {
         if(!_instance)
         {
            _instance = new LanternRiddlesControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         LanternRiddlesManager.instance.addEventListener("lanternOpenView",__onOpenView);
      }
      
      protected function __onOpenView(param1:LanternEvent) : void
      {
         show();
      }
      
      public function show() : void
      {
         if(!LanternRiddlesManager.instance.isBegin)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("lanternRiddles.view.activityExpired"));
            return;
         }
         if(loadComplete)
         {
            showLanternFrame();
         }
         else if(useFirst)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__complainShow);
            UIModuleLoader.Instance.addUIModuleImp("lanternriddles");
         }
      }
      
      public function hide() : void
      {
         dispose();
      }
      
      private function dispose() : void
      {
         removeEvent();
         if(_lanternView != null)
         {
            _lanternView.dispose();
            _lanternView = null;
         }
      }
      
      private function removeEvent() : void
      {
      }
      
      private function __complainShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "lanternriddles")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
            UIModuleSmallLoading.Instance.hide();
            loadComplete = true;
            useFirst = false;
            show();
         }
      }
      
      private function __progressShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "lanternriddles")
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
      
      private function showLanternFrame() : void
      {
         _lanternView = ComponentFactory.Instance.creatComponentByStylename("view.LanternRiddlesView");
         _lanternView.show();
      }
   }
}
