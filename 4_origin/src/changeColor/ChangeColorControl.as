package changeColor
{
   import changeColor.view.ChangeColorFrame;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChangeColorManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   
   public class ChangeColorControl
   {
      
      private static var _instance:ChangeColorControl;
       
      
      private var _changeColorFrame:ChangeColorFrame;
      
      public function ChangeColorControl()
      {
         super();
      }
      
      public static function get instance() : ChangeColorControl
      {
         if(!_instance)
         {
            _instance = new ChangeColorControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         ChangeColorManager.instance.addEventListener(ChangeColorManager.CHAGNECOLOR_OPENVIEW,__onOpenView);
      }
      
      private function __onOpenView(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__changeColorProgress);
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__changeColorComplete);
         UIModuleLoader.Instance.addUIModuleImp("changecolor");
      }
      
      private function __onClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__changeColorProgress);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__changeColorComplete);
      }
      
      private function __changeColorProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "changecolor")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function __changeColorComplete(param1:UIModuleEvent) : void
      {
         if(param1.module == "changecolor")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__changeColorProgress);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__changeColorComplete);
            UIModuleSmallLoading.Instance.hide();
            show();
         }
      }
      
      public function show() : void
      {
         if(!_changeColorFrame)
         {
            _changeColorFrame = ComponentFactory.Instance.creatComponentByStylename("changeColor.ChangeColorFrame");
            _changeColorFrame.moveEnable = false;
            _changeColorFrame.show();
            if(ChangeColorManager.instance.isOneThing)
            {
               _changeColorFrame.setFirstItemSelected();
               ChangeColorManager.instance.isOneThing = false;
            }
         }
      }
      
      public function close() : void
      {
         if(_changeColorFrame)
         {
            ObjectUtils.disposeObject(_changeColorFrame);
            _changeColorFrame = null;
         }
      }
   }
}
