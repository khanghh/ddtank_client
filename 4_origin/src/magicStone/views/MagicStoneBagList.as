package magicStone.views
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import magicStone.components.MgStoneCell;
   
   public class MagicStoneBagList extends BagListView
   {
       
      
      private var _curPage:int;
      
      private var _startIndex:int;
      
      private var _endIndex:int;
      
      public function MagicStoneBagList(param1:int, param2:int = 7, param3:int = 49)
      {
         _curPage = 1;
         _startIndex = 32;
         _endIndex = 32 + param3 - 1;
         super(param1,param2,param3);
      }
      
      override protected function createCells() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         _loc2_ = 32;
         while(_loc2_ <= 143)
         {
            _loc1_ = new MgStoneCell(_loc2_,null,true);
            CellFactory.instance.fillTipProp(_loc1_);
            _loc1_.addEventListener("interactive_click",__clickHandler);
            _loc1_.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(_loc1_);
            _loc1_.addEventListener("lockChanged",__cellChanged);
            if(_loc2_ >= _startIndex && _loc2_ <= _endIndex)
            {
               addChild(_loc1_);
            }
            _cells[_loc2_] = _loc1_;
            _cellVec.push(_loc1_);
            _loc2_++;
         }
      }
      
      override public function setData(param1:BagInfo) : void
      {
         if(_bagdata == param1)
         {
            return;
         }
         if(_bagdata)
         {
            _bagdata.removeEventListener("update",__updateGoods);
         }
         _bagdata = param1;
         updateBagList();
         _bagdata.addEventListener("update",__updateGoods);
      }
      
      override protected function __updateGoods(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:Dictionary = param1.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc3_ in _loc4_)
         {
            if(_loc3_.Place >= 32 && _loc3_.Place <= 143)
            {
               _loc2_ = _bagdata.getItemAt(_loc3_.Place);
               if(_loc2_)
               {
                  setCellInfo(_loc2_.Place,_loc2_);
               }
               else
               {
                  setCellInfo(_loc3_.Place,null);
               }
               dispatchEvent(new Event("change"));
            }
         }
      }
      
      override public function setCellInfo(param1:int, param2:InventoryItemInfo) : void
      {
         var _loc3_:String = String(param1);
         if(param2 == null)
         {
            if(_cells[_loc3_])
            {
               _cells[_loc3_].info = null;
            }
            return;
         }
         if(param2.Count == 0)
         {
            _cells[_loc3_].info = null;
         }
         else
         {
            _cells[_loc3_].info = param2;
         }
      }
      
      public function updateBagList() : void
      {
         var _loc2_:int = 0;
         clearDataCells();
         removeAllChild();
         _loc2_ = 32;
         while(_loc2_ <= 143)
         {
            if(_loc2_ >= _startIndex && _loc2_ <= _endIndex)
            {
               addChild(_cells[_loc2_]);
            }
            _loc2_++;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _bagdata.items;
         for(var _loc1_ in _bagdata.items)
         {
            if(_cells[_loc1_] != null)
            {
               _bagdata.items[_loc1_].isMoveSpace = true;
               _cells[_loc1_].info = _bagdata.items[_loc1_];
            }
         }
      }
      
      public function set curPage(param1:int) : void
      {
         _curPage = param1;
         _startIndex = 32 + (_curPage - 1) * _cellNum;
         _endIndex = 32 + _curPage * _cellNum - 1;
      }
      
      override public function dispose() : void
      {
         if(_bagdata)
         {
            _bagdata.removeEventListener("update",__updateGoods);
         }
         super.dispose();
      }
   }
}
