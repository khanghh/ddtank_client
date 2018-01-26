package ddt.data.goods
{
   import bagAndInfo.amulet.EquipAmuletManager;
   import bagAndInfo.amulet.vo.EquipAmuletPhaseVo;
   import ddt.data.EquipType;
   import ddt.events.GoodsEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import gemstone.info.GemstListInfo;
   import magicStone.data.MagicStoneInfo;
   import road7th.utils.DateUtils;
   import store.forge.wishBead.WishBeadManager;
   import store.forge.wishBead.WishChangeInfo;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class InventoryItemInfo extends ItemTemplateInfo
   {
      
      private static var _isTimerStarted:Boolean = false;
      
      private static var _temp_Instances:Array = [];
       
      
      private var _checkTimeOutTimer:TimerJuggler;
      
      private var _checkColorValidTimer:TimerJuggler;
      
      private var _checkTimePackTimer:TimerJuggler;
      
      public var ItemID:Number;
      
      public var UserID:Number;
      
      public var IsBinds:Boolean;
      
      public var isDeleted:Boolean;
      
      public var BagType:int;
      
      public var type:int;
      
      public var isInvalid:Boolean;
      
      public var lock:Boolean = false;
      
      public var goodsLock:Boolean = false;
      
      public var Color:String;
      
      public var Skin:String;
      
      public var isMoveSpace:Boolean = true;
      
      private var _isUsed:Boolean;
      
      public var BeginDate:String;
      
      protected var _ValidDate:Number;
      
      public var isConversion:Boolean = false;
      
      private var _DiscolorValidDate:String;
      
      private var atLeastOnHour:Boolean;
      
      private var _count:int = 1;
      
      private var _exaltLevel:int;
      
      private var _StrengthenLevel:int;
      
      private var _StrengthenExp:int;
      
      private var _isGold:Boolean;
      
      public var Damage:int;
      
      public var Guard:int;
      
      public var Boold:int;
      
      public var Bless:int;
      
      private var _goldValidDate:int;
      
      private var _goldBeginTime:String;
      
      public var IsJudge:Boolean;
      
      public var Place:int;
      
      public var AttackCompose:int;
      
      public var DefendCompose:int;
      
      public var LuckCompose:int;
      
      public var AgilityCompose:int;
      
      public var lockType:int;
      
      public var Hole1:int = -1;
      
      public var Hole2:int = -1;
      
      public var Hole3:int = -1;
      
      public var Hole4:int = -1;
      
      public var Hole5:int = -1;
      
      public var Hole6:int = -1;
      
      public var Hole5Level:int;
      
      public var Hole5Exp:int = 0;
      
      public var Hole6Level:int;
      
      public var Hole6Exp:int = 0;
      
      public var beadExp:int;
      
      public var beadLevel:int = 1;
      
      public var beadIsLock:int;
      
      private var _curExp:int;
      
      public var isShowBind:Boolean = true;
      
      public var gemstoneList:Vector.<GemstListInfo>;
      
      public var latentEnergyCurStr:String = "0,0,0,0";
      
      public var latentEnergyNewStr:String = "0,0,0,0";
      
      public var latentEnergyEndTime:Date;
      
      public var MagicExp:int;
      
      public var MagicLevel:int;
      
      public var magicStoneAttr:MagicStoneInfo;
      
      public var cellLocked:Boolean;
      
      public var RingExp:int;
      
      private var _awakenEquipPro:AwakenEquipInfo = null;
      
      public var wearStatus:Boolean = false;
      
      public var fromBag:Boolean = false;
      
      public function InventoryItemInfo(){super();}
      
      public static function startTimer() : void{}
      
      public function get IsUsed() : Boolean{return false;}
      
      public function setIsUsed(param1:Boolean) : void{}
      
      public function set IsUsed(param1:Boolean) : void{}
      
      override public function set Property5(param1:String) : void{}
      
      public function set ValidDate(param1:Number) : void{}
      
      private function transformValidDate() : void{}
      
      public function get ValidDate() : Number{return 0;}
      
      public function getRemainDate() : Number{return 0;}
      
      public function getColorValidDate() : Number{return 0;}
      
      public function set DiscolorValidDate(param1:String) : void{}
      
      public function get DiscolorValidDate() : String{return null;}
      
      private function updateDiscolorValidDate() : void{}
      
      private function updateRemainDate() : void{}
      
      private function checkTimePcak(param1:Number) : void{}
      
      protected function __timerPackComplete(param1:Event) : void{}
      
      private function __timerComplete(param1:Event) : void{}
      
      private function _timerColorComplete(param1:Event) : void{}
      
      private function __sendGoodsTimeOut(param1:Event) : void{}
      
      public function get Count() : int{return 0;}
      
      public function set Count(param1:int) : void{}
      
      public function clone() : InventoryItemInfo{return null;}
      
      public function set exaltLevel(param1:int) : void{}
      
      public function get exaltLevel() : int{return 0;}
      
      public function set StrengthenLevel(param1:int) : void{}
      
      public function get StrengthenLevel() : int{return 0;}
      
      public function set StrengthenExp(param1:int) : void{}
      
      public function get StrengthenExp() : int{return 0;}
      
      public function get isGold() : Boolean{return false;}
      
      public function set isGold(param1:Boolean) : void{}
      
      public function get goldValidDate() : int{return 0;}
      
      public function set goldValidDate(param1:int) : void{}
      
      public function get goldBeginTime() : String{return null;}
      
      public function set goldBeginTime(param1:String) : void{}
      
      public function getGoldRemainDate() : Number{return 0;}
      
      public function get equipAmuletProperty1() : int{return 0;}
      
      public function get equipAmuletProperty2() : int{return 0;}
      
      public function get equipAmuletProperty3() : int{return 0;}
      
      public function get equipAmuletProperty4() : int{return 0;}
      
      public function get curExp() : int{return 0;}
      
      public function set curExp(param1:int) : void{}
      
      public function get isHasLatentEnergy() : Boolean{return false;}
      
      public function get latentEnergyCurList() : Array{return null;}
      
      public function get latentEnergyNewList() : Array{return null;}
      
      public function get isHasLatenetEnergyNew() : Boolean{return false;}
      
      public function get isCanLatentEnergy() : Boolean{return false;}
      
      public function isCanEnchant() : Boolean{return false;}
      
      public function isCanGodRefining() : Boolean{return false;}
      
      public function get hasComposeAttribte() : Boolean{return false;}
      
      public function set awakenEquipPro(param1:AwakenEquipInfo) : void{}
      
      public function get awakenEquipPro() : AwakenEquipInfo{return null;}
   }
}
