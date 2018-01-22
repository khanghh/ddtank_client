package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class BagListView extends SimpleTileList
   {
      
      public static const BAG_CAPABILITY:int = 49;
       
      
      private var _allBagData:BagInfo;
      
      protected var _cellNum:int;
      
      protected var _bagdata:BagInfo;
      
      protected var _bagType:int;
      
      protected var _cells:Dictionary;
      
      protected var _cellMouseOverBg:Bitmap;
      
      protected var _cellVec:Array;
      
      private var _isSetFoodData:Boolean;
      
      private var _currentBagType:int;
      
      public function BagListView(param1:int, param2:int = 7, param3:int = 49)
      {
         _cellNum = param3;
         _bagType = param1;
         super(param2);
         _vSpace = 0;
         _hSpace = 0;
         _cellVec = [];
         createCells();
      }
      
      protected function createCells() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         _loc2_ = 0;
         while(_loc2_ < _cellNum)
         {
            _loc1_ = BagCell(CellFactory.instance.createBagCell(_loc2_));
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
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if((param1.currentTarget as BagCell).info != null)
         {
            SoundManager.instance.play("008");
            dispatchEvent(new CellEvent("doubleclick",param1.currentTarget));
         }
      }
      
      protected function __cellChanged(param1:Event) : void
      {
         dispatchEvent(new Event("change"));
      }
      
      protected function __clickHandler(param1:InteractiveEvent) : void
      {
         if((param1.currentTarget as BagCell).info != null)
         {
            dispatchEvent(new CellEvent("itemclick",param1.currentTarget,false,false,param1.ctrlKey));
         }
      }
      
      protected function _cellOverEff(param1:MouseEvent) : void
      {
         BagCell(param1.currentTarget).onParentMouseOver(_cellMouseOverBg);
      }
      
      protected function _cellOutEff(param1:MouseEvent) : void
      {
         BagCell(param1.currentTarget).onParentMouseOut();
      }
      
      public function setCellInfo(param1:int, param2:InventoryItemInfo) : void
      {
         if(param2 == null)
         {
            if(_cells[param1])
            {
               _cells[param1].info = null;
            }
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
      
      protected function clearDataCells() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.info = null;
         }
      }
      
      public function set currentBagType(param1:int) : void
      {
         _currentBagType = param1;
      }
      
      public function setData(param1:BagInfo) : void
      {
         _isSetFoodData = false;
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
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _bagdata.items;
         for(var _loc3_ in _bagdata.items)
         {
            if(_cells[_loc3_] != null)
            {
               if(_currentBagType == 5)
               {
                  if(_bagdata.items[_loc3_].CategoryID == 50 || _bagdata.items[_loc3_].CategoryID == 51 || _bagdata.items[_loc3_].CategoryID == 52)
                  {
                     _bagdata.items[_loc3_].isMoveSpace = true;
                     _cells[_loc3_].info = _bagdata.items[_loc3_];
                     _loc2_.push(_cells[_loc3_]);
                  }
               }
               else
               {
                  _bagdata.items[_loc3_].isMoveSpace = true;
                  _cells[_loc3_].info = _bagdata.items[_loc3_];
               }
            }
         }
         _bagdata.addEventListener("update",__updateGoods);
         if(_currentBagType == 5)
         {
            _cellsSort(_loc2_);
         }
      }
      
      private function sortItems() : void
      {
         var _loc1_:* = null;
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _bagdata.items;
         for(var _loc3_ in _bagdata.items)
         {
            _loc1_ = _bagdata.items[_loc3_];
            if(_cells[_loc3_] != null && _loc1_)
            {
               if(_loc1_.CategoryID == 50 || _loc1_.CategoryID == 51 || _loc1_.CategoryID == 52)
               {
                  BaseCell(_cells[_loc3_]).info = _loc1_;
                  _loc2_.push(_cells[_loc3_]);
               }
            }
         }
         _cellsSort(_loc2_);
      }
      
      private function _cellsSort(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(param1.length <= 0)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc4_ = param1[_loc6_].x;
            _loc5_ = param1[_loc6_].y;
            _loc3_ = _cellVec.indexOf(param1[_loc6_]);
            _loc2_ = _cellVec[_loc6_];
            param1[_loc6_].x = _loc2_.x;
            param1[_loc6_].y = _loc2_.y;
            _loc2_.x = _loc4_;
            _loc2_.y = _loc5_;
            _cellVec[_loc6_] = param1[_loc6_];
            _cellVec[_loc3_] = _loc2_;
            _loc6_++;
         }
      }
      
      protected function __updateFoodGoods(param1:BagEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         if(!_bagdata)
         {
            return;
         }
         var _loc8_:Dictionary = param1.changedSlots;
         var _loc12_:int = 0;
         var _loc11_:* = _loc8_;
         for each(var _loc7_ in _loc8_)
         {
            _loc3_ = -1;
            _loc5_ = null;
            var _loc10_:int = 0;
            var _loc9_:* = _bagdata.items;
            for(var _loc6_ in _bagdata.items)
            {
               _loc4_ = _bagdata.items[_loc6_] as InventoryItemInfo;
               if(_loc7_.ItemID == _loc4_.ItemID)
               {
                  _loc5_ = _loc7_;
                  _loc3_ = _loc6_;
                  break;
               }
            }
            if(_loc3_ != -1)
            {
               _loc2_ = _bagdata.getItemAt(_loc3_);
               if(_loc2_)
               {
                  _loc2_.Count = _loc5_.Count;
                  if(_cells[_loc3_].info)
                  {
                     setCellInfo(_loc3_,null);
                  }
                  else
                  {
                     setCellInfo(_loc3_,_loc2_);
                  }
               }
               else
               {
                  setCellInfo(_loc3_,null);
               }
               dispatchEvent(new Event("change"));
            }
         }
      }
      
      protected function __updateGoods(param1:BagEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         if(_isSetFoodData)
         {
            __updateFoodGoods(param1);
         }
         else
         {
            _loc4_ = param1.changedSlots;
            var _loc6_:int = 0;
            var _loc5_:* = _loc4_;
            for each(var _loc3_ in _loc4_)
            {
               _loc2_ = _bagdata.getItemAt(_loc3_.Place);
               if(_loc2_)
               {
                  if(_currentBagType == 5)
                  {
                     if(_loc2_.CategoryID != 50 && _loc2_.CategoryID != 51 && _loc2_.CategoryID != 52)
                     {
                        setCellInfo(_loc3_.Place,null);
                        continue;
                     }
                  }
                  setCellInfo(_loc2_.Place,_loc2_);
               }
               else
               {
                  setCellInfo(_loc3_.Place,null);
               }
               dispatchEvent(new Event("change"));
            }
         }
         if(_currentBagType == 5)
         {
            sortItems();
         }
      }
      
      override public function dispose() : void
      {
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoods);
            _bagdata = null;
         }
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.removeEventListener("interactive_click",__clickHandler);
            _loc1_.removeEventListener("lockChanged",__cellChanged);
            _loc1_.removeEventListener("mouseOver",_cellOverEff);
            _loc1_.removeEventListener("mouseOut",_cellOutEff);
            _loc1_.removeEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.disableDoubleClick(_loc1_);
            _loc1_.dispose();
         }
         _cells = null;
         _cellVec = null;
         if(_cellMouseOverBg)
         {
            if(_cellMouseOverBg.parent)
            {
               _cellMouseOverBg.parent.removeChild(_cellMouseOverBg);
            }
            _cellMouseOverBg.bitmapData.dispose();
         }
         _cellMouseOverBg = null;
         super.dispose();
      }
      
      public function get cells() : Dictionary
      {
         return _cells;
      }
      
      public function updateBankBag(param1:int) : void
      {
      }
      
      public function checkBankCell() : int
      {
         return 0;
      }
   }
}
