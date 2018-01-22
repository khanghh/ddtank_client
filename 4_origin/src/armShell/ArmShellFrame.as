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
      
      private function updateBag(param1:BagEvent) : void
      {
         var _loc2_:BagInfo = param1.target as BagInfo;
         refreshData(param1.changedSlots,_loc2_);
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
                  if(_itemPlace == _loc4_.Place)
                  {
                     _preItemCell.info = _loc3_;
                     removeFrom(_loc4_,_equipBagInfo);
                  }
                  else
                  {
                     updateDic(_equipBagInfo,_loc3_);
                  }
               }
            }
            else if(param2.BagType == 0)
            {
               if(_itemPlace == _loc4_.Place)
               {
                  _preItemCell.info = null;
               }
               removeFrom(_loc4_,_equipBagInfo);
            }
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
      
      private function refreshBagList() : void
      {
         _equipBagInfo = getEquipProData(PlayerManager.Instance.Self.Bag.items);
         _bagListView.setData(_equipBagInfo);
      }
      
      private function getEquipProData(param1:DictionaryData) : DictionaryData
      {
         var _loc2_:DictionaryData = new DictionaryData();
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            if(EquipType.isArmShell(_loc3_) && _loc3_.getRemainDate() > 0)
            {
               if(_loc3_.Place > 20)
               {
                  _loc2_.add(_loc2_.length,_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function cellClickHandler(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BagCell = param1.data as BagCell;
         _loc2_.dragStart();
      }
      
      protected function __cellDoubleClick(param1:CellEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:InventoryItemInfo = (param1.data as BagCell).info as InventoryItemInfo;
         if(EquipType.isArmShell(_loc3_))
         {
            _loc2_ = EquipType.CategeryIdToPlace(_loc3_.CategoryID)[0];
            SocketManager.Instance.out.sendMoveGoods(0,_loc3_.Place,0,_loc2_,1,true);
         }
      }
      
      private function __startDargHandler(param1:StoreDargEvent) : void
      {
         _preItemCell.startShine();
      }
      
      private function __stopDargHandler(param1:StoreDargEvent) : void
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
