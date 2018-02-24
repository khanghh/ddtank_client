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
      
      public function CardModel(){super();}
      
      public function get setsSortRuleVector() : Vector.<SetsInfo>{return null;}
      
      public function set setsSortRuleVector(param1:Vector.<SetsInfo>) : void{}
      
      public function set GrooveInfoVector(param1:Vector.<GrooveInfo>) : void{}
      
      public function get GrooveInfoVector() : Vector.<GrooveInfo>{return null;}
      
      public function set PlayerId(param1:int) : void{}
      
      public function get PlayerId() : int{return 0;}
      
      public function get setsList() : DictionaryData{return null;}
      
      public function set setsList(param1:DictionaryData) : void{}
      
      public function get inputSoul() : int{return 0;}
      
      public function set inputSoul(param1:int) : void{}
      
      public function fourIsOpen() : Boolean{return false;}
      
      public function fiveIsOpen() : Boolean{return false;}
      
      public function fiveIsOpen2() : Boolean{return false;}
      
      public function get Pages() : int{return 0;}
      
      public function getDataByPage(param1:int) : DictionaryData{return null;}
      
      public function getBagListData() : Array{return null;}
      
      public function getSetsCardFromCardBag(param1:String) : Vector.<CardInfo>{return null;}
   }
}
