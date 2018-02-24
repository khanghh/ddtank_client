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
      
      public function HorseAmuletManager(){super();}
      
      public static function get instance() : HorseAmuletManager{return null;}
      
      public function set viewType(param1:int) : void{}
      
      public function get viewType() : int{return 0;}
      
      public function analyzer(param1:HorseAmuletDataAnalyzer) : void{}
      
      public function get data() : DictionaryData{return null;}
      
      public function getHorseAmuletVo(param1:int) : HorseAmuletVo{return null;}
      
      public function isHighQuality(param1:int) : Boolean{return false;}
      
      public function getByExtendType(param1:int) : String{return null;}
      
      public function canEquipAmulet(param1:int) : Boolean{return false;}
      
      public function canPutInEquipAmulet() : int{return 0;}
      
      public function getHorseAmuletHp() : int{return 0;}
   }
}
