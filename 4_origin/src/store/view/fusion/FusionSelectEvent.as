package store.view.fusion
{
   import ddt.data.goods.InventoryItemInfo;
   import flash.events.Event;
   
   public class FusionSelectEvent extends Event
   {
      
      public static const SELL:String = "sell";
      
      public static const NOTSELL:String = "notsell";
       
      
      private var _sellCount:int;
      
      private var _info:InventoryItemInfo;
      
      public var index:int;
      
      public function FusionSelectEvent(type:String, sellCount:int = 0, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         _sellCount = sellCount;
         super(type,bubbles,cancelable);
      }
      
      public function get sellCount() : int
      {
         return _sellCount;
      }
      
      public function get info() : InventoryItemInfo
      {
         return _info;
      }
      
      public function set info(value:InventoryItemInfo) : void
      {
         _info = value;
      }
   }
}
