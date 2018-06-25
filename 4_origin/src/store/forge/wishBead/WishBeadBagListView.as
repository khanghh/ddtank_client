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
       
      
      public function WishBeadBagListView(bagType:int, columnNum:int = 7, cellNun:int = 49)
      {
         super(bagType,columnNum,cellNun);
         if(bagType == 0)
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
         var i:int = 0;
         var cell:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         for(i = 0; i < _cellNum; )
         {
            cell = createBagCell(i);
            cell.mouseOverEffBoolean = false;
            addChild(cell);
            cell.bagType = _bagType;
            cell.addEventListener("interactive_click",__clickHandler);
            cell.addEventListener("mouseOver",_cellOverEff);
            cell.addEventListener("mouseOut",_cellOutEff);
            cell.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(cell);
            cell.addEventListener("lockChanged",__cellChanged);
            _cells[cell.place] = cell;
            _cellVec.push(cell);
            i++;
         }
      }
      
      private function createBagCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true) : WishBeadEquipListCell
      {
         var cell:WishBeadEquipListCell = new WishBeadEquipListCell(place,info,showLoading);
         fillTipProp(cell);
         return cell;
      }
      
      private function fillTipProp(cell:ICell) : void
      {
         cell.tipDirctions = "7,6,2,1,5,4,0,3,6";
         cell.tipGapV = 10;
         cell.tipGapH = 10;
         cell.tipStyle = "core.GoodsTip";
      }
      
      private function equipMoveHandler(event:WishBeadEvent) : void
      {
         var i:int = 0;
         var itemInfo:InventoryItemInfo = event.info;
         for(i = 0; i < _cellNum; )
         {
            if(_cells[i].info == itemInfo)
            {
               _cells[i].info = null;
               break;
            }
            i++;
         }
      }
      
      private function equipMoveHandler2(event:WishBeadEvent) : void
      {
         var k:int = 0;
         var itemInfo:InventoryItemInfo = event.info;
         if(event.moveType == 2)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _cells;
            for each(var cell in _cells)
            {
               if(cell.info == itemInfo)
               {
                  return;
               }
            }
         }
         k = 0;
         while(k < _cellNum)
         {
            if(!_cells[k].info)
            {
               _cells[k].info = itemInfo;
               break;
            }
            k++;
         }
      }
      
      override public function setData(bag:BagInfo) : void
      {
         if(_bagdata == bag)
         {
            return;
         }
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoods);
         }
         clearDataCells();
         _bagdata = bag;
         var k:int = 0;
         var arr:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _bagdata.items;
         for(var key in _bagdata.items)
         {
            arr.push(key);
         }
         arr.sort(16);
         var _loc9_:int = 0;
         var _loc8_:* = arr;
         for each(var i in arr)
         {
            if(_cells[k] != null)
            {
               _bagdata.items[i].isMoveSpace = true;
               _cells[k].info = _bagdata.items[i];
            }
            k++;
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
