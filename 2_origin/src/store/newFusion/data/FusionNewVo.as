package store.newFusion.data
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   import ddt.data.BagInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   
   public class FusionNewVo implements INotSameHeightListCellData
   {
      
      public static const WEAPON_TYPE:int = 1;
      
      public static const JEWELLRY_TYPE:int = 2;
      
      public static const AVATAR_TYPE:int = 3;
      
      public static const DRILL_TYPE:int = 4;
      
      public static const COMBINE_TYPE:int = 5;
      
      public static const OTHER_TYPE:int = 6;
      
      public static const FUNCTIONPROP_TYPE:int = 101;
      
      public static const TASKGOODS_TYPE:int = 102;
      
      public static const HOMEDRESS_TYPE:int = 103;
       
      
      private var _equipBag:BagInfo;
      
      private var _propBag:BagInfo;
      
      public var FusionID:int;
      
      public var Reward:int;
      
      public var isActivated:Boolean = false;
      
      public var Item1:int;
      
      public var Count1:int;
      
      public var Item2:int;
      
      public var Count2:int;
      
      public var Item3:int;
      
      public var Count3:int;
      
      public var Item4:int;
      
      public var Count4:int;
      
      public var Formula:int;
      
      private var _FusionRate:int;
      
      public var FusionType:int;
      
      private var _mountID:int = 0;
      
      public var NeedPower:int;
      
      public function FusionNewVo()
      {
         _equipBag = PlayerManager.Instance.Self.getBag(0);
         _propBag = PlayerManager.Instance.Self.getBag(1);
         super();
      }
      
      public function get fusionItemInfo() : ItemTemplateInfo
      {
         return ItemManager.Instance.getTemplateById(Reward);
      }
      
      public function get isNeedItem1() : Boolean
      {
         return Item1 != -1 && Count1 > 0;
      }
      
      public function get item1Count() : int
      {
         var equipCount:int = _equipBag.getBagItemCountByTemplateId(Item1);
         var propCount:int = _propBag.getItemCountByTemplateId(Item1);
         return equipCount + propCount;
      }
      
      public function get isNeedItem2() : Boolean
      {
         return Item2 != -1 && Count2 > 0;
      }
      
      public function get item2Count() : int
      {
         var equipCount:int = _equipBag.getBagItemCountByTemplateId(Item2);
         var propCount:int = _propBag.getItemCountByTemplateId(Item2);
         return equipCount + propCount;
      }
      
      public function get isNeedItem3() : Boolean
      {
         return Item3 != -1 && Count3 > 0;
      }
      
      public function get item3Count() : int
      {
         var equipCount:int = _equipBag.getBagItemCountByTemplateId(Item3);
         var propCount:int = _propBag.getItemCountByTemplateId(Item3);
         return equipCount + propCount;
      }
      
      public function get isNeedItem4() : Boolean
      {
         return Item4 != -1 && Count4 > 0;
      }
      
      public function get item4Count() : int
      {
         var equipCount:int = _equipBag.getBagItemCountByTemplateId(Item4);
         var propCount:int = _propBag.getItemCountByTemplateId(Item4);
         return equipCount + propCount;
      }
      
      public function get canFusionCount() : int
      {
         var item1CanCount:int = 2147483647;
         if(isNeedItem1)
         {
            item1CanCount = item1Count / Count1;
         }
         var item2CanCount:int = 2147483647;
         if(isNeedItem2)
         {
            item2CanCount = item2Count / Count2;
         }
         var item3CanCount:int = 2147483647;
         if(isNeedItem3)
         {
            item3CanCount = item3Count / Count3;
         }
         var item4CanCount:int = 2147483647;
         if(isNeedItem4)
         {
            item4CanCount = item4Count / Count4;
         }
         var tmp:int = Math.min(item1CanCount,item2CanCount,item3CanCount,item4CanCount);
         return tmp == 2147483647?0:tmp;
      }
      
      public function get FusionRate() : int
      {
         return _FusionRate;
      }
      
      public function set FusionRate(value:int) : void
      {
         _FusionRate = value / 1000 > 1?int(value / 1000):1;
      }
      
      public function getItemInfoByIndex(index:int) : ItemTemplateInfo
      {
         if(!this["isNeedItem" + index])
         {
            return null;
         }
         return ItemManager.Instance.getTemplateById(this["Item" + index]);
      }
      
      public function getItemNeedCount(index:int) : int
      {
         return this["Count" + index];
      }
      
      public function getItemHadCount(index:int) : int
      {
         return this["item" + index + "Count"];
      }
      
      public function getCellHeight() : Number
      {
         return 26;
      }
      
      public function isNeedPopBindTipWindow(num:int) : Boolean
      {
         var unbindCanCount:int = getCanFusionCountByBindType(1);
         var bindCanCount:int = getCanFusionCountByBindType(2);
         if(num > unbindCanCount + bindCanCount)
         {
            return true;
         }
         return false;
      }
      
      public function getCanFusionCountByBindType(bindType:int) : int
      {
         var item1CanCount:int = 2147483647;
         if(isNeedItem1)
         {
            item1CanCount = getItemCountByIndexBindType(1,bindType) / Count1;
         }
         var item2CanCount:int = 2147483647;
         if(isNeedItem2)
         {
            item2CanCount = getItemCountByIndexBindType(2,bindType) / Count2;
         }
         var item3CanCount:int = 2147483647;
         if(isNeedItem3)
         {
            item3CanCount = getItemCountByIndexBindType(3,bindType) / Count3;
         }
         var item4CanCount:int = 2147483647;
         if(isNeedItem4)
         {
            item4CanCount = getItemCountByIndexBindType(4,bindType) / Count4;
         }
         var tmp:int = Math.min(item1CanCount,item2CanCount,item3CanCount,item4CanCount);
         return tmp == 2147483647?0:tmp;
      }
      
      private function getItemCountByIndexBindType(index:int, bindType:int) : int
      {
         var equipCount:int = _equipBag.getBagItemCountByTemplateIdBindType(this["Item" + index],bindType);
         var propCount:int = _propBag.getItemCountByTemplateIdBindType(this["Item" + index],bindType);
         return equipCount + propCount;
      }
      
      public function get mountID() : int
      {
         return int(fusionItemInfo.Property2);
      }
   }
}
