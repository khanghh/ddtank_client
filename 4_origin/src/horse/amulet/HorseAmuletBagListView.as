package horse.amulet
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
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
      
      private var _currentPage:int;
      
      public function HorseAmuletBagListView(param1:int, param2:int = 7, param3:int = 49)
      {
         super(param1,param2,param3);
      }
      
      public function set currentPage(param1:int) : void
      {
         if(_currentPage == param1)
         {
            return;
         }
         _currentPage = param1;
         _startIndex = 20 + (_currentPage - 1) * 49;
         _endIndex = _startIndex + 49;
         updateBag();
      }
      
      override protected function createCells() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         _loc2_ = 0;
         while(_loc2_ < _cellNum)
         {
            _loc1_ = new HorseAmuletCell(_loc2_ + 20);
            CellFactory.instance.fillTipProp(_loc1_);
            _loc1_.mouseOverEffBoolean = false;
            addChild(_loc1_);
            _loc1_.addEventListener("interactive_click",__clickHandler);
            _loc1_.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(_loc1_);
            _loc1_.bagType = _bagType;
            _loc1_.addEventListener("lockChanged",__cellChanged);
            _cells[_loc2_] = _loc1_;
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
         _bagdata = param1;
         currentPage = 1;
         _bagdata.addEventListener("update",__updateGoods);
      }
      
      private function updateBag() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         _loc4_ = _startIndex;
         while(_loc4_ < _endIndex)
         {
            _loc2_ = (_loc4_ - 20) % 49;
            _loc3_ = _bagdata.getItemAt(_loc4_) as InventoryItemInfo;
            _cells[_loc2_].info = _loc3_;
            _cells[_loc2_].place = _loc4_;
            _loc1_.push(_cells[_loc2_]);
            _loc4_++;
         }
         _cellsSort(_loc1_);
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
      
      override public function setCellInfo(param1:int, param2:InventoryItemInfo) : void
      {
         if(param1 < _startIndex || param1 >= _endIndex)
         {
            return;
         }
         var _loc3_:int = (param1 - 20) % 49;
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
         }
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BagCell = param1.currentTarget as BagCell;
         if(_loc2_.info == null)
         {
            return;
         }
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc4_:HorseAmuletVo = HorseAmuletManager.instance.getHorseAmuletVo((param1.currentTarget as BagCell).info.TemplateID);
         if(HorseAmuletManager.instance.viewType == 2)
         {
            if(_loc4_.IsCanWash)
            {
               SocketManager.Instance.out.sendAmuletMove(_loc2_.place,19);
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.activateFail"));
            }
         }
         else if(HorseAmuletManager.instance.viewType == 1)
         {
            _loc3_ = HorseAmuletManager.instance.canPutInEquipAmulet();
            if(_loc3_ == -1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.maxPutInEquipTips"));
            }
            else
            {
               if(!_loc4_.IsCanWash)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.notEquip"));
                  return;
               }
               if(!HorseAmuletManager.instance.canEquipAmulet(_loc2_.info.TemplateID))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.typeTips"));
                  return;
               }
               SocketManager.Instance.out.sendAmuletMove(_loc2_.place,_loc3_);
            }
         }
      }
      
      private function _cellsSort(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(param1.length <= 0)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc4_ = param1[_loc6_].x;
            _loc5_ = param1[_loc6_].y;
            _loc3_ = _cellVec.indexOf(param1[_loc6_]);
            _loc2_ = _cellVec[_loc6_];
            param1[_loc6_].x = _loc2_.x;
            param1[_loc6_].y = _loc2_.y;
            _loc2_.x = _loc4_;
            _loc2_.y = _loc5_;
            _cellVec[_loc6_] = param1[_loc6_];
            _cellVec[_loc3_] = _loc2_;
            _loc6_++;
         }
      }
      
      public function getAllEnableSmashPlaceList() : Array
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc2_:Array = [];
         var _loc3_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < _cellVec.length)
         {
            _loc1_ = _cellVec[_loc4_];
            if(_loc1_.itemInfo && !_loc1_.itemInfo.cellLocked)
            {
               if(HorseAmuletManager.instance.isHighQuality(_loc1_.itemInfo.TemplateID))
               {
                  _loc3_ = true;
               }
               _loc2_.push(_loc1_.place);
            }
            _loc4_++;
         }
         _loc2_.push(_loc3_);
         return _loc2_;
      }
      
      public function lockCellByPlace(param1:Boolean, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _loc4_ = 0;
         while(_loc4_ < _cellVec.length)
         {
            _loc3_ = _cellVec[_loc4_];
            if(param2.indexOf(_loc3_.place) != -1)
            {
               _loc3_.locked = param1;
            }
            _loc4_++;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
