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
      
      public function MagicHouseModel($instance:MagicHouseInstance)
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
      
      public function set activityWeapons(arr:Array) : void
      {
         _activityWeapons = arr;
      }
      
      public function get magicJuniorLv() : int
      {
         return _magicJuniorLv;
      }
      
      public function set magicJuniorLv(i:int) : void
      {
         _magicJuniorLv = i;
      }
      
      public function get magicJuniorExp() : int
      {
         return _magicJuniorExp;
      }
      
      public function set magicJuniorExp(i:int) : void
      {
         _magicJuniorExp = i;
      }
      
      public function get magicMidLv() : int
      {
         return _magicMidLv;
      }
      
      public function set magicMidLv(i:int) : void
      {
         _magicMidLv = i;
      }
      
      public function get magicMidExp() : int
      {
         return _magicMidExp;
      }
      
      public function set magicMidExp(i:int) : void
      {
         _magicMidExp = i;
      }
      
      public function get magicSeniorLv() : int
      {
         return _magicSeniorLv;
      }
      
      public function set magicSeniorLv(i:int) : void
      {
         _magicSeniorLv = i;
      }
      
      public function get magicSeniorExp() : int
      {
         return _magicSeniorExp;
      }
      
      public function set magicSeniorExp(i:int) : void
      {
         _magicSeniorExp = i;
      }
      
      public function get freeGetCount() : int
      {
         return _freeGetCount;
      }
      
      public function set freeGetCount(i:int) : void
      {
         _freeGetCount = i;
      }
      
      public function get freeGetTime() : Date
      {
         return _freeGetTime;
      }
      
      public function set freeGetTime(d:Date) : void
      {
         _freeGetTime = d;
      }
      
      public function get chargeGetCount() : int
      {
         return _chargeGetCount;
      }
      
      public function set chargeGetCount(i:int) : void
      {
         _chargeGetCount = i;
      }
      
      public function get chargeGetTime() : Date
      {
         return _chargeGetTime;
      }
      
      public function set chargeGetTime(d:Date) : void
      {
         _chargeGetTime = d;
      }
      
      public function get depotCount() : int
      {
         return _depotCount;
      }
      
      public function set depotCount(i:int) : void
      {
         _depotCount = i;
      }
      
      public function get juniorWeaponList() : Array
      {
         return _juniorWeaponList;
      }
      
      public function set juniorWeaponList(arr:Array) : void
      {
         _juniorWeaponList = arr;
      }
      
      public function get midWeaponList() : Array
      {
         return _midWeaponList;
      }
      
      public function set midWeaponList(arr:Array) : void
      {
         _midWeaponList = arr;
      }
      
      public function get seniorWeapinList() : Array
      {
         return _seniorWeapinList;
      }
      
      public function set seniorWeapinList(arr:Array) : void
      {
         _seniorWeapinList = arr;
      }
      
      public function get boxNeedmoney() : int
      {
         return _boxNeedmoney;
      }
      
      public function set boxNeedmoney(i:int) : void
      {
         _boxNeedmoney = i;
      }
      
      public function get levelUpNumber() : Array
      {
         return _levelUpNumber;
      }
      
      public function set levelUpNumber(arr:Array) : void
      {
         _levelUpNumber = arr;
      }
      
      public function get openDepotNeedMoney() : int
      {
         return _openDepotNeedMoney;
      }
      
      public function set openDepotNeedMoney(i:int) : void
      {
         _openDepotNeedMoney = i;
      }
      
      public function get depotPromoteNeedMoney() : int
      {
         return _depotPromoteNeedMoney;
      }
      
      public function set depotPromoteNeedMoney(i:int) : void
      {
         _depotPromoteNeedMoney = i;
      }
      
      public function get equipOpenList() : Array
      {
         return _equipOpenList;
      }
      
      public function set equipOpenList(arr:Array) : void
      {
         _equipOpenList = arr;
      }
      
      public function get juniorAddAttribute() : Array
      {
         return _juniorAddAttribute;
      }
      
      public function set juniorAddAttribute(arr:Array) : void
      {
         _juniorAddAttribute = arr;
      }
      
      public function get midAddAttribute() : Array
      {
         return _midAddAttribute;
      }
      
      public function set midAddAttribute(arr:Array) : void
      {
         _midAddAttribute = arr;
      }
      
      public function get seniorAddAttribute() : Array
      {
         return _seniorAddAttribute;
      }
      
      public function set seniorAddAttribute(arr:Array) : void
      {
         _seniorAddAttribute = arr;
      }
      
      public function get titleDatas() : Array
      {
         return _titleDatas;
      }
      
      public function set titleDatas(arr:Array) : void
      {
         _titleDatas = arr;
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
