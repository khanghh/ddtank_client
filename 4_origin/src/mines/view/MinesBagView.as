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
      
      public function set currentPage(param1:int) : void
      {
         _currentPage = param1;
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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cells = new Dictionary();
         _cellVec = new Vector.<BagCell>();
         _loc2_ = 1;
         while(_loc2_ <= 16)
         {
            _loc1_ = new BagCell(_loc2_,null,true,ComponentFactory.Instance.creatBitmap("asset.mines.bag.cellBg"));
            _loc1_.mouseOverEffBoolean = false;
            _loc1_.x = 29 + 81 * ((_loc2_ - 1) % 4);
            _loc1_.y = 29 + 74 * Math.floor((_loc2_ - 1) / 4);
            addChild(_loc1_);
            _loc1_.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(_loc1_);
            _cells[_loc2_] = _loc1_;
            _cellVec.push(_loc1_);
            _loc2_++;
         }
         upBtn.clickHandler = new Handler(changePage,[-1]);
         downBtn.clickHandler = new Handler(changePage,[1]);
         arrangeBtn.clickHandler = new Handler(arrangeHandler);
      }
      
      private function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if((param1.currentTarget as BagCell).info != null)
         {
            dispatchEvent(new CellEvent("doubleclick",param1.currentTarget,true));
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
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 1;
         while(_loc3_ <= 16)
         {
            _loc1_ = _loc3_ + (_currentPage - 1) * 16;
            _loc2_ = _bagdata.getItemAt(_loc1_) as InventoryItemInfo;
            (_cells[_loc3_] as BagCell).info = _loc2_;
            (_cells[_loc3_] as BagCell).place = _loc1_;
            if(_loc2_)
            {
               (_cells[_loc3_] as BagCell).setCount(_loc2_.Count);
               (_cells[_loc3_] as BagCell).refreshTbxPos();
            }
            _loc3_++;
         }
      }
      
      public function setData(param1:BagInfo) : void
      {
         if(_bagdata == param1)
         {
            return;
         }
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoods);
         }
         _bagdata = param1;
         currentPage = 1;
         _bagdata.addEventListener("update",__updateGoods);
      }
      
      public function __updateGoods(param1:BagEvent) : void
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
      
      public function setCellInfo(param1:int, param2:InventoryItemInfo) : void
      {
         var _loc3_:int = 0;
         if(param1 > (_currentPage - 1) * 16 && param1 <= _currentPage * 16)
         {
            _loc3_ = param1 - (_currentPage - 1) * 16;
            if(param2 == null)
            {
               if(_cells[_loc3_])
               {
                  _cells[_loc3_].info = null;
               }
               return;
            }
            if(param2.Count == 0)
            {
               _cells[_loc3_].info = null;
            }
            else
            {
               _cells[_loc3_].info = param2;
               _cells[_loc3_].refreshTbxPos();
            }
            _cells[_loc3_].place = param1;
         }
      }
      
      private function changePage(param1:int) : void
      {
         currentPage = currentPage + param1;
      }
      
      protected function __clickHandler(param1:InteractiveEvent) : void
      {
         if((param1.currentTarget as BagCell).info != null)
         {
            dispatchEvent(new CellEvent("itemclick",param1.currentTarget,false,false,param1.ctrlKey));
         }
      }
      
      override public function dispose() : void
      {
         _bagdata.removeEventListener("update",__updateGoods);
         super.dispose();
      }
   }
}
