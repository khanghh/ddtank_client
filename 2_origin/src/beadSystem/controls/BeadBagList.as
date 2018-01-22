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
      
      public function BeadBagList(param1:int, param2:int = 32, param3:int = 80, param4:int = 7)
      {
         _startIndex = param2;
         _stopIndex = param3;
         super(param1,param4);
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         var _loc2_:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc3_:InventoryItemInfo = (param1.currentTarget as BeadCell).itemInfo;
         _beadInfo = _loc3_;
         if(_loc3_ && !_loc3_.IsBinds)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.useBindBead"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _loc2_.addEventListener("response",__onBindRespones);
         }
         else
         {
            doBeadEquip();
         }
      }
      
      private function doBeadEquip() : void
      {
         var _loc1_:int = 0;
         if(_beadInfo)
         {
            if(_beadInfo.Property1 == "31")
            {
               if(!_beadInfo.IsBinds)
               {
               }
               _loc1_ = beadSystemManager.Instance.getEquipPlace(_beadInfo);
               if(PlayerManager.Instance.Self.BeadBag.getItemAt(4) && _loc1_ == 4)
               {
                  if(!PlayerManager.Instance.Self.BeadBag.getItemAt(13) && BeadModel._BeadCells[13].isOpend && beadSystemManager.Instance.judgeLevel(_beadInfo.Hole1,BeadModel._BeadCells[13].HoleLv))
                  {
                     _loc1_ = 13;
                  }
                  else if(!PlayerManager.Instance.Self.BeadBag.getItemAt(14) && BeadModel._BeadCells[14].isOpend && beadSystemManager.Instance.judgeLevel(_beadInfo.Hole1,BeadModel._BeadCells[14].HoleLv))
                  {
                     _loc1_ = 14;
                  }
                  else if(!PlayerManager.Instance.Self.BeadBag.getItemAt(15) && BeadModel._BeadCells[15].isOpend && beadSystemManager.Instance.judgeLevel(_beadInfo.Hole1,BeadModel._BeadCells[15].HoleLv))
                  {
                     _loc1_ = 15;
                  }
                  else if(!PlayerManager.Instance.Self.BeadBag.getItemAt(16) && BeadModel._BeadCells[16].isOpend && beadSystemManager.Instance.judgeLevel(_beadInfo.Hole1,BeadModel._BeadCells[16].HoleLv))
                  {
                     _loc1_ = 16;
                  }
                  else if(!PlayerManager.Instance.Self.BeadBag.getItemAt(17) && BeadModel._BeadCells[17].isOpend && beadSystemManager.Instance.judgeLevel(_beadInfo.Hole1,BeadModel._BeadCells[17].HoleLv))
                  {
                     _loc1_ = 17;
                  }
                  else if(!PlayerManager.Instance.Self.BeadBag.getItemAt(18) && BeadModel._BeadCells[18].isOpend && beadSystemManager.Instance.judgeLevel(_beadInfo.Hole1,BeadModel._BeadCells[18].HoleLv))
                  {
                     _loc1_ = 18;
                  }
               }
               SocketManager.Instance.out.sendBeadEquip(_beadInfo.Place,_loc1_);
            }
         }
      }
      
      protected function __onBindRespones(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               break;
            case 2:
            case 3:
            case 4:
               doBeadEquip();
         }
         param1.currentTarget.removeEventListener("response",__onBindRespones);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      public function get BeadCells() : Dictionary
      {
         return _cells;
      }
      
      override protected function createCells() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         _loc2_ = _startIndex;
         while(_loc2_ <= _stopIndex)
         {
            _loc1_ = BeadCell(CellFactory.instance.createBeadCell(_loc2_));
            addChild(_loc1_);
            _loc1_.addEventListener("interactive_click",__clickHandler);
            _loc1_.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(_loc1_);
            _loc1_.addEventListener("lockChanged",__cellChanged);
            _cells[_loc1_.beadPlace] = _loc1_;
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
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoods);
         }
         clearDataCells();
         _bagdata = param1;
         var _loc4_:int = 0;
         var _loc3_:* = _bagdata.items;
         for(var _loc2_ in _bagdata.items)
         {
            if(_cells[_loc2_] != null)
            {
               _bagdata.items[_loc2_].isMoveSpace = true;
               _cells[_loc2_].itemInfo = _bagdata.items[_loc2_];
               _cells[_loc2_].info = _bagdata.items[_loc2_];
            }
         }
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
      
      override protected function __clickHandler(param1:InteractiveEvent) : void
      {
         if((param1.currentTarget as BeadCell).info != null)
         {
            dispatchEvent(new CellEvent("itemclick",param1.currentTarget,false,false,param1.ctrlKey));
         }
      }
      
      override public function setCellInfo(param1:int, param2:InventoryItemInfo) : void
      {
         if(param1 >= _startIndex && param1 <= _stopIndex)
         {
            if(param2 == null)
            {
               _cells[param1].info = null;
               _cells[param1].itemInfo = null;
               return;
            }
            if(param2.Count == 0)
            {
               _cells[param1].info = null;
               _cells[param1].itemInfo = null;
            }
            else
            {
               _cells[param1].itemInfo = param2;
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
            _loc1_.locked = false;
            _loc1_.dispose();
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
