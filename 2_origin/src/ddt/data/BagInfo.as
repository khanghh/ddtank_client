package ddt.data
{
   import cardSystem.CardManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.SetsInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import horse.HorseAmuletManager;
   import horse.data.HorseAmuletVo;
   import road7th.data.DictionaryData;
   
   [Event(name="update",type="ddt.events.BagEvent")]
   public class BagInfo extends EventDispatcher
   {
      
      public static const EQUIPBAG:int = 0;
      
      public static const PROPBAG:int = 1;
      
      public static const TASKBAG:int = 2;
      
      public static const FIGHTBAG:int = 3;
      
      public static const TEMPBAG:int = 4;
      
      public static const CADDYBAG:int = 5;
      
      public static const CONSORTIA:int = 11;
      
      public static const FARM:int = 13;
      
      public static const VEGETABLE:int = 14;
      
      public static const FOOD_OLD:int = 32;
      
      public static const FOOD:int = 34;
      
      public static const PETEGG:int = 35;
      
      public static const BEADBAG:int = 21;
      
      public static const MAGICSTONE:int = 41;
      
      public static const MAXPROPCOUNT:int = 48;
      
      public static const STOREBAG:int = 12;
      
      public static const HOMEBANK:int = 511;
      
      public static const MAGICHOUSE:int = 51;
      
      public static const HORSE_AMULET:int = 42;
      
      public static const ROOMBORDEN:int = 43;
      
      public static const MINES:int = 52;
      
      public static const PERSONAL_EQUIP_COUNT:int = 30;
       
      
      private var _isBatch:Boolean = false;
      
      private var _type:int;
      
      private var _capability:int;
      
      private var _items:DictionaryData;
      
      private var _changedCount:int = 0;
      
      private var _changedSlots:Dictionary;
      
      public const NUMBER:Number = 1.0;
      
      public function BagInfo(type:int, capability:int)
      {
         _changedSlots = new Dictionary();
         super();
         _type = type;
         _items = new DictionaryData();
         _capability = capability;
      }
      
      public static function parseCategoryID(bagType:int, place:int) : int
      {
         var categoryID:int = -1;
         if(bagType != 0 || place > 30)
         {
            return categoryID;
         }
         switch(int(place))
         {
            case 0:
               categoryID = 1;
               break;
            default:
               categoryID = 1;
               break;
            default:
               categoryID = 1;
               break;
            default:
               categoryID = 1;
               break;
            case 4:
               categoryID = 5;
               break;
            default:
               categoryID = 5;
               break;
            case 6:
               categoryID = 7;
         }
         return categoryID;
      }
      
      public function get BagType() : int
      {
         return _type;
      }
      
      public function getItemAt(slot:int) : InventoryItemInfo
      {
         return _items[slot];
      }
      
      public function get items() : DictionaryData
      {
         return _items;
      }
      
      public function get itemNumber() : int
      {
         var i:int = 0;
         var result:int = 0;
         for(i = 0; i < 49; )
         {
            if(_items[i] != null)
            {
               result++;
            }
            i++;
         }
         return result;
      }
      
      public function getBagFullByIndex(startIndex:int, endIndex:int) : Boolean
      {
         var i:* = 0;
         for(i = startIndex; i < endIndex; )
         {
            if(_items[i] == null)
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function set items(dic:DictionaryData) : void
      {
         _items = dic;
      }
      
      public function addItem(item:InventoryItemInfo) : void
      {
         item.BagType = _type;
         item.fromBag = true;
         _items.add(item.Place,item);
         if(isBatch)
         {
            return;
         }
         onItemChanged(item.Place,item);
      }
      
      public function addItemIntoFightBag(itemID:int, count:int = 1) : void
      {
         var item:InventoryItemInfo = new InventoryItemInfo();
         item.BagType = 3;
         item.Place = findFirstPlace();
         item.Count = count;
         item.TemplateID = itemID;
         ItemManager.fill(item);
         addItem(item);
      }
      
      private function findFirstPlace() : int
      {
         var i:int = 0;
         for(i = 0; i < 3; )
         {
            if(getItemAt(i) == null)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public function removeItemAt(slot:int) : void
      {
         var item:InventoryItemInfo = _items[slot];
         if(item)
         {
            item.fromBag = false;
            _items.remove(slot);
            if(isBatch || _type == 4 && StateManager.currentStateType == "fighting")
            {
               return;
            }
            onItemChanged(slot,item);
         }
      }
      
      public function updateItem(item:InventoryItemInfo) : void
      {
         if(item.BagType == _type)
         {
            onItemChanged(item.Place,item);
         }
      }
      
      public function beginChanges() : void
      {
         _changedCount = Number(_changedCount) + 1;
      }
      
      public function commiteChanges() : void
      {
         _changedCount = Number(_changedCount) - 1;
         if(_changedCount <= 0)
         {
            _changedCount = 0;
            updateChanged();
         }
      }
      
      protected function onItemChanged(slot:int, value:InventoryItemInfo) : void
      {
         _changedSlots[slot] = value;
         if(_changedCount <= 0)
         {
            _changedCount = 0;
            updateChanged();
         }
      }
      
      protected function updateChanged() : void
      {
         dispatchEvent(new BagEvent("update",_changedSlots));
         isBatch = false;
         _changedSlots = new Dictionary();
      }
      
      public function findItems(categoryId:int, validate:Boolean = true) : Array
      {
         var list:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var i in _items)
         {
            if(i.CategoryID == categoryId)
            {
               if(!validate || i.getRemainDate() > 0)
               {
                  list.push(i);
               }
            }
         }
         return list;
      }
      
      public function findFirstItem(categoryId:int, validate:Boolean = true) : InventoryItemInfo
      {
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var i in _items)
         {
            if(i.CategoryID == categoryId)
            {
               if(!validate || i.getRemainDate() > 0)
               {
                  return i;
               }
            }
         }
         return null;
      }
      
      public function getItemByTemplateId(TemplateID:int) : InventoryItemInfo
      {
         var i:int = 0;
         var info:* = null;
         for(i = 0; i < _items.list.length; )
         {
            info = _items.list[i];
            if(info.TemplateID == TemplateID)
            {
               return info;
            }
            i++;
         }
         return null;
      }
      
      public function findEquipedItemByTemplateId(TemplateID:int, validate:Boolean = true) : InventoryItemInfo
      {
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var i in _items)
         {
            if(i.TemplateID == TemplateID)
            {
               if(i.Place <= 30)
               {
                  if(!validate || i.getRemainDate() > 0)
                  {
                     return i;
                  }
               }
            }
         }
         return null;
      }
      
      public function findIsEquipedByPlace(placeArr:Array) : Array
      {
         var i:int = 0;
         var notEquipedPlaceArray:* = placeArr;
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var item in _items)
         {
            if(item.Place <= 30)
            {
               i = 0;
               while(i < placeArr.length)
               {
                  if(placeArr[i] == item.Place && item.getRemainDate() > 0)
                  {
                     notEquipedPlaceArray.splice(i,1);
                  }
                  i++;
               }
            }
         }
         return notEquipedPlaceArray;
      }
      
      public function findOvertimeItems(lefttime:Number = 0) : Array
      {
         var num:Number = NaN;
         var list:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var i in _items)
         {
            num = i.getRemainDate();
            if(num > lefttime && num < 1)
            {
               list.push(i);
            }
         }
         return list;
      }
      
      public function findOvertimeItemsByBody() : Array
      {
         var i:* = 0;
         var item:* = null;
         var num:Number = NaN;
         var list:Array = [];
         for(i = uint(0); i < 30; )
         {
            if(i != 17 && _items[i] as InventoryItemInfo)
            {
               item = _items[i] as InventoryItemInfo;
               num = item.getRemainDate();
               if(num <= 0 && ShopManager.Instance.canAddPrice(item.TemplateID))
               {
                  list.push(_items[i]);
               }
            }
            i++;
         }
         return list;
      }
      
      public function findOvertimeItemsByBodyII() : Array
      {
         var i:* = 0;
         var num:Number = NaN;
         var list:Array = [];
         for(i = uint(0); i < 80; )
         {
            if(_items[i] as InventoryItemInfo)
            {
               if(i < 30)
               {
                  num = (_items[i] as InventoryItemInfo).getRemainDate();
               }
               if((_items[i] as InventoryItemInfo).isGold)
               {
                  num = (_items[i] as InventoryItemInfo).getGoldRemainDate();
               }
               if(num <= 0)
               {
                  list.push(_items[i]);
               }
            }
            i++;
         }
         return list;
      }
      
      public function findItemsForEach(categoryId:int, validate:Boolean = true) : Array
      {
         var t:DictionaryData = new DictionaryData();
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var i in _items)
         {
            if(i.CategoryID == categoryId && t[i.TemplateID] == null)
            {
               if(!validate || i.getRemainDate() > 0)
               {
                  t.add(i.TemplateID,i);
               }
            }
         }
         return t.list;
      }
      
      public function findFistItemByTemplateId(templateId:int, validate:Boolean = true, usedFirst:Boolean = false) : InventoryItemInfo
      {
         var used:* = null;
         var normal:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = _items;
         for each(var i in _items)
         {
            if(i.TemplateID == templateId && (!validate || i.getRemainDate() > 0))
            {
               if(usedFirst)
               {
                  if(i.IsUsed)
                  {
                     if(used == null)
                     {
                        used = i;
                     }
                  }
                  else if(normal == null)
                  {
                     normal = i;
                  }
                  continue;
               }
               return i;
            }
         }
         return !!used?used:normal;
      }
      
      public function findBodyThingByCategory(id:int) : Array
      {
         var i:int = 0;
         var item:* = null;
         var arr:Array = [];
         for(i = 0; i < 30; )
         {
            item = _items[i] as InventoryItemInfo;
            if(item != null)
            {
               if(item.CategoryID == id)
               {
                  arr.push(item);
               }
            }
            i++;
         }
         return arr;
      }
      
      public function getItemCountByTemplateIdBindType(templateId:int, bindType:int) : int
      {
         var count:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var i in _items)
         {
            if(i.TemplateID == templateId && i.getRemainDate() > 0 && (bindType == 1 && !i.IsBinds || bindType == 2 && i.IsBinds))
            {
               count = count + i.Count;
            }
         }
         return count;
      }
      
      public function getItemCountByTemplateId(templateId:int, validate:Boolean = true) : int
      {
         var count:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var i in _items)
         {
            if(i.TemplateID == templateId && (!validate || i.getRemainDate() > 0))
            {
               count = count + i.Count;
            }
         }
         return count;
      }
      
      public function getLimitSLItemCountByTemplateId(templateId:int, LimitValue:int = -1, validate:Boolean = true) : int
      {
         var count:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = _items;
         for each(var i in _items)
         {
            if(i.TemplateID == templateId && i.Place > 30 && (i.StrengthenLevel == LimitValue || LimitValue == -1) && (!validate || i.getRemainDate() > 0))
            {
               count = count + i.Count;
            }
         }
         return count;
      }
      
      public function getBagItemCountByTemplateIdBindType(templateId:int, bindType:int) : int
      {
         var count:int = 0;
         var selfID:int = PlayerManager.Instance.Self.ID;
         var _loc7_:int = 0;
         var _loc6_:* = _items;
         for each(var i in _items)
         {
            if(i.TemplateID == templateId && i.Place > 30 && i.getRemainDate() > 0 && (bindType == 1 && !i.IsBinds || bindType == 2 && i.IsBinds))
            {
               count = count + i.Count;
            }
         }
         return count;
      }
      
      public function getBagItemCountByTemplateId(templateId:int, validate:Boolean = true) : int
      {
         var count:int = 0;
         var selfID:int = PlayerManager.Instance.Self.ID;
         var _loc7_:int = 0;
         var _loc6_:* = _items;
         for each(var i in _items)
         {
            if(i.TemplateID == templateId && i.Place > 30 && (!validate || i.getRemainDate() > 0))
            {
               count = count + i.Count;
            }
         }
         return count;
      }
      
      public function findItemsByTempleteID(templeteID:int, validate:Boolean = true) : Array
      {
         var t:DictionaryData = new DictionaryData();
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var i in _items)
         {
            if(i.TemplateID == templeteID && t[i.TemplateID] == null)
            {
               if(!validate || i.getRemainDate() > 0)
               {
                  t.add(i.TemplateID,i);
               }
            }
         }
         return t.list;
      }
      
      public function findItemsByTempleteIDNoValidate(templeteID:int) : Array
      {
         var t:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var i in _items)
         {
            if(i.TemplateID == templeteID)
            {
               t.push(i);
            }
         }
         return t;
      }
      
      public function findCellsByTempleteID(templeteID:int, validate:Boolean = true) : Array
      {
         var t:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var i in _items)
         {
            if(i.TemplateID == templeteID && (!validate || i.getRemainDate() > 0))
            {
               t.push(i);
            }
         }
         return t;
      }
      
      public function clearnAll() : void
      {
         var i:int = 0;
         for(i = 0; i < 49; )
         {
            removeItemAt(i);
            i++;
         }
      }
      
      public function unlockItem(item:InventoryItemInfo) : void
      {
         item.lock = false;
         onItemChanged(item.Place,item);
      }
      
      public function unLockAll() : void
      {
         beginChanges();
         var _loc3_:int = 0;
         var _loc2_:* = _items;
         for each(var i in _items)
         {
            if(i.lock)
            {
               onItemChanged(i.Place,i);
            }
            i.lock = false;
         }
         commiteChanges();
      }
      
      public function sortBag(type:int, bagInfo:BagInfo, startPlace:int, endPlace:int, isSegistration:Boolean = false) : void
      {
         type = type;
         bagInfo = bagInfo;
         startPlace = startPlace;
         endPlace = endPlace;
         isSegistration = isSegistration;
         __onResponse = function(evt:FrameEvent):void
         {
            SoundManager.instance.play("008");
            var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
            confirmFrame.removeEventListener("response",__onResponse);
            confirmFrame.dispose();
            if(evt.responseCode == 3 || evt.responseCode == 2)
            {
               if(!isSegistration && bagComparison(arrayBag,arrayBag2,beginPlace))
               {
                  return;
               }
               SocketManager.Instance.out.sendMoveGoodsAll(bagInfo.BagType,arrayBag,beginPlace,isSegistration);
            }
         };
         if(type != 2 && type != 21 && type != 41 && type != 42)
         {
            var bagData:DictionaryData = bagInfo.items;
            var arrayBag:Array = [];
            var arrayBag2:Array = [];
            var CategoryIDSort:int = 0;
            var listLen:int = bagData.list.length;
            var beginPlace:int = 0;
            if(bagInfo == PlayerManager.Instance.Self.Bag)
            {
               beginPlace = 31;
               var endPlace:int = 79;
            }
            while(i < listLen)
            {
               if(int(bagData.list[i].Place) >= beginPlace && int(bagData.list[i].Place) <= endPlace)
               {
                  arrayBag.push({
                     "TemplateID":bagData.list[i].TemplateID,
                     "ItemID":bagData.list[i].ItemID,
                     "CategoryIDSort":getBagGoodsCategoryIDSort(uint(bagData.list[i].CategoryID)),
                     "Place":bagData.list[i].Place,
                     "RemainDate":bagData.list[i].getRemainDate() > 0,
                     "CanStrengthen":bagData.list[i].CanStrengthen,
                     "StrengthenLevel":bagData.list[i].StrengthenLevel,
                     "IsBinds":bagData.list[i].IsBinds
                  });
               }
               i = Number(i) + 1;
            }
            var fooBA:ByteArray = new ByteArray();
            fooBA.writeObject(arrayBag);
            fooBA.position = 0;
            arrayBag2 = fooBA.readObject() as Array;
            arrayBag.sortOn(["RemainDate","CategoryIDSort","TemplateID","CanStrengthen","IsBinds","StrengthenLevel","Place"],[2,16,16 | 2,2,2,16 | 2,16]);
            if(!isSegistration && bagComparison(arrayBag,arrayBag2,beginPlace))
            {
               return;
            }
            SocketManager.Instance.out.sendMoveGoodsAll(bagInfo.BagType,arrayBag,beginPlace,isSegistration);
         }
         else if(type == 2)
         {
            sortCard();
         }
         else if(type == 21)
         {
            sortBead(bagInfo,startPlace,endPlace,isSegistration);
         }
         else if(type == 41)
         {
            sortMagicStone(bagInfo,startPlace,endPlace);
         }
         else if(type == 42)
         {
            sortAmulet(bagInfo,startPlace,endPlace);
         }
      }
      
      public function foldPetEquips(type:int, bagInfo:BagInfo, startPlace:int, endPlace:int) : void
      {
         var item:* = null;
         var notFind:Boolean = false;
         var skey:int = 0;
         var sPlace:int = 0;
         var bagData:DictionaryData = bagInfo.items;
         var beginPlace:* = startPlace;
         if(bagInfo == PlayerManager.Instance.Self.Bag)
         {
            beginPlace = 31;
            endPlace = 79;
         }
         var canFoldDic:Dictionary = new Dictionary();
         var arr:Array = [];
         var _loc18_:int = 0;
         var _loc17_:* = bagData;
         for(var key in bagData)
         {
            item = bagData[key];
            if(item.Place >= beginPlace && item.Place <= endPlace && item.CategoryID >= 50 && item.CategoryID <= 52 && item.Quality <= 4)
            {
               notFind = true;
               var _loc16_:int = 0;
               var _loc15_:* = canFoldDic;
               for(var templateId in canFoldDic)
               {
                  if(item.TemplateID == parseInt(templateId))
                  {
                     skey = canFoldDic[templateId];
                     sPlace = bagData[skey].Place;
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
                  canFoldDic[item.TemplateID] = key;
               }
            }
         }
         if(arr.length > 0)
         {
            SocketManager.Instance.out.foldDressItem(arr,68,36);
         }
      }
      
      private function sortMagicStone(bagInfo:BagInfo, startPlace:int, endPlace:int) : void
      {
         var bagData:DictionaryData = bagInfo.items;
         var arrayBag:Array = [];
         var arrayBag2:Array = [];
         var _loc10_:int = 0;
         var _loc9_:* = bagData;
         for each(var item in bagData)
         {
            if(item.Place >= startPlace && item.Place <= endPlace)
            {
               arrayBag.push({
                  "Property":propertyAssort(item),
                  "Quality":item.Quality,
                  "StrengthenLevel":item.StrengthenLevel,
                  "StrengthenExp":item.StrengthenExp,
                  "Place":item.Place,
                  "Name":item.Name,
                  "ItemID":item.ItemID,
                  "TemplateID":item.TemplateID
               });
            }
         }
         var fooBA:ByteArray = new ByteArray();
         fooBA.writeObject(arrayBag);
         fooBA.position = 0;
         arrayBag2 = fooBA.readObject() as Array;
         arrayBag.sortOn(["Property","Quality","StrengthenLevel","StrengthenExp","Place"],[16,16 | 2,16 | 2,16 | 2,16]);
         if(bagComparison(arrayBag,arrayBag2,startPlace))
         {
            return;
         }
         SocketManager.Instance.out.sortMgStoneBag(arrayBag,startPlace);
      }
      
      private function propertyAssort(item:InventoryItemInfo) : int
      {
         if(item.Property3 == "4")
         {
            return 1;
         }
         if(item.Property3 == "3")
         {
            return 2;
         }
         if(item.Property3 == "2")
         {
            return 3;
         }
         if(item.MagicAttack > 0)
         {
            return 4;
         }
         if(item.MagicDefence > 0)
         {
            return 5;
         }
         if(item.AttackCompose > 0)
         {
            return 6;
         }
         if(item.DefendCompose > 0)
         {
            return 7;
         }
         if(item.AgilityCompose > 0)
         {
            return 8;
         }
         if(item.LuckCompose > 0)
         {
            return 9;
         }
         return 0;
      }
      
      private function sortBead(bagInfo:BagInfo, startPlace:int, endPlace:int, isSegistration:Boolean) : void
      {
         var i:int = 0;
         var bagData:DictionaryData = bagInfo.items;
         var arrayBag:Array = [];
         var arrayBag2:Array = [];
         var CategoryIDSort:int = 0;
         var listLen:int = bagData.list.length;
         for(i = 0; i < listLen; )
         {
            if(int(bagData.list[i].Place) >= startPlace && int(bagData.list[i].Place) <= endPlace)
            {
               arrayBag.push({
                  "Type":bagData.list[i].Property2,
                  "TemplateID":bagData.list[i].TemplateID,
                  "Level":bagData.list[i].Hole1,
                  "Exp":bagData.list[i].Hole2,
                  "Place":bagData.list[i].Place
               });
            }
            i++;
         }
         var fooBA:ByteArray = new ByteArray();
         fooBA.writeObject(arrayBag);
         fooBA.position = 0;
         arrayBag2 = fooBA.readObject() as Array;
         arrayBag.sortOn(["Type","TemplateID","Level","Exp","Place"],[16,2,2,2,16]);
         if(!isSegistration && bagComparison(arrayBag,arrayBag2,startPlace))
         {
            return;
         }
         SocketManager.Instance.out.sendMoveGoodsAll(bagInfo.BagType,arrayBag,startPlace,isSegistration);
      }
      
      private function sortAmulet(bagInfo:BagInfo, startPlace:int, endPlace:int, isSegistration:Boolean = false) : void
      {
         var i:int = 0;
         var vo:* = null;
         var bagData:DictionaryData = bagInfo.items;
         var arrayBag:Array = [];
         var arrayBag2:Array = [];
         var CategoryIDSort:int = 0;
         var listLen:int = bagData.list.length;
         for(i = 0; i < listLen; )
         {
            if(int(bagData.list[i].Place) >= startPlace && int(bagData.list[i].Place) <= endPlace)
            {
               vo = HorseAmuletManager.instance.getHorseAmuletVo(bagData.list[i].TemplateID);
               arrayBag.push({
                  "Quality":vo.Quality,
                  "Type":vo.ExtendType1,
                  "Place":bagData.list[i].Place
               });
            }
            i++;
         }
         var fooBA:ByteArray = new ByteArray();
         fooBA.writeObject(arrayBag);
         fooBA.position = 0;
         arrayBag2 = fooBA.readObject() as Array;
         arrayBag.sortOn(["Quality","Type","Place"],[16 | 2,16,16]);
         if(!isSegistration && bagComparisonType(arrayBag,arrayBag2,startPlace))
         {
            return;
         }
         SocketManager.Instance.out.sendMoveGoodsAll(bagInfo.BagType,arrayBag,startPlace,isSegistration);
      }
      
      private function showPetsMergerInfo(arrayBag:Array) : Boolean
      {
         var j:int = 0;
         var bRes:Boolean = false;
         var tempId:int = -1;
         for(j = 0; j < arrayBag.length; )
         {
            if(isPetsEquip(arrayBag[j].TemplateID))
            {
               if(tempId != arrayBag[j].TemplateID)
               {
                  tempId = arrayBag[j].TemplateID;
               }
               else
               {
                  bRes = true;
                  break;
               }
            }
            j++;
         }
         return bRes;
      }
      
      private function sortCard() : void
      {
         var m:int = 0;
         var idVec:* = undefined;
         var j:int = 0;
         var data:* = null;
         var sortData:Vector.<int> = new Vector.<int>();
         var sortArr:Vector.<SetsInfo> = CardManager.Instance.model.setsSortRuleVector;
         for(m = 0; m < sortArr.length; )
         {
            idVec = sortArr[m].cardIdVec;
            for(j = 0; j < idVec.length; )
            {
               data = PlayerManager.Instance.Self.cardBagDic;
               var _loc9_:int = 0;
               var _loc8_:* = data;
               for each(var info in data)
               {
                  if(info.TemplateID == idVec[j])
                  {
                     sortData.push(info.Place);
                     break;
                  }
               }
               j++;
            }
            m++;
         }
         SocketManager.Instance.out.sendSortCards(sortData);
      }
      
      public function getBagGoodsCategoryIDSort(CategoryID:uint) : int
      {
         var i:int = 0;
         var arrCategoryIDSort:Array = [7,17,1,5,8,9,2,14,13,15,3,6,4,16];
         for(i = 0; i < arrCategoryIDSort.length; )
         {
            if(CategoryID == arrCategoryIDSort[i])
            {
               return i;
            }
            i++;
         }
         return 9999;
      }
      
      private function bagComparisonType(bagArray1:Array, bagArray2:Array, startPlace:int) : Boolean
      {
         var i:int = 0;
         if(bagArray1.length < bagArray2.length)
         {
            return false;
         }
         var len:int = bagArray1.length;
         for(i = 0; i < len; )
         {
            if(i + startPlace != bagArray2[i].Place || bagArray1[i].Quality != bagArray2[i].Quality || bagArray1[i].Type != bagArray2[i].Type)
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      private function bagComparison(bagArray1:Array, bagArray2:Array, startPlace:int) : Boolean
      {
         var i:int = 0;
         if(bagArray1.length < bagArray2.length)
         {
            return false;
         }
         var len:int = bagArray1.length;
         for(i = 0; i < len; )
         {
            if(i + startPlace != bagArray2[i].Place || bagArray1[i].ItemID != bagArray2[i].ItemID || bagArray1[i].TemplateID != bagArray2[i].TemplateID)
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function itemBgNumber(startPlace:int, endPlace:int) : int
      {
         var i:* = 0;
         var result:int = 0;
         for(i = startPlace; i <= endPlace; )
         {
            if(_items[i] != null)
            {
               result++;
            }
            i++;
         }
         return result;
      }
      
      public function getItemByItemId(itemId:int) : InventoryItemInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var i in _items)
         {
            if(i.ItemID == itemId)
            {
               return i;
            }
         }
         return null;
      }
      
      private function isPetsEquip(id:int) : Boolean
      {
         return id >= 30001 && id <= 30006 || id >= 31001 && id <= 31006 || id >= 32001 && id <= 32006;
      }
      
      public function get isBatch() : Boolean
      {
         return _isBatch;
      }
      
      public function set isBatch(value:Boolean) : void
      {
         _isBatch = value;
      }
   }
}
