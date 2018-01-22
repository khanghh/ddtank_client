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
      
      public function CaddyModel()
      {
         _boxName = [LanguageMgr.GetTranslation("tank.view.caddy.boxNameCaddy"),LanguageMgr.GetTranslation("tank.view.caddy.boxNameBead"),LanguageMgr.GetTranslation("tank.view.caddy.boxNameGift")];
         super();
         init();
      }
      
      public static function get instance() : CaddyModel
      {
         if(_instance == null)
         {
            _instance = new CaddyModel();
         }
         return _instance;
      }
      
      private function init() : void
      {
         awardsList = new Vector.<AwardsInfo>();
         beadAwardsList = new Vector.<AwardsInfo>();
         _caddyBoxList = new Vector.<InventoryItemInfo>();
         _attackList = new Vector.<InventoryItemInfo>();
         _defenseList = new Vector.<InventoryItemInfo>();
         _attributeList = new Vector.<InventoryItemInfo>();
         initExploitList();
         createData();
      }
      
      private function initExploitList() : void
      {
         exploitList = [];
         exploitList.push(new Vector.<InventoryItemInfo>());
         exploitList.push(new Vector.<InventoryItemInfo>());
         exploitList.push(new Vector.<InventoryItemInfo>());
         exploitList.push(new Vector.<InventoryItemInfo>());
         exploitList.push(new Vector.<InventoryItemInfo>());
      }
      
      public function setup(param1:int) : void
      {
         _type = param1;
      }
      
      private function createData() : void
      {
         createBeadData(BossBoxManager.instance.beadTempInfoList[311500],_attackList);
         createBeadData(BossBoxManager.instance.beadTempInfoList[312500],_defenseList);
         createBeadData(BossBoxManager.instance.beadTempInfoList[313500],_attributeList);
         createBeadData(BossBoxManager.instance.exploitTemplateIDs[11252],exploitList[0]);
         createBeadData(BossBoxManager.instance.exploitTemplateIDs[11257],exploitList[1]);
         createBeadData(BossBoxManager.instance.exploitTemplateIDs[11258],exploitList[2]);
         createBeadData(BossBoxManager.instance.exploitTemplateIDs[11259],exploitList[3]);
         createBeadData(BossBoxManager.instance.exploitTemplateIDs[11260],exploitList[4]);
         sortBeadData();
      }
      
      private function createBeadData(param1:Vector.<BoxGoodsTempInfo>, param2:Vector.<InventoryItemInfo>) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            param2.push(createInfo(param1[_loc3_]));
            _loc3_++;
         }
      }
      
      private function createInfo(param1:BoxGoodsTempInfo) : InventoryItemInfo
      {
         var _loc2_:* = null;
         if(param1)
         {
            _loc2_ = getTemplateInfo(param1.TemplateId) as InventoryItemInfo;
            _loc2_.StrengthenLevel = param1.StrengthenLevel;
            _loc2_.AttackCompose = param1.AttackCompose;
            _loc2_.DefendCompose = param1.DefendCompose;
            _loc2_.LuckCompose = param1.LuckCompose;
            _loc2_.AgilityCompose = param1.AgilityCompose;
            _loc2_.isShowBind = false;
            if(param1.TemplateId == 11025)
            {
               _loc2_.Count == 10;
            }
            else
            {
               _loc2_.Count = param1.ItemCount;
            }
            _loc2_.IsJudge = true;
         }
         return _loc2_;
      }
      
      private function getTemplateInfo(param1:int) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1;
         ItemManager.fill(_loc2_);
         return _loc2_;
      }
      
      private function sortBeadData() : void
      {
         _attackList.sort(compareBeadDataFun);
         _defenseList.sort(compareBeadDataFun);
         _attributeList.sort(compareBeadDataFun);
      }
      
      private function compareFun(param1:BoxGoodsTempInfo, param2:BoxGoodsTempInfo) : int
      {
         if(param1.IsTips >= param2.IsTips)
         {
            return -1;
         }
         return 1;
      }
      
      private function compareBeadDataFun(param1:InventoryItemInfo, param2:InventoryItemInfo) : int
      {
         if(param1.TemplateID >= param2.TemplateID)
         {
            return -1;
         }
         return 1;
      }
      
      private function _addAwardsInfo(param1:String, param2:int, param3:Boolean = false, param4:String = "", param5:int = 0, param6:int = 0, param7:int = 0) : void
      {
         var _loc8_:AwardsInfo = new AwardsInfo();
         _loc8_.name = param1;
         _loc8_.TemplateId = param2;
         _loc8_.isLong = param3;
         _loc8_.zone = param4;
         _loc8_.zoneID = param5;
         _loc8_.channel = param6;
         _loc8_.count = param7;
         awardsList.unshift(_loc8_);
         if(awardsList.length > 1000)
         {
            awardsList.pop();
         }
      }
      
      private function _addBeadAwardsInfo(param1:String, param2:int, param3:Boolean = false, param4:String = "", param5:int = 0, param6:int = 0) : void
      {
         var _loc7_:AwardsInfo = new AwardsInfo();
         _loc7_.name = param1;
         _loc7_.TemplateId = param2;
         _loc7_.isLong = param3;
         _loc7_.zone = param4;
         _loc7_.zoneID = param5;
         _loc7_.channel = param6;
         beadAwardsList.unshift(_loc7_);
         if(beadAwardsList.length > 1000)
         {
            beadAwardsList.pop();
         }
      }
      
      public function get tempid() : Array
      {
         return _caddyTempId;
      }
      
      public function set tempid(param1:Array) : void
      {
         _caddyTempId = param1;
      }
      
      private function fillListFromAward(param1:Vector.<CaddyAwardInfo>) : Vector.<InventoryItemInfo>
      {
         var _loc5_:int = 0;
         var _loc2_:Vector.<InventoryItemInfo> = new Vector.<InventoryItemInfo>();
         var _loc4_:DictionaryData = BossBoxManager.instance.boxTempIDList;
         var _loc3_:int = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_[param1[_loc5_].TemplateID].ItemCount = param1[_loc5_].Count;
            _loc2_.push(createInfo(_loc4_[param1[_loc5_].TemplateID]));
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function getCaddyTrophy(param1:int) : Vector.<InventoryItemInfo>
      {
         if(param1 == 112101 || param1 == 112224)
         {
            return fillListFromAward(CaddyAwardModel.getInstance().getGoldAwards());
         }
         if(param1 == 112100 || param1 == 112223)
         {
            return fillListFromAward(CaddyAwardModel.getInstance().getSilverAwards());
         }
         if(param1 == 112222)
         {
            return fillListFromAward(CaddyAwardModel.getInstance().getAwards());
         }
         if(param1 == 2000)
         {
            return fillListFromAward(CaddyAwardModel.getInstance().getTreasureAwards());
         }
         if(param1 == 1222010)
         {
            return fillListFromAward(CaddyAwardModel.getInstance().getSilverToyAwards());
         }
         if(param1 == 1222110)
         {
            return fillListFromAward(CaddyAwardModel.getInstance().getGoldToyAwards());
         }
         return new Vector.<InventoryItemInfo>();
      }
      
      public function getOfferPacketThrophy(param1:int) : Vector.<InventoryItemInfo>
      {
         switch(int(param1) - 11252)
         {
            case 0:
               return exploitList[0];
            default:
            default:
            default:
            default:
               return null;
            case 5:
               return exploitList[1];
            case 6:
               return exploitList[2];
            case 7:
               return exploitList[3];
            case 8:
               return exploitList[4];
         }
      }
      
      public function getTrophyData() : Vector.<InventoryItemInfo>
      {
         switch(int(_type) - 1)
         {
            case 0:
               return _caddyBoxList;
            case 1:
               if(beadType == 0)
               {
                  return _attackList;
               }
               if(beadType == 1)
               {
                  return _defenseList;
               }
               return _attributeList;
            case 2:
               return exploitList[_offerType];
         }
      }
      
      public function appendAwardsInfo(param1:String, param2:int, param3:Boolean = false, param4:String = "", param5:int = 0, param6:int = 0) : void
      {
         switch(int(_type) - 1)
         {
            case 0:
               if(param6 == 3)
               {
                  _addAwardsInfo(param1,param2,param3,param4,param5);
                  dispatchEvent(new Event("awards_change"));
               }
               break;
            case 1:
               if(param6 == 4)
               {
                  _addBeadAwardsInfo(param1,param2,param3,param4,param5);
                  dispatchEvent(new Event("beadType_change"));
               }
               break;
            case 2:
               if(param6 == 5)
               {
                  _addAwardsInfo(param1,param2,param3,param4,param5);
                  dispatchEvent(new Event("awards_change"));
               }
               break;
            default:
               if(param6 == 5)
               {
                  _addAwardsInfo(param1,param2,param3,param4,param5);
                  dispatchEvent(new Event("awards_change"));
               }
               break;
            default:
               if(param6 == 5)
               {
                  _addAwardsInfo(param1,param2,param3,param4,param5);
                  dispatchEvent(new Event("awards_change"));
               }
               break;
            default:
               if(param6 == 5)
               {
                  _addAwardsInfo(param1,param2,param3,param4,param5);
                  dispatchEvent(new Event("awards_change"));
               }
               break;
            default:
               if(param6 == 5)
               {
                  _addAwardsInfo(param1,param2,param3,param4,param5);
                  dispatchEvent(new Event("awards_change"));
               }
               break;
            default:
               if(param6 == 5)
               {
                  _addAwardsInfo(param1,param2,param3,param4,param5);
                  dispatchEvent(new Event("awards_change"));
               }
               break;
            default:
               if(param6 == 5)
               {
                  _addAwardsInfo(param1,param2,param3,param4,param5);
                  dispatchEvent(new Event("awards_change"));
               }
               break;
            case 9:
               if(param6 == 11)
               {
                  _addAwardsInfo(param1,param2,param3,param4,param5);
                  dispatchEvent(new Event("bless_change"));
               }
               break;
            default:
               if(param6 == 11)
               {
                  _addAwardsInfo(param1,param2,param3,param4,param5);
                  dispatchEvent(new Event("bless_change"));
               }
               break;
            case 11:
               if(param6 == 14)
               {
                  _addAwardsInfo(param1,param2,param3,param4,param5);
                  dispatchEvent(new Event("awards_change"));
               }
         }
      }
      
      public function addAwardsInfoByArr(param1:Vector.<AwardsInfo>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length > 1000?1000:param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _addAwardsInfo(param1[_loc3_].name,param1[_loc3_].TemplateId,param1[_loc3_].isLong,param1[_loc3_].zone,param1[_loc3_].zoneID,param1[_loc3_].channel);
            _loc3_++;
         }
         dispatchEvent(new Event("awards_change"));
      }
      
      public function addBlessInfoByArr(param1:Vector.<AwardsInfo>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length > 1000?1000:param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _addAwardsInfo(param1[_loc3_].name,param1[_loc3_].TemplateId,param1[_loc3_].isLong,param1[_loc3_].zone,param1[_loc3_].zoneID,param1[_loc3_].channel,param1[_loc3_].count);
            _loc3_++;
         }
         dispatchEvent(new Event("bless_change"));
      }
      
      public function addTreasureInfoByArr(param1:Vector.<AwardsInfo>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length > 1000?1000:param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _addAwardsInfo(param1[_loc3_].name,param1[_loc3_].TemplateId,param1[_loc3_].isLong,param1[_loc3_].zone,param1[_loc3_].zoneID,param1[_loc3_].channel,param1[_loc3_].count);
            _loc3_++;
         }
         dispatchEvent(new Event("treasure_change"));
      }
      
      public function clearAwardsList() : void
      {
         awardsList.splice(0,awardsList.length);
         awardsList = new Vector.<AwardsInfo>();
      }
      
      public function get bagInfo() : BagInfo
      {
         switch(int(_type) - 1)
         {
            case 0:
               return PlayerManager.Instance.Self.CaddyBag;
            case 1:
               return PlayerManager.Instance.Self.CaddyBag;
         }
      }
      
      public function get rightView() : RightView
      {
         switch(int(_type) - 1)
         {
            case 0:
               return ComponentFactory.Instance.creatCustomObject("caddy.CaddyViewII");
            case 1:
               return ComponentFactory.Instance.creatCustomObject("bead.BeadViewII");
            case 2:
               return ComponentFactory.Instance.creatCustomObject("offer.OfferPackViewII");
            default:
            default:
            default:
            default:
               return ComponentFactory.Instance.creatCustomObject("offer.OfferPackViewII");
            case 7:
               return ComponentFactory.Instance.creatCustomObject("caddy.CaddyViewII");
            case 8:
               return ComponentFactory.Instance.creatCustomObject("caddy.CaddyViewII");
            case 9:
            default:
               return ComponentFactory.Instance.creatCustomObject("caddy.BLESSViewI");
            case 11:
               return ComponentFactory.Instance.creatCustomObject("celebration.CelebrationBoxView");
         }
      }
      
      public function get readView() : CaddyUpdate
      {
         switch(int(_type) - 1)
         {
            case 0:
               return ComponentFactory.Instance.creatCustomObject("caddy.BadLuckView");
            case 1:
               return ComponentFactory.Instance.creatCustomObject("caddy.ReadAwardsView");
            case 2:
               return ComponentFactory.Instance.creatCustomObject("caddy.ReadAwardsView");
            default:
            default:
               return ComponentFactory.Instance.creatCustomObject("caddy.BlessLuckView");
            case 5:
            default:
            case 7:
            case 8:
               return ComponentFactory.Instance.creatCustomObject("caddy.ReadAwardsViewI");
            case 9:
            case 10:
               return ComponentFactory.Instance.creatCustomObject("caddy.BlessLuckView");
            case 11:
               return ComponentFactory.Instance.creatCustomObject("caddy.ReadAwardsView");
         }
      }
      
      public function get moveSprite() : Sprite
      {
         switch(int(_type) - 1)
         {
            case 0:
               return ComponentFactory.Instance.creatCustomObject("caddy.moveSprite");
            case 1:
               return ComponentFactory.Instance.creatCustomObject("bead.moveSprite");
            case 2:
               return ComponentFactory.Instance.creatCustomObject("bead.moveSprite");
         }
      }
      
      public function get caddyType() : int
      {
         return _CaddyType;
      }
      
      public function set caddyType(param1:int) : void
      {
         _CaddyType = param1;
      }
      
      public function get beadType() : int
      {
         return _beadType;
      }
      
      public function set beadType(param1:int) : void
      {
         var _loc2_:* = param1;
         if(311500 !== _loc2_)
         {
            if(312500 !== _loc2_)
            {
               if(313500 !== _loc2_)
               {
                  _beadType = param1;
               }
               else
               {
                  _beadType = 2;
               }
            }
            else
            {
               _beadType = 1;
            }
         }
         else
         {
            _beadType = 0;
         }
         dispatchEvent(new Event("beadType_change"));
      }
      
      public function set offerType(param1:int) : void
      {
         switch(int(param1) - 11252)
         {
            case 0:
               _offerType = 0;
               break;
            default:
            default:
            default:
            default:
               _offerType = 0;
               break;
            case 5:
               _offerType = 1;
               break;
            case 6:
               _offerType = 2;
               break;
            case 7:
               _offerType = 3;
               break;
            case 8:
               _offerType = 4;
         }
      }
      
      public function get offerType() : int
      {
         return _offerType;
      }
      
      public function get CaddyFrameTitle() : String
      {
         switch(int(_type) - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("tank.view.caddy.title");
            case 1:
               return LanguageMgr.GetTranslation("tank.view.bead.title");
            case 2:
               return LanguageMgr.GetTranslation("tank.game.GameView.GiftBattle");
            default:
            default:
               return null;
            case 5:
            default:
               return LanguageMgr.GetTranslation("tank.view.card.title");
            case 7:
               return LanguageMgr.GetTranslation("tank.game.GameView.cardBoxBattle");
            case 8:
               return LanguageMgr.GetTranslation("tank.game.GameView.cardBoxBattle1");
            case 9:
            default:
               return LanguageMgr.GetTranslation("tank.view.BOMO.title");
            case 11:
               return LanguageMgr.GetTranslation("tank.view.caddy.celebrationTitle");
         }
      }
      
      public function get dontClose() : String
      {
         switch(int(_type) - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("tank.view.caddy.dontClose");
            case 1:
               return LanguageMgr.GetTranslation("tank.view.bead.dontClose");
            case 2:
               return LanguageMgr.GetTranslation("tank.view.offer.dontClose");
            default:
            default:
               return null;
            case 5:
            default:
               return LanguageMgr.GetTranslation("tank.view.card.dontClose");
            case 7:
               return LanguageMgr.GetTranslation("tank.view.caddy.cardBoxDontClose");
            case 8:
               return LanguageMgr.GetTranslation("tank.view.caddy.cardBoxDontClose");
            case 9:
            default:
               return LanguageMgr.GetTranslation("tank.view.caddy.BlessClose");
            case 11:
               return LanguageMgr.GetTranslation("tank.view.caddy.celebrationClose");
         }
      }
      
      public function get AwardsBuff() : String
      {
         switch(int(_type) - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("tank.view.caddy.openCaddy");
            case 1:
            case 2:
               return LanguageMgr.GetTranslation("tank.view.offer.opendGetAwards");
            default:
            default:
            default:
            default:
               return LanguageMgr.GetTranslation("tank.view.caddy.openBless");
            case 7:
               return LanguageMgr.GetTranslation("tank.view.caddy.openCardBox");
            case 8:
               return LanguageMgr.GetTranslation("tank.view.caddy.openCardBox");
            case 9:
            default:
               return LanguageMgr.GetTranslation("tank.view.caddy.openBless");
            case 11:
            default:
            default:
               return LanguageMgr.GetTranslation("tank.view.caddy.openCelebration");
            case 14:
               return LanguageMgr.GetTranslation("treasureHunting.recordTxt");
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
   }
}
