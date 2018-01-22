package ddt.data
{
   import ddt.events.PlayerPropertyEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.utils.DateUtils;
   
   public class ConsortiaInfo extends EventDispatcher
   {
      
      public static const LEVEL:String = "level";
      
      public static const STORE_LEVEL:String = "storeLevel";
      
      public static const SHOP_LEVEL:String = "shopLevel";
      
      public static const BANK_LEVEL:String = "bankLevel";
      
      public static const RICHES:String = "riches";
      
      public static const DESCRIPTION:String = "description";
      
      public static const PLACARD:String = "placard";
      
      public static const CHAIRMANNAME:String = "chairmanName";
      
      public static const CONSORTIANAME:String = "consortiaName";
      
      public static const BADGE_ID:String = "badgeID";
      
      public static const BADGE_DATE:String = "badgedate";
      
      public static const COUNT:String = "count";
      
      public static const POLLOPEN:String = "pollOpen";
      
      public static const SKILL_LEVEL:String = "skillLevel";
      
      public static const IS_VOTING:String = "isVoting";
       
      
      public var ConsortiaID:int;
      
      private var _consortiaName:String = "";
      
      private var _badgeID:int = 0;
      
      private var _badgeBuyTime:String;
      
      private var _validDate:int;
      
      private var _IsVoting:Boolean;
      
      public var VoteRemainDay:int;
      
      public var CreatorID:int;
      
      public var CreatorName:String = "";
      
      public var ChairmanID:int;
      
      private var _chairmanName:String = "";
      
      public var MaxCount:int;
      
      public var CelebCount:int;
      
      public var BuildDate:String = "";
      
      public var IP:String;
      
      public var Port:int;
      
      private var _count:int;
      
      public var Repute:int;
      
      public var IsApply:Boolean;
      
      public var State:int;
      
      public var DeductDate:String;
      
      public var Honor:int;
      
      public var LastDayRiches:int;
      
      public var OpenApply:Boolean;
      
      public var FightPower:Number = 0;
      
      public var ChairmanTypeVIP:int;
      
      public var ChairmanVIPLevel:int;
      
      private var _PollOpen:Boolean;
      
      public var CharmGP:int;
      
      private var _Level:int;
      
      private var _storeLevel:int;
      
      private var _SmithLevel:int;
      
      private var _ShopLevel:int;
      
      private var _bufferLevel:int;
      
      private var _riches:int;
      
      private var _description:String;
      
      private var _placard:String = "";
      
      public var BadgeType:int;
      
      public var BadgeName:String;
      
      protected var _changeCount:int = 0;
      
      protected var _changedPropeties:Dictionary;
      
      public function ConsortiaInfo()
      {
         _badgeBuyTime = DateUtils.dateFormat(new Date());
         _changedPropeties = new Dictionary();
         super();
      }
      
      public function get ValidDate() : int
      {
         return _validDate;
      }
      
      public function set ValidDate(param1:int) : void
      {
         _validDate = param1;
      }
      
      public function get BadgeBuyTime() : String
      {
         return _badgeBuyTime;
      }
      
      public function set BadgeBuyTime(param1:String) : void
      {
         _badgeBuyTime = param1;
         onPropertiesChanged("badgedate");
      }
      
      public function get BadgeID() : int
      {
         return _badgeID;
      }
      
      public function set BadgeID(param1:int) : void
      {
         _badgeID = param1;
         onPropertiesChanged("badgeID");
      }
      
      public function get ConsortiaName() : String
      {
         return _consortiaName;
      }
      
      public function set ConsortiaName(param1:String) : void
      {
         if(_consortiaName == param1)
         {
            return;
         }
         _consortiaName = param1;
         onPropertiesChanged("consortiaName");
      }
      
      public function get IsVoting() : Boolean
      {
         return _IsVoting;
      }
      
      public function set IsVoting(param1:Boolean) : void
      {
         _IsVoting = param1;
         onPropertiesChanged("isVoting");
      }
      
      public function get ChairmanName() : String
      {
         return _chairmanName;
      }
      
      public function set ChairmanName(param1:String) : void
      {
         if(_chairmanName == param1)
         {
            return;
         }
         _chairmanName = param1;
         onPropertiesChanged("chairmanName");
      }
      
      public function get Count() : int
      {
         return _count;
      }
      
      public function set Count(param1:int) : void
      {
         if(_count == param1)
         {
            return;
         }
         _count = param1;
         onPropertiesChanged("count");
      }
      
      public function get PollOpen() : Boolean
      {
         return _PollOpen;
      }
      
      public function get ChairmanIsVIP() : Boolean
      {
         return ChairmanTypeVIP > 0;
      }
      
      public function set PollOpen(param1:Boolean) : void
      {
         if(_PollOpen == param1)
         {
            return;
         }
         _PollOpen = param1;
         onPropertiesChanged("pollOpen");
      }
      
      public function get Level() : int
      {
         return _Level;
      }
      
      public function set Level(param1:int) : void
      {
         _Level = param1;
         onPropertiesChanged("level");
      }
      
      public function set StoreLevel(param1:int) : void
      {
         _storeLevel = param1;
         onPropertiesChanged("bankLevel");
      }
      
      public function get StoreLevel() : int
      {
         return _storeLevel;
      }
      
      public function get SmithLevel() : int
      {
         return _SmithLevel;
      }
      
      public function set SmithLevel(param1:int) : void
      {
         _SmithLevel = param1;
         onPropertiesChanged("storeLevel");
      }
      
      public function get ShopLevel() : int
      {
         return _ShopLevel;
      }
      
      public function set ShopLevel(param1:int) : void
      {
         _ShopLevel = param1;
         onPropertiesChanged("shopLevel");
      }
      
      public function get BufferLevel() : int
      {
         return _bufferLevel;
      }
      
      public function set BufferLevel(param1:int) : void
      {
         _bufferLevel = param1;
         onPropertiesChanged("skillLevel");
      }
      
      public function set Riches(param1:int) : void
      {
         this._riches = param1;
         onPropertiesChanged("riches");
      }
      
      public function get Riches() : int
      {
         return this._riches;
      }
      
      public function get Description() : String
      {
         return _description;
      }
      
      public function set Description(param1:String) : void
      {
         if(_description == param1)
         {
            return;
         }
         _description = param1;
         onPropertiesChanged("description");
      }
      
      public function get Placard() : String
      {
         return _placard;
      }
      
      public function set Placard(param1:String) : void
      {
         if(_placard == param1)
         {
            return;
         }
         _placard = param1;
         onPropertiesChanged("placard");
      }
      
      public function beginChanges() : void
      {
         _changeCount = Number(_changeCount) + 1;
      }
      
      public function commitChanges() : void
      {
         _changeCount = Number(_changeCount) - 1;
         if(_changeCount <= 0)
         {
            _changeCount = 0;
            updateProperties();
         }
      }
      
      protected function onPropertiesChanged(param1:String = null) : void
      {
         if(param1 != null)
         {
            _changedPropeties[param1] = true;
         }
         if(_changeCount <= 0)
         {
            _changeCount = 0;
            updateProperties();
         }
      }
      
      public function updateProperties() : void
      {
         var _loc1_:Dictionary = _changedPropeties;
         _changedPropeties = new Dictionary();
         dispatchEvent(new PlayerPropertyEvent("propertychange",_loc1_));
      }
   }
}
