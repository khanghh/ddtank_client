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
         var award:* = null;
         var i:int = 0;
         _awardVec = new Vector.<BagCell>();
         for(i = 0; i < AWARD_NUM; )
         {
            award = new BagCell(i);
            award.BGVisible = false;
            award.setContentSize(28,28);
            award.x = i * 35;
            award.y = 3;
            addChild(award);
            _awardVec.push(award);
            i++;
         }
      }
      
      public function set info(infoVec:Vector.<LanternAwardInfo>) : void
      {
         var i:int = 0;
         var item:* = null;
         for(i = 0; i < infoVec.length; )
         {
            item = new InventoryItemInfo();
            item.TemplateID = infoVec[i].TempId;
            item.IsBinds = infoVec[i].IsBind;
            item.ValidDate = infoVec[i].ValidDate;
            _awardVec[i].info = ItemManager.fill(item);
            _awardVec[i].setCount(infoVec[i].AwardNum);
            i++;
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         if(_awardVec)
         {
            for(i = 0; i < AWARD_NUM; )
            {
               _awardVec[i].dispose();
               _awardVec[i] = null;
               i++;
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
