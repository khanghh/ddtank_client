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
      
      public function ConsortionBankListView(param1:int, param2:int = 0)
      {
         super(param1,MAX_LINE_NUM);
      }
      
      override public function updateBankBag(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(param1 == _bankLevel)
         {
            return;
         }
         _loc5_ = _bankLevel;
         while(_loc5_ < param1)
         {
            _loc4_ = 0;
            while(_loc4_ < MAX_LINE_NUM)
            {
               _loc2_ = _loc5_ * MAX_LINE_NUM + _loc4_;
               _loc3_ = _cells[_loc2_] as BagCell;
               _loc3_.grayFilters = false;
               _loc3_.mouseEnabled = true;
               _loc4_++;
            }
            _loc5_++;
         }
         _bankLevel = param1;
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if((param1.currentTarget as BagCell).info != null)
         {
            dispatchEvent(new CellEvent("doubleclick",param1.currentTarget));
         }
      }
      
      override protected function __clickHandler(param1:InteractiveEvent) : void
      {
         if(param1.currentTarget)
         {
            dispatchEvent(new CellEvent("itemclick",param1.currentTarget,false,false));
         }
      }
      
      private function __resultHandler(param1:MouseEvent) : void
      {
      }
      
      override protected function createCells() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _cells = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < MAX_LINE_NUM)
         {
            _loc3_ = 0;
            while(_loc3_ < MAX_LINE_NUM)
            {
               _loc1_ = _loc4_ * MAX_LINE_NUM + _loc3_;
               _loc2_ = CellFactory.instance.createBankCell(_loc1_) as BagCell;
               addChild(_loc2_);
               _loc2_.bagType = _bagType;
               _loc2_.addEventListener("interactive_click",__clickHandler);
               _loc2_.addEventListener("interactive_double_click",__doubleClickHandler);
               DoubleClickManager.Instance.enableDoubleClick(_loc2_);
               _loc2_.addEventListener("lockChanged",__cellChanged);
               _cells[_loc2_.place] = _loc2_;
               if(_bankLevel <= _loc4_)
               {
                  _loc2_.grayFilters = true;
                  _loc2_.mouseEnabled = false;
               }
               _loc3_++;
            }
            _loc4_++;
         }
      }
      
      override public function checkBankCell() : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(_bankLevel == 0)
         {
            return 1;
         }
         _loc4_ = 0;
         while(_loc4_ < _bankLevel)
         {
            _loc3_ = 0;
            while(_loc3_ < MAX_LINE_NUM)
            {
               _loc1_ = _loc4_ * MAX_LINE_NUM + _loc3_;
               _loc2_ = _cells[_loc1_] as BagCell;
               if(!_loc2_.info)
               {
                  return 0;
               }
               _loc3_++;
            }
            _loc4_++;
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
         for each(var _loc1_ in _cells)
         {
            _loc1_.removeEventListener("interactive_click",__clickHandler);
            _loc1_.removeEventListener("interactive_double_click",__doubleClickHandler);
            _loc1_.removeEventListener("lockChanged",__cellChanged);
         }
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
