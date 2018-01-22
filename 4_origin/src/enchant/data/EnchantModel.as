package enchant.data
{
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import store.events.StoreBagEvent;
   import store.events.UpdateItemEvent;
   
   public class EnchantModel extends EventDispatcher
   {
       
      
      private var _canEnchantEquipList:DictionaryData;
      
      private var _canEnchantPropList:DictionaryData;
      
      private var _info:SelfInfo;
      
      private var _equipmentBag:DictionaryData;
      
      private var _propBag:DictionaryData;
      
      public function EnchantModel()
      {
         super();
         _info = PlayerManager.Instance.Self;
         _equipmentBag = _info.Bag.items;
         _propBag = _info.PropBag.items;
         initData();
         initEvent();
      }
      
      public function get canEnchantEquipList() : DictionaryData
      {
         return _canEnchantEquipList;
      }
      
      public function get canEnchantPropList() : DictionaryData
      {
         return _canEnchantPropList;
      }
      
      private function initData() : void
      {
         _canEnchantEquipList = new DictionaryData();
         _canEnchantPropList = new DictionaryData();
         initEquipProData(_equipmentBag,true);
         initEquipProData(_propBag,false);
      }
      
      private function initEquipProData(param1:DictionaryData, param2:Boolean) : void
      {
         var _loc4_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(var _loc5_ in param1)
         {
            if(param2)
            {
               if(_loc5_.isCanEnchant() && _loc5_.getRemainDate() > 0)
               {
                  if(_loc5_.Place < 17)
                  {
                     _canEnchantEquipList.add(_canEnchantEquipList.length,_loc5_);
                  }
                  else
                  {
                     _loc4_.push(_loc5_);
                  }
               }
            }
            else if(_loc5_.getRemainDate() > 0 && _loc5_.CategoryID == 11 && int(_loc5_.Property1) == 104)
            {
               _canEnchantPropList.add(_canEnchantPropList.length,_loc5_);
            }
         }
         if(param2)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _loc4_;
            for each(var _loc3_ in _loc4_)
            {
               _canEnchantEquipList.add(_canEnchantEquipList.length,_loc3_);
            }
         }
      }
      
      private function initEvent() : void
      {
         _info.PropBag.addEventListener("update",updateBag);
         _info.Bag.addEventListener("update",updateBag);
      }
      
      private function updateBag(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:BagInfo = param1.target as BagInfo;
         var _loc5_:Dictionary = param1.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = _loc5_;
         for each(var _loc4_ in _loc5_)
         {
            _loc2_ = _loc3_.getItemAt(_loc4_.Place);
            if(_loc2_)
            {
               if(_loc3_.BagType == 0)
               {
                  __updateEquip(_loc2_);
               }
               else if(_loc3_.BagType == 1)
               {
                  __updateProp(_loc2_);
               }
            }
            else if(_loc3_.BagType == 0)
            {
               removeFrom(_loc4_,_canEnchantEquipList);
            }
            else
            {
               removeFrom(_loc4_,_canEnchantPropList);
            }
         }
      }
      
      private function __updateEquip(param1:InventoryItemInfo) : void
      {
         if(param1.isCanEnchant() && param1.getRemainDate() > 0)
         {
            updateDic(_canEnchantEquipList,param1);
         }
         else
         {
            removeFrom(param1,_canEnchantEquipList);
         }
      }
      
      private function updateDic(param1:DictionaryData, param2:InventoryItemInfo) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] != null && param1[_loc3_].Place == param2.Place)
            {
               param1.add(_loc3_,param2);
               param1.dispatchEvent(new UpdateItemEvent("updateItemEvent",_loc3_,param2));
               return;
            }
            _loc3_++;
         }
         addItemToTheFirstNullCell(param2,param1);
      }
      
      private function addItemToTheFirstNullCell(param1:InventoryItemInfo, param2:DictionaryData) : void
      {
         param2.add(findFirstNullCellID(param2),param1);
      }
      
      private function findFirstNullCellID(param1:DictionaryData) : int
      {
         var _loc4_:int = 0;
         var _loc2_:* = -1;
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ <= _loc3_)
         {
            if(param1[_loc4_] == null)
            {
               _loc2_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function __updateProp(param1:InventoryItemInfo) : void
      {
         if(param1.getRemainDate() > 0 && param1.CategoryID == 11 && int(param1.Property1) == 104)
         {
            updateDic(_canEnchantPropList,param1);
         }
         else
         {
            removeFrom(param1,_canEnchantPropList);
         }
      }
      
      private function removeFrom(param1:InventoryItemInfo, param2:DictionaryData) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = param2.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(param2[_loc4_] && param2[_loc4_].Place == param1.Place)
            {
               param2[_loc4_] = null;
               param2.dispatchEvent(new StoreBagEvent("storeBagRemove",_loc4_,param1));
               break;
            }
            _loc4_++;
         }
      }
   }
}
