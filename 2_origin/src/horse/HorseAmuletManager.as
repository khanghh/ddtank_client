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
      
      public var isActivate:Boolean;
      
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
      
      public function set viewType(value:int) : void
      {
         if(_viewType == value)
         {
            return;
         }
         _viewType = value;
         dispatchEvent(new Event("change"));
      }
      
      public function get viewType() : int
      {
         return _viewType;
      }
      
      public function analyzer(value:HorseAmuletDataAnalyzer) : void
      {
         _data = value.data;
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
      
      public function getHorseAmuletVo(id:int) : HorseAmuletVo
      {
         return _data[id] as HorseAmuletVo;
      }
      
      public function isHighQuality(id:int) : Boolean
      {
         return getHorseAmuletVo(id).Quality >= 4;
      }
      
      public function getByExtendType(type:int) : String
      {
         return _property[type - 1];
      }
      
      public function canEquipAmulet(tempID:int) : Boolean
      {
         var count:int = 0;
         var i:int = 0;
         var info:* = null;
         var type:int = getHorseAmuletVo(tempID).ExtendType1;
         var bag:BagInfo = PlayerManager.Instance.Self.horseAmuletBag;
         for(i = 0; i < 9; )
         {
            info = bag.getItemAt(i);
            if(info && getHorseAmuletVo(info.TemplateID).ExtendType1 == type)
            {
               count++;
               if(count >= 3)
               {
                  return false;
               }
            }
            i++;
         }
         return true;
      }
      
      public function canPutInEquipAmulet() : int
      {
         var i:int = 0;
         var info:* = null;
         var bag:BagInfo = PlayerManager.Instance.Self.horseAmuletBag;
         for(i = 0; i < 9; )
         {
            if(LIMIT_LEVEL[i] > HorseManager.instance.curLevel)
            {
               return -1;
            }
            info = bag.getItemAt(i);
            if(info == null)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public function getHorseAmuletHp() : int
      {
         var i:int = 0;
         var info:* = null;
         var vo:* = null;
         var hp:int = 0;
         var bag:BagInfo = PlayerManager.Instance.Self.horseAmuletBag;
         for(i = 0; i < 9; )
         {
            info = bag.getItemAt(i) as InventoryItemInfo;
            if(info)
            {
               vo = HorseAmuletManager.instance.getHorseAmuletVo(info.TemplateID);
               hp = hp + vo.BaseType1Value;
            }
            i++;
         }
         return hp;
      }
   }
}
