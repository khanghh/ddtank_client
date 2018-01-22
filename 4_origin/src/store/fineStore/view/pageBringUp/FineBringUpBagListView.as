package store.fineStore.view.pageBringUp
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import bagAndInfo.cell.LockableBagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CEvent;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.utils.Dictionary;
   import latentEnergy.LatentEnergyEvent;
   import store.FineBringUpController;
   
   public class FineBringUpBagListView extends BagListView
   {
       
      
      public function FineBringUpBagListView(param1:int, param2:int = 7, param3:int = 49)
      {
         super(param1,param2,param3);
         FineBringUpController.getInstance().addEventListener("latentEnergy_equip_move",equipMoveHandler);
         FineBringUpController.getInstance().addEventListener("latentEnergy_equip_move2",equipMoveHandler2);
         FineBringUpController.getInstance().addEventListener("bringup_item_lock_status",onItemLockStatusUpdate);
      }
      
      protected function onItemLockStatusUpdate(param1:CEvent) : void
      {
      }
      
      override protected function createCells() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         _loc2_ = 0;
         while(_loc2_ < _cellNum)
         {
            _loc1_ = LockableBagCell(CellFactory.instance.creteLockableBagCell(_loc2_));
            _loc1_.lockDisplayObject = ComponentFactory.Instance.creatBitmap("asset.store.bringup.lock");
            PositionUtils.setPos(_loc1_.lockDisplayObject,"storeBringUp.cellLockPos");
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
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if(FineBringUpController.getInstance().usingLock == true)
         {
            return;
         }
         var _loc2_:LockableBagCell = param1.target as LockableBagCell;
         if(_loc2_.info)
         {
            if(_loc2_.info.FusionType == 0)
            {
               FineBringUpController.getInstance().isTopLevel();
               return;
            }
            if(_loc2_.info.Property5 == "1")
            {
               FineBringUpController.getInstance().isExpJewelry();
               return;
            }
         }
         super.__doubleClickHandler(param1);
      }
      
      override protected function __clickHandler(param1:InteractiveEvent) : void
      {
         if(FineBringUpController.getInstance().usingLock == true)
         {
            return;
         }
         var _loc2_:LockableBagCell = param1.target as LockableBagCell;
         if(_loc2_.info && _loc2_.info.FusionType == 0)
         {
            FineBringUpController.getInstance().isTopLevel();
            return;
         }
         super.__clickHandler(param1);
      }
      
      private function equipMoveHandler(param1:LatentEnergyEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:InventoryItemInfo = param1.info;
         _loc3_ = 0;
         while(_loc3_ < _cellNum)
         {
            if(_cells[_loc3_].info == _loc2_)
            {
               _cells[_loc3_].info = null;
               break;
            }
            _loc3_++;
         }
         SocketManager.Instance.out.sendMoveGoods(param1.info.BagType,param1.info.Place,12,0);
      }
      
      private function equipMoveHandler2(param1:LatentEnergyEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:InventoryItemInfo = param1.info;
         if(param1.moveType == 2)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _cells;
            for each(var _loc2_ in _cells)
            {
               if(_loc2_.info == _loc3_)
               {
                  return;
               }
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _cellNum)
         {
            if(!_cells[_loc4_].info)
            {
               _cells[_loc4_].info = _loc3_;
               break;
            }
            _loc4_++;
         }
      }
      
      override public function setData(param1:BagInfo) : void
      {
         var _loc4_:* = null;
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
         var _loc2_:Dictionary = FineBringUpController.getInstance().getPlaceMap();
         var _loc6_:int = 0;
         var _loc5_:* = _loc2_;
         for(var _loc3_ in _loc2_)
         {
            _loc4_ = FineBringUpController.getInstance().getItem(_loc2_[_loc3_]);
            if(_loc4_)
            {
               _loc4_.isMoveSpace = true;
            }
            _cells[_loc3_].info = _loc4_;
         }
         _bagdata.addEventListener("update",__updateGoods);
      }
      
      override public function dispose() : void
      {
         FineBringUpController.getInstance().removeEventListener("latentEnergy_equip_move",equipMoveHandler);
         FineBringUpController.getInstance().removeEventListener("latentEnergy_equip_move2",equipMoveHandler2);
         FineBringUpController.getInstance().removeEventListener("bringup_item_lock_status",onItemLockStatusUpdate);
         super.dispose();
      }
   }
}
