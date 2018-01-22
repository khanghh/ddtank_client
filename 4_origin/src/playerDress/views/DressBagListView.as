package playerDress.views
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.BaseCell;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.SocketManager;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import playerDress.PlayerDressControl;
   import playerDress.components.DressUtils;
   
   public class DressBagListView extends BagListView
   {
      
      public static const DRESS_INDEX:int = 80;
       
      
      private var _dressType:int;
      
      private var _sex:int;
      
      private var _searchStr:String;
      
      private var _displayItems:Dictionary;
      
      private var _equipBag:BagInfo;
      
      private var _virtualBag:BagInfo;
      
      private var _currentPage:int = 1;
      
      public var locked:Boolean = false;
      
      public function DressBagListView(param1:int, param2:int = 7, param3:int = 49)
      {
         super(param1,param2,param3);
      }
      
      public function setSortType(param1:int, param2:Boolean, param3:String = "") : void
      {
         _dressType = param1;
         _sex = !!param2?1:2;
         _searchStr = param3;
         sortItems();
      }
      
      override public function setData(param1:BagInfo) : void
      {
         if(_equipBag != null)
         {
            _equipBag.removeEventListener("update",__updateGoods);
         }
         _equipBag = param1;
         setVirtualBagData();
         _equipBag.addEventListener("update",__updateGoods);
      }
      
      private function setVirtualBagData() : void
      {
         _virtualBag = new BagInfo(0,48);
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _equipBag.items;
         for each(var _loc2_ in _equipBag.items)
         {
            if(DressUtils.isDress(_loc2_))
            {
               _virtualBag.items[_loc1_] = _loc2_;
               _loc1_++;
            }
         }
      }
      
      override protected function __updateGoods(param1:BagEvent) : void
      {
         if(!locked)
         {
            setVirtualBagData();
            sortItems();
         }
      }
      
      private function sortItems() : void
      {
         var _loc1_:* = null;
         _displayItems = new Dictionary();
         clearDataCells();
         var _loc3_:int = 0;
         sequenceItems();
         var _loc5_:int = 0;
         var _loc4_:* = _virtualBag.items;
         for(var _loc2_ in _virtualBag.items)
         {
            _loc1_ = _virtualBag.items[_loc2_];
            if(_loc1_.NeedSex == _sex || _loc1_.NeedSex == 0)
            {
               if(!PlayerDressControl.instance.showBind)
               {
                  if(_loc1_.IsBinds == true)
                  {
                     continue;
                  }
               }
               if(_dressType == -1)
               {
                  if(_searchStr != "" && _loc1_.Name.indexOf(_searchStr) != -1)
                  {
                     _displayItems[_loc3_] = _loc1_;
                     if(_loc3_ >= 0 && _loc3_ < _cellNum)
                     {
                        BaseCell(_cells[_loc3_]).info = _loc1_;
                     }
                     _loc3_++;
                  }
               }
               else if(_dressType == 0)
               {
                  _displayItems[_loc3_] = _loc1_;
                  if(_loc3_ >= 0 && _loc3_ < _cellNum)
                  {
                     BaseCell(_cells[_loc3_]).info = _loc1_;
                  }
                  _loc3_++;
               }
               else if(_loc1_.CategoryID == _dressType)
               {
                  _displayItems[_loc3_] = _loc1_;
                  if(_loc3_ >= 0 && _loc3_ < _cellNum)
                  {
                     BaseCell(_cells[_loc3_]).info = _loc1_;
                  }
                  _loc3_++;
               }
            }
         }
         _currentPage = 1;
         (parent as DressBagView).currentPage = 1;
         (parent as DressBagView).updatePage();
      }
      
      private function sequenceItems() : void
      {
         var _loc8_:int = 0;
         var _loc6_:BagInfo = new BagInfo(0,48);
         var _loc3_:Array = [];
         var _loc5_:Array = [];
         var _loc10_:int = 0;
         var _loc9_:* = _virtualBag.items;
         for each(var _loc4_ in _virtualBag.items)
         {
            _loc3_.push({
               "TemplateID":_loc4_.TemplateID,
               "ItemID":_loc4_.ItemID,
               "CategoryIDSort":DressUtils.getBagGoodsCategoryIDSort(uint(_loc4_.CategoryID)),
               "Place":_loc4_.Place,
               "RemainDate":_loc4_.getRemainDate() > 0,
               "CanStrengthen":_loc4_.CanStrengthen,
               "StrengthenLevel":_loc4_.StrengthenLevel,
               "IsBinds":_loc4_.IsBinds
            });
         }
         var _loc7_:ByteArray = new ByteArray();
         _loc7_.writeObject(_loc3_);
         _loc7_.position = 0;
         _loc5_ = _loc7_.readObject() as Array;
         _loc3_.sortOn(["RemainDate","CategoryIDSort","TemplateID","CanStrengthen","IsBinds","StrengthenLevel","Place"],[2,16,16 | 2,2,2,16 | 2,16]);
         if(bagComparison(_loc3_,_loc5_))
         {
            return;
         }
         var _loc1_:int = 0;
         _loc8_ = 0;
         while(_loc8_ <= _loc3_.length - 1)
         {
            var _loc12_:int = 0;
            var _loc11_:* = _virtualBag.items;
            for each(var _loc2_ in _virtualBag.items)
            {
               if(_loc3_[_loc8_].Place == _loc2_.Place)
               {
                  _loc6_.items[_loc1_] = _loc2_;
                  _loc1_++;
                  break;
               }
            }
            _loc8_++;
         }
         _virtualBag = _loc6_;
      }
      
      private function bagComparison(param1:Array, param2:Array) : Boolean
      {
         var _loc4_:int = 0;
         if(param1.length < param2.length)
         {
            return false;
         }
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1[_loc4_].ItemID != param2[_loc4_].ItemID || param1[_loc4_].TemplateID != param2[_loc4_].TemplateID)
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      public function foldItems() : void
      {
         var _loc9_:* = null;
         var _loc5_:Boolean = false;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc10_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:* = null;
         var _loc2_:Dictionary = new Dictionary();
         var _loc8_:Array = [];
         var _loc15_:int = 0;
         var _loc14_:* = _virtualBag.items;
         for(var _loc11_ in _virtualBag.items)
         {
            _loc9_ = _virtualBag.items[_loc11_];
            if(DressUtils.isDress(_loc9_) && DressUtils.hasNoAddition(_loc9_))
            {
               _loc5_ = true;
               var _loc13_:int = 0;
               var _loc12_:* = _loc2_;
               for(var _loc1_ in _loc2_)
               {
                  _loc4_ = !!_loc9_.IsBinds?"t":"f";
                  _loc7_ = String(_loc9_.TemplateID) + _loc4_;
                  if(_loc7_ == _loc1_)
                  {
                     _loc10_ = _loc2_[_loc1_];
                     _loc3_ = _virtualBag.items[_loc10_].Place;
                     _loc8_.push({
                        "sPlace":_loc3_,
                        "tPlace":_loc9_.Place
                     });
                     _loc5_ = false;
                     break;
                  }
               }
               if(_loc5_)
               {
                  _loc6_ = !!_loc9_.IsBinds?"t":"f";
                  _loc2_[String(_loc9_.TemplateID) + _loc6_] = _loc11_;
               }
            }
         }
         if(_loc8_.length > 0)
         {
            _equipBag.isBatch = true;
            SocketManager.Instance.out.foldDressItem(_loc8_,237,6);
         }
      }
      
      public function fillPage(param1:int) : void
      {
         var _loc2_:int = 0;
         _currentPage = param1;
         clearDataCells();
         var _loc5_:int = 0;
         var _loc4_:* = _displayItems;
         for(var _loc3_ in _displayItems)
         {
            _loc2_ = parseInt(_loc3_) - (_currentPage - 1) * _cellNum;
            if(_loc2_ >= 0 && _loc2_ < _cellNum)
            {
               BaseCell(_cells[_loc2_]).info = _displayItems[_loc3_];
            }
         }
      }
      
      public function displayItemsLength() : int
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _displayItems;
         for each(var _loc1_ in _displayItems)
         {
            _loc2_++;
         }
         return _loc2_;
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
      
      public function unlockBag() : void
      {
         setVirtualBagData();
         sortItems();
         locked = false;
      }
      
      override public function dispose() : void
      {
         locked = false;
         if(_equipBag)
         {
            _equipBag.removeEventListener("update",__updateGoods);
         }
         super.dispose();
      }
   }
}
