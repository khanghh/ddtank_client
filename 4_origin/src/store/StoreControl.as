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
       
      
      public function StoreControl()
      {
         super();
      }
      
      public static function get instance() : StoreControl
      {
         if(_instance == null)
         {
            _instance = new StoreControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         BagStore.instance.addEventListener("openview",__onOpenView);
         BagStore.instance.addEventListener("showbuyframe",__onShowBuyFrame);
      }
      
      private function __onOpenView(param1:*) : void
      {
         var _loc2_:* = null;
         if(param1 is CEvent)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtstore.BagStoreFrame");
            _loc2_.controller = param1.data.control;
            _loc2_.show(param1.data.type);
            BagStore.instance.isInBagStoreFrame = true;
            BagStore.instance.dispatchEvent(new Event(BagStore.OPEN_BAGSTORE));
         }
      }
      
      private function __onShowBuyFrame(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1 is CEvent)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ddtstore.ShortcutBuyFrame");
            _loc2_ = param1.data;
            _loc3_.show(_loc2_.templateIDList,_loc2_.showRadioBtn,_loc2_.title,_loc2_.panelIndex,_loc2_.selectedIndex,_loc2_.hSpace,_loc2_.vSpace);
         }
      }
   }
}
