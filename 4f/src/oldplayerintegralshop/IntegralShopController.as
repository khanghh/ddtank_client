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
      
      public function IntegralShopController(){super();}
      
      public static function get instance() : IntegralShopController{return null;}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      private function __complainShow(param1:UIModuleEvent) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function showIntegralShopFrame() : void{}
      
      public function get integralNum() : int{return 0;}
      
      public function set integralNum(param1:int) : void{}
   }
}
