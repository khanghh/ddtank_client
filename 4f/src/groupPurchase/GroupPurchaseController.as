package groupPurchase
{
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import groupPurchase.view.GroupPurchaseMainView;
   import hallIcon.HallIconManager;
   
   public class GroupPurchaseController
   {
      
      private static var _instance:GroupPurchaseController;
       
      
      public function GroupPurchaseController(){super();}
      
      public static function get instance() : GroupPurchaseController{return null;}
      
      public function setup() : void{}
      
      private function __onShowFrame(param1:Event) : void{}
   }
}
