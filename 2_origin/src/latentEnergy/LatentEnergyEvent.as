package latentEnergy
{
   import ddt.data.goods.InventoryItemInfo;
   import flash.events.Event;
   
   public class LatentEnergyEvent extends Event
   {
       
      
      public var info:InventoryItemInfo;
      
      public var moveType:int;
      
      public function LatentEnergyEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
