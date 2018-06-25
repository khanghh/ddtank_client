package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class BagEquipListView extends BagListView
   {
       
      
      public var _startIndex:int;
      
      public var _stopIndex:int;
      
      public function BagEquipListView(bagType:int, startIndex:int = 31, stopIndex:int = 80, columnNum:int = 7)
      {
         _startIndex = startIndex;
         _stopIndex = stopIndex;
         super(bagType,columnNum);
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
            cell.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(cell);
            cell.bagType = _bagType;
            cell.addEventListener("lockChanged",__cellChanged);
            _cells[cell.place] = cell;
            _cellVec.push(cell);
            i++;
         }
      }
      
      override protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if((evt.currentTarget as BagCell).info != null)
         {
            SoundManager.instance.play("008");
            dispatchEvent(new CellEvent("doubleclick",evt.currentTarget));
         }
      }
      
      override protected function __clickHandler(e:InteractiveEvent) : void
      {
         if(e.currentTarget)
         {
            dispatchEvent(new CellEvent("itemclick",e.currentTarget,false,false,e.ctrlKey));
         }
      }
      
      protected function __cellClick(evt:MouseEvent) : void
      {
      }
      
      override public function setCellInfo(index:int, info:InventoryItemInfo) : void
      {
         if(index >= _startIndex && index < _stopIndex)
         {
            if(info == null)
            {
               _cells[index].info = null;
               return;
            }
            if(info.Count == 0)
            {
               _cells[index].info = null;
            }
            else
            {
               _cells[index].info = info;
            }
         }
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.removeEventListener("interactive_click",__clickHandler);
            cell.removeEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.disableDoubleClick(cell);
            cell.removeEventListener("lockChanged",__cellChanged);
         }
         _cellMouseOverBg = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
