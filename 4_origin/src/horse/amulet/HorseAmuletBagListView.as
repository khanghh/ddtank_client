package horse.amulet
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
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
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import horse.HorseAmuletManager;
   import horse.data.HorseAmuletVo;
   
   public class HorseAmuletBagListView extends BagListView
   {
      
      public static const MIN_PLACE:int = 20;
      
      public static const MAX_PLACE:int = 167;
       
      
      private var _startIndex:int;
      
      private var _endIndex:int;
      
      private var _alertFrame:BaseAlerFrame;
      
      private var _currentPage:int;
      
      private var _place:int;
      
      public function HorseAmuletBagListView(bagType:int, columnNum:int = 7, cellNun:int = 49)
      {
         super(bagType,columnNum,cellNun);
      }
      
      public function set currentPage(value:int) : void
      {
         if(_currentPage == value)
         {
            return;
         }
         _currentPage = value;
         _startIndex = 20 + (_currentPage - 1) * 49;
         _endIndex = _startIndex + 49;
         updateBag();
      }
      
      override protected function createCells() : void
      {
         var i:int = 0;
         var cell:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         for(i = 0; i < _cellNum; )
         {
            cell = new HorseAmuletCell(i + 20);
            CellFactory.instance.fillTipProp(cell);
            cell.mouseOverEffBoolean = false;
            addChild(cell);
            cell.addEventListener("interactive_click",__clickHandler);
            cell.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(cell);
            cell.bagType = _bagType;
            cell.addEventListener("lockChanged",__cellChanged);
            _cells[i] = cell;
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
         _bagdata = bag;
         currentPage = 1;
         _bagdata.addEventListener("update",__updateGoods);
      }
      
      private function updateBag() : void
      {
         var i:int = 0;
         var info:* = null;
         var _infoArr:Array = [];
         var index:int = 0;
         for(i = _startIndex; i < _endIndex; )
         {
            index = (i - 20) % 49;
            info = _bagdata.getItemAt(i) as InventoryItemInfo;
            _cells[index].info = info;
            _cells[index].place = i;
            _infoArr.push(_cells[index]);
            i++;
         }
         _cellsSort(_infoArr);
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
      
      override public function setCellInfo($index:int, info:InventoryItemInfo) : void
      {
         if($index < _startIndex || $index >= _endIndex)
         {
            return;
         }
         var index:int = ($index - 20) % 49;
         if(info == null)
         {
            if(_cells[index])
            {
               _cells[index].info = null;
            }
            return;
         }
         if(info.Count == 0)
         {
            _cells[index].info = null;
         }
         else
         {
            _cells[index].info = info;
         }
      }
      
      override protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         var place:int = 0;
         var bagCell:BagCell = evt.currentTarget as BagCell;
         if(bagCell.info == null)
         {
            return;
         }
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var vo:HorseAmuletVo = HorseAmuletManager.instance.getHorseAmuletVo((evt.currentTarget as BagCell).info.TemplateID);
         if(HorseAmuletManager.instance.viewType == 2)
         {
            if(vo.IsCanWash)
            {
               if(HorseAmuletManager.instance.isActivate)
               {
                  _place = bagCell.place;
                  _alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.horseAmulet.replaceTips"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true);
                  _alertFrame.addEventListener("response",__onClickFrame);
               }
               else
               {
                  SocketManager.Instance.out.sendAmuletMove(bagCell.place,19);
               }
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.activateFail"));
            }
         }
         else if(HorseAmuletManager.instance.viewType == 1)
         {
            place = HorseAmuletManager.instance.canPutInEquipAmulet();
            if(place == -1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.maxPutInEquipTips"));
            }
            else
            {
               if(!vo.IsCanWash)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.notEquip"));
                  return;
               }
               if(!HorseAmuletManager.instance.canEquipAmulet(bagCell.info.TemplateID))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.typeTips"));
                  return;
               }
               SocketManager.Instance.out.sendAmuletMove(bagCell.place,place);
            }
         }
      }
      
      private function __onClickFrame(e:FrameEvent) : void
      {
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            SocketManager.Instance.out.sendAmuletMove(_place,19);
         }
         disposeAlertFrame();
      }
      
      private function disposeAlertFrame() : void
      {
         if(_alertFrame)
         {
            _alertFrame.removeEventListener("response",__onClickFrame);
            ObjectUtils.disposeObject(_alertFrame);
            _alertFrame = null;
         }
      }
      
      private function _cellsSort(arr:Array) : void
      {
         var i:int = 0;
         var oldx:Number = NaN;
         var oldy:Number = NaN;
         var n:int = 0;
         var oldCell:* = null;
         if(arr.length <= 0)
         {
            return;
         }
         i = 0;
         while(i < arr.length)
         {
            oldx = arr[i].x;
            oldy = arr[i].y;
            n = _cellVec.indexOf(arr[i]);
            oldCell = _cellVec[i];
            arr[i].x = oldCell.x;
            arr[i].y = oldCell.y;
            oldCell.x = oldx;
            oldCell.y = oldy;
            _cellVec[i] = arr[i];
            _cellVec[n] = oldCell;
            i++;
         }
      }
      
      public function getAllEnableSmashPlaceList() : Array
      {
         var i:int = 0;
         var cell:* = null;
         var list:Array = [];
         var isConfirm:Boolean = false;
         for(i = 0; i < _cellVec.length; )
         {
            cell = _cellVec[i];
            if(cell.itemInfo && !cell.itemInfo.cellLocked)
            {
               if(HorseAmuletManager.instance.isHighQuality(cell.itemInfo.TemplateID))
               {
                  isConfirm = true;
               }
               list.push(cell.place);
            }
            i++;
         }
         list.push(isConfirm);
         return list;
      }
      
      public function lockCellByPlace(lock:Boolean, placeList:Array) : void
      {
         var i:int = 0;
         var cell:* = null;
         for(i = 0; i < _cellVec.length; )
         {
            cell = _cellVec[i];
            if(placeList.indexOf(cell.place) != -1)
            {
               cell.locked = lock;
            }
            i++;
         }
      }
      
      override public function dispose() : void
      {
         disposeAlertFrame();
         super.dispose();
      }
   }
}
