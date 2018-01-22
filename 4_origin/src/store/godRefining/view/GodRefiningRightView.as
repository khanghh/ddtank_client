package store.godRefining.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CEvent;
   import ddt.events.CellEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import store.events.StoreBagEvent;
   import store.events.StoreDargEvent;
   import store.events.UpdateItemEvent;
   import store.forge.ForgeRightBgView;
   import store.godRefining.GodRefiningManager;
   
   public class GodRefiningRightView extends ForgeRightBgView
   {
       
      
      private var _bagList:GodRefiningBagListView;
      
      private var _proBagList:GodRefiningBagListView;
      
      private var _equipBagInfo:DictionaryData;
      
      private var _propBagInfo:DictionaryData;
      
      private var _selectIndex:int;
      
      public function GodRefiningRightView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bagList = new GodRefiningBagListView();
         _bagList.setup(0,null,21);
         PositionUtils.setPos(_bagList,"godRefiningRightView.bagListPos");
         addChild(_bagList);
         _proBagList = new GodRefiningBagListView();
         _proBagList.setup(1,null,21);
         PositionUtils.setPos(_proBagList,"godRefiningRightView.proBagListPos");
         addChild(_proBagList);
         showStoreBagViewText("store.GodRefining.ItemTip.Text1","store.StoreBagView.ItemTip.Text1");
      }
      
      private function initEvent() : void
      {
         _bagList.addEventListener("itemclick",cellClickHandler,false,0,true);
         _bagList.addEventListener("doubleclick",__cellDoubleClick,false,0,true);
         _bagList.addEventListener("startDarg",__startDargHandler);
         _bagList.addEventListener("stopDarg",__stopDargHandler);
         _proBagList.addEventListener("itemclick",cellClickHandler,false,0,true);
         _proBagList.addEventListener("doubleclick",__cellDoubleClick,false,0,true);
         _proBagList.addEventListener("startDarg",__startDargHandler);
         _proBagList.addEventListener("stopDarg",__stopDargHandler);
      }
      
      public function updateView(param1:int) : void
      {
         _selectIndex = param1;
         refreshBagList();
         refreshPropBagList();
      }
      
      private function __startDargHandler(param1:StoreDargEvent) : void
      {
         GodRefiningManager.instance.dispatchEvent(new CEvent("godRefining_equip_startdarg",param1.target));
      }
      
      private function __stopDargHandler(param1:StoreDargEvent) : void
      {
         GodRefiningManager.instance.dispatchEvent(new CEvent("godRefining_equip_stopdarg",param1.target));
      }
      
      private function cellClickHandler(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BagCell = param1.data as BagCell;
         _loc2_.dragStart();
      }
      
      protected function __cellDoubleClick(param1:CellEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:InventoryItemInfo = (param1.data as BagCell).info as InventoryItemInfo;
         if(param1.target == _proBagList)
         {
            GodRefiningManager.instance.dispatchEvent(new CEvent("godRefining_prop_move",_loc2_));
         }
         else
         {
            GodRefiningManager.instance.dispatchEvent(new CEvent("godRefining_equip_move",_loc2_));
         }
      }
      
      private function refreshBagList() : void
      {
         _equipBagInfo = getEquipProData(PlayerManager.Instance.Self.Bag.items,true);
         _bagList.setData(_equipBagInfo);
      }
      
      private function refreshPropBagList() : void
      {
         _propBagInfo = getEquipProData(PlayerManager.Instance.Self.PropBag.items,false);
         _proBagList.setData(_propBagInfo);
      }
      
      private function getEquipProData(param1:DictionaryData, param2:Boolean) : DictionaryData
      {
         var _loc4_:DictionaryData = new DictionaryData();
         var _loc5_:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(var _loc6_ in param1)
         {
            if(param2)
            {
               if(_loc6_.isCanGodRefining() && _loc6_.getRemainDate() > 0)
               {
                  if(_loc6_.Place < 17)
                  {
                     _loc4_.add(_loc4_.length,_loc6_);
                  }
                  else
                  {
                     _loc5_.push(_loc6_);
                  }
               }
            }
            else if(EquipType.isArmShellClip(_loc6_) || EquipType.isArmShellStone(_loc6_))
            {
               _loc4_.add(_loc4_.length,_loc6_);
            }
         }
         if(param2)
         {
            var _loc10_:int = 0;
            var _loc9_:* = _loc5_;
            for each(var _loc3_ in _loc5_)
            {
               _loc4_.add(_loc4_.length,_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function refreshData(param1:Dictionary, param2:BagInfo) : void
      {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc4_ in param1)
         {
            _loc3_ = param2.getItemAt(_loc4_.Place);
            if(_loc3_)
            {
               if(param2.BagType == 0)
               {
                  updateEquip(_loc3_);
               }
               else if(param2.BagType == 1)
               {
                  updateProp(_loc3_);
               }
            }
            else if(param2.BagType == 0)
            {
               removeFrom(_loc4_,_equipBagInfo);
            }
            else
            {
               removeFrom(_loc4_,_propBagInfo);
            }
         }
      }
      
      private function updateEquip(param1:InventoryItemInfo) : void
      {
         if(isProperTo_CanEquipList(param1))
         {
            updateDic(_equipBagInfo,param1);
         }
         else
         {
            removeFrom(param1,_equipBagInfo);
         }
      }
      
      private function updateProp(param1:InventoryItemInfo) : void
      {
         if(isProperTo_CanPropList(param1))
         {
            updateDic(_propBagInfo,param1);
         }
         else
         {
            removeFrom(param1,_propBagInfo);
         }
      }
      
      private function isProperTo_CanEquipList(param1:InventoryItemInfo) : Boolean
      {
         return EquipType.isArmShell(param1);
      }
      
      private function isProperTo_CanPropList(param1:InventoryItemInfo) : Boolean
      {
         return EquipType.isArmShellStone(param1) || EquipType.isArmShellClip(param1);
      }
      
      private function removeFrom(param1:InventoryItemInfo, param2:DictionaryData) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = param2.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(param2[_loc4_] && param2[_loc4_].Place == param1.Place)
            {
               param2[_loc4_] = null;
               param2.dispatchEvent(new StoreBagEvent("storeBagRemove",_loc4_,param1));
               break;
            }
            _loc4_++;
         }
      }
      
      private function updateDic(param1:DictionaryData, param2:InventoryItemInfo) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] != null && param1[_loc3_].Place == param2.Place)
            {
               param1.add(_loc3_,param2);
               param1.dispatchEvent(new UpdateItemEvent("updateItemEvent",_loc3_,param2));
               return;
            }
            _loc3_++;
         }
         addItemToTheFirstNullCell(param2,param1);
      }
      
      private function addItemToTheFirstNullCell(param1:InventoryItemInfo, param2:DictionaryData) : void
      {
         param2.add(findFirstNullCellID(param2),param1);
      }
      
      private function findFirstNullCellID(param1:DictionaryData) : int
      {
         var _loc4_:int = 0;
         var _loc2_:* = -1;
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ <= _loc3_)
         {
            if(param1[_loc4_] == null)
            {
               _loc2_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function removeEvent() : void
      {
         _bagList.removeEventListener("itemclick",cellClickHandler);
         _bagList.removeEventListener("doubleclick",__cellDoubleClick);
         _bagList.removeEventListener("startDarg",__startDargHandler);
         _bagList.removeEventListener("stopDarg",__stopDargHandler);
         _proBagList.removeEventListener("itemclick",cellClickHandler);
         _proBagList.removeEventListener("doubleclick",__cellDoubleClick);
         _proBagList.removeEventListener("startDarg",__startDargHandler);
         _proBagList.removeEventListener("stopDarg",__stopDargHandler);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         ObjectUtils.disposeObject(_bagList);
         _bagList = null;
         ObjectUtils.disposeObject(_proBagList);
         _proBagList = null;
         _equipBagInfo = null;
      }
   }
}
