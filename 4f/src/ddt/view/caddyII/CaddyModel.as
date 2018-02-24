package ddt.view.caddyII
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.BagInfo;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.view.caddyII.reader.AwardsInfo;
   import ddt.view.caddyII.reader.CaddyUpdate;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.data.DictionaryData;
   
   public class CaddyModel extends EventDispatcher
   {
      
      public static var _instance:CaddyModel;
      
      public static const Gold_Caddy:int = 4;
      
      public static const Silver_Caddy:int = 5;
      
      public static const CADDY_TYPE:int = 1;
      
      public static const BEAD_TYPE:int = 2;
      
      public static const OFFER_PACKET:int = 3;
      
      public static const CARD_TYPE:int = 6;
      
      public static const MYSTICAL_CARDBOX:int = 8;
      
      public static const MY_CARDBOX:int = 9;
      
      public static const CARDSOUL_BOX:int = 11;
      
      public static const BOMB_KING_BLESS:int = 10;
      
      public static const CELEBRATION_BOX:int = 12;
      
      public static const VIP_TYPE:int = 13;
      
      public static const TREASURE_HUNTING:int = 15;
      
      public static const AWARDS_NUMBER:int = 1000;
      
      public static const BEADTYPE_CHANGE:String = "beadType_change";
      
      public static const AWARDS_CHANGE:String = "awards_change";
      
      public static const BLESS_CHAGE:String = "bless_change";
      
      public static const CARDS_NAME:String = "cards_name";
      
      public static const TREASURE_CHANGE:String = "treasure_change";
      
      public static const Bead_Attack:int = 0;
      
      public static const Bead_Defense:int = 1;
      
      public static const Bead_Attribute:int = 2;
      
      public static const PACK_I:int = 0;
      
      public static const PACK_II:int = 1;
      
      public static const PACK_III:int = 2;
      
      public static const PACK_IV:int = 3;
      
      public static const PACK_V:int = 4;
       
      
      private var _type:int;
      
      private var _bagInfo:BagInfo;
      
      private var _beadType:int;
      
      private var _offerType:int;
      
      private var _boxName:Array;
      
      private var _caddyTempId:Array;
      
      private var _CaddyType:int;
      
      public var _caddyBoxList:Vector.<InventoryItemInfo>;
      
      public var _attackList:Vector.<InventoryItemInfo>;
      
      public var _defenseList:Vector.<InventoryItemInfo>;
      
      public var _attributeList:Vector.<InventoryItemInfo>;
      
      public var awardsList:Vector.<AwardsInfo>;
      
      public var beadAwardsList:Vector.<AwardsInfo>;
      
      public var exploitList:Array;
      
      public function CaddyModel(){super();}
      
      public static function get instance() : CaddyModel{return null;}
      
      private function init() : void{}
      
      private function initExploitList() : void{}
      
      public function setup(param1:int) : void{}
      
      private function createData() : void{}
      
      private function createBeadData(param1:Vector.<BoxGoodsTempInfo>, param2:Vector.<InventoryItemInfo>) : void{}
      
      private function createInfo(param1:BoxGoodsTempInfo) : InventoryItemInfo{return null;}
      
      private function getTemplateInfo(param1:int) : InventoryItemInfo{return null;}
      
      private function sortBeadData() : void{}
      
      private function compareFun(param1:BoxGoodsTempInfo, param2:BoxGoodsTempInfo) : int{return 0;}
      
      private function compareBeadDataFun(param1:InventoryItemInfo, param2:InventoryItemInfo) : int{return 0;}
      
      private function _addAwardsInfo(param1:String, param2:int, param3:Boolean = false, param4:String = "", param5:int = 0, param6:int = 0, param7:int = 0) : void{}
      
      private function _addBeadAwardsInfo(param1:String, param2:int, param3:Boolean = false, param4:String = "", param5:int = 0, param6:int = 0) : void{}
      
      public function get tempid() : Array{return null;}
      
      public function set tempid(param1:Array) : void{}
      
      private function fillListFromAward(param1:Vector.<CaddyAwardInfo>) : Vector.<InventoryItemInfo>{return null;}
      
      public function getCaddyTrophy(param1:int) : Vector.<InventoryItemInfo>{return null;}
      
      public function getOfferPacketThrophy(param1:int) : Vector.<InventoryItemInfo>{return null;}
      
      public function getTrophyData() : Vector.<InventoryItemInfo>{return null;}
      
      public function appendAwardsInfo(param1:String, param2:int, param3:Boolean = false, param4:String = "", param5:int = 0, param6:int = 0) : void{}
      
      public function addAwardsInfoByArr(param1:Vector.<AwardsInfo>) : void{}
      
      public function addBlessInfoByArr(param1:Vector.<AwardsInfo>) : void{}
      
      public function addTreasureInfoByArr(param1:Vector.<AwardsInfo>) : void{}
      
      public function clearAwardsList() : void{}
      
      public function get bagInfo() : BagInfo{return null;}
      
      public function get rightView() : RightView{return null;}
      
      public function get readView() : CaddyUpdate{return null;}
      
      public function get moveSprite() : Sprite{return null;}
      
      public function get caddyType() : int{return 0;}
      
      public function set caddyType(param1:int) : void{}
      
      public function get beadType() : int{return 0;}
      
      public function set beadType(param1:int) : void{}
      
      public function set offerType(param1:int) : void{}
      
      public function get offerType() : int{return 0;}
      
      public function get CaddyFrameTitle() : String{return null;}
      
      public function get dontClose() : String{return null;}
      
      public function get AwardsBuff() : String{return null;}
      
      public function get type() : int{return 0;}
   }
}
