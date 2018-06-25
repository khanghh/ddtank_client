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
      
      private function initEquipProData(bag:DictionaryData, isEquip:Boolean) : void
      {
         var arr:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = bag;
         for each(var item in bag)
         {
            if(isEquip)
            {
               if(item.isCanEnchant() && item.getRemainDate() > 0)
               {
                  if(item.Place < 17)
                  {
                     _canEnchantEquipList.add(_canEnchantEquipList.length,item);
                  }
                  else
                  {
                     arr.push(item);
                  }
               }
            }
            else if(item.getRemainDate() > 0 && item.CategoryID == 11 && int(item.Property1) == 104)
            {
               _canEnchantPropList.add(_canEnchantPropList.length,item);
            }
         }
         if(isEquip)
         {
            var _loc9_:int = 0;
            var _loc8_:* = arr;
            for each(var infoItem in arr)
            {
               _canEnchantEquipList.add(_canEnchantEquipList.length,infoItem);
            }
         }
      }
      
      private function initEvent() : void
      {
         _info.PropBag.addEventListener("update",updateBag);
         _info.Bag.addEventListener("update",updateBag);
      }
      
      private function updateBag(evt:BagEvent) : void
      {
         var c:* = null;
         var bag:BagInfo = evt.target as BagInfo;
         var changes:Dictionary = evt.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = changes;
         for each(var i in changes)
         {
            c = bag.getItemAt(i.Place);
            if(c)
            {
               if(bag.BagType == 0)
               {
                  __updateEquip(c);
               }
               else if(bag.BagType == 1)
               {
                  __updateProp(c);
               }
            }
            else if(bag.BagType == 0)
            {
               removeFrom(i,_canEnchantEquipList);
            }
            else
            {
               removeFrom(i,_canEnchantPropList);
            }
         }
      }
      
      private function __updateEquip(item:InventoryItemInfo) : void
      {
         if(item.isCanEnchant() && item.getRemainDate() > 0)
         {
            updateDic(_canEnchantEquipList,item);
         }
         else
         {
            removeFrom(item,_canEnchantEquipList);
         }
      }
      
      private function updateDic(dic:DictionaryData, item:InventoryItemInfo) : void
      {
         var i:int = 0;
         for(i = 0; i < dic.length; )
         {
            if(dic[i] != null && dic[i].Place == item.Place)
            {
               dic.add(i,item);
               dic.dispatchEvent(new UpdateItemEvent("updateItemEvent",i,item));
               return;
            }
            i++;
         }
         addItemToTheFirstNullCell(item,dic);
      }
      
      private function addItemToTheFirstNullCell(item:InventoryItemInfo, dic:DictionaryData) : void
      {
         dic.add(findFirstNullCellID(dic),item);
      }
      
      private function findFirstNullCellID(dic:DictionaryData) : int
      {
         var i:int = 0;
         var result:* = -1;
         var lth:int = dic.length;
         for(i = 0; i <= lth; )
         {
            if(dic[i] == null)
            {
               result = i;
               break;
            }
            i++;
         }
         return result;
      }
      
      private function __updateProp(item:InventoryItemInfo) : void
      {
         if(item.getRemainDate() > 0 && item.CategoryID == 11 && int(item.Property1) == 104)
         {
            updateDic(_canEnchantPropList,item);
         }
         else
         {
            removeFrom(item,_canEnchantPropList);
         }
      }
      
      private function removeFrom(item:InventoryItemInfo, dic:DictionaryData) : void
      {
         var i:int = 0;
         var lth:int = dic.length;
         for(i = 0; i < lth; )
         {
            if(dic[i] && dic[i].Place == item.Place)
            {
               dic[i] = null;
               dic.dispatchEvent(new StoreBagEvent("storeBagRemove",i,item));
               break;
            }
            i++;
         }
      }
   }
}
