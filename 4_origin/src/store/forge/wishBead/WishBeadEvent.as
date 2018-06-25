package store.forge.wishBead
{
   import ddt.data.goods.InventoryItemInfo;
   import flash.events.Event;
   
   public class WishBeadEvent extends Event
   {
       
      
      public var info:InventoryItemInfo;
      
      public var moveType:int;
      
      public function WishBeadEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
