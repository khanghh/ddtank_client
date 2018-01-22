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
      
      public function LanternRankItemAward()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _awardVec = new Vector.<BagCell>();
         _loc2_ = 0;
         while(_loc2_ < AWARD_NUM)
         {
            _loc1_ = new BagCell(_loc2_);
            _loc1_.BGVisible = false;
            _loc1_.setContentSize(28,28);
            _loc1_.x = _loc2_ * 35;
            _loc1_.y = 3;
            addChild(_loc1_);
            _awardVec.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function set info(param1:Vector.<LanternAwardInfo>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new InventoryItemInfo();
            _loc2_.TemplateID = param1[_loc3_].TempId;
            _loc2_.IsBinds = param1[_loc3_].IsBind;
            _loc2_.ValidDate = param1[_loc3_].ValidDate;
            _awardVec[_loc3_].info = ItemManager.fill(_loc2_);
            _awardVec[_loc3_].setCount(param1[_loc3_].AwardNum);
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(_awardVec)
         {
            _loc1_ = 0;
            while(_loc1_ < AWARD_NUM)
            {
               _awardVec[_loc1_].dispose();
               _awardVec[_loc1_] = null;
               _loc1_++;
            }
            _awardVec.length = 0;
            _awardVec = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
