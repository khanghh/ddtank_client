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
       
      
      public function FineBringUpBagListView(bagType:int, columnNum:int = 7, cellNun:int = 49)
      {
         super(bagType,columnNum,cellNun);
         FineBringUpController.getInstance().addEventListener("latentEnergy_equip_move",equipMoveHandler);
         FineBringUpController.getInstance().addEventListener("latentEnergy_equip_move2",equipMoveHandler2);
         FineBringUpController.getInstance().addEventListener("bringup_item_lock_status",onItemLockStatusUpdate);
      }
      
      protected function onItemLockStatusUpdate(e:CEvent) : void
      {
      }
      
      override protected function createCells() : void
      {
         var i:int = 0;
         var cell:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         for(i = 0; i < _cellNum; )
         {
            cell = LockableBagCell(CellFactory.instance.creteLockableBagCell(i));
            cell.lockDisplayObject = ComponentFactory.Instance.creatBitmap("asset.store.bringup.lock");
            PositionUtils.setPos(cell.lockDisplayObject,"storeBringUp.cellLockPos");
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
            i++;
         }
      }
      
      override protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if(FineBringUpController.getInstance().usingLock == true)
         {
            return;
         }
         var cell:LockableBagCell = evt.target as LockableBagCell;
         if(cell.info)
         {
            if(cell.info.FusionType == 0)
            {
               FineBringUpController.getInstance().isTopLevel();
               return;
            }
            if(cell.info.Property5 == "1")
            {
               FineBringUpController.getInstance().isExpJewelry();
               return;
            }
         }
         super.__doubleClickHandler(evt);
      }
      
      override protected function __clickHandler(evt:InteractiveEvent) : void
      {
         if(FineBringUpController.getInstance().usingLock == true)
         {
            return;
         }
         var cell:LockableBagCell = evt.target as LockableBagCell;
         if(cell.info && cell.info.FusionType == 0)
         {
            FineBringUpController.getInstance().isTopLevel();
            return;
         }
         super.__clickHandler(evt);
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
         SocketManager.Instance.out.sendMoveGoods(event.info.BagType,event.info.Place,12,0);
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
         var info:* = null;
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
         var placeMap:Dictionary = FineBringUpController.getInstance().getPlaceMap();
         var _loc6_:int = 0;
         var _loc5_:* = placeMap;
         for(var key in placeMap)
         {
            info = FineBringUpController.getInstance().getItem(placeMap[key]);
            if(info)
            {
               info.isMoveSpace = true;
            }
            _cells[key].info = info;
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
