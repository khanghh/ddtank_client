package toyMachine
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import toyMachine.view.ToyMachineFrame;
   
   public class ToyMachineManager extends EventDispatcher
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      private static var _instance:ToyMachineManager;
       
      
      private var _toyMachineFrame:ToyMachineFrame;
      
      public function ToyMachineManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : ToyMachineManager
      {
         if(!_instance)
         {
            _instance = new ToyMachineManager();
         }
         return _instance;
      }
      
      public function show() : void
      {
         if(loadComplete)
         {
            showToyFrame();
         }
         else if(useFirst)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__complainShow);
            UIModuleLoader.Instance.addUIModuleImp("toyMachine");
         }
      }
      
      private function __complainShow(event:UIModuleEvent) : void
      {
         if(event.module == "toyMachine")
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
      
      private function __progressShow(event:UIModuleEvent) : void
      {
         if(event.module == "toyMachine")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      protected function __onClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
      }
      
      private function showToyFrame() : void
      {
         _toyMachineFrame = ComponentFactory.Instance.creatComponentByStylename("toyMachine.toyMachineFrame");
         LayerManager.Instance.addToLayer(_toyMachineFrame,2,true,1);
      }
      
      public function hide() : void
      {
         if(_toyMachineFrame != null)
         {
            _toyMachineFrame.dispose();
            _toyMachineFrame = null;
         }
      }
   }
}
