package latentEnergy
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.interfaces.ICell;
   import flash.utils.Dictionary;
   
   public class LatentEnergyBagListView extends BagListView
   {
       
      
      private var _autoExpandV:Boolean;
      
      public function LatentEnergyBagListView(param1:int, param2:int = 7, param3:int = 49, param4:Boolean = false){super(null,null,null);}
      
      override protected function createCells() : void{}
      
      private function addCell(param1:int) : void{}
      
      private function createBagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true) : LatentEnergyEquipListCell{return null;}
      
      private function fillTipProp(param1:ICell) : void{}
      
      private function equipMoveHandler(param1:LatentEnergyEvent) : void{}
      
      private function equipMoveHandler2(param1:LatentEnergyEvent) : void{}
      
      override public function setData(param1:BagInfo) : void{}
      
      public function get autoExpandV() : Boolean{return false;}
      
      public function set autoExpandV(param1:Boolean) : void{}
      
      override public function dispose() : void{}
   }
}
