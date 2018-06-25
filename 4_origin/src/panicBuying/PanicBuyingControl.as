package panicBuying
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import panicBuying.event.PanicBuyingEvent;
   import panicBuying.views.PanicBuyingFrame;
   
   public class PanicBuyingControl
   {
      
      private static var _instance:PanicBuyingControl;
       
      
      private var _frame:PanicBuyingFrame;
      
      public function PanicBuyingControl()
      {
         super();
      }
      
      public static function get instance() : PanicBuyingControl
      {
         if(!_instance)
         {
            _instance = new PanicBuyingControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         PanicBuyingManager.instance.addEventListener("panicBuyingOpenView",__panicBuyingOpenView);
         PanicBuyingManager.instance.addEventListener("updateView",__updateView);
      }
      
      protected function __updateView(event:PanicBuyingEvent) : void
      {
         if(_frame)
         {
            _frame.refreshActivity();
         }
      }
      
      protected function __panicBuyingOpenView(event:PanicBuyingEvent) : void
      {
         AssetModuleLoader.addModelLoader("panicBuying",6);
         AssetModuleLoader.startCodeLoader(openPanicBuyingFrame);
      }
      
      private function openPanicBuyingFrame() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("panicBuying.frame");
         LayerManager.Instance.addToLayer(_frame,3,true,1,true);
         SocketManager.Instance.out.requestWonderfulActInit(2);
      }
   }
}
