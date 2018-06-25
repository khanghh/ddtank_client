package quest
{
   import flash.events.Event;
   
   public class RewardSelectedEvent extends Event
   {
      
      public static var ITEM_SELECTED:String = "ItemSelected";
       
      
      private var _itemCell:QuestRewardCell;
      
      public function RewardSelectedEvent(itemCell:QuestRewardCell, type:String = "ItemSelected", bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         _itemCell = itemCell;
      }
      
      public function get itemCell() : QuestRewardCell
      {
         return _itemCell;
      }
   }
}
