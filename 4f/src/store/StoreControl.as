package store
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.bagStore.BagStore;
   import ddt.events.CEvent;
   import flash.events.Event;
   import store.view.BagStoreFrame;
   import store.view.shortcutBuy.ShortcutBuyFrame;
   
   public class StoreControl
   {
      
      private static var _instance:StoreControl;
       
      
      public function StoreControl(){super();}
      
      public static function get instance() : StoreControl{return null;}
      
      public function setup() : void{}
      
      private function __onOpenView(param1:*) : void{}
      
      private function __onShowBuyFrame(param1:*) : void{}
   }
}
