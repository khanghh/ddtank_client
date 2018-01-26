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
      
      public function MagicHouseModel(param1:MagicHouseInstance){super();}
      
      public static function get instance() : MagicHouseModel{return null;}
      
      public function get activityWeapons() : Array{return null;}
      
      public function set activityWeapons(param1:Array) : void{}
      
      public function get magicJuniorLv() : int{return 0;}
      
      public function set magicJuniorLv(param1:int) : void{}
      
      public function get magicJuniorExp() : int{return 0;}
      
      public function set magicJuniorExp(param1:int) : void{}
      
      public function get magicMidLv() : int{return 0;}
      
      public function set magicMidLv(param1:int) : void{}
      
      public function get magicMidExp() : int{return 0;}
      
      public function set magicMidExp(param1:int) : void{}
      
      public function get magicSeniorLv() : int{return 0;}
      
      public function set magicSeniorLv(param1:int) : void{}
      
      public function get magicSeniorExp() : int{return 0;}
      
      public function set magicSeniorExp(param1:int) : void{}
      
      public function get freeGetCount() : int{return 0;}
      
      public function set freeGetCount(param1:int) : void{}
      
      public function get freeGetTime() : Date{return null;}
      
      public function set freeGetTime(param1:Date) : void{}
      
      public function get chargeGetCount() : int{return 0;}
      
      public function set chargeGetCount(param1:int) : void{}
      
      public function get chargeGetTime() : Date{return null;}
      
      public function set chargeGetTime(param1:Date) : void{}
      
      public function get depotCount() : int{return 0;}
      
      public function set depotCount(param1:int) : void{}
      
      public function get juniorWeaponList() : Array{return null;}
      
      public function set juniorWeaponList(param1:Array) : void{}
      
      public function get midWeaponList() : Array{return null;}
      
      public function set midWeaponList(param1:Array) : void{}
      
      public function get seniorWeapinList() : Array{return null;}
      
      public function set seniorWeapinList(param1:Array) : void{}
      
      public function get boxNeedmoney() : int{return 0;}
      
      public function set boxNeedmoney(param1:int) : void{}
      
      public function get levelUpNumber() : Array{return null;}
      
      public function set levelUpNumber(param1:Array) : void{}
      
      public function get openDepotNeedMoney() : int{return 0;}
      
      public function set openDepotNeedMoney(param1:int) : void{}
      
      public function get depotPromoteNeedMoney() : int{return 0;}
      
      public function set depotPromoteNeedMoney(param1:int) : void{}
      
      public function get equipOpenList() : Array{return null;}
      
      public function set equipOpenList(param1:Array) : void{}
      
      public function get juniorAddAttribute() : Array{return null;}
      
      public function set juniorAddAttribute(param1:Array) : void{}
      
      public function get midAddAttribute() : Array{return null;}
      
      public function set midAddAttribute(param1:Array) : void{}
      
      public function get seniorAddAttribute() : Array{return null;}
      
      public function set seniorAddAttribute(param1:Array) : void{}
      
      public function get titleDatas() : Array{return null;}
      
      public function set titleDatas(param1:Array) : void{}
   }
}

class MagicHouseInstance
{
    
   
   function MagicHouseInstance(){super();}
}
