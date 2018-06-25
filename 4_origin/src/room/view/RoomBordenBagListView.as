package room.view
{
   import bagAndInfo.bag.CellMenu;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import road7th.data.DictionaryData;
   import store.view.storeBag.StoreBagCell;
   
   public class RoomBordenBagListView extends Sprite implements Disposeable
   {
      
      public static const SMALLGRID:int = 21;
       
      
      protected var _list:SimpleTileList;
      
      protected var panel:ScrollPanel;
      
      protected var _cells:DictionaryData;
      
      protected var _bagdata:DictionaryData;
      
      protected var _bagType:int;
      
      private var cellNum:int = 70;
      
      private var beginGridNumber:int;
      
      private var _columnNum:int;
      
      private var _cell:BagCell;
      
      public function RoomBordenBagListView()
      {
         super();
         addEvent();
      }
      
      public function setup(bagType:int, number:int, columnNum:int = 7) : void
      {
         _bagType = bagType;
         beginGridNumber = number;
         _columnNum = columnNum;
         init();
      }
      
      private function init() : void
      {
         createPanel();
         _list = new SimpleTileList(_columnNum);
         _list.vSpace = 0;
         _list.hSpace = 0;
         panel.setView(_list);
         panel.invalidateViewport();
         createCells();
      }
      
      protected function createCells() : void
      {
         _cells = new DictionaryData();
      }
      
      private function addEvent() : void
      {
         CellMenu.instance.addEventListener("use",__cellUse);
         CellMenu.instance.addEventListener("delete",__cellSell);
         CellMenu.instance.addEventListener("relieve",__cellRelieve);
      }
      
      private function removeEvent() : void
      {
         CellMenu.instance.removeEventListener("use",__cellUse);
         CellMenu.instance.removeEventListener("delete",__cellSell);
         CellMenu.instance.removeEventListener("relieve",__cellRelieve);
      }
      
      private function __cellRelieve(e:Event) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var cell:BagCell = CellMenu.instance.cell;
         if(cell.info.CategoryID == 73)
         {
            SocketManager.Instance.out.sendUseRoomBorden(false,cell.itemInfo.ItemID);
         }
      }
      
      private function __cellUse(e:Event) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var cell:BagCell = CellMenu.instance.cell;
         if(cell.info.CategoryID == 73)
         {
            SocketManager.Instance.out.sendUseRoomBorden(true,cell.itemInfo.ItemID);
         }
      }
      
      private function __cellSell(e:Event) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _cell = CellMenu.instance.cell;
         var info:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_cell.info.TemplateID);
         var msg:String = LanguageMgr.GetTranslation("tank.room.sellRommBorden",info.ReclaimValue);
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),msg,LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),true,false,false,2);
         alert.addEventListener("response",onResponse);
      }
      
      protected function onResponse(e:FrameEvent) : void
      {
         e.target.removeEventListener("response",onResponse);
         SoundManager.instance.play("008");
         switch(int(e.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               if(_cell.info.CategoryID == 73)
               {
                  SocketManager.Instance.out.sendSellRoomBordan(_cell.itemInfo.ItemID,_cell.place);
                  _cell = null;
               }
            default:
               if(_cell.info.CategoryID == 73)
               {
                  SocketManager.Instance.out.sendSellRoomBordan(_cell.itemInfo.ItemID,_cell.place);
                  _cell = null;
               }
         }
      }
      
      protected function createPanel() : void
      {
         panel = ComponentFactory.Instance.creat("ddtstore.roomBorden.BagEquipScrollPanel");
         addChild(panel);
         panel.hScrollProxy = 2;
         panel.vScrollProxy = 0;
      }
      
      protected function createCell(index:int) : void
      {
         var cell:StoreBagCell = new StoreBagCell(index);
         cell.bagType = _bagType;
         cell.tipDirctions = "7,5,2,6,4,1";
         cell.addEventListener("interactive_click",__clickHandler);
         DoubleClickManager.Instance.enableDoubleClick(cell);
         cell.addEventListener("click",__cellClick);
         cell.addEventListener("doubleClick",__doubleCellClick);
         _cells.add(cell.place,cell);
         _list.addChild(cell);
      }
      
      protected function __clickHandler(e:InteractiveEvent) : void
      {
         if(e.currentTarget)
         {
            dispatchEvent(new CellEvent("itemclick",e.currentTarget));
         }
      }
      
      private function addGrid(list:DictionaryData) : void
      {
         var i:int = 0;
         _cells.clear();
         _list.disposeAllChildren();
         var n:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = list;
         for(var key in list)
         {
            n++;
         }
         var needGrid:int = (int((n - 1) / _columnNum) + 1) * _columnNum;
         needGrid = needGrid < beginGridNumber?beginGridNumber:int(needGrid);
         cellNum = needGrid;
         _list.beginChanges();
         for(i = 0; i < needGrid; )
         {
            createCell(i);
            i++;
         }
         _list.commitChanges();
         invalidatePanel();
      }
      
      private function invalidatePanel() : void
      {
         panel.invalidateViewport();
      }
      
      public function setData(list:DictionaryData) : void
      {
         var arr:* = null;
         _bagdata = list;
         addGrid(list);
         if(list)
         {
            arr = [];
            var _loc6_:int = 0;
            var _loc5_:* = list;
            for(var key in list)
            {
               arr.push(key);
            }
            arr.sort(16);
            var _loc8_:int = 0;
            var _loc7_:* = arr;
            for(var i in arr)
            {
               if(_cells[i] != null)
               {
                  _cells[i].info = list[arr[i]];
               }
            }
         }
      }
      
      protected function __doubleCellClick(e:MouseEvent) : void
      {
         __cellUse(null);
      }
      
      protected function __cellClick(e:MouseEvent) : void
      {
         var info:* = null;
         var cell:* = e.currentTarget as BagCell;
         if(cell)
         {
            info = cell.itemInfo as InventoryItemInfo;
         }
         if(info == null)
         {
            return;
         }
         var pos:Point = cell.parent.localToGlobal(new Point(cell.x,cell.y));
         CellMenu.instance.show(cell,pos.x + 20,pos.y + 20);
      }
      
      public function get cells() : DictionaryData
      {
         return _cells;
      }
      
      public function dispose() : void
      {
         removeEvent();
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var i in _cells)
         {
            i.removeEventListener("interactive_click",__clickHandler);
            DoubleClickManager.Instance.disableDoubleClick(i);
            i.removeEventListener("click",__cellClick);
            ObjectUtils.disposeObject(i);
         }
         if(_cells)
         {
            _cells.clear();
         }
         DoubleClickManager.Instance.clearTarget();
         if(_list)
         {
            _list.disposeAllChildren();
            _list = null;
         }
         _cells = null;
         if(panel)
         {
            ObjectUtils.disposeObject(panel);
         }
         panel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
