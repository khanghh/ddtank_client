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
      
      public function BagEquipListView(param1:int, param2:int = 31, param3:int = 80, param4:int = 7)
      {
         _startIndex = param2;
         _stopIndex = param3;
         super(param1,param4);
      }
      
      override protected function createCells() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         _loc2_ = _startIndex;
         while(_loc2_ < _stopIndex)
         {
            _loc1_ = CellFactory.instance.createBagCell(_loc2_) as BagCell;
            _loc1_.mouseOverEffBoolean = false;
            addChild(_loc1_);
            _loc1_.addEventListener("interactive_click",__clickHandler);
            _loc1_.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(_loc1_);
            _loc1_.bagType = _bagType;
            _loc1_.addEventListener("lockChanged",__cellChanged);
            _cells[_loc1_.place] = _loc1_;
            _cellVec.push(_loc1_);
            _loc2_++;
         }
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if((param1.currentTarget as BagCell).info != null)
         {
            SoundManager.instance.play("008");
            dispatchEvent(new CellEvent("doubleclick",param1.currentTarget));
         }
      }
      
      override protected function __clickHandler(param1:InteractiveEvent) : void
      {
         if(param1.currentTarget)
         {
            dispatchEvent(new CellEvent("itemclick",param1.currentTarget,false,false,param1.ctrlKey));
         }
      }
      
      protected function __cellClick(param1:MouseEvent) : void
      {
      }
      
      override public function setCellInfo(param1:int, param2:InventoryItemInfo) : void
      {
         if(param1 >= _startIndex && param1 < _stopIndex)
         {
            if(param2 == null)
            {
               _cells[param1].info = null;
               return;
            }
            if(param2.Count == 0)
            {
               _cells[param1].info = null;
            }
            else
            {
               _cells[param1].info = param2;
            }
         }
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.removeEventListener("interactive_click",__clickHandler);
            _loc1_.removeEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.disableDoubleClick(_loc1_);
            _loc1_.removeEventListener("lockChanged",__cellChanged);
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
