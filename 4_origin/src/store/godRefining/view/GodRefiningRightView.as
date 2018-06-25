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
      
      public function updateView(selectIndex:int) : void
      {
         _selectIndex = selectIndex;
         refreshBagList();
         refreshPropBagList();
      }
      
      private function __startDargHandler(event:StoreDargEvent) : void
      {
         GodRefiningManager.instance.dispatchEvent(new CEvent("godRefining_equip_startdarg",event.target));
      }
      
      private function __stopDargHandler(event:StoreDargEvent) : void
      {
         GodRefiningManager.instance.dispatchEvent(new CEvent("godRefining_equip_stopdarg",event.target));
      }
      
      private function cellClickHandler(event:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var cell:BagCell = event.data as BagCell;
         cell.dragStart();
      }
      
      protected function __cellDoubleClick(evt:CellEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var info:InventoryItemInfo = (evt.data as BagCell).info as InventoryItemInfo;
         if(evt.target == _proBagList)
         {
            GodRefiningManager.instance.dispatchEvent(new CEvent("godRefining_prop_move",info));
         }
         else
         {
            GodRefiningManager.instance.dispatchEvent(new CEvent("godRefining_equip_move",info));
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
      
      private function getEquipProData(bag:DictionaryData, isEquip:Boolean) : DictionaryData
      {
         var _canList:DictionaryData = new DictionaryData();
         var arr:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = bag;
         for each(var item in bag)
         {
            if(isEquip)
            {
               if(item.isCanGodRefining() && item.getRemainDate() > 0)
               {
                  if(item.Place < 17)
                  {
                     _canList.add(_canList.length,item);
                  }
                  else
                  {
                     arr.push(item);
                  }
               }
            }
            else if(EquipType.isArmShellClip(item) || EquipType.isArmShellStone(item))
            {
               _canList.add(_canList.length,item);
            }
         }
         if(isEquip)
         {
            var _loc10_:int = 0;
            var _loc9_:* = arr;
            for each(var infoItem in arr)
            {
               _canList.add(_canList.length,infoItem);
            }
         }
         return _canList;
      }
      
      public function refreshData(items:Dictionary, bag:BagInfo) : void
      {
         var c:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = items;
         for each(var i in items)
         {
            c = bag.getItemAt(i.Place);
            if(c)
            {
               if(bag.BagType == 0)
               {
                  updateEquip(c);
               }
               else if(bag.BagType == 1)
               {
                  updateProp(c);
               }
            }
            else if(bag.BagType == 0)
            {
               removeFrom(i,_equipBagInfo);
            }
            else
            {
               removeFrom(i,_propBagInfo);
            }
         }
      }
      
      private function updateEquip(item:InventoryItemInfo) : void
      {
         if(isProperTo_CanEquipList(item))
         {
            updateDic(_equipBagInfo,item);
         }
         else
         {
            removeFrom(item,_equipBagInfo);
         }
      }
      
      private function updateProp(item:InventoryItemInfo) : void
      {
         if(isProperTo_CanPropList(item))
         {
            updateDic(_propBagInfo,item);
         }
         else
         {
            removeFrom(item,_propBagInfo);
         }
      }
      
      private function isProperTo_CanEquipList(item:InventoryItemInfo) : Boolean
      {
         return EquipType.isArmShell(item);
      }
      
      private function isProperTo_CanPropList(item:InventoryItemInfo) : Boolean
      {
         return EquipType.isArmShellStone(item) || EquipType.isArmShellClip(item);
      }
      
      private function removeFrom(item:InventoryItemInfo, dic:DictionaryData) : void
      {
         var i:int = 0;
         var lth:int = dic.length;
         for(i = 0; i < lth; )
         {
            if(dic[i] && dic[i].Place == item.Place)
            {
               dic[i] = null;
               dic.dispatchEvent(new StoreBagEvent("storeBagRemove",i,item));
               break;
            }
            i++;
         }
      }
      
      private function updateDic(dic:DictionaryData, item:InventoryItemInfo) : void
      {
         var i:int = 0;
         for(i = 0; i < dic.length; )
         {
            if(dic[i] != null && dic[i].Place == item.Place)
            {
               dic.add(i,item);
               dic.dispatchEvent(new UpdateItemEvent("updateItemEvent",i,item));
               return;
            }
            i++;
         }
         addItemToTheFirstNullCell(item,dic);
      }
      
      private function addItemToTheFirstNullCell(item:InventoryItemInfo, dic:DictionaryData) : void
      {
         dic.add(findFirstNullCellID(dic),item);
      }
      
      private function findFirstNullCellID(dic:DictionaryData) : int
      {
         var i:int = 0;
         var result:* = -1;
         var lth:int = dic.length;
         for(i = 0; i <= lth; )
         {
            if(dic[i] == null)
            {
               result = i;
               break;
            }
            i++;
         }
         return result;
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
