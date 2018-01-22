package oldplayerintegralshop
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import oldplayerintegralshop.view.IntegralShopView;
   
   public class IntegralShopController extends EventDispatcher
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      private static var _instance:IntegralShopController;
       
      
      private var _integralShopView:IntegralShopView;
      
      private var _integralNum:int;
      
      public function IntegralShopController()
      {
         super();
      }
      
      public static function get instance() : IntegralShopController
      {
         if(!_instance)
         {
            _instance = new IntegralShopController();
         }
         return _instance;
      }
      
      public function show() : void
      {
         if(loadComplete)
         {
            showIntegralShopFrame();
         }
         else if(useFirst)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__complainShow);
            UIModuleLoader.Instance.addUIModuleImp("integralshop");
         }
      }
      
      public function hide() : void
      {
         if(_integralShopView != null)
         {
            _integralShopView.dispose();
         }
         _integralShopView = null;
      }
      
      private function __complainShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "integralshop")
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
         if(param1.module == "integralshop")
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
      
      private function showIntegralShopFrame() : void
      {
         _integralShopView = ComponentFactory.Instance.creatComponentByStylename("oldplayerintegralshop.IntegralShopView");
         _integralShopView.show();
      }
      
      public function get integralNum() : int
      {
         return _integralNum;
      }
      
      public function set integralNum(param1:int) : void
      {
         _integralNum = param1;
      }
   }
}
