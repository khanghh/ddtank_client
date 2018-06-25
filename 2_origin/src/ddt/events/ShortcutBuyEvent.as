package ddt.events
{
   import flash.events.Event;
   
   public class ShortcutBuyEvent extends Event
   {
      
      public static const SHORTCUT_BUY:String = "shortcutBuy";
      
      public static const SHORTCUT_BUY_MONEY_OK:String = "shortcutBuyMoneyOk";
      
      public static const SHORTCUT_BUY_MONEY_CANCEL:String = "shortcutBuyMoneyCancel";
       
      
      private var _itemID:int;
      
      private var _itemNum:int;
      
      public function ShortcutBuyEvent(itemID:int, itemNum:int, bubbles:Boolean = false, cancelable:Boolean = false, eventName:String = "shortcutBuy")
      {
         super(eventName,bubbles,cancelable);
         _itemID = itemID;
         _itemNum = itemNum;
      }
      
      public function get ItemID() : int
      {
         return _itemID;
      }
      
      public function get ItemNum() : int
      {
         return _itemNum;
      }
   }
}
