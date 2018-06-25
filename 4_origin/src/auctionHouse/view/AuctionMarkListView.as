package auctionHouse.view
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import flash.utils.Dictionary;
   import mark.MarkMgr;
   import mark.data.MarkBagData;
   import mark.data.MarkChipData;
   
   public class AuctionMarkListView extends BagListView
   {
       
      
      public var _startIndex:int;
      
      public var _stopIndex:int;
      
      private var _type:int = 1003;
      
      public function AuctionMarkListView(bagType:int, startIndex:int = 31, stopIndex:int = 80, columnNum:int = 7, page:int = 1)
      {
         _startIndex = startIndex;
         _stopIndex = stopIndex;
         super(bagType,columnNum,42);
      }
      
      override protected function createCells() : void
      {
         var i:int = 0;
         var cell:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         for(i = _startIndex; i < _stopIndex; )
         {
            cell = CellFactory.instance.createBagCell(i) as BagCell;
            cell.mouseOverEffBoolean = false;
            addChild(cell);
            cell.addEventListener("interactive_click",__clickHandler);
            cell.addEventListener("mouseOver",_cellOverEff);
            cell.addEventListener("mouseOut",_cellOutEff);
            cell.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(cell);
            cell.bagType = _bagType;
            cell.addEventListener("lockChanged",__cellChanged);
            _cells[cell.place] = cell;
            _cellVec.push(cell);
            i++;
         }
      }
      
      public function set type(value:int) : void
      {
         _type = value;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      override protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
      }
      
      public function setMarkDic(page:int = 1) : void
      {
         var chip:* = null;
         var info:* = null;
         var bag:MarkBagData = MarkMgr.inst.model.bags[_type];
         var cellNum:int = 0;
         var startNum:int = 0;
         if(_cells)
         {
            var _loc10_:int = 0;
            var _loc9_:* = _cells;
            for each(var bagCell in _cells)
            {
               bagCell.info = null;
            }
         }
         var _loc12_:int = 0;
         var _loc11_:* = bag.chips;
         for(var key in bag.chips)
         {
            chip = bag.chips[key];
            if(!chip.isbind)
            {
               if(startNum < 42 * (page - 1))
               {
                  startNum++;
                  continue;
               }
               if(int(cellNum) < 42)
               {
                  if(chip)
                  {
                     info = ItemManager.fillByID(chip.templateId);
                     info.BagType = _bagType;
                     info.ItemID = chip.itemID;
                     (_cells[cellNum] as BagCell).info = info;
                     (_cells[cellNum] as BagCell).tipData = chip;
                     (_cells[cellNum] as BagCell).updateCellStar();
                     cellNum++;
                  }
                  continue;
               }
               break;
            }
         }
      }
   }
}
