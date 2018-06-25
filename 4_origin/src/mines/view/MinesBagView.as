package mines.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import mines.mornui.view.MinesBagViewUI;
   import morn.core.handlers.Handler;
   
   public class MinesBagView extends MinesBagViewUI
   {
      
      public static const BAG_CAPABILITY:int = 16;
       
      
      private var _currentPage:int = 1;
      
      private var _cells:Dictionary;
      
      private var _cellVec:Vector.<BagCell>;
      
      protected var _bagdata:BagInfo;
      
      public function MinesBagView()
      {
         super();
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(value:int) : void
      {
         _currentPage = value;
         if(_currentPage < 1)
         {
            _currentPage = 4;
         }
         else if(_currentPage > 4)
         {
            _currentPage = 1;
         }
         pageLabel.text = String(_currentPage) + "/4";
         updateBag();
      }
      
      override protected function initialize() : void
      {
         var i:int = 0;
         var cell:* = null;
         _cells = new Dictionary();
         _cellVec = new Vector.<BagCell>();
         for(i = 1; i <= 16; )
         {
            cell = new BagCell(i,null,true,ComponentFactory.Instance.creatBitmap("asset.mines.bag.cellBg"));
            cell.mouseOverEffBoolean = false;
            cell.x = 29 + 81 * ((i - 1) % 4);
            cell.y = 29 + 74 * Math.floor((i - 1) / 4);
            addChild(cell);
            cell.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(cell);
            _cells[i] = cell;
            _cellVec.push(cell);
            i++;
         }
         upBtn.clickHandler = new Handler(changePage,[-1]);
         downBtn.clickHandler = new Handler(changePage,[1]);
         arrangeBtn.clickHandler = new Handler(arrangeHandler);
      }
      
      private function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if((evt.currentTarget as BagCell).info != null)
         {
            dispatchEvent(new CellEvent("doubleclick",evt.currentTarget,true));
            SoundManager.instance.play("008");
         }
      }
      
      private function arrangeHandler() : void
      {
         dispatchEvent(new CellEvent("doubleclick",null,true));
         SocketManager.Instance.out.sendMinesArrange();
      }
      
      private function updateBag() : void
      {
         var i:int = 0;
         var index:int = 0;
         var info:* = null;
         for(i = 1; i <= 16; )
         {
            index = i + (_currentPage - 1) * 16;
            info = _bagdata.getItemAt(index) as InventoryItemInfo;
            (_cells[i] as BagCell).info = info;
            (_cells[i] as BagCell).place = index;
            if(info)
            {
               (_cells[i] as BagCell).setCount(info.Count);
               (_cells[i] as BagCell).refreshTbxPos();
            }
            i++;
         }
      }
      
      public function setData(bag:BagInfo) : void
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
      
      public function __updateGoods(evt:BagEvent) : void
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
      
      public function setCellInfo(place:int, info:InventoryItemInfo) : void
      {
         var index:int = 0;
         if(place > (_currentPage - 1) * 16 && place <= _currentPage * 16)
         {
            index = place - (_currentPage - 1) * 16;
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
               _cells[index].refreshTbxPos();
            }
            _cells[index].place = place;
         }
      }
      
      private function changePage(type:int) : void
      {
         currentPage = currentPage + type;
      }
      
      protected function __clickHandler(evt:InteractiveEvent) : void
      {
         if((evt.currentTarget as BagCell).info != null)
         {
            dispatchEvent(new CellEvent("itemclick",evt.currentTarget,false,false,evt.ctrlKey));
         }
      }
      
      override public function dispose() : void
      {
         _bagdata.removeEventListener("update",__updateGoods);
         super.dispose();
      }
   }
}
