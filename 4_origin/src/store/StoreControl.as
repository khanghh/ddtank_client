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
      
      private function __onOpenView(e:*) : void
      {
         var _frame:* = null;
         if(e is CEvent)
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("ddtstore.BagStoreFrame");
            _frame.controller = e.data.control;
            _frame.show(e.data.type);
            BagStore.instance.isInBagStoreFrame = true;
            BagStore.instance.dispatchEvent(new Event(BagStore.OPEN_BAGSTORE));
         }
      }
      
      private function __onShowBuyFrame(e:*) : void
      {
         var quickBuy:* = null;
         var data:* = null;
         if(e is CEvent)
         {
            quickBuy = ComponentFactory.Instance.creatComponentByStylename("ddtstore.ShortcutBuyFrame");
            data = e.data;
            quickBuy.show(data.templateIDList,data.showRadioBtn,data.title,data.panelIndex,data.selectedIndex,data.hSpace,data.vSpace);
         }
      }
   }
}
