package ddt.view.caddyII
{
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class CaddyEvent extends Event
   {
      
      public static const UPDATE_BADLUCK:String = "update_badLuck";
      
      public static const CARD_NAME:String = "card_name";
      
      public static const LUCKSTONE_RANK_LIMIT:String = "luckstone_rank_limit";
       
      
      public var point:Point;
      
      public var lastTime:String;
      
      public var info:InventoryItemInfo;
      
      public var itemTemplateInfo:ItemTemplateInfo;
      
      public var dataList:Vector.<Object>;
      
      public function CaddyEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
