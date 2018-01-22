package horse
{
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import horse.analyzer.HorseAmuletDataAnalyzer;
   import horse.data.HorseAmuletVo;
   import road7th.data.DictionaryData;
   
   public class HorseAmuletManager extends EventDispatcher
   {
      
      public static const LIMIT_LEVEL:Array = [0,0,3,6,9,12,15,18,21];
      
      public static const EQUIP_VIEW:int = 1;
      
      public static const ACTIVATE_VIEW:int = 2;
      
      public static const ACTIVATE_PLACE:int = 19;
      
      public static const HIGH_QUALITY:int = 4;
      
      private static var _instance:HorseAmuletManager;
       
      
      public var activateAlertFrameShow:Boolean = true;
      
      private var _data:DictionaryData;
      
      private var _property:Array;
      
      private var _viewType:int = 1;
      
      public function HorseAmuletManager()
      {
         super();
         _property = LanguageMgr.GetTranslation("tank.horseAmulet.propertyList").split(",");
      }
      
      public static function get instance() : HorseAmuletManager
      {
         if(_instance == null)
         {
            _instance = new HorseAmuletManager();
         }
         return _instance;
      }
      
      public function set viewType(param1:int) : void
      {
         if(_viewType == param1)
         {
            return;
         }
         _viewType = param1;
         dispatchEvent(new Event("change"));
      }
      
      public function get viewType() : int
      {
         return _viewType;
      }
      
      public function analyzer(param1:HorseAmuletDataAnalyzer) : void
      {
         _data = param1.data;
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
      
      public function getHorseAmuletVo(param1:int) : HorseAmuletVo
      {
         return _data[param1] as HorseAmuletVo;
      }
      
      public function isHighQuality(param1:int) : Boolean
      {
         return getHorseAmuletVo(param1).Quality >= 4;
      }
      
      public function getByExtendType(param1:int) : String
      {
         return _property[param1 - 1];
      }
      
      public function canEquipAmulet(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:int = getHorseAmuletVo(param1).ExtendType1;
         var _loc3_:BagInfo = PlayerManager.Instance.Self.horseAmuletBag;
         _loc6_ = 0;
         while(_loc6_ < 9)
         {
            _loc5_ = _loc3_.getItemAt(_loc6_);
            if(_loc5_ && getHorseAmuletVo(_loc5_.TemplateID).ExtendType1 == _loc4_)
            {
               _loc2_++;
               if(_loc2_ >= 3)
               {
                  return false;
               }
            }
            _loc6_++;
         }
         return true;
      }
      
      public function canPutInEquipAmulet() : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:BagInfo = PlayerManager.Instance.Self.horseAmuletBag;
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            if(LIMIT_LEVEL[_loc3_] > HorseManager.instance.curLevel)
            {
               return -1;
            }
            _loc2_ = _loc1_.getItemAt(_loc3_);
            if(_loc2_ == null)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function getHorseAmuletHp() : int
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc1_:int = 0;
         var _loc2_:BagInfo = PlayerManager.Instance.Self.horseAmuletBag;
         _loc5_ = 0;
         while(_loc5_ < 9)
         {
            _loc4_ = _loc2_.getItemAt(_loc5_) as InventoryItemInfo;
            if(_loc4_)
            {
               _loc3_ = HorseAmuletManager.instance.getHorseAmuletVo(_loc4_.TemplateID);
               _loc1_ = _loc1_ + _loc3_.BaseType1Value;
            }
            _loc5_++;
         }
         return _loc1_;
      }
   }
}
