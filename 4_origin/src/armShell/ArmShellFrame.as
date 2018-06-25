package armShell
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import ddt.data.BagInfo;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import store.events.StoreBagEvent;
   import store.events.StoreDargEvent;
   import store.events.UpdateItemEvent;
   
   public class ArmShellFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _preItemCell:ArmShellItemCell;
      
      private var _bagListView:ArmShellBagListView;
      
      private var _equipBagInfo:DictionaryData;
      
      private var _itemPlace:int;
      
      public function ArmShellFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = LanguageMgr.GetTranslation("core.godRefiningArmShellFrame.title");
         autoExit = true;
         escEnable = true;
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         _itemPlace = EquipType.CategeryIdToPlace(64)[0];
         _bg = ComponentFactory.Instance.creatBitmap("asset.ddtcorei.armShellFrameBg");
         addToContent(_bg);
         _preItemCell = new ArmShellItemCell([64],_itemPlace);
         _preItemCell.info = PlayerManager.Instance.Self.Bag.getItemAt(20);
         PositionUtils.setPos(_preItemCell,"asset.ddtcorei.armShellItemCellPos");
         addToContent(_preItemCell);
         _bagListView = new ArmShellBagListView();
         _bagListView.setup(0,null,9,3);
         PositionUtils.setPos(_bagListView,"asset.ddtcorei.armShellBagListPos");
         addToContent(_bagListView);
         refreshBagList();
      }
      
      private function addEvents() : void
      {
         addEventListener("response",__responseHandler);
         PlayerManager.Instance.Self.Bag.addEventListener("update",updateBag);
         _bagListView.addEventListener("itemclick",cellClickHandler,false,0,true);
         _bagListView.addEventListener("doubleclick",__cellDoubleClick,false,0,true);
         _bagListView.addEventListener("startDarg",__startDargHandler);
         _bagListView.addEventListener("stopDarg",__stopDargHandler);
      }
      
      private function updateBag(evt:BagEvent) : void
      {
         var bag:BagInfo = evt.target as BagInfo;
         refreshData(evt.changedSlots,bag);
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
                  if(_itemPlace == i.Place)
                  {
                     _preItemCell.info = c;
                     removeFrom(i,_equipBagInfo);
                  }
                  else
                  {
                     updateDic(_equipBagInfo,c);
                  }
               }
            }
            else if(bag.BagType == 0)
            {
               if(_itemPlace == i.Place)
               {
                  _preItemCell.info = null;
               }
               removeFrom(i,_equipBagInfo);
            }
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
      
      private function refreshBagList() : void
      {
         _equipBagInfo = getEquipProData(PlayerManager.Instance.Self.Bag.items);
         _bagListView.setData(_equipBagInfo);
      }
      
      private function getEquipProData(bag:DictionaryData) : DictionaryData
      {
         var _canList:DictionaryData = new DictionaryData();
         var _loc5_:int = 0;
         var _loc4_:* = bag;
         for each(var item in bag)
         {
            if(EquipType.isArmShell(item) && item.getRemainDate() > 0)
            {
               if(item.Place > 20)
               {
                  _canList.add(_canList.length,item);
               }
            }
         }
         return _canList;
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function cellClickHandler(event:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var cell:BagCell = event.data as BagCell;
         cell.dragStart();
      }
      
      protected function __cellDoubleClick(evt:CellEvent) : void
      {
         var toPlace:int = 0;
         var info:InventoryItemInfo = (evt.data as BagCell).info as InventoryItemInfo;
         if(EquipType.isArmShell(info))
         {
            toPlace = EquipType.CategeryIdToPlace(info.CategoryID)[0];
            SocketManager.Instance.out.sendMoveGoods(0,info.Place,0,toPlace,1,true);
         }
      }
      
      private function __startDargHandler(event:StoreDargEvent) : void
      {
         _preItemCell.startShine();
      }
      
      private function __stopDargHandler(event:StoreDargEvent) : void
      {
         _preItemCell.stopShine();
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__responseHandler);
         PlayerManager.Instance.Self.Bag.removeEventListener("update",updateBag);
         _bagListView.removeEventListener("itemclick",cellClickHandler);
         _bagListView.removeEventListener("doubleclick",__cellDoubleClick);
         _bagListView.removeEventListener("startDarg",__startDargHandler);
         _bagListView.removeEventListener("stopDarg",__stopDargHandler);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         _bg = null;
         _preItemCell = null;
         _bagListView = null;
         _equipBagInfo = null;
         super.dispose();
      }
   }
}
