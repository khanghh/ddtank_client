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
      
      public function AuctionMarkListView(param1:int, param2:int = 31, param3:int = 80, param4:int = 7, param5:int = 1)
      {
         _startIndex = param2;
         _stopIndex = param3;
         super(param1,param4,42);
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
            _loc1_.addEventListener("mouseOver",_cellOverEff);
            _loc1_.addEventListener("mouseOut",_cellOutEff);
            _loc1_.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(_loc1_);
            _loc1_.bagType = _bagType;
            _loc1_.addEventListener("lockChanged",__cellChanged);
            _cells[_loc1_.place] = _loc1_;
            _cellVec.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
      }
      
      public function setMarkDic(param1:int = 1) : void
      {
         var _loc2_:* = null;
         var _loc8_:* = null;
         var _loc5_:MarkBagData = MarkMgr.inst.model.bags[_type];
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         if(_cells)
         {
            var _loc10_:int = 0;
            var _loc9_:* = _cells;
            for each(var _loc3_ in _cells)
            {
               _loc3_.info = null;
            }
         }
         var _loc12_:int = 0;
         var _loc11_:* = _loc5_.chips;
         for(var _loc7_ in _loc5_.chips)
         {
            _loc2_ = _loc5_.chips[_loc7_];
            if(!_loc2_.isbind)
            {
               if(_loc6_ < 42 * (param1 - 1))
               {
                  _loc6_++;
                  continue;
               }
               if(int(_loc4_) < 42)
               {
                  if(_loc2_)
                  {
                     _loc8_ = ItemManager.fillByID(_loc2_.templateId);
                     _loc8_.BagType = _bagType;
                     _loc8_.ItemID = _loc2_.itemID;
                     (_cells[_loc4_] as BagCell).info = _loc8_;
                     (_cells[_loc4_] as BagCell).tipData = _loc2_;
                     (_cells[_loc4_] as BagCell).updateCellStar();
                     _loc4_++;
                  }
                  continue;
               }
               break;
            }
         }
      }
   }
}
