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
      
      public function FusionNewVo(){super();}
      
      public function get fusionItemInfo() : ItemTemplateInfo{return null;}
      
      public function get isNeedItem1() : Boolean{return false;}
      
      public function get item1Count() : int{return 0;}
      
      public function get isNeedItem2() : Boolean{return false;}
      
      public function get item2Count() : int{return 0;}
      
      public function get isNeedItem3() : Boolean{return false;}
      
      public function get item3Count() : int{return 0;}
      
      public function get isNeedItem4() : Boolean{return false;}
      
      public function get item4Count() : int{return 0;}
      
      public function get canFusionCount() : int{return 0;}
      
      public function get FusionRate() : int{return 0;}
      
      public function set FusionRate(param1:int) : void{}
      
      public function getItemInfoByIndex(param1:int) : ItemTemplateInfo{return null;}
      
      public function getItemNeedCount(param1:int) : int{return 0;}
      
      public function getItemHadCount(param1:int) : int{return 0;}
      
      public function getCellHeight() : Number{return 0;}
      
      public function isNeedPopBindTipWindow(param1:int) : Boolean{return false;}
      
      public function getCanFusionCountByBindType(param1:int) : int{return 0;}
      
      private function getItemCountByIndexBindType(param1:int, param2:int) : int{return 0;}
      
      public function get mountID() : int{return 0;}
   }
}
