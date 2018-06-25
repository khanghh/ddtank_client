package oldPlayerComeBack.data
{
   import flash.events.EventDispatcher;
   
   public class ComeBackAwardItemsInfo extends EventDispatcher
   {
       
      
      private var _curPlace:int;
      
      private var awardItems:Vector.<AwardItemInfo>;
      
      public function ComeBackAwardItemsInfo()
      {
         super();
         awardItems = new Vector.<AwardItemInfo>();
      }
      
      public function addInfo(info:AwardItemInfo) : void
      {
         awardItems.push(info);
      }
      
      public function get allAwardItems() : Vector.<AwardItemInfo>
      {
         return awardItems;
      }
      
      public function get curPlace() : int
      {
         return _curPlace;
      }
      
      public function set curPlace(value:int) : void
      {
         _curPlace = value;
      }
   }
}
