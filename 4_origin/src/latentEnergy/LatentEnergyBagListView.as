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
      
      public function LatentEnergyBagListView(param1:int, param2:int = 7, param3:int = 49, param4:Boolean = false)
      {
         _autoExpandV = param4;
         super(param1,param2,param3);
         if(param1 == 0)
         {
            LatentEnergyManager.instance.addEventListener("latentEnergy_equip_move",equipMoveHandler);
            LatentEnergyManager.instance.addEventListener("latentEnergy_equip_move2",equipMoveHandler2);
         }
         else
         {
            LatentEnergyManager.instance.addEventListener("latentEnergy_item_move",equipMoveHandler);
            LatentEnergyManager.instance.addEventListener("latentEnergy_item_move2",equipMoveHandler2);
         }
      }
      
      override protected function createCells() : void
      {
         var _loc1_:int = 0;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         _loc1_ = 0;
         while(_loc1_ < _cellNum)
         {
            addCell(_loc1_);
            _loc1_++;
         }
      }
      
      private function addCell(param1:int) : void
      {
         var _loc2_:LatentEnergyEquipListCell = createBagCell(param1);
         _loc2_.mouseOverEffBoolean = false;
         addChild(_loc2_);
         _loc2_.bagType = _bagType;
         _loc2_.addEventListener("interactive_click",__clickHandler);
         _loc2_.addEventListener("mouseOver",_cellOverEff);
         _loc2_.addEventListener("mouseOut",_cellOutEff);
         _loc2_.addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(_loc2_);
         _loc2_.addEventListener("lockChanged",__cellChanged);
         _cells[_loc2_.place] = _loc2_;
         _cellVec.push(_loc2_);
      }
      
      private function createBagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true) : LatentEnergyEquipListCell
      {
         var _loc4_:LatentEnergyEquipListCell = new LatentEnergyEquipListCell(param1,param2,param3);
         fillTipProp(_loc4_);
         return _loc4_;
      }
      
      private function fillTipProp(param1:ICell) : void
      {
         param1.tipDirctions = "7,6,2,1,5,4,0,3,6";
         param1.tipGapV = 10;
         param1.tipGapH = 10;
         param1.tipStyle = "core.GoodsTip";
      }
      
      private function equipMoveHandler(param1:LatentEnergyEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:InventoryItemInfo = param1.info;
         _loc3_ = 0;
         while(_loc3_ < _cellNum)
         {
            if(_cells[_loc3_].info == _loc2_)
            {
               _cells[_loc3_].info = null;
               break;
            }
            _loc3_++;
         }
      }
      
      private function equipMoveHandler2(param1:LatentEnergyEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:InventoryItemInfo = param1.info;
         if(param1.moveType == 2)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _cells;
            for each(var _loc2_ in _cells)
            {
               if(_loc2_.info == _loc3_)
               {
                  return;
               }
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _cellNum)
         {
            if(!_cells[_loc4_].info)
            {
               _cells[_loc4_].info = _loc3_;
               break;
            }
            _loc4_++;
         }
      }
      
      override public function setData(param1:BagInfo) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:* = 0;
         if(_bagdata == param1)
         {
            return;
         }
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoods);
         }
         clearDataCells();
         _bagdata = param1;
         if(autoExpandV && _cellVec.length < _bagdata.items.length)
         {
            _loc4_ = _bagdata.items.length - _cellVec.length;
            _loc3_ = _cellVec.length;
            _loc2_ = 0;
            if(_bagdata.items.length % 7 > 0)
            {
               _loc2_ = 7 - _bagdata.items.length % 7;
            }
            _loc6_ = _loc3_;
            while(_loc6_ < _loc3_ + _loc4_ + _loc2_)
            {
               addCell(_loc6_);
               _loc6_++;
            }
            _cellNum = _cellVec.length;
         }
         var _loc5_:Array = [];
         var _loc11_:int = 0;
         var _loc10_:* = _bagdata.items;
         for(var _loc8_ in _bagdata.items)
         {
            _loc5_.push(_loc8_);
         }
         _loc5_.sort(16);
         var _loc7_:int = 0;
         var _loc13_:int = 0;
         var _loc12_:* = _loc5_;
         for each(var _loc9_ in _loc5_)
         {
            if(_cells[_loc7_] != null)
            {
               _bagdata.items[_loc9_].isMoveSpace = true;
               _cells[_loc7_].info = _bagdata.items[_loc9_];
            }
            _loc7_++;
         }
         _bagdata.addEventListener("update",__updateGoods);
      }
      
      public function get autoExpandV() : Boolean
      {
         return _autoExpandV;
      }
      
      public function set autoExpandV(param1:Boolean) : void
      {
         _autoExpandV = param1;
      }
      
      override public function dispose() : void
      {
         LatentEnergyManager.instance.removeEventListener("latentEnergy_equip_move",equipMoveHandler);
         LatentEnergyManager.instance.removeEventListener("latentEnergy_equip_move2",equipMoveHandler2);
         LatentEnergyManager.instance.removeEventListener("latentEnergy_item_move",equipMoveHandler);
         LatentEnergyManager.instance.removeEventListener("latentEnergy_item_move2",equipMoveHandler2);
         super.dispose();
      }
   }
}
