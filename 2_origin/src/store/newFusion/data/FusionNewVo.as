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
         var _loc1_:int = _equipBag.getBagItemCountByTemplateId(Item1);
         var _loc2_:int = _propBag.getItemCountByTemplateId(Item1);
         return _loc1_ + _loc2_;
      }
      
      public function get isNeedItem2() : Boolean
      {
         return Item2 != -1 && Count2 > 0;
      }
      
      public function get item2Count() : int
      {
         var _loc1_:int = _equipBag.getBagItemCountByTemplateId(Item2);
         var _loc2_:int = _propBag.getItemCountByTemplateId(Item2);
         return _loc1_ + _loc2_;
      }
      
      public function get isNeedItem3() : Boolean
      {
         return Item3 != -1 && Count3 > 0;
      }
      
      public function get item3Count() : int
      {
         var _loc1_:int = _equipBag.getBagItemCountByTemplateId(Item3);
         var _loc2_:int = _propBag.getItemCountByTemplateId(Item3);
         return _loc1_ + _loc2_;
      }
      
      public function get isNeedItem4() : Boolean
      {
         return Item4 != -1 && Count4 > 0;
      }
      
      public function get item4Count() : int
      {
         var _loc1_:int = _equipBag.getBagItemCountByTemplateId(Item4);
         var _loc2_:int = _propBag.getItemCountByTemplateId(Item4);
         return _loc1_ + _loc2_;
      }
      
      public function get canFusionCount() : int
      {
         var _loc2_:int = 2147483647;
         if(isNeedItem1)
         {
            _loc2_ = item1Count / Count1;
         }
         var _loc5_:int = 2147483647;
         if(isNeedItem2)
         {
            _loc5_ = item2Count / Count2;
         }
         var _loc3_:int = 2147483647;
         if(isNeedItem3)
         {
            _loc3_ = item3Count / Count3;
         }
         var _loc1_:int = 2147483647;
         if(isNeedItem4)
         {
            _loc1_ = item4Count / Count4;
         }
         var _loc4_:int = Math.min(_loc2_,_loc5_,_loc3_,_loc1_);
         return _loc4_ == 2147483647?0:_loc4_;
      }
      
      public function get FusionRate() : int
      {
         return _FusionRate;
      }
      
      public function set FusionRate(param1:int) : void
      {
         _FusionRate = param1 / 1000 > 1?int(param1 / 1000):1;
      }
      
      public function getItemInfoByIndex(param1:int) : ItemTemplateInfo
      {
         if(!this["isNeedItem" + param1])
         {
            return null;
         }
         return ItemManager.Instance.getTemplateById(this["Item" + param1]);
      }
      
      public function getItemNeedCount(param1:int) : int
      {
         return this["Count" + param1];
      }
      
      public function getItemHadCount(param1:int) : int
      {
         return this["item" + param1 + "Count"];
      }
      
      public function getCellHeight() : Number
      {
         return 26;
      }
      
      public function isNeedPopBindTipWindow(param1:int) : Boolean
      {
         var _loc3_:int = getCanFusionCountByBindType(1);
         var _loc2_:int = getCanFusionCountByBindType(2);
         if(param1 > _loc3_ + _loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function getCanFusionCountByBindType(param1:int) : int
      {
         var _loc3_:int = 2147483647;
         if(isNeedItem1)
         {
            _loc3_ = getItemCountByIndexBindType(1,param1) / Count1;
         }
         var _loc6_:int = 2147483647;
         if(isNeedItem2)
         {
            _loc6_ = getItemCountByIndexBindType(2,param1) / Count2;
         }
         var _loc4_:int = 2147483647;
         if(isNeedItem3)
         {
            _loc4_ = getItemCountByIndexBindType(3,param1) / Count3;
         }
         var _loc2_:int = 2147483647;
         if(isNeedItem4)
         {
            _loc2_ = getItemCountByIndexBindType(4,param1) / Count4;
         }
         var _loc5_:int = Math.min(_loc3_,_loc6_,_loc4_,_loc2_);
         return _loc5_ == 2147483647?0:_loc5_;
      }
      
      private function getItemCountByIndexBindType(param1:int, param2:int) : int
      {
         var _loc3_:int = _equipBag.getBagItemCountByTemplateIdBindType(this["Item" + param1],param2);
         var _loc4_:int = _propBag.getItemCountByTemplateIdBindType(this["Item" + param1],param2);
         return _loc3_ + _loc4_;
      }
      
      public function get mountID() : int
      {
         return int(fusionItemInfo.Property2);
      }
   }
}
