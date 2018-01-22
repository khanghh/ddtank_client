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
       
      
      public function BeadModel()
      {
         super();
      }
      
      public static function getDrills() : DictionaryData
      {
         var _loc2_:DictionaryData = new DictionaryData();
         var _loc4_:int = 0;
         var _loc3_:* = PlayerManager.Instance.Self.PropBag.items;
         for each(var _loc1_ in PlayerManager.Instance.Self.PropBag.items)
         {
            if(EquipType.isDrill(_loc1_))
            {
               _loc2_.add(_loc2_.length,_loc1_);
            }
         }
         return _loc2_;
      }
      
      public static function getDrillsIgnoreBindState() : DictionaryData
      {
         var _loc3_:* = null;
         var _loc1_:DictionaryData = new DictionaryData();
         var _loc5_:int = 0;
         var _loc4_:* = PlayerManager.Instance.Self.PropBag.items;
         for each(var _loc2_ in PlayerManager.Instance.Self.PropBag.items)
         {
            if(EquipType.isDrill(_loc2_))
            {
               if(_loc1_[_loc2_.TemplateID] != null)
               {
                  DrillItemInfo(_loc1_[_loc2_.TemplateID]).amount = DrillItemInfo(_loc1_[_loc2_.TemplateID]).amount + _loc2_.Count;
               }
               else
               {
                  _loc3_ = new DrillItemInfo();
                  _loc3_.itemInfo = _loc2_;
                  _loc3_.amount = _loc2_.Count;
                  _loc1_.add(_loc2_.TemplateID,_loc3_);
               }
            }
         }
         return _loc1_;
      }
      
      public static function getHoleMaxOpLv() : int
      {
         if(_holeExpModel == null)
         {
            _holeExpModel = ComponentFactory.Instance.creatCustomObject("BeadHoleModel");
         }
         return _holeExpModel.getMaxOpLv();
      }
      
      public static function getHoleExpByLv(param1:int) : int
      {
         return ServerConfigManager.instance.getBeadHoleUpExp()[param1];
      }
   }
}
