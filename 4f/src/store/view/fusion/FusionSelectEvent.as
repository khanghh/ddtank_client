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
      
      public function FusionSelectEvent(param1:String, param2:int = 0, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
      
      public function get sellCount() : int{return 0;}
      
      public function get info() : InventoryItemInfo{return null;}
      
      public function set info(param1:InventoryItemInfo) : void{}
   }
}
