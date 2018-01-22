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
      
      public function setup(param1:int, param2:int, param3:int = 7) : void
      {
         _bagType = param1;
         beginGridNumber = param2;
         _columnNum = param3;
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
      
      private function __cellRelieve(param1:Event) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BagCell = CellMenu.instance.cell;
         if(_loc2_.info.CategoryID == 73)
         {
            SocketManager.Instance.out.sendUseRoomBorden(false,_loc2_.itemInfo.ItemID);
         }
      }
      
      private function __cellUse(param1:Event) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BagCell = CellMenu.instance.cell;
         if(_loc2_.info.CategoryID == 73)
         {
            SocketManager.Instance.out.sendUseRoomBorden(true,_loc2_.itemInfo.ItemID);
         }
      }
      
      private function __cellSell(param1:Event) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _cell = CellMenu.instance.cell;
         var _loc4_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_cell.info.TemplateID);
         var _loc3_:String = LanguageMgr.GetTranslation("tank.room.sellRommBorden",_loc4_.ReclaimValue);
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),_loc3_,LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),true,false,false,2);
         _loc2_.addEventListener("response",onResponse);
      }
      
      protected function onResponse(param1:FrameEvent) : void
      {
         param1.target.removeEventListener("response",onResponse);
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
      
      protected function createCell(param1:int) : void
      {
         var _loc2_:StoreBagCell = new StoreBagCell(param1);
         _loc2_.bagType = _bagType;
         _loc2_.tipDirctions = "7,5,2,6,4,1";
         _loc2_.addEventListener("interactive_click",__clickHandler);
         DoubleClickManager.Instance.enableDoubleClick(_loc2_);
         _loc2_.addEventListener("click",__cellClick);
         _loc2_.addEventListener("doubleClick",__doubleCellClick);
         _cells.add(_loc2_.place,_loc2_);
         _list.addChild(_loc2_);
      }
      
      protected function __clickHandler(param1:InteractiveEvent) : void
      {
         if(param1.currentTarget)
         {
            dispatchEvent(new CellEvent("itemclick",param1.currentTarget));
         }
      }
      
      private function addGrid(param1:DictionaryData) : void
      {
         var _loc5_:int = 0;
         _cells.clear();
         _list.disposeAllChildren();
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for(var _loc4_ in param1)
         {
            _loc3_++;
         }
         var _loc2_:int = (int((_loc3_ - 1) / _columnNum) + 1) * _columnNum;
         _loc2_ = _loc2_ < beginGridNumber?beginGridNumber:int(_loc2_);
         cellNum = _loc2_;
         _list.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            createCell(_loc5_);
            _loc5_++;
         }
         _list.commitChanges();
         invalidatePanel();
      }
      
      private function invalidatePanel() : void
      {
         panel.invalidateViewport();
      }
      
      public function setData(param1:DictionaryData) : void
      {
         var _loc2_:* = null;
         _bagdata = param1;
         addGrid(param1);
         if(param1)
         {
            _loc2_ = [];
            var _loc6_:int = 0;
            var _loc5_:* = param1;
            for(var _loc3_ in param1)
            {
               _loc2_.push(_loc3_);
            }
            _loc2_.sort(16);
            var _loc8_:int = 0;
            var _loc7_:* = _loc2_;
            for(var _loc4_ in _loc2_)
            {
               if(_cells[_loc4_] != null)
               {
                  _cells[_loc4_].info = param1[_loc2_[_loc4_]];
               }
            }
         }
      }
      
      protected function __doubleCellClick(param1:MouseEvent) : void
      {
         __cellUse(null);
      }
      
      protected function __cellClick(param1:MouseEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = param1.currentTarget as BagCell;
         if(_loc2_)
         {
            _loc4_ = _loc2_.itemInfo as InventoryItemInfo;
         }
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:Point = _loc2_.parent.localToGlobal(new Point(_loc2_.x,_loc2_.y));
         CellMenu.instance.show(_loc2_,_loc3_.x + 20,_loc3_.y + 20);
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
         for each(var _loc1_ in _cells)
         {
            _loc1_.removeEventListener("interactive_click",__clickHandler);
            DoubleClickManager.Instance.disableDoubleClick(_loc1_);
            _loc1_.removeEventListener("click",__cellClick);
            ObjectUtils.disposeObject(_loc1_);
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
