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
      
      public function BagInfo(param1:int, param2:int)
      {
         _changedSlots = new Dictionary();
         super();
         _type = param1;
         _items = new DictionaryData();
         _capability = param2;
      }
      
      public static function parseCategoryID(param1:int, param2:int) : int
      {
         var _loc3_:int = -1;
         if(param1 != 0 || param2 > 30)
         {
            return _loc3_;
         }
         switch(int(param2))
         {
            case 0:
               _loc3_ = 1;
               break;
            default:
               _loc3_ = 1;
               break;
            default:
               _loc3_ = 1;
               break;
            default:
               _loc3_ = 1;
               break;
            case 4:
               _loc3_ = 5;
               break;
            default:
               _loc3_ = 5;
               break;
            case 6:
               _loc3_ = 7;
         }
         return _loc3_;
      }
      
      public function get BagType() : int
      {
         return _type;
      }
      
      public function getItemAt(param1:int) : InventoryItemInfo
      {
         return _items[param1];
      }
      
      public function get items() : DictionaryData
      {
         return _items;
      }
      
      public function get itemNumber() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 49)
         {
            if(_items[_loc2_] != null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getBagFullByIndex(param1:int, param2:int) : Boolean
      {
         var _loc3_:* = 0;
         _loc3_ = param1;
         while(_loc3_ < param2)
         {
            if(_items[_loc3_] == null)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function set items(param1:DictionaryData) : void
      {
         _items = param1;
      }
      
      public function addItem(param1:InventoryItemInfo) : void
      {
         param1.BagType = _type;
         param1.fromBag = true;
         _items.add(param1.Place,param1);
         if(isBatch)
         {
            return;
         }
         onItemChanged(param1.Place,param1);
      }
      
      public function addItemIntoFightBag(param1:int, param2:int = 1) : void
      {
         var _loc3_:InventoryItemInfo = new InventoryItemInfo();
         _loc3_.BagType = 3;
         _loc3_.Place = findFirstPlace();
         _loc3_.Count = param2;
         _loc3_.TemplateID = param1;
         ItemManager.fill(_loc3_);
         addItem(_loc3_);
      }
      
      private function findFirstPlace() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            if(getItemAt(_loc1_) == null)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function removeItemAt(param1:int) : void
      {
         var _loc2_:InventoryItemInfo = _items[param1];
         if(_loc2_)
         {
            _loc2_.fromBag = false;
            _items.remove(param1);
            if(isBatch || _type == 4 && StateManager.currentStateType == "fighting")
            {
               return;
            }
            onItemChanged(param1,_loc2_);
         }
      }
      
      public function updateItem(param1:InventoryItemInfo) : void
      {
         if(param1.BagType == _type)
         {
            onItemChanged(param1.Place,param1);
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
      
      protected function onItemChanged(param1:int, param2:InventoryItemInfo) : void
      {
         _changedSlots[param1] = param2;
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
      
      public function findItems(param1:int, param2:Boolean = true) : Array
      {
         var _loc3_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var _loc4_ in _items)
         {
            if(_loc4_.CategoryID == param1)
            {
               if(!param2 || _loc4_.getRemainDate() > 0)
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         return _loc3_;
      }
      
      public function findFirstItem(param1:int, param2:Boolean = true) : InventoryItemInfo
      {
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc3_ in _items)
         {
            if(_loc3_.CategoryID == param1)
            {
               if(!param2 || _loc3_.getRemainDate() > 0)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public function getItemByTemplateId(param1:int) : InventoryItemInfo
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _items.list.length)
         {
            _loc2_ = _items.list[_loc3_];
            if(_loc2_.TemplateID == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function findEquipedItemByTemplateId(param1:int, param2:Boolean = true) : InventoryItemInfo
      {
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc3_ in _items)
         {
            if(_loc3_.TemplateID == param1)
            {
               if(_loc3_.Place <= 30)
               {
                  if(!param2 || _loc3_.getRemainDate() > 0)
                  {
                     return _loc3_;
                  }
               }
            }
         }
         return null;
      }
      
      public function findIsEquipedByPlace(param1:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:* = param1;
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var _loc3_ in _items)
         {
            if(_loc3_.Place <= 30)
            {
               _loc4_ = 0;
               while(_loc4_ < param1.length)
               {
                  if(param1[_loc4_] == _loc3_.Place && _loc3_.getRemainDate() > 0)
                  {
                     _loc2_.splice(_loc4_,1);
                  }
                  _loc4_++;
               }
               continue;
            }
         }
         return _loc2_;
      }
      
      public function findOvertimeItems(param1:Number = 0) : Array
      {
         var _loc2_:Number = NaN;
         var _loc3_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var _loc4_ in _items)
         {
            _loc2_ = _loc4_.getRemainDate();
            if(_loc2_ > param1 && _loc2_ < 1)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function findOvertimeItemsByBody() : Array
      {
         var _loc4_:* = 0;
         var _loc2_:* = null;
         var _loc1_:Number = NaN;
         var _loc3_:Array = [];
         _loc4_ = uint(0);
         while(_loc4_ < 30)
         {
            if(_loc4_ != 17 && _items[_loc4_] as InventoryItemInfo)
            {
               _loc2_ = _items[_loc4_] as InventoryItemInfo;
               _loc1_ = _loc2_.getRemainDate();
               if(_loc1_ <= 0 && ShopManager.Instance.canAddPrice(_loc2_.TemplateID))
               {
                  _loc3_.push(_items[_loc4_]);
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function findOvertimeItemsByBodyII() : Array
      {
         var _loc3_:* = 0;
         var _loc1_:Number = NaN;
         var _loc2_:Array = [];
         _loc3_ = uint(0);
         while(_loc3_ < 80)
         {
            if(_items[_loc3_] as InventoryItemInfo)
            {
               if(_loc3_ < 30)
               {
                  _loc1_ = (_items[_loc3_] as InventoryItemInfo).getRemainDate();
               }
               if((_items[_loc3_] as InventoryItemInfo).isGold)
               {
                  _loc1_ = (_items[_loc3_] as InventoryItemInfo).getGoldRemainDate();
               }
               if(_loc1_ <= 0)
               {
                  _loc2_.push(_items[_loc3_]);
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function findItemsForEach(param1:int, param2:Boolean = true) : Array
      {
         var _loc3_:DictionaryData = new DictionaryData();
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var _loc4_ in _items)
         {
            if(_loc4_.CategoryID == param1 && _loc3_[_loc4_.TemplateID] == null)
            {
               if(!param2 || _loc4_.getRemainDate() > 0)
               {
                  _loc3_.add(_loc4_.TemplateID,_loc4_);
               }
            }
         }
         return _loc3_.list;
      }
      
      public function findFistItemByTemplateId(param1:int, param2:Boolean = true, param3:Boolean = false) : InventoryItemInfo
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = _items;
         for each(var _loc6_ in _items)
         {
            if(_loc6_.TemplateID == param1 && (!param2 || _loc6_.getRemainDate() > 0))
            {
               if(param3)
               {
                  if(_loc6_.IsUsed)
                  {
                     if(_loc5_ == null)
                     {
                        _loc5_ = _loc6_;
                     }
                  }
                  else if(_loc4_ == null)
                  {
                     _loc4_ = _loc6_;
                  }
                  continue;
               }
               return _loc6_;
            }
         }
         return !!_loc5_?_loc5_:_loc4_;
      }
      
      public function findBodyThingByCategory(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < 30)
         {
            _loc3_ = _items[_loc4_] as InventoryItemInfo;
            if(_loc3_ != null)
            {
               if(_loc3_.CategoryID == param1)
               {
                  _loc2_.push(_loc3_);
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getItemCountByTemplateIdBindType(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var _loc4_ in _items)
         {
            if(_loc4_.TemplateID == param1 && _loc4_.getRemainDate() > 0 && (param2 == 1 && !_loc4_.IsBinds || param2 == 2 && _loc4_.IsBinds))
            {
               _loc3_ = _loc3_ + _loc4_.Count;
            }
         }
         return _loc3_;
      }
      
      public function getItemCountByTemplateId(param1:int, param2:Boolean = true) : int
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var _loc4_ in _items)
         {
            if(_loc4_.TemplateID == param1 && (!param2 || _loc4_.getRemainDate() > 0))
            {
               _loc3_ = _loc3_ + _loc4_.Count;
            }
         }
         return _loc3_;
      }
      
      public function getLimitSLItemCountByTemplateId(param1:int, param2:int = -1, param3:Boolean = true) : int
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = _items;
         for each(var _loc5_ in _items)
         {
            if(_loc5_.TemplateID == param1 && _loc5_.Place > 30 && (_loc5_.StrengthenLevel == param2 || param2 == -1) && (!param3 || _loc5_.getRemainDate() > 0))
            {
               _loc4_ = _loc4_ + _loc5_.Count;
            }
         }
         return _loc4_;
      }
      
      public function getBagItemCountByTemplateIdBindType(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = PlayerManager.Instance.Self.ID;
         var _loc7_:int = 0;
         var _loc6_:* = _items;
         for each(var _loc5_ in _items)
         {
            if(_loc5_.TemplateID == param1 && _loc5_.Place > 30 && _loc5_.getRemainDate() > 0 && (param2 == 1 && !_loc5_.IsBinds || param2 == 2 && _loc5_.IsBinds))
            {
               _loc3_ = _loc3_ + _loc5_.Count;
            }
         }
         return _loc3_;
      }
      
      public function getBagItemCountByTemplateId(param1:int, param2:Boolean = true) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = PlayerManager.Instance.Self.ID;
         var _loc7_:int = 0;
         var _loc6_:* = _items;
         for each(var _loc5_ in _items)
         {
            if(_loc5_.TemplateID == param1 && _loc5_.Place > 30 && (!param2 || _loc5_.getRemainDate() > 0))
            {
               _loc3_ = _loc3_ + _loc5_.Count;
            }
         }
         return _loc3_;
      }
      
      public function findItemsByTempleteID(param1:int, param2:Boolean = true) : Array
      {
         var _loc3_:DictionaryData = new DictionaryData();
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var _loc4_ in _items)
         {
            if(_loc4_.TemplateID == param1 && _loc3_[_loc4_.TemplateID] == null)
            {
               if(!param2 || _loc4_.getRemainDate() > 0)
               {
                  _loc3_.add(_loc4_.TemplateID,_loc4_);
               }
            }
         }
         return _loc3_.list;
      }
      
      public function findItemsByTempleteIDNoValidate(param1:int) : Array
      {
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc3_ in _items)
         {
            if(_loc3_.TemplateID == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function findCellsByTempleteID(param1:int, param2:Boolean = true) : Array
      {
         var _loc3_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(var _loc4_ in _items)
         {
            if(_loc4_.TemplateID == param1 && (!param2 || _loc4_.getRemainDate() > 0))
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function clearnAll() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 49)
         {
            removeItemAt(_loc1_);
            _loc1_++;
         }
      }
      
      public function unlockItem(param1:InventoryItemInfo) : void
      {
         param1.lock = false;
         onItemChanged(param1.Place,param1);
      }
      
      public function unLockAll() : void
      {
         beginChanges();
         var _loc3_:int = 0;
         var _loc2_:* = _items;
         for each(var _loc1_ in _items)
         {
            if(_loc1_.lock)
            {
               onItemChanged(_loc1_.Place,_loc1_);
            }
            _loc1_.lock = false;
         }
         commiteChanges();
      }
      
      public function sortBag(param1:int, param2:BagInfo, param3:int, param4:int, param5:Boolean = false) : void
      {
         type = param1;
         bagInfo = param2;
         startPlace = param3;
         endPlace = param4;
         isSegistration = param5;
         __onResponse = function(param1:FrameEvent):void
         {
            SoundManager.instance.play("008");
            var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
            _loc2_.removeEventListener("response",__onResponse);
            _loc2_.dispose();
            if(param1.responseCode == 3 || param1.responseCode == 2)
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
      
      public function foldPetEquips(param1:int, param2:BagInfo, param3:int, param4:int) : void
      {
         var _loc12_:* = null;
         var _loc10_:Boolean = false;
         var _loc13_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:DictionaryData = param2.items;
         var _loc11_:* = param3;
         if(param2 == PlayerManager.Instance.Self.Bag)
         {
            _loc11_ = 31;
            param4 = 79;
         }
         var _loc5_:Dictionary = new Dictionary();
         var _loc7_:Array = [];
         var _loc18_:int = 0;
         var _loc17_:* = _loc8_;
         for(var _loc14_ in _loc8_)
         {
            _loc12_ = _loc8_[_loc14_];
            if(_loc12_.Place >= _loc11_ && _loc12_.Place <= param4 && _loc12_.CategoryID >= 50 && _loc12_.CategoryID <= 52 && _loc12_.Quality <= 4)
            {
               _loc10_ = true;
               var _loc16_:int = 0;
               var _loc15_:* = _loc5_;
               for(var _loc9_ in _loc5_)
               {
                  if(_loc12_.TemplateID == parseInt(_loc9_))
                  {
                     _loc13_ = _loc5_[_loc9_];
                     _loc6_ = _loc8_[_loc13_].Place;
                     _loc7_.push({
                        "sPlace":_loc6_,
                        "tPlace":_loc12_.Place
                     });
                     _loc10_ = false;
                     break;
                  }
               }
               if(_loc10_)
               {
                  _loc5_[_loc12_.TemplateID] = _loc14_;
               }
            }
         }
         if(_loc7_.length > 0)
         {
            SocketManager.Instance.out.foldDressItem(_loc7_,68,36);
         }
      }
      
      private function sortMagicStone(param1:BagInfo, param2:int, param3:int) : void
      {
         var _loc7_:DictionaryData = param1.items;
         var _loc6_:Array = [];
         var _loc5_:Array = [];
         var _loc10_:int = 0;
         var _loc9_:* = _loc7_;
         for each(var _loc4_ in _loc7_)
         {
            if(_loc4_.Place >= param2 && _loc4_.Place <= param3)
            {
               _loc6_.push({
                  "Property":propertyAssort(_loc4_),
                  "Quality":_loc4_.Quality,
                  "StrengthenLevel":_loc4_.StrengthenLevel,
                  "StrengthenExp":_loc4_.StrengthenExp,
                  "Place":_loc4_.Place,
                  "Name":_loc4_.Name,
                  "ItemID":_loc4_.ItemID,
                  "TemplateID":_loc4_.TemplateID
               });
            }
         }
         var _loc8_:ByteArray = new ByteArray();
         _loc8_.writeObject(_loc6_);
         _loc8_.position = 0;
         _loc5_ = _loc8_.readObject() as Array;
         _loc6_.sortOn(["Property","Quality","StrengthenLevel","StrengthenExp","Place"],[16,16 | 2,16 | 2,16 | 2,16]);
         if(bagComparison(_loc6_,_loc5_,param2))
         {
            return;
         }
         SocketManager.Instance.out.sortMgStoneBag(_loc6_,param2);
      }
      
      private function propertyAssort(param1:InventoryItemInfo) : int
      {
         if(param1.Property3 == "4")
         {
            return 1;
         }
         if(param1.Property3 == "3")
         {
            return 2;
         }
         if(param1.Property3 == "2")
         {
            return 3;
         }
         if(param1.MagicAttack > 0)
         {
            return 4;
         }
         if(param1.MagicDefence > 0)
         {
            return 5;
         }
         if(param1.AttackCompose > 0)
         {
            return 6;
         }
         if(param1.DefendCompose > 0)
         {
            return 7;
         }
         if(param1.AgilityCompose > 0)
         {
            return 8;
         }
         if(param1.LuckCompose > 0)
         {
            return 9;
         }
         return 0;
      }
      
      private function sortBead(param1:BagInfo, param2:int, param3:int, param4:Boolean) : void
      {
         var _loc11_:int = 0;
         var _loc9_:DictionaryData = param1.items;
         var _loc8_:Array = [];
         var _loc7_:Array = [];
         var _loc5_:int = 0;
         var _loc6_:int = _loc9_.list.length;
         _loc11_ = 0;
         while(_loc11_ < _loc6_)
         {
            if(int(_loc9_.list[_loc11_].Place) >= param2 && int(_loc9_.list[_loc11_].Place) <= param3)
            {
               _loc8_.push({
                  "Type":_loc9_.list[_loc11_].Property2,
                  "TemplateID":_loc9_.list[_loc11_].TemplateID,
                  "Level":_loc9_.list[_loc11_].Hole1,
                  "Exp":_loc9_.list[_loc11_].Hole2,
                  "Place":_loc9_.list[_loc11_].Place
               });
            }
            _loc11_++;
         }
         var _loc10_:ByteArray = new ByteArray();
         _loc10_.writeObject(_loc8_);
         _loc10_.position = 0;
         _loc7_ = _loc10_.readObject() as Array;
         _loc8_.sortOn(["Type","TemplateID","Level","Exp","Place"],[16,2,2,2,16]);
         if(!param4 && bagComparison(_loc8_,_loc7_,param2))
         {
            return;
         }
         SocketManager.Instance.out.sendMoveGoodsAll(param1.BagType,_loc8_,param2,param4);
      }
      
      private function sortAmulet(param1:BagInfo, param2:int, param3:int, param4:Boolean = false) : void
      {
         var _loc12_:int = 0;
         var _loc11_:* = null;
         var _loc9_:DictionaryData = param1.items;
         var _loc8_:Array = [];
         var _loc7_:Array = [];
         var _loc5_:int = 0;
         var _loc6_:int = _loc9_.list.length;
         _loc12_ = 0;
         while(_loc12_ < _loc6_)
         {
            if(int(_loc9_.list[_loc12_].Place) >= param2 && int(_loc9_.list[_loc12_].Place) <= param3)
            {
               _loc11_ = HorseAmuletManager.instance.getHorseAmuletVo(_loc9_.list[_loc12_].TemplateID);
               _loc8_.push({
                  "Quality":_loc11_.Quality,
                  "Type":_loc11_.ExtendType1,
                  "Place":_loc9_.list[_loc12_].Place
               });
            }
            _loc12_++;
         }
         var _loc10_:ByteArray = new ByteArray();
         _loc10_.writeObject(_loc8_);
         _loc10_.position = 0;
         _loc7_ = _loc10_.readObject() as Array;
         _loc8_.sortOn(["Quality","Type","Place"],[16 | 2,16,16]);
         if(!param4 && bagComparisonType(_loc8_,_loc7_,param2))
         {
            return;
         }
         SocketManager.Instance.out.sendMoveGoodsAll(param1.BagType,_loc8_,param2,param4);
      }
      
      private function showPetsMergerInfo(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:int = -1;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(isPetsEquip(param1[_loc2_].TemplateID))
            {
               if(_loc4_ != param1[_loc2_].TemplateID)
               {
                  _loc4_ = param1[_loc2_].TemplateID;
               }
               else
               {
                  _loc3_ = true;
                  break;
               }
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      private function sortCard() : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = undefined;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Vector.<int> = new Vector.<int>();
         var _loc1_:Vector.<SetsInfo> = CardManager.Instance.model.setsSortRuleVector;
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc5_].cardIdVec;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc3_ = PlayerManager.Instance.Self.cardBagDic;
               var _loc9_:int = 0;
               var _loc8_:* = _loc3_;
               for each(var _loc7_ in _loc3_)
               {
                  if(_loc7_.TemplateID == _loc4_[_loc6_])
                  {
                     _loc2_.push(_loc7_.Place);
                     break;
                  }
               }
               _loc6_++;
            }
            _loc5_++;
         }
         SocketManager.Instance.out.sendSortCards(_loc2_);
      }
      
      public function getBagGoodsCategoryIDSort(param1:uint) : int
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [7,17,1,5,8,9,2,14,13,15,3,6,4,16];
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 == _loc2_[_loc3_])
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return 9999;
      }
      
      private function bagComparisonType(param1:Array, param2:Array, param3:int) : Boolean
      {
         var _loc5_:int = 0;
         if(param1.length < param2.length)
         {
            return false;
         }
         var _loc4_:int = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc5_ + param3 != param2[_loc5_].Place || param1[_loc5_].Quality != param2[_loc5_].Quality || param1[_loc5_].Type != param2[_loc5_].Type)
            {
               return false;
            }
            _loc5_++;
         }
         return true;
      }
      
      private function bagComparison(param1:Array, param2:Array, param3:int) : Boolean
      {
         var _loc5_:int = 0;
         if(param1.length < param2.length)
         {
            return false;
         }
         var _loc4_:int = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc5_ + param3 != param2[_loc5_].Place || param1[_loc5_].ItemID != param2[_loc5_].ItemID || param1[_loc5_].TemplateID != param2[_loc5_].TemplateID)
            {
               return false;
            }
            _loc5_++;
         }
         return true;
      }
      
      public function itemBgNumber(param1:int, param2:int) : int
      {
         var _loc4_:* = 0;
         var _loc3_:int = 0;
         _loc4_ = param1;
         while(_loc4_ <= param2)
         {
            if(_items[_loc4_] != null)
            {
               _loc3_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getItemByItemId(param1:int) : InventoryItemInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc2_ in _items)
         {
            if(_loc2_.ItemID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function isPetsEquip(param1:int) : Boolean
      {
         return param1 >= 30001 && param1 <= 30006 || param1 >= 31001 && param1 <= 31006 || param1 >= 32001 && param1 <= 32006;
      }
      
      public function get isBatch() : Boolean
      {
         return _isBatch;
      }
      
      public function set isBatch(param1:Boolean) : void
      {
         _isBatch = param1;
      }
   }
}
