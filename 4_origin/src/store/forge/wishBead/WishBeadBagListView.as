package store.forge.wishBead
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
   
   public class WishBeadBagListView extends BagListView
   {
       
      
      public function WishBeadBagListView(param1:int, param2:int = 7, param3:int = 49)
      {
         super(param1,param2,param3);
         if(param1 == 0)
         {
            WishBeadManager.instance.addEventListener("wishBead_equip_move",equipMoveHandler);
            WishBeadManager.instance.addEventListener("wishBead_equip_move2",equipMoveHandler2);
         }
         else
         {
            WishBeadManager.instance.addEventListener("wishBead_item_move",equipMoveHandler);
            WishBeadManager.instance.addEventListener("wishBead_item_move2",equipMoveHandler2);
         }
      }
      
      override protected function createCells() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         _loc2_ = 0;
         while(_loc2_ < _cellNum)
         {
            _loc1_ = createBagCell(_loc2_);
            _loc1_.mouseOverEffBoolean = false;
            addChild(_loc1_);
            _loc1_.bagType = _bagType;
            _loc1_.addEventListener("interactive_click",__clickHandler);
            _loc1_.addEventListener("mouseOver",_cellOverEff);
            _loc1_.addEventListener("mouseOut",_cellOutEff);
            _loc1_.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(_loc1_);
            _loc1_.addEventListener("lockChanged",__cellChanged);
            _cells[_loc1_.place] = _loc1_;
            _cellVec.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function createBagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true) : WishBeadEquipListCell
      {
         var _loc4_:WishBeadEquipListCell = new WishBeadEquipListCell(param1,param2,param3);
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
      
      private function equipMoveHandler(param1:WishBeadEvent) : void
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
      
      private function equipMoveHandler2(param1:WishBeadEvent) : void
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
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _bagdata.items;
         for(var _loc4_ in _bagdata.items)
         {
            _loc2_.push(_loc4_);
         }
         _loc2_.sort(16);
         var _loc9_:int = 0;
         var _loc8_:* = _loc2_;
         for each(var _loc5_ in _loc2_)
         {
            if(_cells[_loc3_] != null)
            {
               _bagdata.items[_loc5_].isMoveSpace = true;
               _cells[_loc3_].info = _bagdata.items[_loc5_];
            }
            _loc3_++;
         }
         _bagdata.addEventListener("update",__updateGoods);
      }
      
      override public function dispose() : void
      {
         WishBeadManager.instance.removeEventListener("wishBead_equip_move",equipMoveHandler);
         WishBeadManager.instance.removeEventListener("wishBead_equip_move2",equipMoveHandler2);
         WishBeadManager.instance.removeEventListener("wishBead_item_move",equipMoveHandler);
         WishBeadManager.instance.removeEventListener("wishBead_item_move2",equipMoveHandler2);
         super.dispose();
      }
   }
}
