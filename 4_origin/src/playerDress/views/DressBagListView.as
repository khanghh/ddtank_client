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
      
      public function DressBagListView(bagType:int, columnNum:int = 7, cellNun:int = 49)
      {
         super(bagType,columnNum,cellNun);
      }
      
      public function setSortType(type:int, isMale:Boolean, str:String = "") : void
      {
         _dressType = type;
         _sex = !!isMale?1:2;
         _searchStr = str;
         sortItems();
      }
      
      override public function setData(bag:BagInfo) : void
      {
         if(_equipBag != null)
         {
            _equipBag.removeEventListener("update",__updateGoods);
         }
         _equipBag = bag;
         setVirtualBagData();
         _equipBag.addEventListener("update",__updateGoods);
      }
      
      private function setVirtualBagData() : void
      {
         _virtualBag = new BagInfo(0,48);
         var index:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _equipBag.items;
         for each(var item in _equipBag.items)
         {
            if(DressUtils.isDress(item))
            {
               _virtualBag.items[index] = item;
               index++;
            }
         }
      }
      
      override protected function __updateGoods(evt:BagEvent) : void
      {
         if(!locked)
         {
            setVirtualBagData();
            sortItems();
         }
      }
      
      private function sortItems() : void
      {
         var item:* = null;
         _displayItems = new Dictionary();
         clearDataCells();
         var i:int = 0;
         sequenceItems();
         var _loc5_:int = 0;
         var _loc4_:* = _virtualBag.items;
         for(var key in _virtualBag.items)
         {
            item = _virtualBag.items[key];
            if(item.NeedSex == _sex || item.NeedSex == 0)
            {
               if(!PlayerDressControl.instance.showBind)
               {
                  if(item.IsBinds == true)
                  {
                     continue;
                  }
               }
               if(_dressType == -1)
               {
                  if(_searchStr != "" && item.Name.indexOf(_searchStr) != -1)
                  {
                     _displayItems[i] = item;
                     if(i >= 0 && i < _cellNum)
                     {
                        BaseCell(_cells[i]).info = item;
                     }
                     i++;
                  }
               }
               else if(_dressType == 0)
               {
                  _displayItems[i] = item;
                  if(i >= 0 && i < _cellNum)
                  {
                     BaseCell(_cells[i]).info = item;
                  }
                  i++;
               }
               else if(item.CategoryID == _dressType)
               {
                  _displayItems[i] = item;
                  if(i >= 0 && i < _cellNum)
                  {
                     BaseCell(_cells[i]).info = item;
                  }
                  i++;
               }
            }
         }
         _currentPage = 1;
         (parent as DressBagView).currentPage = 1;
         (parent as DressBagView).updatePage();
      }
      
      private function sequenceItems() : void
      {
         var i:int = 0;
         var tempBag:BagInfo = new BagInfo(0,48);
         var arr:Array = [];
         var arr2:Array = [];
         var _loc10_:int = 0;
         var _loc9_:* = _virtualBag.items;
         for each(var item in _virtualBag.items)
         {
            arr.push({
               "TemplateID":item.TemplateID,
               "ItemID":item.ItemID,
               "CategoryIDSort":DressUtils.getBagGoodsCategoryIDSort(uint(item.CategoryID)),
               "Place":item.Place,
               "RemainDate":item.getRemainDate() > 0,
               "CanStrengthen":item.CanStrengthen,
               "StrengthenLevel":item.StrengthenLevel,
               "IsBinds":item.IsBinds
            });
         }
         var fooBA:ByteArray = new ByteArray();
         fooBA.writeObject(arr);
         fooBA.position = 0;
         arr2 = fooBA.readObject() as Array;
         arr.sortOn(["RemainDate","CategoryIDSort","TemplateID","CanStrengthen","IsBinds","StrengthenLevel","Place"],[2,16,16 | 2,2,2,16 | 2,16]);
         if(bagComparison(arr,arr2))
         {
            return;
         }
         var index:int = 0;
         for(i = 0; i <= arr.length - 1; )
         {
            var _loc12_:int = 0;
            var _loc11_:* = _virtualBag.items;
            for each(var tItem in _virtualBag.items)
            {
               if(arr[i].Place == tItem.Place)
               {
                  tempBag.items[index] = tItem;
                  index++;
                  break;
               }
            }
            i++;
         }
         _virtualBag = tempBag;
      }
      
      private function bagComparison(bagArray1:Array, bagArray2:Array) : Boolean
      {
         var i:int = 0;
         if(bagArray1.length < bagArray2.length)
         {
            return false;
         }
         var len:int = bagArray1.length;
         for(i = 0; i < len; )
         {
            if(bagArray1[i].ItemID != bagArray2[i].ItemID || bagArray1[i].TemplateID != bagArray2[i].TemplateID)
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function foldItems() : void
      {
         var item:* = null;
         var notFind:Boolean = false;
         var flag:* = null;
         var s:* = null;
         var skey:int = 0;
         var sPlace:int = 0;
         var str:* = null;
         var canFoldDic:Dictionary = new Dictionary();
         var arr:Array = [];
         var _loc15_:int = 0;
         var _loc14_:* = _virtualBag.items;
         for(var key in _virtualBag.items)
         {
            item = _virtualBag.items[key];
            if(DressUtils.isDress(item) && DressUtils.hasNoAddition(item))
            {
               notFind = true;
               var _loc13_:int = 0;
               var _loc12_:* = canFoldDic;
               for(var templateId in canFoldDic)
               {
                  flag = !!item.IsBinds?"t":"f";
                  s = String(item.TemplateID) + flag;
                  if(s == templateId)
                  {
                     skey = canFoldDic[templateId];
                     sPlace = _virtualBag.items[skey].Place;
                     arr.push({
                        "sPlace":sPlace,
                        "tPlace":item.Place
                     });
                     notFind = false;
                     break;
                  }
               }
               if(notFind)
               {
                  str = !!item.IsBinds?"t":"f";
                  canFoldDic[String(item.TemplateID) + str] = key;
               }
            }
         }
         if(arr.length > 0)
         {
            _equipBag.isBatch = true;
            SocketManager.Instance.out.foldDressItem(arr,237,6);
         }
      }
      
      public function fillPage(page:int) : void
      {
         var index:int = 0;
         _currentPage = page;
         clearDataCells();
         var _loc5_:int = 0;
         var _loc4_:* = _displayItems;
         for(var i in _displayItems)
         {
            index = parseInt(i) - (_currentPage - 1) * _cellNum;
            if(index >= 0 && index < _cellNum)
            {
               BaseCell(_cells[index]).info = _displayItems[i];
            }
         }
      }
      
      public function displayItemsLength() : int
      {
         var length:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _displayItems;
         for each(var item in _displayItems)
         {
            length++;
         }
         return length;
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
