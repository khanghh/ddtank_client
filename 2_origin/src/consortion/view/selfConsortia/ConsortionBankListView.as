package consortion.view.selfConsortia
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.events.CellEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class ConsortionBankListView extends BagListView
   {
      
      private static var MAX_LINE_NUM:int = 10;
       
      
      private var _bankLevel:int;
      
      public function ConsortionBankListView(bagType:int, level:int = 0)
      {
         super(bagType,MAX_LINE_NUM);
      }
      
      override public function updateBankBag(level:int) : void
      {
         var i:int = 0;
         var j:int = 0;
         var index:int = 0;
         var cell:* = null;
         if(level == _bankLevel)
         {
            return;
         }
         for(i = _bankLevel; i < level; )
         {
            for(j = 0; j < MAX_LINE_NUM; )
            {
               index = i * MAX_LINE_NUM + j;
               cell = _cells[index] as BagCell;
               cell.grayFilters = false;
               cell.mouseEnabled = true;
               j++;
            }
            i++;
         }
         _bankLevel = level;
      }
      
      override protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if((evt.currentTarget as BagCell).info != null)
         {
            dispatchEvent(new CellEvent("doubleclick",evt.currentTarget));
         }
      }
      
      override protected function __clickHandler(e:InteractiveEvent) : void
      {
         if(e.currentTarget)
         {
            dispatchEvent(new CellEvent("itemclick",e.currentTarget,false,false));
         }
      }
      
      private function __resultHandler(evt:MouseEvent) : void
      {
      }
      
      override protected function createCells() : void
      {
         var i:int = 0;
         var j:int = 0;
         var index:int = 0;
         var cell:* = null;
         _cells = new Dictionary();
         for(i = 0; i < MAX_LINE_NUM; )
         {
            for(j = 0; j < MAX_LINE_NUM; )
            {
               index = i * MAX_LINE_NUM + j;
               cell = CellFactory.instance.createBankCell(index) as BagCell;
               addChild(cell);
               cell.bagType = _bagType;
               cell.addEventListener("interactive_click",__clickHandler);
               cell.addEventListener("interactive_double_click",__doubleClickHandler);
               DoubleClickManager.Instance.enableDoubleClick(cell);
               cell.addEventListener("lockChanged",__cellChanged);
               _cells[cell.place] = cell;
               if(_bankLevel <= i)
               {
                  cell.grayFilters = true;
                  cell.mouseEnabled = false;
               }
               j++;
            }
            i++;
         }
      }
      
      override public function checkBankCell() : int
      {
         var i:int = 0;
         var j:int = 0;
         var index:int = 0;
         var cell:* = null;
         if(_bankLevel == 0)
         {
            return 1;
         }
         i = 0;
         while(i < _bankLevel)
         {
            for(j = 0; j < MAX_LINE_NUM; )
            {
               index = i * MAX_LINE_NUM + j;
               cell = _cells[index] as BagCell;
               if(!cell.info)
               {
                  return 0;
               }
               j++;
            }
            i++;
         }
         if(_bankLevel == MAX_LINE_NUM)
         {
            return 2;
         }
         return 3;
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.removeEventListener("interactive_click",__clickHandler);
            cell.removeEventListener("interactive_double_click",__doubleClickHandler);
            cell.removeEventListener("lockChanged",__cellChanged);
         }
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
