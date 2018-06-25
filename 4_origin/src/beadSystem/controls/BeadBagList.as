package beadSystem.controls
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import beadSystem.beadSystemManager;
   import beadSystem.model.BeadModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class BeadBagList extends BagListView
   {
       
      
      public var _startIndex:int;
      
      public var _stopIndex:int;
      
      private var _toPlace:int;
      
      private var _beadInfo:InventoryItemInfo;
      
      public function BeadBagList(bagType:int, startIndex:int = 32, stopIndex:int = 80, columnNum:int = 7)
      {
         _startIndex = startIndex;
         _stopIndex = stopIndex;
         super(bagType,columnNum);
      }
      
      override protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         var bindAlert:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var info:InventoryItemInfo = (evt.currentTarget as BeadCell).itemInfo;
         _beadInfo = info;
         if(info && !info.IsBinds)
         {
            bindAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.useBindBead"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            bindAlert.addEventListener("response",__onBindRespones);
         }
         else
         {
            doBeadEquip();
         }
      }
      
      private function doBeadEquip() : void
      {
         var vToPlace:int = 0;
         if(_beadInfo)
         {
            if(_beadInfo.Property1 == "31")
            {
               if(!_beadInfo.IsBinds)
               {
               }
               vToPlace = beadSystemManager.Instance.getEquipPlace(_beadInfo);
               if(PlayerManager.Instance.Self.BeadBag.getItemAt(4) && vToPlace == 4)
               {
                  if(!PlayerManager.Instance.Self.BeadBag.getItemAt(13) && BeadModel._BeadCells[13].isOpend && beadSystemManager.Instance.judgeLevel(_beadInfo.Hole1,BeadModel._BeadCells[13].HoleLv))
                  {
                     vToPlace = 13;
                  }
                  else if(!PlayerManager.Instance.Self.BeadBag.getItemAt(14) && BeadModel._BeadCells[14].isOpend && beadSystemManager.Instance.judgeLevel(_beadInfo.Hole1,BeadModel._BeadCells[14].HoleLv))
                  {
                     vToPlace = 14;
                  }
                  else if(!PlayerManager.Instance.Self.BeadBag.getItemAt(15) && BeadModel._BeadCells[15].isOpend && beadSystemManager.Instance.judgeLevel(_beadInfo.Hole1,BeadModel._BeadCells[15].HoleLv))
                  {
                     vToPlace = 15;
                  }
                  else if(!PlayerManager.Instance.Self.BeadBag.getItemAt(16) && BeadModel._BeadCells[16].isOpend && beadSystemManager.Instance.judgeLevel(_beadInfo.Hole1,BeadModel._BeadCells[16].HoleLv))
                  {
                     vToPlace = 16;
                  }
                  else if(!PlayerManager.Instance.Self.BeadBag.getItemAt(17) && BeadModel._BeadCells[17].isOpend && beadSystemManager.Instance.judgeLevel(_beadInfo.Hole1,BeadModel._BeadCells[17].HoleLv))
                  {
                     vToPlace = 17;
                  }
                  else if(!PlayerManager.Instance.Self.BeadBag.getItemAt(18) && BeadModel._BeadCells[18].isOpend && beadSystemManager.Instance.judgeLevel(_beadInfo.Hole1,BeadModel._BeadCells[18].HoleLv))
                  {
                     vToPlace = 18;
                  }
               }
               SocketManager.Instance.out.sendBeadEquip(_beadInfo.Place,vToPlace);
            }
         }
      }
      
      protected function __onBindRespones(pEvent:FrameEvent) : void
      {
         switch(int(pEvent.responseCode))
         {
            case 0:
            case 1:
               break;
            case 2:
            case 3:
            case 4:
               doBeadEquip();
         }
         pEvent.currentTarget.removeEventListener("response",__onBindRespones);
         ObjectUtils.disposeObject(pEvent.currentTarget);
      }
      
      public function get BeadCells() : Dictionary
      {
         return _cells;
      }
      
      override protected function createCells() : void
      {
         var i:int = 0;
         var cell:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         for(i = _startIndex; i <= _stopIndex; )
         {
            cell = BeadCell(CellFactory.instance.createBeadCell(i));
            addChild(cell);
            cell.addEventListener("interactive_click",__clickHandler);
            cell.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(cell);
            cell.addEventListener("lockChanged",__cellChanged);
            _cells[cell.beadPlace] = cell;
            _cellVec.push(cell);
            i++;
         }
      }
      
      override public function setData(bag:BagInfo) : void
      {
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
         var _loc4_:int = 0;
         var _loc3_:* = _bagdata.items;
         for(var i in _bagdata.items)
         {
            if(_cells[i] != null)
            {
               _bagdata.items[i].isMoveSpace = true;
               _cells[i].itemInfo = _bagdata.items[i];
               _cells[i].info = _bagdata.items[i];
            }
         }
         _bagdata.addEventListener("update",__updateGoods);
      }
      
      override protected function __updateGoods(evt:BagEvent) : void
      {
         var c:* = null;
         var changes:Dictionary = evt.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = changes;
         for each(var i in changes)
         {
            c = _bagdata.getItemAt(i.Place);
            if(c)
            {
               setCellInfo(c.Place,c);
            }
            else
            {
               setCellInfo(i.Place,null);
            }
            dispatchEvent(new Event("change"));
         }
      }
      
      override protected function __clickHandler(evt:InteractiveEvent) : void
      {
         if((evt.currentTarget as BeadCell).info != null)
         {
            dispatchEvent(new CellEvent("itemclick",evt.currentTarget,false,false,evt.ctrlKey));
         }
      }
      
      override public function setCellInfo(index:int, info:InventoryItemInfo) : void
      {
         if(index >= _startIndex && index <= _stopIndex)
         {
            if(info == null)
            {
               _cells[index].info = null;
               _cells[index].itemInfo = null;
               return;
            }
            if(info.Count == 0)
            {
               _cells[index].info = null;
               _cells[index].itemInfo = null;
            }
            else
            {
               _cells[index].itemInfo = info;
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
            cell.locked = false;
            cell.dispose();
         }
         _cells = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
