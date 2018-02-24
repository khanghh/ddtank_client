package lanternriddles.view
{
   import bagAndInfo.cell.BagCell;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import flash.display.Sprite;
   import lanternriddles.data.LanternAwardInfo;
   
   public class LanternRankItemAward extends Sprite
   {
      
      private static var AWARD_NUM:int = 3;
       
      
      private var _awardVec:Vector.<BagCell>;
      
      public function LanternRankItemAward(){super();}
      
      private function initView() : void{}
      
      public function set info(param1:Vector.<LanternAwardInfo>) : void{}
      
      public function dispose() : void{}
   }
}
