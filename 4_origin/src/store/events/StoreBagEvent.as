package store.events
{
   import ddt.data.goods.InventoryItemInfo;
   import flash.events.Event;
   
   public class StoreBagEvent extends Event
   {
      
      public static const BUYSYMBOL:String = "buySymbol";
      
      public static const STRNGTH_TRAN:String = "strengthTran";
      
      public static const REMOVE:String = "storeBagRemove";
      
      public static const UPDATE:String = "update";
      
      public static const AUTOLINK:String = "autoLink";
       
      
      public var pos:int;
      
      public var data:InventoryItemInfo;
      
      public function StoreBagEvent(type:String, pos:int, data:InventoryItemInfo, bubbles:Boolean = false, cancelabel:Boolean = true)
      {
         super(type,bubbles,cancelable);
         this.pos = pos;
         this.data = data;
      }
   }
}
