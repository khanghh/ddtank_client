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
      
      public function LatentEnergyBagListView(bagType:int, columnNum:int = 7, cellNun:int = 49, autoExpandV:Boolean = false)
      {
         _autoExpandV = autoExpandV;
         super(bagType,columnNum,cellNun);
         if(bagType == 0)
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
         var i:int = 0;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         for(i = 0; i < _cellNum; )
         {
            addCell(i);
            i++;
         }
      }
      
      private function addCell(place:int) : void
      {
         var cell:LatentEnergyEquipListCell = createBagCell(place);
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
      }
      
      private function createBagCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true) : LatentEnergyEquipListCell
      {
         var cell:LatentEnergyEquipListCell = new LatentEnergyEquipListCell(place,info,showLoading);
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
      
      private function equipMoveHandler(event:LatentEnergyEvent) : void
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
      
      private function equipMoveHandler2(event:LatentEnergyEvent) : void
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
         var tempA:int = 0;
         var tempB:int = 0;
         var tempC:int = 0;
         var q:* = 0;
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
         if(autoExpandV && _cellVec.length < _bagdata.items.length)
         {
            tempA = _bagdata.items.length - _cellVec.length;
            tempB = _cellVec.length;
            tempC = 0;
            if(_bagdata.items.length % 7 > 0)
            {
               tempC = 7 - _bagdata.items.length % 7;
            }
            for(q = tempB; q < tempB + tempA + tempC; )
            {
               addCell(q);
               q++;
            }
            _cellNum = _cellVec.length;
         }
         var arr:Array = [];
         var _loc11_:int = 0;
         var _loc10_:* = _bagdata.items;
         for(var key in _bagdata.items)
         {
            arr.push(key);
         }
         arr.sort(16);
         var k:int = 0;
         var _loc13_:int = 0;
         var _loc12_:* = arr;
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
      
      public function get autoExpandV() : Boolean
      {
         return _autoExpandV;
      }
      
      public function set autoExpandV(value:Boolean) : void
      {
         _autoExpandV = value;
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
