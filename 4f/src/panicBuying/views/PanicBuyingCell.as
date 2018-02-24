package panicBuying.views
{
   import bagAndInfo.cell.BagCell;
   import beadSystem.beadSystemManager;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.ServerConfigManager;
   import ddt.view.tips.GoodTipInfo;
   import magicStone.MagicStoneManager;
   
   public class PanicBuyingCell extends BagCell
   {
       
      
      private var _expireTime:int;
      
      private var _buyType:int;
      
      public function PanicBuyingCell(param1:int, param2:ItemTemplateInfo, param3:int, param4:int){super(null,null);}
      
      override protected function setDefaultTipData() : void{}
   }
}
