package cardSystem.model
{
   import cardSystem.CardSocketEvent;
   import cardSystem.data.CardInfo;
   import cardSystem.data.GrooveInfo;
   import cardSystem.data.SetsInfo;
   import cardSystem.data.SetsUpgradeRuleInfo;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
   import road7th.data.DictionaryData;
   
   public class CardModel extends EventDispatcher
   {
      
      public static const OPEN_FOUR_NEEDS_TWOSTAR:int = 1;
      
      public static const OPEN_FIVE_NEEDS_THREESTAR:int = 2;
      
      public static const OPEN_FIVE_NEEDS_THREESTARTWO:int = 3;
      
      public static const MONSTER_CARDS:int = 0;
      
      public static const WEQPON_CARDS:int = 1;
      
      public static const PVE_CARDS:int = 2;
      
      public static const CELLS_SUM:int = 15;
      
      public static const EQUIP_CELLS_SUM:int = 5;
       
      
      private var _setsList:DictionaryData;
      
      private var _setsSortRuleVector:Vector.<SetsInfo>;
      
      public var upgradeRuleVec:Vector.<SetsUpgradeRuleInfo>;
      
      public var propIncreaseDic:DictionaryData;
      
      private var _inputSoul:int;
      
      private var _grooveinfo:Vector.<GrooveInfo>;
      
      private var _playerid:int;
      
      public var tempCardGroove:GrooveInfo;
      
      public var achievementProperty:Array;
      
      public var achievementProgress:DictionaryData;
      
      public var achievementData:DictionaryData;
      
      public function CardModel()
      {
         super();
         achievementProperty = [0,0,0,0,0,0,0,0];
         achievementProgress = new DictionaryData();
      }
      
      public function get setsSortRuleVector() : Vector.<SetsInfo>
      {
         return _setsSortRuleVector;
      }
      
      public function set setsSortRuleVector(param1:Vector.<SetsInfo>) : void
      {
         _setsSortRuleVector = param1;
         dispatchEvent(new CardSocketEvent("setsSortRuleInitComplete",setsSortRuleVector));
      }
      
      public function set GrooveInfoVector(param1:Vector.<GrooveInfo>) : void
      {
         _grooveinfo = param1;
      }
      
      public function get GrooveInfoVector() : Vector.<GrooveInfo>
      {
         if(_grooveinfo == null)
         {
            return null;
         }
         return _grooveinfo;
      }
      
      public function set PlayerId(param1:int) : void
      {
         _playerid = param1;
      }
      
      public function get PlayerId() : int
      {
         return _playerid;
      }
      
      public function get setsList() : DictionaryData
      {
         return _setsList;
      }
      
      public function set setsList(param1:DictionaryData) : void
      {
         _setsList = param1;
         dispatchEvent(new CardSocketEvent("setsPropIntComplete",setsList));
      }
      
      public function get inputSoul() : int
      {
         return _inputSoul;
      }
      
      public function set inputSoul(param1:int) : void
      {
         _inputSoul = param1;
      }
      
      public function fourIsOpen() : Boolean
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = PlayerManager.Instance.Self.cardBagDic;
         for each(var _loc2_ in PlayerManager.Instance.Self.cardBagDic)
         {
            if(_loc2_.Level >= 20)
            {
               _loc1_++;
            }
         }
         return _loc1_ >= 1;
      }
      
      public function fiveIsOpen() : Boolean
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = PlayerManager.Instance.Self.cardBagDic;
         for each(var _loc2_ in PlayerManager.Instance.Self.cardBagDic)
         {
            if(_loc2_.Level == 30)
            {
               _loc1_++;
            }
         }
         return _loc1_ >= 1;
      }
      
      public function fiveIsOpen2() : Boolean
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = PlayerManager.Instance.Self.cardBagDic;
         for each(var _loc2_ in PlayerManager.Instance.Self.cardBagDic)
         {
            if(_loc2_.Level >= 20)
            {
               _loc1_++;
            }
         }
         return _loc1_ >= 3;
      }
      
      public function get Pages() : int
      {
         return Math.ceil(PlayerManager.Instance.Self.cardBagDic.length / 15);
      }
      
      public function getDataByPage(param1:int) : DictionaryData
      {
         var _loc2_:DictionaryData = new DictionaryData();
         var _loc3_:DictionaryData = PlayerManager.Instance.Self.cardBagDic;
         var _loc6_:int = (param1 - 1) * 15 + 5;
         var _loc4_:int = _loc6_ + 15;
         var _loc8_:int = 0;
         var _loc7_:* = _loc3_;
         for each(var _loc5_ in _loc3_)
         {
            if(_loc5_.Place >= _loc6_ && _loc5_.Place < _loc4_)
            {
               _loc2_[_loc5_.Place] = _loc5_;
            }
         }
         return _loc2_;
      }
      
      public function getBagListData() : Array
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Array = [];
         var _loc4_:DictionaryData = PlayerManager.Instance.Self.cardBagDic;
         var _loc2_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:* = _loc4_;
         for each(var _loc7_ in _loc4_)
         {
            _loc5_ = _loc7_.Place % 4 == 0?_loc7_.Place / 4 - 2:Number(_loc7_.Place / 4 - 1);
            if(_loc1_[_loc5_] == null)
            {
               _loc1_[_loc5_] = [];
            }
            _loc3_ = _loc7_.Place % 4 == 0?4:Number(_loc7_.Place % 4);
            _loc1_[_loc5_][0] = _loc5_ + 1;
            _loc1_[_loc5_][_loc3_] = _loc7_;
            if(_loc5_ + 1 > _loc2_)
            {
               _loc2_ = _loc5_ + 1;
            }
         }
         if(_loc2_ < 3)
         {
            _loc2_ = 3;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            if(_loc1_[_loc6_] == null)
            {
               _loc1_[_loc6_] = [];
               _loc1_[_loc6_][0] = _loc6_ + 1;
            }
            _loc6_++;
         }
         return _loc1_;
      }
      
      public function getSetsCardFromCardBag(param1:String) : Vector.<CardInfo>
      {
         var _loc3_:DictionaryData = PlayerManager.Instance.Self.cardBagDic;
         var _loc4_:Vector.<CardInfo> = new Vector.<CardInfo>();
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            if(_loc2_.templateInfo.Property7 == param1)
            {
               _loc4_.push(_loc2_);
            }
         }
         return _loc4_;
      }
   }
}
