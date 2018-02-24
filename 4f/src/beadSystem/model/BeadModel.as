package beadSystem.model
{
   import beadSystem.controls.DrillItemInfo;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import road7th.data.DictionaryData;
   import store.data.HoleExpModel;
   
   public class BeadModel
   {
      
      private static var _holeExpModel:HoleExpModel;
      
      public static var _allBeadList:Vector.<InventoryItemInfo> = new Vector.<InventoryItemInfo>();
      
      public static var drillInfo:DictionaryData = new DictionaryData();
      
      public static var beadRequestBtnIndex:int = -1;
      
      public static var beadCanUpgrade:Boolean = false;
      
      public static var upgradeCellBeadLv:int = -1;
      
      public static var isHoleOpendComplete:Boolean = false;
      
      public static var tempHoleLv:int = -1;
      
      public static var _BeadCells:DictionaryData = new DictionaryData();
      
      public static var isBeadCellIsBind:Boolean = false;
      
      public static var upgradeCellInfo:InventoryItemInfo;
       
      
      public function BeadModel(){super();}
      
      public static function getDrills() : DictionaryData{return null;}
      
      public static function getDrillsIgnoreBindState() : DictionaryData{return null;}
      
      public static function getHoleMaxOpLv() : int{return 0;}
      
      public static function getHoleExpByLv(param1:int) : int{return 0;}
   }
}
