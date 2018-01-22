package magicHouse
{
   import flash.events.EventDispatcher;
   
   public class MagicHouseModel extends EventDispatcher
   {
      
      public static const FREEBOX_MAXCOUNT:int = 5;
      
      public static const CHARGEBOX_MAXCOUNT:int = 20;
      
      private static var _instance:MagicHouseModel = null;
       
      
      public var viewIndex:int = 0;
      
      public const TITLE_JUNIOR_ID:int = 1010;
      
      public const TITLE_MID_ID:int = 1011;
      
      public const TITLE_SENIOR_ID:int = 1012;
      
      private var _equipOpenList:Array;
      
      public var isOpen:Boolean;
      
      public var isMagicRoomShow:Boolean;
      
      private var _activityWeapons:Array;
      
      private var _magicJuniorLv:int;
      
      private var _magicJuniorExp:int;
      
      private var _magicMidLv:int;
      
      private var _magicMidExp:int;
      
      private var _magicSeniorLv:int;
      
      private var _magicSeniorExp:int;
      
      private var _freeGetCount:int;
      
      private var _freeGetTime:Date;
      
      private var _chargeGetCount:int;
      
      private var _chargeGetTime:Date;
      
      private var _depotCount:int;
      
      private var _juniorWeaponList:Array;
      
      private var _midWeaponList:Array;
      
      private var _seniorWeapinList:Array;
      
      private var _boxNeedmoney:int;
      
      private var _levelUpNumber:Array;
      
      private var _openDepotNeedMoney:int;
      
      private var _depotPromoteNeedMoney:int;
      
      private var _juniorAddAttribute:Array;
      
      private var _midAddAttribute:Array;
      
      private var _seniorAddAttribute:Array;
      
      private var _titleDatas:Array;
      
      public var itemExtrationEnableList:Array;
      
      public var itemFusionEnableList:Array;
      
      public var freeBoxGoodListInfos:Array;
      
      public var chargeBoxGoodListInfos:Array;
      
      public function MagicHouseModel(param1:MagicHouseInstance)
      {
         super();
      }
      
      public static function get instance() : MagicHouseModel
      {
         if(_instance == null)
         {
            _instance = new MagicHouseModel(new MagicHouseInstance());
         }
         return _instance;
      }
      
      public function get activityWeapons() : Array
      {
         return _activityWeapons;
      }
      
      public function set activityWeapons(param1:Array) : void
      {
         _activityWeapons = param1;
      }
      
      public function get magicJuniorLv() : int
      {
         return _magicJuniorLv;
      }
      
      public function set magicJuniorLv(param1:int) : void
      {
         _magicJuniorLv = param1;
      }
      
      public function get magicJuniorExp() : int
      {
         return _magicJuniorExp;
      }
      
      public function set magicJuniorExp(param1:int) : void
      {
         _magicJuniorExp = param1;
      }
      
      public function get magicMidLv() : int
      {
         return _magicMidLv;
      }
      
      public function set magicMidLv(param1:int) : void
      {
         _magicMidLv = param1;
      }
      
      public function get magicMidExp() : int
      {
         return _magicMidExp;
      }
      
      public function set magicMidExp(param1:int) : void
      {
         _magicMidExp = param1;
      }
      
      public function get magicSeniorLv() : int
      {
         return _magicSeniorLv;
      }
      
      public function set magicSeniorLv(param1:int) : void
      {
         _magicSeniorLv = param1;
      }
      
      public function get magicSeniorExp() : int
      {
         return _magicSeniorExp;
      }
      
      public function set magicSeniorExp(param1:int) : void
      {
         _magicSeniorExp = param1;
      }
      
      public function get freeGetCount() : int
      {
         return _freeGetCount;
      }
      
      public function set freeGetCount(param1:int) : void
      {
         _freeGetCount = param1;
      }
      
      public function get freeGetTime() : Date
      {
         return _freeGetTime;
      }
      
      public function set freeGetTime(param1:Date) : void
      {
         _freeGetTime = param1;
      }
      
      public function get chargeGetCount() : int
      {
         return _chargeGetCount;
      }
      
      public function set chargeGetCount(param1:int) : void
      {
         _chargeGetCount = param1;
      }
      
      public function get chargeGetTime() : Date
      {
         return _chargeGetTime;
      }
      
      public function set chargeGetTime(param1:Date) : void
      {
         _chargeGetTime = param1;
      }
      
      public function get depotCount() : int
      {
         return _depotCount;
      }
      
      public function set depotCount(param1:int) : void
      {
         _depotCount = param1;
      }
      
      public function get juniorWeaponList() : Array
      {
         return _juniorWeaponList;
      }
      
      public function set juniorWeaponList(param1:Array) : void
      {
         _juniorWeaponList = param1;
      }
      
      public function get midWeaponList() : Array
      {
         return _midWeaponList;
      }
      
      public function set midWeaponList(param1:Array) : void
      {
         _midWeaponList = param1;
      }
      
      public function get seniorWeapinList() : Array
      {
         return _seniorWeapinList;
      }
      
      public function set seniorWeapinList(param1:Array) : void
      {
         _seniorWeapinList = param1;
      }
      
      public function get boxNeedmoney() : int
      {
         return _boxNeedmoney;
      }
      
      public function set boxNeedmoney(param1:int) : void
      {
         _boxNeedmoney = param1;
      }
      
      public function get levelUpNumber() : Array
      {
         return _levelUpNumber;
      }
      
      public function set levelUpNumber(param1:Array) : void
      {
         _levelUpNumber = param1;
      }
      
      public function get openDepotNeedMoney() : int
      {
         return _openDepotNeedMoney;
      }
      
      public function set openDepotNeedMoney(param1:int) : void
      {
         _openDepotNeedMoney = param1;
      }
      
      public function get depotPromoteNeedMoney() : int
      {
         return _depotPromoteNeedMoney;
      }
      
      public function set depotPromoteNeedMoney(param1:int) : void
      {
         _depotPromoteNeedMoney = param1;
      }
      
      public function get equipOpenList() : Array
      {
         return _equipOpenList;
      }
      
      public function set equipOpenList(param1:Array) : void
      {
         _equipOpenList = param1;
      }
      
      public function get juniorAddAttribute() : Array
      {
         return _juniorAddAttribute;
      }
      
      public function set juniorAddAttribute(param1:Array) : void
      {
         _juniorAddAttribute = param1;
      }
      
      public function get midAddAttribute() : Array
      {
         return _midAddAttribute;
      }
      
      public function set midAddAttribute(param1:Array) : void
      {
         _midAddAttribute = param1;
      }
      
      public function get seniorAddAttribute() : Array
      {
         return _seniorAddAttribute;
      }
      
      public function set seniorAddAttribute(param1:Array) : void
      {
         _seniorAddAttribute = param1;
      }
      
      public function get titleDatas() : Array
      {
         return _titleDatas;
      }
      
      public function set titleDatas(param1:Array) : void
      {
         _titleDatas = param1;
      }
   }
}

class MagicHouseInstance
{
    
   
   function MagicHouseInstance()
   {
      super();
   }
}
