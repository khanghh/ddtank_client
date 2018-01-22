package ddt.manager
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class VipIntegralShopManager extends EventDispatcher
   {
      
      public static const VIPINTEGRAL_OPENVIEW:String = "vipintgralOpenView";
      
      private static var _instance:VipIntegralShopManager;
       
      
      public function VipIntegralShopManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get Instance() : VipIntegralShopManager
      {
         if(_instance == null)
         {
            _instance = new VipIntegralShopManager();
         }
         return _instance;
      }
      
      public function show() : void
      {
         dispatchEvent(new Event("vipintgralOpenView"));
      }
   }
}
