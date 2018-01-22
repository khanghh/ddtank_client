package ddt.manager
{
   import GodSyah.SyahManager;
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.energyData.EnergyDataAnalyzer;
   import baglocked.BaglockedManager;
   import beadSystem.data.BeadEvent;
   import beadSystem.model.BeadModel;
   import calendar.CalendarManager;
   import cardSystem.data.CardInfo;
   import cityWide.CityWideEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.yy.game.GameMsgCollector;
   import com.yy.game.GameProfileParams;
   import consortion.ConsortionModelManager;
   import ddt.bagStore.BagStore;
   import ddt.data.AccountInfo;
   import ddt.data.AreaInfo;
   import ddt.data.BagInfo;
   import ddt.data.BuffInfo;
   import ddt.data.CMFriendInfo;
   import ddt.data.CheckCodeData;
   import ddt.data.EquipType;
   import ddt.data.PathInfo;
   import ddt.data.analyze.FriendListAnalyzer;
   import ddt.data.analyze.MyAcademyPlayersAnalyze;
   import ddt.data.analyze.RecentContactsAnalyze;
   import ddt.data.club.ClubInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.PlayerState;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.view.CheckCodeFrame;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.reader.AwardsInfo;
   import ddt.view.chat.ChatData;
   import ddt.view.im.AddCommunityFriend;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flashP2P.FlashP2PManager;
   import game.GameManager;
   import gemstone.info.GemstListInfo;
   import gemstone.info.GemstonInitInfo;
   import giftSystem.GiftManager;
   import giftSystem.MyGiftCellInfo;
   import im.CustomInfo;
   import im.IMEvent;
   import kingBless.KingBlessManager;
   import magicStone.data.MagicStoneInfo;
   import mainbutton.MainButtnController;
   import mark.data.MarkBagData;
   import mark.data.MarkChipData;
   import mark.data.MarkProData;
   import pet.data.PetEquipData;
   import pet.data.PetInfo;
   import pet.data.PetSkill;
   import powerUp.PowerUpMovieManager;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import road7th.utils.BitmapReader;
   import roomList.PassInputFrame;
   import starling.display.player.FightPlayerVo;
   import store.equipGhost.data.EquipGhostData;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   import totem.TotemManager;
   import trainer.controller.SystemOpenPromptManager;
   
   public class PlayerManager extends EventDispatcher
   {
      
      public static const FULL_HP:int = 1;
      
      public static const BAG_UPDATED:String = "bag_update";
      
      public static const PROPBAG_UPDATED:String = "propbag_update";
      
      public static const FRIEND_STATE_CHANGED:String = "friendStateChanged";
      
      public static const FRIENDLIST_COMPLETE:String = "friendListComplete";
      
      public static const RECENT_CONTAST_COMPLETE:String = "recentContactsComplete";
      
      public static const CIVIL_SELFINFO_CHANGE:String = "civilselfinfochange";
      
      public static const VIP_STATE_CHANGE:String = "VIPStateChange";
      
      public static const GIFT_INFO_CHANGE:String = "giftInfoChange";
      
      public static const SELF_GIFT_INFO_CHANGE:String = "selfGiftInfoChange";
      
      public static const NEW_GIFT_UPDATE:String = "newGiftUPDATE";
      
      public static const NEW_GIFT_ADD:String = "newGiftAdd";
      
      public static const FARM_BAG_UPDATE:String = "farmDataUpdate";
      
      public static const UPDATE_PLAYER_PROPERTY:String = "updatePlayerState";
      
      public static const UPDATE_PET:String = "updatePet";
      
      public static const GIRL_HEAD_PHOTO_CHANGE:String = "girl_head_photo_change";
      
      public static const GirlHeadPhotoRoot:String = "http://ddthead.7road.com";
      
      public static var isShowPHP:Boolean = false;
      
      public static const CUSTOM_MAX:int = 10;
      
      public static const VIP_GRADE_MAX:int = 15;
      
      private static var _instance:PlayerManager;
      
      public static const HORSERACING_BUY:int = 1;
      
      public static const WORSHIP_THE_MOON:int = 2;
      
      public static var SelfStudyEnergy:Boolean = true;
       
      
      private var _recentContacts:DictionaryData;
      
      public var customList:Vector.<CustomInfo>;
      
      private var _friendList:DictionaryData;
      
      private var _cmFriendList:DictionaryData;
      
      private var _blackList:DictionaryData;
      
      private var _clubPlays:DictionaryData;
      
      private var _tempList:DictionaryData;
      
      private var _mailTempList:DictionaryData;
      
      private var _myAcademyPlayers:DictionaryData;
      
      private var _sameCityList:Array;
      
      public var energyData:Object;
      
      private var _timer1:TimerJuggler;
      
      private var _timer2:TimerJuggler;
      
      private var _fightPower:int;
      
      private var _bagLockStateList:Array;
      
      private var _isReportGameProfile:Boolean;
      
      private var _playerEquipCategaryIdArr:Array;
      
      private var _self:SelfInfo;
      
      private var _curcentId:int;
      
      public var SelfConsortia:ClubInfo;
      
      private var _fightVo:FightPlayerVo;
      
      private var _account:AccountInfo;
      
      public var vipDiscountArr:Array;
      
      public var vipPriceArr:Array;
      
      public var merryDiscountArr:Array;
      
      public var merryActivity:Boolean = false;
      
      public var vipActivity:Boolean = false;
      
      public var vipDiscountTime:String = "";
      
      public var merryDiscountTime:String = "";
      
      public var kingBuffDiscountArr:Array;
      
      public var kingBuffPriceArr:Array;
      
      public var kingBuffDiscountTime:String = "";
      
      public var kingBuffActivity:Boolean = false;
      
      private var _areaList:DictionaryData;
      
      private var _propertyAdditions:DictionaryData;
      
      private var _whoGetCards:Boolean = false;
      
      private var tempStyle:Array;
      
      private var changedStyle:DictionaryData;
      
      public var gemstoneInfoList:Vector.<GemstonInitInfo>;
      
      public function PlayerManager()
      {
         _playerEquipCategaryIdArr = [1,2,3,4,5,6,7,8,9,13,14,15,16,17,19,40];
         SelfConsortia = new ClubInfo();
         vipDiscountArr = ["0","0","0"];
         vipPriceArr = ["0","0","0"];
         merryDiscountArr = ["0","0","0"];
         kingBuffDiscountArr = ["0","0","0"];
         kingBuffPriceArr = ["0","0","0"];
         _areaList = new DictionaryData();
         tempStyle = [];
         changedStyle = new DictionaryData();
         super();
         _self = new SelfInfo();
         _clubPlays = new DictionaryData();
         _tempList = new DictionaryData();
         _mailTempList = new DictionaryData();
         _timer1 = TimerManager.getInstance().addTimerJuggler(500);
         _timer2 = TimerManager.getInstance().addTimerJuggler(500);
      }
      
      public static function get Instance() : PlayerManager
      {
         if(_instance == null)
         {
            _instance = new PlayerManager();
         }
         return _instance;
      }
      
      public static function readLuckyPropertyName(param1:int) : String
      {
         switch(int(param1) - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("exp");
            case 1:
               return LanguageMgr.GetTranslation("offer");
            case 2:
               return LanguageMgr.GetTranslation("agility");
            case 3:
               return LanguageMgr.GetTranslation("luck");
            case 4:
               return LanguageMgr.GetTranslation("defence");
            default:
               return "";
            case 6:
               return LanguageMgr.GetTranslation("recovery");
            case 7:
               return LanguageMgr.GetTranslation("damage");
         }
      }
      
      public function get curcentId() : int
      {
         return _curcentId;
      }
      
      public function set curcentId(param1:int) : void
      {
         _curcentId = param1;
      }
      
      public function get Self() : SelfInfo
      {
         return _self;
      }
      
      public function get fightVo() : FightPlayerVo
      {
         if(_fightVo == null)
         {
            _fightVo = new FightPlayerVo();
            _fightVo.playerInfo = _self;
         }
         return _fightVo;
      }
      
      public function setup(param1:AccountInfo) : void
      {
         _account = param1;
         customList = new Vector.<CustomInfo>();
         _friendList = new DictionaryData();
         _blackList = new DictionaryData();
         initEvents();
      }
      
      public function get Account() : AccountInfo
      {
         return _account;
      }
      
      public function getDressEquipPlace(param1:InventoryItemInfo) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         if(EquipType.isWeddingRing(param1) && Self.Bag.getItemAt(16) == null)
         {
            return 16;
         }
         var _loc4_:Array = EquipType.CategeryIdToPlace(param1.CategoryID,param1.Place);
         if(_loc4_.length == 1)
         {
            _loc2_ = _loc4_[0];
         }
         else
         {
            _loc3_ = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               if(PlayerManager.Instance.Self.Bag.getItemAt(_loc4_[_loc5_]) == null)
               {
                  _loc2_ = _loc4_[_loc5_];
                  break;
               }
               _loc3_++;
               if(_loc3_ == _loc4_.length)
               {
                  _loc2_ = _loc4_[0];
               }
               _loc5_++;
            }
         }
         return _loc2_;
      }
      
      private function __updateInventorySlot(param1:PkgEvent) : void
      {
         var _loc11_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc2_:Boolean = false;
         var _loc6_:PackageIn = param1.pkg as PackageIn;
         var _loc3_:int = _loc6_.readInt();
         var _loc7_:int = _loc6_.readInt();
         var _loc4_:BagInfo = _self.getBag(_loc3_);
         if(_loc3_ == 21)
         {
            _loc2_ = true;
         }
         _loc4_.beginChanges();
         var _loc12_:int = 0;
         try
         {
            _loc11_ = 0;
            while(_loc11_ < _loc7_)
            {
               _loc9_ = _loc6_.readInt();
               _loc10_ = _loc6_.readBoolean();
               if(_loc10_)
               {
                  _loc5_ = _loc4_.getItemAt(_loc9_);
                  if(_loc5_ == null)
                  {
                     _loc5_ = new InventoryItemInfo();
                     _loc5_.Place = _loc9_;
                  }
                  _loc5_.UserID = _loc6_.readInt();
                  _loc5_.ItemID = _loc6_.readInt();
                  _loc5_.Count = _loc6_.readInt();
                  _loc5_.Place = _loc6_.readInt();
                  _loc5_.TemplateID = _loc6_.readInt();
                  _loc5_.AttackCompose = _loc6_.readInt();
                  _loc5_.DefendCompose = _loc6_.readInt();
                  _loc5_.AgilityCompose = _loc6_.readInt();
                  _loc5_.LuckCompose = _loc6_.readInt();
                  _loc5_.StrengthenLevel = _loc6_.readInt();
                  _loc5_.StrengthenExp = _loc6_.readInt();
                  _loc5_.IsBinds = _loc6_.readBoolean();
                  _loc5_.IsJudge = _loc6_.readBoolean();
                  _loc5_.BeginDate = _loc6_.readDateString();
                  _loc5_.ValidDate = _loc6_.readInt();
                  _loc5_.Color = _loc6_.readUTF();
                  _loc5_.Skin = _loc6_.readUTF();
                  _loc5_.IsUsed = _loc6_.readBoolean();
                  _loc5_.Hole1 = _loc6_.readInt();
                  _loc5_.Hole2 = _loc6_.readInt();
                  _loc5_.Hole3 = _loc6_.readInt();
                  _loc5_.Hole4 = _loc6_.readInt();
                  _loc5_.Hole5 = _loc6_.readInt();
                  _loc5_.Hole6 = _loc6_.readInt();
                  ItemManager.fill(_loc5_);
                  _loc5_.Pic = _loc6_.readUTF();
                  _loc5_.RefineryLevel = _loc6_.readInt();
                  _loc5_.DiscolorValidDate = _loc6_.readDateString();
                  _loc5_.StrengthenTimes = _loc6_.readInt();
                  _loc5_.Hole5Level = _loc6_.readByte();
                  _loc5_.Hole5Exp = _loc6_.readInt();
                  _loc5_.Hole6Level = _loc6_.readByte();
                  _loc5_.Hole6Exp = _loc6_.readInt();
                  _loc5_.curExp = _loc6_.readInt();
                  _loc5_.cellLocked = _loc6_.readBoolean();
                  _loc5_.isGold = _loc6_.readBoolean();
                  if(_loc5_.isGold)
                  {
                     _loc5_.goldValidDate = _loc6_.readInt();
                     _loc5_.goldBeginTime = _loc6_.readDateString();
                  }
                  _loc5_.latentEnergyCurStr = _loc6_.readUTF();
                  _loc5_.latentEnergyNewStr = _loc6_.readUTF();
                  _loc5_.latentEnergyEndTime = _loc6_.readDate();
                  _loc8_ = new Date();
                  _loc8_.time;
                  if(EquipType.isMagicStone(_loc5_.CategoryID))
                  {
                     _loc5_.Level = _loc5_.StrengthenLevel;
                     _loc5_.Attack = _loc5_.AttackCompose;
                     _loc5_.Defence = _loc5_.DefendCompose;
                     _loc5_.Agility = _loc5_.AgilityCompose;
                     _loc5_.Luck = _loc5_.LuckCompose;
                     _loc5_.MagicAttack = _loc6_.readInt();
                     _loc5_.MagicDefence = _loc6_.readInt();
                  }
                  else
                  {
                     _loc6_.readInt();
                     _loc6_.readInt();
                  }
                  _loc5_.goodsLock = _loc6_.readBoolean();
                  _loc5_.MagicExp = _loc6_.readInt();
                  _loc5_.MagicLevel = _loc6_.readInt();
                  if(EquipType.isWeddingRing(_loc5_))
                  {
                     _loc5_.RingExp = _self.RingExp;
                  }
                  if(int(PlayerManager._instance.Self.Grade) >= 10 && !_loc5_.IsUsed && _loc3_ == 0 && !BagAndInfoManager.Instance.isInBagAndInfoView && SystemOpenPromptManager.instance.isShowNewEuipTip && !BagStore.instance.isInBagStoreFrame && _playerEquipCategaryIdArr.indexOf(_loc5_.CategoryID) != -1 && int(PlayerManager._instance.Self.Grade) >= int(_loc5_.Property1))
                  {
                     showTipWithEquip(_loc5_);
                  }
                  _loc4_.addItem(_loc5_);
                  if(_loc5_.Place == 15 && _loc3_ == 0 && _loc5_.UserID == Self.ID)
                  {
                     _self.DeputyWeaponID = _loc5_.TemplateID;
                  }
                  if(PathManager.solveExternalInterfaceEnabel() && _loc3_ == 12 && _loc5_.StrengthenLevel >= 7)
                  {
                     ExternalInterfaceManager.sendToAgent(3,Self.ID,Self.NickName,ServerManager.Instance.zoneName,_loc5_.StrengthenLevel);
                  }
                  trace(_loc3_ + "全部：",_loc5_.Name,_loc5_.latentEnergyEndTime.fullYear,_loc5_.latentEnergyEndTime.month,_loc5_.latentEnergyEndTime.date);
               }
               else
               {
                  _loc4_.removeItemAt(_loc9_);
               }
               _loc11_++;
            }
         }
         catch(_loc13_:*)
         {
            _loc12_ = 1;
         }
         _loc4_.commiteChanges();
         if(!int(_loc12_))
         {
            if(_loc2_)
            {
               dispatchEvent(new BeadEvent("equip",0));
            }
            BuriedManager.Instance.dispatchEvent(new BuriedEvent("buried_UpDate_Stone_Count"));
            if(_loc3_ == 0)
            {
               dispatchEvent(new Event("bag_update"));
            }
            else if(_loc3_ == 1)
            {
               dispatchEvent(new Event("propbag_update"));
            }
            dispatchEvent(new CEvent("bring_up"));
            return;
         }
         throw _loc13_;
      }
      
      public function getPlaceOfEquip(param1:InventoryItemInfo) : int
      {
         var _loc3_:* = null;
         if(EquipType.isWeddingRing(param1))
         {
            _loc3_ = [16];
         }
         else
         {
            _loc3_ = EquipType.CategeryIdToPlace(param1.CategoryID);
         }
         var _loc2_:Array = _self.Bag.findIsEquipedByPlace(_loc3_);
         if(_loc2_.length > 0)
         {
            return _loc2_[0];
         }
         return -1;
      }
      
      private function showTipWithEquip(param1:InventoryItemInfo) : void
      {
         var _loc3_:* = null;
         if(EquipType.isWeddingRing(param1))
         {
            _loc3_ = [16];
         }
         else
         {
            _loc3_ = EquipType.CategeryIdToPlace(param1.CategoryID);
         }
         var _loc2_:Array = _self.Bag.findIsEquipedByPlace(_loc3_);
         if(_loc2_.length > 0)
         {
            SystemOpenPromptManager.instance.showEquipTipFrame(param1);
         }
      }
      
      private function __itemEquip(param1:PkgEvent) : void
      {
         var _loc36_:int = 0;
         var _loc30_:* = 0;
         var _loc37_:* = null;
         var _loc5_:int = 0;
         var _loc25_:* = 0;
         var _loc33_:* = null;
         var _loc3_:int = 0;
         var _loc26_:int = 0;
         var _loc7_:* = null;
         var _loc34_:* = null;
         var _loc20_:* = null;
         var _loc24_:* = undefined;
         var _loc9_:int = 0;
         var _loc35_:* = null;
         var _loc6_:* = null;
         var _loc27_:int = 0;
         var _loc12_:* = null;
         var _loc2_:* = null;
         var _loc14_:int = 0;
         var _loc29_:int = 0;
         var _loc28_:* = null;
         var _loc32_:int = 0;
         var _loc15_:int = 0;
         var _loc19_:int = 0;
         var _loc21_:* = null;
         var _loc22_:int = 0;
         var _loc4_:int = 0;
         var _loc17_:* = null;
         var _loc16_:* = null;
         var _loc13_:int = 0;
         var _loc18_:* = null;
         var _loc23_:PackageIn = param1.pkg;
         _loc23_.deCompress();
         var _loc10_:int = _loc23_.readInt();
         var _loc31_:int = _loc23_.readInt();
         var _loc11_:String = _loc23_.readUTF();
         var _loc8_:PlayerInfo = findPlayer(_loc10_,_loc31_,_loc11_);
         _loc8_.ID = _loc10_;
         if(_loc8_ != null)
         {
            _loc8_.beginChanges();
            _loc8_.Agility = _loc23_.readInt();
            _loc8_.Attack = _loc23_.readInt();
            if(!PlayerManager.Instance.isChangeStyleTemp(_loc10_))
            {
               _loc8_.Colors = _loc23_.readUTF();
               _loc8_.Skin = _loc23_.readUTF();
            }
            else
            {
               _loc23_.readUTF();
               _loc23_.readUTF();
               _loc8_.Colors = changedStyle[_loc10_]["Colors"];
               _loc8_.Skin = changedStyle[_loc10_]["Skin"];
            }
            _loc8_.Defence = _loc23_.readInt();
            _loc8_.GP = _loc23_.readInt();
            _loc8_.Grade = _loc23_.readInt();
            _loc8_.ddtKingGrade = _loc23_.readInt();
            _loc8_.Luck = _loc23_.readInt();
            _loc8_.hp = _loc23_.readInt();
            if(!PlayerManager.Instance.isChangeStyleTemp(_loc10_))
            {
               _loc8_.Hide = _loc23_.readInt();
            }
            else
            {
               _loc23_.readInt();
               _loc8_.Hide = changedStyle[_loc10_]["Hide"];
            }
            _loc8_.Repute = _loc23_.readInt();
            if(!PlayerManager.Instance.isChangeStyleTemp(_loc10_))
            {
               _loc8_.Sex = _loc23_.readBoolean();
               _loc8_.Style = _loc23_.readUTF();
            }
            else
            {
               _loc23_.readBoolean();
               _loc23_.readUTF();
               _loc8_.Sex = changedStyle[_loc10_]["Sex"];
               _loc8_.Style = changedStyle[_loc10_]["Style"];
            }
            _loc8_.Offer = _loc23_.readInt();
            _loc8_.NickName = _loc11_;
            _loc8_.typeVIP = _loc23_.readByte();
            _loc8_.VIPLevel = _loc23_.readInt();
            _loc8_.isOpenKingBless = _loc23_.readBoolean();
            _loc8_.WinCount = _loc23_.readInt();
            _loc8_.TotalCount = _loc23_.readInt();
            _loc8_.EscapeCount = _loc23_.readInt();
            _loc8_.ConsortiaID = _loc23_.readInt();
            _loc8_.ConsortiaName = _loc23_.readUTF();
            _loc8_.badgeID = _loc23_.readInt();
            _loc8_.RichesOffer = _loc23_.readInt();
            _loc8_.RichesRob = _loc23_.readInt();
            _loc8_.IsMarried = _loc23_.readBoolean();
            _loc8_.SpouseID = _loc23_.readInt();
            _loc8_.SpouseName = _loc23_.readUTF();
            _loc8_.DutyName = _loc23_.readUTF();
            _loc8_.Nimbus = _loc23_.readInt();
            _loc8_.FightPower = _loc23_.readInt();
            _loc8_.apprenticeshipState = _loc23_.readInt();
            _loc8_.masterID = _loc23_.readInt();
            _loc8_.setMasterOrApprentices(_loc23_.readUTF());
            _loc8_.graduatesCount = _loc23_.readInt();
            _loc8_.honourOfMaster = _loc23_.readUTF();
            _loc8_.AchievementPoint = _loc23_.readInt();
            _loc8_.honor = _loc23_.readUTF();
            _loc8_.LastLoginDate = _loc23_.readDate();
            _loc8_.spdTexpExp = _loc23_.readInt();
            _loc8_.attTexpExp = _loc23_.readInt();
            _loc8_.defTexpExp = _loc23_.readInt();
            _loc8_.hpTexpExp = _loc23_.readInt();
            _loc8_.lukTexpExp = _loc23_.readInt();
            _loc8_.magicAtkTexpExp = _loc23_.readInt();
            _loc8_.magicDefTexpExp = _loc23_.readInt();
            _loc8_.DailyLeagueFirst = _loc23_.readBoolean();
            _loc8_.DailyLeagueLastScore = _loc23_.readInt();
            _loc8_.totemId = _loc23_.readInt();
            _loc8_.necklaceExp = _loc23_.readInt();
            _loc8_.isAttest = _loc23_.readBoolean();
            _loc8_.curHorseLevel = _loc23_.readInt();
            _loc8_.RingExp = _loc23_.readInt();
            _loc8_.commitChanges();
            _loc36_ = _loc23_.readInt();
            _loc8_.Bag.beginChanges();
            if(!(_loc8_ is SelfInfo))
            {
               _loc8_.Bag.clearnAll();
            }
            _loc30_ = uint(0);
            while(_loc30_ < _loc36_)
            {
               _loc37_ = new InventoryItemInfo();
               _loc37_.BagType = _loc23_.readByte();
               _loc37_.UserID = _loc23_.readInt();
               _loc37_.ItemID = _loc23_.readInt();
               _loc37_.Count = _loc23_.readInt();
               _loc37_.Place = _loc23_.readInt();
               _loc37_.TemplateID = _loc23_.readInt();
               _loc37_.AttackCompose = _loc23_.readInt();
               _loc37_.DefendCompose = _loc23_.readInt();
               _loc37_.AgilityCompose = _loc23_.readInt();
               _loc37_.LuckCompose = _loc23_.readInt();
               _loc37_.StrengthenLevel = _loc23_.readInt();
               _loc37_.IsBinds = _loc23_.readBoolean();
               _loc37_.IsJudge = _loc23_.readBoolean();
               _loc37_.BeginDate = _loc23_.readDateString();
               _loc37_.ValidDate = _loc23_.readInt();
               _loc37_.Color = _loc23_.readUTF();
               _loc37_.Skin = _loc23_.readUTF();
               _loc37_.IsUsed = _loc23_.readBoolean();
               ItemManager.fill(_loc37_);
               _loc37_.Hole1 = _loc23_.readInt();
               _loc37_.Hole2 = _loc23_.readInt();
               _loc37_.Hole3 = _loc23_.readInt();
               _loc37_.Hole4 = _loc23_.readInt();
               _loc37_.Hole5 = _loc23_.readInt();
               _loc37_.Hole6 = _loc23_.readInt();
               _loc37_.Pic = _loc23_.readUTF();
               _loc37_.RefineryLevel = _loc23_.readInt();
               _loc37_.DiscolorValidDate = _loc23_.readDateString();
               _loc37_.Hole5Level = _loc23_.readByte();
               _loc37_.Hole5Exp = _loc23_.readInt();
               _loc37_.Hole6Level = _loc23_.readByte();
               _loc37_.Hole6Exp = _loc23_.readInt();
               _loc37_.curExp = _loc23_.readInt();
               _loc37_.isGold = _loc23_.readBoolean();
               if(_loc37_.isGold)
               {
                  _loc37_.goldValidDate = _loc23_.readInt();
                  _loc37_.goldBeginTime = _loc23_.readDateString();
               }
               _loc37_.latentEnergyCurStr = _loc23_.readUTF();
               _loc37_.latentEnergyNewStr = _loc23_.readUTF();
               _loc37_.latentEnergyEndTime = _loc23_.readDate();
               _loc37_.MagicLevel = _loc23_.readInt();
               if(EquipType.isWeddingRing(_loc37_))
               {
                  _loc37_.RingExp = _loc8_.RingExp;
               }
               if(_loc37_.Place == 18)
               {
               }
               _loc8_.Bag.addItem(_loc37_);
               _loc30_++;
            }
            _loc5_ = _loc23_.readInt();
            if(!(_loc8_ is SelfInfo))
            {
               _loc8_.BeadBag.clearnAll();
            }
            _loc8_.BeadBag.beginChanges();
            _loc25_ = uint(0);
            while(_loc25_ < _loc5_)
            {
               _loc33_ = new InventoryItemInfo();
               _loc33_.BagType = _loc23_.readByte();
               _loc33_.UserID = _loc23_.readInt();
               _loc33_.ItemID = _loc23_.readInt();
               _loc33_.Count = _loc23_.readInt();
               _loc33_.Place = _loc23_.readInt();
               _loc33_.TemplateID = _loc23_.readInt();
               _loc33_.AttackCompose = _loc23_.readInt();
               _loc33_.DefendCompose = _loc23_.readInt();
               _loc33_.AgilityCompose = _loc23_.readInt();
               _loc33_.LuckCompose = _loc23_.readInt();
               _loc33_.StrengthenLevel = _loc23_.readInt();
               _loc33_.IsBinds = _loc23_.readBoolean();
               _loc33_.IsJudge = _loc23_.readBoolean();
               _loc33_.BeginDate = _loc23_.readDateString();
               _loc33_.ValidDate = _loc23_.readInt();
               _loc33_.Color = _loc23_.readUTF();
               _loc33_.Skin = _loc23_.readUTF();
               _loc33_.IsUsed = _loc23_.readBoolean();
               ItemManager.fill(_loc33_);
               _loc33_.Hole1 = _loc23_.readInt();
               _loc33_.Hole2 = _loc23_.readInt();
               _loc33_.Hole3 = _loc23_.readInt();
               _loc33_.Hole4 = _loc23_.readInt();
               _loc33_.Hole5 = _loc23_.readInt();
               _loc33_.Hole6 = _loc23_.readInt();
               _loc33_.Pic = _loc23_.readUTF();
               _loc33_.RefineryLevel = _loc23_.readInt();
               _loc33_.DiscolorValidDate = _loc23_.readDateString();
               _loc33_.Hole5Level = _loc23_.readByte();
               _loc33_.Hole5Exp = _loc23_.readInt();
               _loc33_.Hole6Level = _loc23_.readByte();
               _loc33_.Hole6Exp = _loc23_.readInt();
               _loc33_.isGold = _loc23_.readBoolean();
               _loc8_.BeadBag.addItem(_loc33_);
               _loc25_++;
            }
            _loc3_ = _loc23_.readInt();
            gemstoneInfoList = new Vector.<GemstonInitInfo>();
            _loc26_ = 0;
            while(_loc26_ < _loc3_)
            {
               _loc7_ = new GemstonInitInfo();
               _loc7_.figSpiritId = _loc23_.readInt();
               _loc34_ = _loc23_.readUTF();
               _loc20_ = rezArr(_loc34_);
               _loc24_ = new Vector.<GemstListInfo>();
               _loc9_ = 0;
               while(_loc9_ < 3)
               {
                  _loc35_ = _loc20_[_loc9_].split(",");
                  _loc6_ = new GemstListInfo();
                  _loc6_.fightSpiritId = _loc7_.figSpiritId;
                  _loc6_.level = _loc35_[0];
                  _loc6_.exp = _loc35_[1];
                  _loc6_.place = _loc35_[2];
                  _loc24_.push(_loc6_);
                  _loc9_++;
               }
               _loc7_.equipPlace = _loc23_.readInt();
               if(_loc8_.Bag.getItemAt(_loc7_.equipPlace))
               {
                  _loc8_.Bag.getItemAt(_loc7_.equipPlace).gemstoneList = _loc24_;
               }
               _loc7_.list = _loc24_;
               gemstoneInfoList.push(_loc7_);
               _loc26_++;
            }
            _loc8_.gemstoneList = gemstoneInfoList;
            _loc8_.evolutionGrade = _loc23_.readInt();
            _loc8_.evolutionExp = _loc23_.readInt();
            _loc8_.MagicAttack = _loc23_.readInt();
            _loc8_.MagicDefence = _loc23_.readInt();
            _loc3_ = _loc23_.readInt();
            _loc27_ = 0;
            while(_loc27_ <= _loc3_ - 1)
            {
               _loc12_ = new MagicStoneInfo();
               _loc12_.place = _loc23_.readInt();
               _loc12_.templateId = _loc23_.readInt();
               _loc12_.level = _loc23_.readInt();
               _loc12_.attack = _loc23_.readInt();
               _loc12_.defence = _loc23_.readInt();
               _loc12_.agility = _loc23_.readInt();
               _loc12_.luck = _loc23_.readInt();
               _loc12_.magicAttack = _loc23_.readInt();
               _loc12_.magicDefence = _loc23_.readInt();
               _loc2_ = _loc8_.Bag.getItemAt(_loc12_.place);
               if(_loc2_)
               {
                  _loc2_.magicStoneAttr = _loc12_;
               }
               _loc27_++;
            }
            _loc8_.MountsType = _loc23_.readInt();
            _loc14_ = 0;
            while(_loc14_ < 9)
            {
               _loc8_.horseAmuletProperty[_loc14_] = _loc23_.readInt();
               _loc14_++;
            }
            _loc8_.horseAmuletHp = _loc23_.readInt();
            _loc8_.manualProInfo.manual_Level = _loc23_.readInt();
            _loc8_.manualProInfo.pro_Agile = _loc23_.readInt();
            _loc8_.manualProInfo.pro_Armor = _loc23_.readInt();
            _loc8_.manualProInfo.pro_Attack = _loc23_.readInt();
            _loc8_.manualProInfo.pro_Damage = _loc23_.readInt();
            _loc8_.manualProInfo.pro_Defense = _loc23_.readInt();
            _loc8_.manualProInfo.pro_HP = _loc23_.readInt();
            _loc8_.manualProInfo.pro_Lucky = _loc23_.readInt();
            _loc8_.manualProInfo.pro_MagicAttack = _loc23_.readInt();
            _loc8_.manualProInfo.pro_MagicResistance = _loc23_.readInt();
            _loc8_.manualProInfo.pro_Stamina = _loc23_.readInt();
            _loc8_.guardCoreGrade = _loc23_.readInt();
            _loc8_.guardCoreID = _loc23_.readInt();
            _loc29_ = _loc23_.readInt();
            if(_loc29_ > 0)
            {
               _loc28_ = null;
               _loc32_ = 0;
               _loc15_ = 0;
               _loc19_ = 0;
               while(_loc19_ < _loc29_)
               {
                  _loc32_ = _loc23_.readInt();
                  _loc15_ = _loc23_.readInt();
                  _loc28_ = new EquipGhostData(_loc32_,_loc15_);
                  _loc28_.level = _loc23_.readInt();
                  _loc28_.totalGhost = _loc23_.readInt();
                  _loc8_.addGhostData(_loc28_);
                  _loc19_++;
               }
            }
            _loc8_.teamID = _loc23_.readInt();
            _loc8_.teamName = _loc23_.readUTF();
            _loc8_.teamTag = _loc23_.readUTF();
            _loc8_.teamGrade = _loc23_.readInt();
            _loc8_.teamWinTime = _loc23_.readInt();
            _loc8_.teamTotalTime = _loc23_.readInt();
            _loc8_.teamDivision = _loc23_.readInt();
            _loc8_.teamScore = _loc23_.readInt();
            _loc8_.teamDuty = _loc23_.readInt();
            _loc8_.teamPersonalScore = _loc23_.readInt();
            _loc21_ = new MarkBagData();
            _loc22_ = _loc23_.readInt();
            _loc4_ = 0;
            while(_loc4_ < _loc22_)
            {
               _loc17_ = new MarkChipData();
               _loc17_.itemID = _loc23_.readInt();
               _loc17_.templateId = _loc23_.readInt();
               _loc17_.position = _loc23_.readInt();
               _loc17_.isExist = _loc23_.readBoolean();
               if(!_loc17_.isExist)
               {
                  _loc23_.readBoolean();
               }
               else
               {
                  _loc23_.readBoolean();
                  _loc17_.isbind = _loc23_.readBoolean();
                  _loc17_.bornLv = _loc23_.readInt();
                  _loc17_.hammerLv = _loc23_.readInt();
                  _loc17_.hLv = _loc23_.readInt();
                  _loc16_ = new MarkProData();
                  _loc16_.type = _loc23_.readInt();
                  _loc16_.value = _loc23_.readInt();
                  _loc16_.attachValue = _loc23_.readInt();
                  _loc17_.mainPro = _loc16_;
                  _loc17_.props = new Vector.<MarkProData>();
                  _loc13_ = 0;
                  while(_loc13_ < 4)
                  {
                     _loc18_ = new MarkProData();
                     _loc18_.type = _loc23_.readInt();
                     _loc18_.value = _loc23_.readInt();
                     _loc18_.attachValue = _loc23_.readInt();
                     _loc18_.hummerCount = _loc23_.readInt();
                     _loc17_.props.push(_loc18_);
                     _loc13_++;
                  }
                  _loc21_.chips[_loc17_.itemID] = _loc17_;
               }
               _loc4_++;
            }
            _loc8_.Markbag = _loc21_;
            _loc8_.Bag.commiteChanges();
            _loc8_.BeadBag.commiteChanges();
            _loc8_.commitChanges();
            dispatchEvent(new CEvent("playerEquipItem",_loc10_));
         }
      }
      
      private function rezArr(param1:String) : Array
      {
         var _loc2_:Array = param1.split("|");
         return _loc2_;
      }
      
      private function __onsItemEquip(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         var _loc3_:String = _loc4_.readUTF();
         var _loc5_:PlayerInfo = findPlayer(_loc2_);
         if(_loc5_ != null)
         {
            _loc5_.beginChanges();
            _loc5_.Agility = _loc4_.readInt();
            _loc5_.Attack = _loc4_.readInt();
            if(!PlayerManager.Instance.isChangeStyleTemp(_loc2_))
            {
               _loc5_.Colors = _loc4_.readUTF();
               _loc5_.Skin = _loc4_.readUTF();
            }
            else
            {
               _loc4_.readUTF();
               _loc4_.readUTF();
               _loc5_.Colors = changedStyle[_loc2_]["Colors"];
               _loc5_.Skin = changedStyle[_loc2_]["Skin"];
            }
            _loc5_.Defence = _loc4_.readInt();
            _loc5_.GP = _loc4_.readInt();
            _loc5_.Grade = _loc4_.readInt();
            _loc5_.ddtKingGrade = _loc4_.readInt();
            _loc5_.Luck = _loc4_.readInt();
            if(!PlayerManager.Instance.isChangeStyleTemp(_loc2_))
            {
               _loc5_.Hide = _loc4_.readInt();
            }
            else
            {
               _loc4_.readInt();
               _loc5_.Hide = changedStyle[_loc2_]["Hide"];
            }
            _loc5_.Repute = _loc4_.readInt();
            if(!PlayerManager.Instance.isChangeStyleTemp(_loc2_))
            {
               _loc5_.Sex = _loc4_.readBoolean();
               _loc5_.Style = _loc4_.readUTF();
            }
            else
            {
               _loc4_.readBoolean();
               _loc4_.readUTF();
               _loc5_.Sex = changedStyle[_loc2_]["Sex"];
               _loc5_.Style = changedStyle[_loc2_]["Style"];
            }
            _loc5_.Offer = _loc4_.readInt();
            _loc5_.NickName = _loc3_;
            _loc5_.typeVIP = _loc4_.readByte();
            _loc5_.VIPLevel = _loc4_.readInt();
            _loc5_.WinCount = _loc4_.readInt();
            _loc5_.TotalCount = _loc4_.readInt();
            _loc5_.EscapeCount = _loc4_.readInt();
            _loc5_.ConsortiaID = _loc4_.readInt();
            _loc5_.ConsortiaName = _loc4_.readUTF();
            _loc5_.RichesOffer = _loc4_.readInt();
            _loc5_.RichesRob = _loc4_.readInt();
            _loc5_.IsMarried = _loc4_.readBoolean();
            _loc5_.SpouseID = _loc4_.readInt();
            _loc5_.SpouseName = _loc4_.readUTF();
            _loc5_.DutyName = _loc4_.readUTF();
            _loc5_.Nimbus = _loc4_.readInt();
            _loc5_.FightPower = _loc4_.readInt();
            _loc5_.apprenticeshipState = _loc4_.readInt();
            _loc5_.masterID = _loc4_.readInt();
            _loc5_.setMasterOrApprentices(_loc4_.readUTF());
            _loc5_.graduatesCount = _loc4_.readInt();
            _loc5_.honourOfMaster = _loc4_.readUTF();
            _loc5_.AchievementPoint = _loc4_.readInt();
            _loc5_.honor = _loc4_.readUTF();
            _loc5_.LastLoginDate = _loc4_.readDate();
            _loc5_.commitChanges();
            _loc5_.Bag.beginChanges();
            _loc5_.Bag.commiteChanges();
            _loc5_.commitChanges();
         }
         super.dispatchEvent(new CityWideEvent("ons_playerInfo",_loc5_));
      }
      
      protected function __onGetBagLockedList(param1:PkgEvent) : void
      {
         e = param1;
         formatArr = function(param1:Array, param2:int):void
         {
            var _loc3_:int = 0;
            if(param1.length == param2)
            {
               return;
            }
            _loc3_ = param1.length;
            while(_loc3_ < param2)
            {
               param1.unshift("0");
               _loc3_++;
            }
         };
         var bytes:ByteArray = e.pkg;
         var stateList:Array = [];
         if(bytes.bytesAvailable)
         {
            var tempInt:uint = bytes.readUnsignedInt();
            var binaryString:String = tempInt.toString(2);
            stateList = binaryString.split("");
            formatArr(stateList,32);
         }
         _bagLockStateList = stateList;
      }
      
      public function isBagLockedPSWNeeded(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         if(_bagLockStateList == null)
         {
            return true;
         }
         if(param1 < 0 || param1 >= _bagLockStateList.length)
         {
            return true;
         }
         var _loc3_:int = _bagLockStateList.length;
         if(_bagLockStateList[_loc3_ - param1 - 1] == 0)
         {
            return false;
         }
         return true;
      }
      
      public function get bagLockStateList() : Array
      {
         return _bagLockStateList;
      }
      
      public function requireBagLockPSWDNeededList() : void
      {
         if(_bagLockStateList == null)
         {
            GameInSocketOut.sendBagLockStates();
         }
      }
      
      public function submitBagLockPSWNeededList(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = param1.length;
         while(_loc3_ < 32)
         {
            param1.unshift(0);
            _loc3_++;
         }
         var _loc2_:ByteArray = new ByteArray();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_.writeByte((param1[_loc4_ + 0] << 7) + (param1[_loc4_ + 1] << 6) + (param1[_loc4_ + 2] << 5) + (param1[_loc4_ + 3] << 4) + (param1[_loc4_ + 4] << 3) + (param1[_loc4_ + 5] << 2) + (param1[_loc4_ + 6] << 1) + param1[_loc4_ + 7]);
            _loc4_ = _loc4_ + 8;
         }
         GameInSocketOut.sendBagLockStates(_loc2_);
      }
      
      private function __bagLockedHandler(param1:PkgEvent) : void
      {
         var _loc5_:int = param1.pkg.readInt();
         var _loc6_:int = param1.pkg.readInt();
         var _loc8_:Boolean = param1.pkg.readBoolean();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc7_:String = param1.pkg.readUTF();
         var _loc4_:int = param1.pkg.readInt();
         var _loc9_:String = param1.pkg.readUTF();
         var _loc2_:String = param1.pkg.readUTF();
         if(_loc8_)
         {
            switch(int(_loc6_) - 1)
            {
               case 0:
                  _self.bagPwdState = true;
                  _self.bagLocked = true;
                  _self.onReceiveTypes("changePassword");
                  BaglockedManager.PWD = BaglockedManager.TEMP_PWD;
                  MessageTipManager.getInstance().show(_loc7_);
                  break;
               case 1:
                  _self.bagPwdState = true;
                  _self.bagLocked = false;
                  if(!ServerManager.AUTO_UNLOCK)
                  {
                     if(_loc7_ != "")
                     {
                        MessageTipManager.getInstance().show(_loc7_);
                     }
                     ServerManager.AUTO_UNLOCK = false;
                  }
                  BaglockedManager.PWD = BaglockedManager.TEMP_PWD;
                  _self.onReceiveTypes("clearSuccess");
                  break;
               case 2:
                  _self.onReceiveTypes("updateSuccess");
                  BaglockedManager.PWD = BaglockedManager.TEMP_PWD;
                  MessageTipManager.getInstance().show(_loc7_);
                  break;
               case 3:
                  _self.bagPwdState = false;
                  _self.bagLocked = false;
                  _self.onReceiveTypes("afterDel");
                  MessageTipManager.getInstance().show(_loc7_);
                  break;
               case 4:
                  _self.bagPwdState = true;
                  _self.bagLocked = true;
                  MessageTipManager.getInstance().show(_loc7_);
               default:
                  _self.bagPwdState = true;
                  _self.bagLocked = true;
                  MessageTipManager.getInstance().show(_loc7_);
            }
         }
         else
         {
            MessageTipManager.getInstance().show(_loc7_);
         }
      }
      
      private function __friendAdd(param1:PkgEvent) : void
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc4_.readBoolean();
         if(_loc2_)
         {
            _loc5_ = new FriendListPlayer();
            _loc5_.beginChanges();
            _loc5_.ID = _loc4_.readInt();
            _loc5_.NickName = _loc4_.readUTF();
            _loc5_.typeVIP = _loc4_.readByte();
            _loc5_.VIPLevel = _loc4_.readInt();
            _loc5_.Sex = _loc4_.readBoolean();
            _loc3_ = findPlayer(_loc5_.ID);
            if(!PlayerManager.Instance.isChangeStyleTemp(_loc5_.ID))
            {
               _loc5_.Style = _loc4_.readUTF();
               _loc5_.Colors = _loc4_.readUTF();
               _loc5_.Skin = _loc4_.readUTF();
            }
            else
            {
               _loc4_.readUTF();
               _loc4_.readUTF();
               _loc4_.readUTF();
               _loc5_.Style = _loc3_.Style;
               _loc5_.Colors = _loc3_.Colors;
               _loc5_.Skin = _loc3_.Skin;
            }
            _loc5_.playerState = new PlayerState(_loc4_.readInt());
            _loc5_.Grade = _loc4_.readInt();
            _loc5_.ddtKingGrade = _loc4_.readInt();
            if(!PlayerManager.Instance.isChangeStyleTemp(_loc5_.ID))
            {
               _loc5_.Hide = _loc4_.readInt();
            }
            else
            {
               _loc4_.readInt();
               _loc5_.Hide = _loc3_.Hide;
            }
            _loc5_.ConsortiaName = _loc4_.readUTF();
            _loc5_.TotalCount = _loc4_.readInt();
            _loc5_.EscapeCount = _loc4_.readInt();
            _loc5_.WinCount = _loc4_.readInt();
            _loc5_.Offer = _loc4_.readInt();
            _loc5_.Repute = _loc4_.readInt();
            _loc5_.Relation = _loc4_.readInt();
            _loc5_.LoginName = _loc4_.readUTF();
            _loc5_.Nimbus = _loc4_.readInt();
            _loc5_.FightPower = _loc4_.readInt();
            _loc5_.apprenticeshipState = _loc4_.readInt();
            _loc5_.masterID = _loc4_.readInt();
            _loc5_.setMasterOrApprentices(_loc4_.readUTF());
            _loc5_.graduatesCount = _loc4_.readInt();
            _loc5_.honourOfMaster = _loc4_.readUTF();
            _loc5_.AchievementPoint = _loc4_.readInt();
            _loc5_.honor = _loc4_.readUTF();
            _loc5_.IsMarried = _loc4_.readBoolean();
            _loc5_.isOld = _loc4_.readBoolean();
            _loc5_.LastLoginDate = _loc4_.readDate();
            _loc5_.ImagePath = _loc4_.readUTF();
            _loc5_.IsShow = _loc4_.readBoolean();
            _loc5_.isAttest = _loc4_.readBoolean();
            _loc5_.commitChanges();
            if(_loc5_.Relation != 1)
            {
               addFriend(_loc5_);
               if(PathInfo.isUserAddFriend)
               {
                  new AddCommunityFriend(_loc5_.LoginName,_loc5_.NickName);
               }
            }
            else
            {
               addBlackList(_loc5_);
            }
            dispatchEvent(new IMEvent("addnewfriend",_loc5_));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.playerManager.addFriend.isRefused"));
         }
      }
      
      public function isNeedPSW(param1:int) : Boolean
      {
         return false;
      }
      
      public function addFriend(param1:PlayerInfo) : void
      {
         if(!blackList && !friendList)
         {
            return;
         }
         blackList.remove(param1.ID);
         friendList.add(param1.ID,param1);
      }
      
      public function addBlackList(param1:FriendListPlayer) : void
      {
         if(!blackList && !friendList)
         {
            return;
         }
         friendList.remove(param1.ID);
         blackList.add(param1.ID,param1);
      }
      
      public function removeFriend(param1:int) : void
      {
         if(!blackList && !friendList)
         {
            return;
         }
         friendList.remove(param1);
         blackList.remove(param1);
      }
      
      private function __friendRemove(param1:PkgEvent) : void
      {
         removeFriend(param1.pkg.clientId);
      }
      
      private function __playerState(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:PackageIn = param1.pkg;
         if(_loc2_.clientId != _self.ID)
         {
            _loc3_ = {};
            _loc3_["clientId"] = _loc2_.clientId;
            _loc3_["state"] = _loc2_.readInt();
            _loc3_["typeVip"] = _loc2_.readByte();
            _loc3_["viplevel"] = _loc2_.readInt();
            _loc3_["isSameCity"] = _loc2_.readBoolean();
            playerStateChange(_loc3_);
            ConsortionModelManager.Instance.model.consortiaPlayerStateChange(_loc3_.clientId,_loc3_.state);
         }
      }
      
      private function spouseStateChange(param1:int) : void
      {
         var _loc2_:* = null;
         if(param1 == 1)
         {
            _loc2_ = !!Self.Sex?LanguageMgr.GetTranslation("ddt.manager.playerManager.wifeOnline",Self.SpouseName):LanguageMgr.GetTranslation("ddt.manager.playerManager.hushandOnline",Self.SpouseName);
            ChatManager.Instance.sysChatYellow(_loc2_);
         }
      }
      
      private function masterStateChange(param1:int, param2:int) : void
      {
         var _loc3_:* = null;
         if(param1 == 1 && param2 != Self.SpouseID)
         {
            if(param2 == Self.masterID)
            {
               _loc3_ = LanguageMgr.GetTranslation("ddt.manager.playerManager.masterState",Self.getMasterOrApprentices()[param2]);
            }
            else if(Self.getMasterOrApprentices()[param2])
            {
               _loc3_ = LanguageMgr.GetTranslation("ddt.manager.playerManager.ApprenticeState",Self.getMasterOrApprentices()[param2]);
            }
            else
            {
               return;
            }
            ChatManager.Instance.sysChatYellow(_loc3_);
         }
      }
      
      private function playerStateChange(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:PlayerInfo = friendList[param1.clientId];
         if(_loc5_)
         {
            if(_loc5_.playerState.StateID != param1.state || _loc5_.typeVIP != param1.typeVIP || _loc5_.isSameCity != param1.isSameCity)
            {
               _loc5_.typeVIP = param1.typeVip;
               _loc5_.VIPLevel = param1.viplevel;
               _loc5_.isSameCity = param1.isSameCity;
               if(param1.state == 1)
               {
                  _loc5_.LastLoginDate = TimeManager.Instance.serverDate;
               }
               _loc2_ = "";
               _loc3_ = _loc5_.playerState.StateID;
               if(_loc5_.playerState.StateID != param1.state)
               {
                  _loc5_.playerState = new PlayerState(param1.state);
                  friendList.add(param1.clientId,_loc5_);
                  if(_loc3_ == 4)
                  {
                     return;
                  }
                  if(param1.clientId == Self.SpouseID)
                  {
                     spouseStateChange(param1.state);
                     return;
                  }
                  if(param1.clientId == Self.masterID || Self.getMasterOrApprentices()[param1.clientId])
                  {
                     masterStateChange(param1.state,param1.clientId);
                     return;
                  }
                  if(param1.state == 1 && SharedManager.Instance.showOL)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("tank.view.chat.ChatInputView.friend") + "[" + _loc5_.NickName + "]" + LanguageMgr.GetTranslation("tank.manager.PlayerManger.friendOnline");
                     ChatManager.Instance.sysChatYellow(_loc2_);
                     return;
                  }
                  return;
               }
            }
            friendList.add(param1.clientId,_loc5_);
         }
         else if(myAcademyPlayers)
         {
            _loc4_ = myAcademyPlayers[param1.clientId];
            if(_loc4_)
            {
               if(_loc4_.playerState.StateID != param1.state || _loc4_.IsVIP != param1.typeVip)
               {
                  _loc4_.typeVIP = param1.typeVip;
                  _loc4_.VIPLevel = param1.viplevel;
                  _loc4_.playerState = new PlayerState(param1.state);
                  myAcademyPlayers.add(param1.clientId,_loc4_);
               }
            }
         }
      }
      
      private function initEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(64),__updateInventorySlot);
         SocketManager.Instance.addEventListener(PkgEvent.format(210),__updateAreaInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(74),__itemEquip);
         SocketManager.Instance.addEventListener(PkgEvent.format(160,45),__onsItemEquip);
         SocketManager.Instance.addEventListener(PkgEvent.format(25,1),__bagLockedHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(25,2),__onGetBagLockedList);
         SocketManager.Instance.addEventListener(PkgEvent.format(38),__updatePrivateInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(67),__updatePlayerInfo);
         SocketManager.Instance.addEventListener("tempStyle",__readTempStyle);
         SocketManager.Instance.addEventListener(PkgEvent.format(13),__dailyAwardHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(200),__checkCodePopup);
         SocketManager.Instance.addEventListener("buffObtain",__buffObtain);
         SocketManager.Instance.addEventListener("buffUpdate",__buffUpdate);
         Self.addEventListener("propertychange",__selfPopChange);
         SocketManager.Instance.addEventListener(PkgEvent.format(160,160),__friendAdd);
         SocketManager.Instance.addEventListener(PkgEvent.format(160,161),__friendRemove);
         SocketManager.Instance.addEventListener(PkgEvent.format(160,165),__playerState);
         SocketManager.Instance.addEventListener(PkgEvent.format(92),__upVipInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(218),__getGifts);
         SocketManager.Instance.addEventListener(PkgEvent.format(220),__addGiftItem);
         SocketManager.Instance.addEventListener(PkgEvent.format(214),__canReLoadGift);
         SocketManager.Instance.addEventListener(PkgEvent.format(216),__getCards);
         SocketManager.Instance.addEventListener(PkgEvent.format(15),__updateUerGuild);
         SocketManager.Instance.addEventListener(PkgEvent.format(17),__chatFilteringFriendsShare);
         SocketManager.Instance.addEventListener(PkgEvent.format(160,164),__sameCity);
         SocketManager.Instance.addEventListener("RoomListPass",__roomListPass);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,1),__updatePet);
         SocketManager.Instance.addEventListener(PkgEvent.format(95),__necklaceStrengthInfoUpadte);
         SocketManager.Instance.addEventListener(PkgEvent.format(86),__updateOneKeyFinish);
         SocketManager.Instance.addEventListener(PkgEvent.format(164),__updatePlayerProperty);
         SocketManager.Instance.addEventListener(PkgEvent.format(121,6),__onOpenHole);
         SocketManager.Instance.addEventListener(PkgEvent.format(105),__updateEnergyHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(272),__updatePeerID);
         SocketManager.Instance.addEventListener(PkgEvent.format(404,64),__onUpdateDungeonExp);
         SocketManager.Instance.addEventListener(PkgEvent.format(264),__totalCharge);
         SocketManager.Instance.addEventListener("vipMerryDiscount",__vipMerryDiscountInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(314),__gameRate);
         SocketManager.Instance.addEventListener(PkgEvent.format(321),__onGetPlayerRspecial);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,20),__updateRoomBordenBag);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,23),__useRoomBordenBoxHanlder);
      }
      
      private function __useRoomBordenBoxHanlder(param1:PkgEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:PackageIn = param1.pkg as PackageIn;
         var _loc3_:BagInfo = _self.getBag(43);
         _loc3_.beginChanges();
         if(_loc4_ == null)
         {
            _loc4_ = new InventoryItemInfo();
         }
         var _loc2_:String = _loc5_.readUTF();
         _loc4_.Count = _loc5_.readInt();
         _loc4_.ItemID = _loc5_.readInt();
         _loc4_.TemplateID = _loc5_.readInt();
         _loc4_.ValidDate = _loc5_.readInt();
         _loc4_.BeginDate = _loc5_.readDateString();
         _loc4_.IsUsed = _loc5_.readBoolean();
         _loc4_.IsBinds = true;
         ItemManager.fill(_loc4_);
         _loc3_.items.add(_loc4_.ItemID,_loc4_);
         BagAndInfoManager.Instance.showPreviewFrame(_loc2_,[_loc4_]);
      }
      
      private function __updateRoomBordenBag(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc6_:PackageIn = param1.pkg as PackageIn;
         var _loc3_:BagInfo = _self.getBag(43);
         _loc3_.beginChanges();
         var _loc5_:Boolean = _loc6_.readBoolean();
         var _loc2_:int = _loc6_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _loc4_ = new InventoryItemInfo();
            _loc4_.ItemID = _loc6_.readInt();
            _loc4_.TemplateID = _loc6_.readInt();
            _loc4_.ValidDate = _loc6_.readInt();
            _loc4_.BeginDate = _loc6_.readDateString();
            _loc4_.IsUsed = _loc6_.readBoolean();
            _loc4_.BagType = 43;
            _loc4_.IsBinds = true;
            ItemManager.fill(_loc4_);
            if(_loc5_)
            {
               _loc3_.items.add(_loc4_.ItemID,_loc4_);
            }
            else
            {
               _loc3_.items.remove(_loc4_.ItemID);
            }
            _loc7_++;
         }
         curcentId = _loc6_.readInt();
         if(!_loc5_)
         {
            _loc3_.dispatchEvent(new BagEvent("update",null));
         }
      }
      
      private function __gameRate(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:int = _loc3_.readInt();
         _self.experience_Rate = Number((_loc4_ / 100).toFixed(1));
         var _loc2_:int = _loc3_.readInt();
         _self.offer_Rate = Number((_loc2_ / 100).toFixed(1));
      }
      
      private function __vipMerryDiscountInfo(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc10_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc9_:int = 0;
         var _loc11_:* = null;
         var _loc13_:* = null;
         var _loc8_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         var _loc6_:int = _loc3_.readInt();
         var _loc12_:Boolean = _loc3_.readBoolean();
         if(_loc6_ == 1)
         {
            merryDiscountArr = ["0","0","0"];
            if(_loc12_)
            {
               _loc10_ = _loc3_.readUTF();
               _loc4_ = _loc3_.readUTF();
               _loc7_ = _loc3_.readUTF();
               merryDiscountTime = _loc4_ + "--" + _loc7_;
               merryDiscountArr = _loc10_.split("|");
               merryActivity = true;
            }
            else
            {
               merryDiscountArr = ServerConfigManager.instance.weddingMoney;
               merryDiscountArr.push(ServerConfigManager.instance.divorcedMoney);
               merryActivity = false;
            }
         }
         else if(_loc6_ == 2)
         {
            vipDiscountArr = ["0","0","0"];
            vipPriceArr = ["0","0","0"];
            if(_loc12_)
            {
               _loc5_ = _loc3_.readUTF();
               _loc2_ = _loc5_.split("|");
               _loc9_ = 0;
               while(_loc9_ < _loc2_.length)
               {
                  vipDiscountArr[_loc9_] = _loc2_[_loc9_].split(",")[1];
                  vipPriceArr[_loc9_] = _loc2_[_loc9_].split(",")[0];
                  _loc9_++;
               }
               _loc4_ = _loc3_.readUTF();
               _loc7_ = _loc3_.readUTF();
               vipDiscountTime = _loc4_ + "--" + _loc7_;
               vipActivity = true;
            }
            else
            {
               vipPriceArr = ServerConfigManager.instance.VIPRenewalPrice;
               vipActivity = false;
            }
         }
         else if(_loc6_ == 3)
         {
            kingBuffDiscountArr = ["0","0","0"];
            kingBuffPriceArr = ["0","0","0"];
            if(_loc12_)
            {
               _loc11_ = _loc3_.readUTF();
               _loc13_ = _loc11_.split("|");
               _loc8_ = 0;
               while(_loc8_ < _loc13_.length)
               {
                  kingBuffDiscountArr[_loc8_] = _loc13_[_loc8_].split(",")[1];
                  kingBuffPriceArr[_loc8_] = _loc13_[_loc8_].split(",")[0];
                  _loc8_++;
               }
               _loc4_ = _loc3_.readUTF();
               _loc7_ = _loc3_.readUTF();
               kingBuffDiscountTime = _loc4_ + "--" + _loc7_;
               kingBuffActivity = true;
            }
            else
            {
               kingBuffActivity = false;
            }
         }
      }
      
      private function __onGetPlayerRspecial(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc12_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc11_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:PackageIn = param1.pkg;
         var _loc10_:int = _loc8_.readInt();
         if(_loc10_ == 1)
         {
            _loc7_ = param1.pkg.readInt();
            _loc9_ = param1.pkg.readInt();
            _self.uploadNum = _loc9_;
            _self.ticketNum = _loc7_;
         }
         else if(_loc10_ == 2)
         {
            _loc4_ = _loc8_.readInt();
            _loc6_ = new DictionaryData();
            _loc12_ = 0;
            while(_loc12_ < _loc4_)
            {
               _loc3_ = _loc8_.readInt();
               _loc2_ = _loc8_.readInt();
               _loc6_.add(_loc3_,_loc2_);
               _loc12_++;
            }
            _self.ringUseNum = _loc6_;
         }
         else if(_loc10_ == 3)
         {
            _loc4_ = _loc8_.readInt();
            _loc12_ = 0;
            while(_loc12_ < _loc4_)
            {
               _loc11_ = _loc8_.readInt();
               _loc5_ = _loc8_.readInt();
               _self.setDungeonCount(_loc11_,_loc5_);
               _loc12_++;
            }
         }
      }
      
      protected function __totalCharge(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _self.totalCharge = _loc2_.readInt();
      }
      
      protected function __onUpdateDungeonExp(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _self.DungeonExpReceiveNum = _loc2_.readInt();
         _self.DungeonExpTotalNum = _loc2_.readInt();
      }
      
      protected function __updatePeerID(param1:PkgEvent) : void
      {
         var _loc4_:int = param1.pkg.readInt();
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:PlayerInfo = findPlayer(_loc2_,_loc4_);
         _loc3_.peerID = param1.pkg.readUTF();
         FlashP2PManager.Instance.addReadStream(_loc3_.peerID,_loc3_.ID);
      }
      
      protected function __updateEnergyHandler(param1:PkgEvent) : void
      {
         Self.energy = param1.pkg.readInt();
         Self.buyEnergyCount = param1.pkg.readInt();
      }
      
      protected function __necklaceStrengthInfoUpadte(param1:PkgEvent) : void
      {
         Self.necklaceExp = param1.pkg.readInt();
         Self.necklaceExpAdd = param1.pkg.readInt();
      }
      
      protected function __updateAreaInfo(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = param1.pkg.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new AreaInfo();
            _loc2_.areaID = param1.pkg.readInt();
            _loc2_.areaName = param1.pkg.readUTF();
            _areaList.add(_loc2_.areaName,_loc2_);
            _loc4_++;
         }
      }
      
      public function get areaList() : DictionaryData
      {
         return _areaList;
      }
      
      public function getSelfAreaNameByAreaID() : String
      {
         var _loc3_:int = 0;
         var _loc2_:* = _areaList;
         for each(var _loc1_ in _areaList)
         {
            if(_loc1_.areaID == Self.ZoneID)
            {
               return _loc1_.areaName;
            }
         }
         return "";
      }
      
      public function getAreaNameByAreaID(param1:int) : String
      {
         var _loc4_:int = 0;
         var _loc3_:* = _areaList;
         for each(var _loc2_ in _areaList)
         {
            if(_loc2_.areaID == param1)
            {
               return _loc2_.areaName;
            }
         }
         return "";
      }
      
      private function __onOpenHole(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg as PackageIn;
         var _loc2_:int = _loc3_.readInt();
         BeadModel.drillInfo.clear();
         BeadModel.drillInfo.add(131,_loc3_.readInt());
         BeadModel.drillInfo.add(141,_loc3_.readInt());
         BeadModel.drillInfo.add(151,_loc3_.readInt());
         BeadModel.drillInfo.add(161,_loc3_.readInt());
         BeadModel.drillInfo.add(171,_loc3_.readInt());
         BeadModel.drillInfo.add(181,_loc3_.readInt());
         BeadModel.drillInfo.add(132,_loc3_.readInt());
         BeadModel.drillInfo.add(142,_loc3_.readInt());
         BeadModel.drillInfo.add(152,_loc3_.readInt());
         BeadModel.drillInfo.add(162,_loc3_.readInt());
         BeadModel.drillInfo.add(172,_loc3_.readInt());
         BeadModel.drillInfo.add(182,_loc3_.readInt());
         dispatchEvent(new BeadEvent("openBeadHole",0));
      }
      
      protected function __updatePlayerProperty(param1:PkgEvent) : void
      {
         var _loc7_:PackageIn = param1.pkg;
         var _loc4_:Array = ["Attack","Defence","Agility","Luck"];
         var _loc5_:DictionaryData = new DictionaryData();
         var _loc6_:DictionaryData = null;
         var _loc3_:int = -1;
         _loc3_ = _loc7_.readInt();
         var _loc9_:int = _loc7_.readInt();
         var _loc12_:* = 0;
         var _loc11_:* = _loc4_;
         for each(var _loc2_ in _loc4_)
         {
            var _loc10_:* = new DictionaryData();
            _loc5_[_loc2_] = _loc10_;
            _loc6_ = _loc10_;
            _loc7_.readInt();
            _loc6_["Texp"] = _loc7_.readInt();
            _loc6_["Card"] = _loc7_.readInt();
            _loc6_["Pet"] = _loc7_.readInt();
            _loc6_["Suit"] = _loc7_.readInt();
            _loc6_["gem"] = _loc7_.readInt();
            _loc6_["Bead"] = _loc7_.readInt();
            _loc6_["Avatar"] = _loc7_.readInt();
            _loc6_["MagicStone"] = _loc7_.readInt();
            _loc6_["Temple"] = _loc7_.readInt();
            _loc6_["PetAtlas"] = _loc7_.readInt();
         }
         _loc10_ = new DictionaryData();
         _loc5_["MagicAttack"] = _loc10_;
         _loc6_ = _loc10_;
         _loc6_["MagicStone"] = _loc7_.readInt();
         _loc6_["Horse"] = _loc7_.readInt();
         _loc6_["HorsePicCherish"] = _loc7_.readInt();
         _loc6_["Enchant"] = _loc7_.readInt();
         _loc6_["Suit"] = _loc7_.readInt();
         _loc6_["Texp"] = _loc7_.readInt();
         _loc6_["Card"] = _loc7_.readInt();
         _loc12_ = new DictionaryData();
         _loc5_["MagicDefence"] = _loc12_;
         _loc6_ = _loc12_;
         _loc6_["MagicStone"] = _loc7_.readInt();
         _loc6_["Horse"] = _loc7_.readInt();
         _loc6_["HorsePicCherish"] = _loc7_.readInt();
         _loc6_["Enchant"] = _loc7_.readInt();
         _loc6_["Suit"] = _loc7_.readInt();
         _loc6_["Temple"] = _loc7_.readInt();
         _loc6_["Texp"] = _loc7_.readInt();
         _loc6_["Card"] = _loc7_.readInt();
         _loc11_ = new DictionaryData();
         _loc5_["HP"] = _loc11_;
         _loc6_ = _loc11_;
         _loc7_.readInt();
         _loc6_["Texp"] = _loc7_.readInt();
         _loc6_["Pet"] = _loc7_.readInt();
         _loc6_["Bead"] = _loc7_.readInt();
         _loc6_["Suit"] = _loc7_.readInt();
         _loc6_["gem"] = _loc7_.readInt();
         _loc6_["Avatar"] = _loc7_.readInt();
         _loc6_["Horse"] = _loc7_.readInt();
         _loc6_["HorsePicCherish"] = _loc7_.readInt();
         _loc6_["Temple"] = _loc7_.readInt();
         _loc10_ = new DictionaryData();
         _loc5_["Damage"] = _loc10_;
         _loc6_ = _loc10_;
         _loc6_["Suit"] = _loc7_.readInt();
         _loc12_ = new DictionaryData();
         _loc5_["Guard"] = _loc12_;
         _loc6_ = _loc12_;
         _loc6_["Suit"] = _loc7_.readInt();
         _loc5_["Damage"]["Bead"] = _loc7_.readInt();
         _loc5_["Damage"]["Avatar"] = _loc7_.readInt();
         _loc5_["Damage"]["Horse"] = _loc7_.readInt();
         _loc5_["Damage"]["HorsePicCherish"] = _loc7_.readInt();
         _loc5_["Armor"] = new DictionaryData();
         _loc5_["Armor"]["Bead"] = _loc7_.readInt();
         _loc5_["Armor"]["Avatar"] = _loc7_.readInt();
         _loc5_["Armor"]["Horse"] = _loc7_.readInt();
         _loc5_["Armor"]["HorsePicCherish"] = _loc7_.readInt();
         _loc5_["Armor"]["Temple"] = _loc7_.readInt();
         _loc5_["Armor"]["Pet"] = _loc7_.readInt();
         SyahManager.Instance.totalDamage = _loc7_.readInt();
         SyahManager.Instance.totalArmor = _loc7_.readInt();
         var _loc8_:PlayerInfo = findPlayer(_loc3_,_loc9_);
         _loc8_.fineSuitExp = _loc7_.readInt();
         _loc7_.readInt();
         _loc7_.readInt();
         _loc7_.readInt();
         _loc5_["Damage"]["mark"] = _loc7_.readInt();
         _loc5_["Armor"]["mark"] = _loc7_.readInt();
         _loc5_["Attack"]["mark"] = _loc7_.readInt();
         _loc5_["Defence"]["mark"] = _loc7_.readInt();
         _loc5_["Agility"]["mark"] = _loc7_.readInt();
         _loc5_["Luck"]["mark"] = _loc7_.readInt();
         _loc5_["HP"]["mark"] = _loc7_.readInt();
         _loc5_["MagicAttack"]["mark"] = _loc7_.readInt();
         _loc5_["MagicDefence"]["mark"] = _loc7_.readInt();
         _loc7_.readInt();
         _loc7_.readInt();
         _loc7_.readInt();
         _loc7_.readInt();
         _loc7_.readInt();
         FineSuitManager.Instance.updateFineSuitProperty(_loc8_.fineSuitExp,_loc5_);
         TotemManager.instance.updatePropertyAddtion(_loc8_.totemId,_loc5_);
         _loc8_.propertyAddition = _loc5_;
         dispatchEvent(new Event("updatePlayerState"));
         _loc8_.commitChanges();
      }
      
      public function get propertyAdditions() : DictionaryData
      {
         return _propertyAdditions;
      }
      
      private function __roomListPass(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:PassInputFrame = ComponentFactory.Instance.creat("asset.ddtroomList.RoomList.passInputFrame");
         LayerManager.Instance.addToLayer(_loc3_,3,true,1);
         _loc3_.ID = _loc2_;
      }
      
      private function __sameCity(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = param1.pkg.readInt();
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1.pkg.readInt();
            findPlayer(_loc2_,Self.ZoneID).isSameCity = true;
            if(!_sameCityList)
            {
               _sameCityList = [];
            }
            _sameCityList.push(_loc2_);
            _loc4_++;
         }
         initSameCity();
      }
      
      private function initSameCity() : void
      {
         var _loc1_:int = 0;
         if(!_sameCityList)
         {
            _sameCityList = [];
         }
         _loc1_ = 0;
         while(_loc1_ < _sameCityList.length)
         {
            findPlayer(_sameCityList[_loc1_]).isSameCity = true;
            _loc1_++;
         }
         _friendList[_self.ZoneID].dispatchEvent(new DictionaryEvent("update"));
      }
      
      private function __chatFilteringFriendsShare(param1:PkgEvent) : void
      {
         if(!_cmFriendList)
         {
            return;
         }
         var _loc5_:PackageIn = param1.pkg;
         var _loc2_:int = _loc5_.readInt();
         var _loc4_:String = _loc5_.readUTF();
         var _loc3_:Boolean = false;
         var _loc8_:int = 0;
         var _loc7_:* = _cmFriendList;
         for each(var _loc6_ in _cmFriendList)
         {
            if(_loc6_.UserId == _loc2_)
            {
               _loc3_ = true;
            }
         }
         if(_loc3_)
         {
            ChatManager.Instance.sysChatYellow(_loc4_);
         }
      }
      
      private function __updateUerGuild(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:int = param1.pkg.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = param1.pkg.readByte();
            _loc3_.writeByte(_loc2_);
            _loc5_++;
         }
         _self.weaklessGuildProgress = _loc3_;
      }
      
      private function __getCards(param1:PkgEvent) : void
      {
         var _loc9_:int = 0;
         var _loc13_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:* = null;
         var _loc4_:* = undefined;
         var _loc10_:* = null;
         _whoGetCards = true;
         var _loc11_:* = false;
         var _loc5_:PackageIn = param1.pkg;
         var _loc12_:int = _loc5_.readInt();
         var _loc7_:int = _loc5_.readInt();
         var _loc6_:int = _loc5_.readInt();
         var _loc8_:PlayerInfo = findPlayer(_loc12_,_loc7_);
         _loc9_ = 0;
         while(_loc9_ < _loc6_)
         {
            _loc13_ = _loc5_.readInt();
            _loc2_ = _loc5_.readBoolean();
            if(_loc2_)
            {
               _loc3_ = new CardInfo();
               _loc3_.CardID = _loc5_.readInt();
               _loc3_.CardType = _loc5_.readInt();
               _loc3_.UserID = _loc5_.readInt();
               _loc3_.Place = _loc5_.readInt();
               _loc3_.TemplateID = _loc5_.readInt();
               _loc3_.isFirstGet = _loc5_.readBoolean();
               _loc3_.Attack = _loc5_.readInt();
               _loc3_.Defence = _loc5_.readInt();
               _loc3_.Agility = _loc5_.readInt();
               _loc3_.Luck = _loc5_.readInt();
               _loc3_.Damage = _loc5_.readInt();
               _loc3_.Guard = _loc5_.readInt();
               if(CaddyModel.instance.type == 6 || CaddyModel.instance.type == 9 || CaddyModel.instance.type == 8)
               {
                  if(_loc3_.TemplateID != 0)
                  {
                     _self.cardInfo = _loc3_;
                     dispatchEvent(new Event("cards_name"));
                  }
               }
               if(_loc3_.Place <= 4 && _loc3_.TemplateID > 0)
               {
                  _loc8_.cardEquipDic.add(_loc3_.Place,_loc3_);
               }
               else if(_loc3_.Place <= 4 && _loc3_.TemplateID == 0)
               {
                  _loc8_.cardEquipDic.remove(_loc13_);
               }
               else if(_loc3_.Place > 4 && _loc3_.TemplateID == 0)
               {
                  _loc8_.cardBagDic.remove(_loc13_);
               }
               else
               {
                  _loc8_.cardBagDic.add(_loc3_.Place,_loc3_);
                  _loc4_ = new Vector.<AwardsInfo>();
                  _loc10_ = new AwardsInfo();
                  _loc10_.name = _loc3_.templateInfo.Name;
                  _loc10_.TemplateId = _loc3_.TemplateID;
                  _loc10_.channel = _loc3_.CardType;
                  _loc10_.zone = String(_loc3_.Place);
                  _loc10_.zoneID = 0;
                  _loc4_.push(_loc10_);
                  CaddyModel.instance.addAwardsInfoByArr(_loc4_);
                  if(!_loc11_)
                  {
                     _loc11_ = _loc12_ == Self.ID;
                  }
               }
            }
            else if(_loc13_ <= 4)
            {
               _loc8_.cardEquipDic.remove(_loc13_);
            }
            else
            {
               _loc8_.cardBagDic.remove(_loc13_);
            }
            if(_loc11_)
            {
               SocketManager.Instance.out.requestCardAchievement();
            }
            _loc9_++;
         }
      }
      
      public function get whoGetCards() : Boolean
      {
         return _whoGetCards;
      }
      
      public function set whoGetCards(param1:Boolean) : void
      {
         _whoGetCards = param1;
      }
      
      private function __sysNotice(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc6_:int = _loc3_.readInt();
         var _loc9_:String = _loc3_.readUTF();
         var _loc7_:int = _loc3_.readByte();
         var _loc4_:int = _loc3_.readInt();
         var _loc10_:int = _loc3_.readInt();
         var _loc2_:int = _loc3_.readInt();
         var _loc5_:String = _loc3_.readUTF();
         var _loc8_:ChatData = new ChatData();
         _loc8_.type = 1;
         _loc8_.msg = _loc9_;
         _loc8_.channel = _loc6_;
         trace("---------------------");
         trace(_loc8_.msg);
      }
      
      private function __canReLoadGift(param1:PkgEvent) : void
      {
         var _loc2_:Boolean = param1.pkg.readBoolean();
         if(_loc2_)
         {
            SocketManager.Instance.out.sendPlayerGift(_self.ID);
         }
      }
      
      private function __addGiftItem(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:int = _loc4_.readInt();
         var _loc2_:int = _loc4_.readInt();
         var _loc5_:int = _self.myGiftData.length;
         if(_loc5_ != 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               if(_self.myGiftData[_loc6_].TemplateID == _loc3_)
               {
                  _self.myGiftData[_loc6_].amount = _loc2_;
                  dispatchEvent(new DictionaryEvent("update",_self.myGiftData[_loc6_]));
                  break;
               }
               if(_loc6_ == _loc5_ - 1)
               {
                  addItem(_loc3_,_loc2_);
               }
               _loc6_++;
            }
         }
         else
         {
            addItem(_loc3_,_loc2_);
         }
         GiftManager.Instance.loadRecord("GiftRecieveLog.ashx",_self.ID);
      }
      
      private function addItem(param1:int, param2:int) : void
      {
         var _loc3_:MyGiftCellInfo = new MyGiftCellInfo();
         _loc3_.TemplateID = param1;
         _loc3_.amount = param2;
         _self.myGiftData.push(_loc3_);
         dispatchEvent(new DictionaryEvent("add",_self.myGiftData[_self.myGiftData.length - 1]));
      }
      
      private function __getGifts(param1:PkgEvent) : void
      {
         var _loc6_:* = undefined;
         var _loc10_:int = 0;
         var _loc8_:* = null;
         var _loc3_:* = undefined;
         var _loc9_:int = 0;
         var _loc7_:* = null;
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.pkg;
         var _loc2_:int = _loc5_.readInt();
         var _loc11_:PlayerInfo = findPlayer(_loc2_);
         if(_loc2_ == _self.ID)
         {
            _self.charmGP = _loc5_.readInt();
            _loc4_ = _loc5_.readInt();
            _loc6_ = new Vector.<MyGiftCellInfo>();
            _loc10_ = 0;
            while(_loc10_ < _loc4_)
            {
               _loc8_ = new MyGiftCellInfo();
               _loc8_.TemplateID = _loc5_.readInt();
               _loc8_.amount = _loc5_.readInt();
               _loc6_.push(_loc8_);
               _loc10_++;
            }
            _self.myGiftData = _loc6_;
            dispatchEvent(new Event("selfGiftInfoChange"));
         }
         else
         {
            _loc11_.beginChanges();
            _loc11_.charmGP = _loc5_.readInt();
            _loc4_ = _loc5_.readInt();
            _loc3_ = new Vector.<MyGiftCellInfo>();
            _loc9_ = 0;
            while(_loc9_ < _loc4_)
            {
               _loc7_ = new MyGiftCellInfo();
               _loc7_.TemplateID = _loc5_.readInt();
               _loc7_.amount = _loc5_.readInt();
               _loc3_.push(_loc7_);
               _loc9_++;
            }
            _loc11_.myGiftData = _loc3_;
            _loc11_.commitChanges();
            dispatchEvent(new Event("giftInfoChange"));
         }
      }
      
      private function __upVipInfo(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _self.typeVIP = _loc2_.readByte();
         _self.VIPLevel = _loc2_.readInt();
         _self.VIPExp = _loc2_.readInt();
         _self.VIPExpireDay = _loc2_.readDate();
         _self.LastDate = _loc2_.readDate();
         _self.VIPNextLevelDaysNeeded = _loc2_.readInt();
         _self.canTakeVipReward = _loc2_.readBoolean();
         dispatchEvent(new Event("VIPStateChange"));
      }
      
      public function setupFriendList(param1:FriendListAnalyzer) : void
      {
         customList = param1.customList;
         friendList = param1.friendlist;
         blackList = param1.blackList;
         initSameCity();
      }
      
      public function setupEnergyData(param1:EnergyDataAnalyzer) : void
      {
         energyData = param1.data;
      }
      
      public function checkHasGroupName(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < customList.length)
         {
            if(customList[_loc2_].Name == param1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.addFirend.repet"),0,true);
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function setupMyacademyPlayers(param1:MyAcademyPlayersAnalyze) : void
      {
         _myAcademyPlayers = param1.myAcademyPlayers;
      }
      
      private function romoveAcademyPlayers() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _myAcademyPlayers;
         for each(var _loc1_ in _myAcademyPlayers)
         {
            friendList.remove(_loc1_.ID);
         }
      }
      
      public function setupRecentContacts(param1:RecentContactsAnalyze) : void
      {
         recentContacts = param1.recentContacts;
      }
      
      public function set friendList(param1:DictionaryData) : void
      {
         _friendList[_self.ZoneID] = param1;
         IMManager.Instance.isLoadComplete = true;
         dispatchEvent(new Event("friendListComplete"));
      }
      
      public function get friendList() : DictionaryData
      {
         if(_friendList[_self.ZoneID] == null)
         {
            _friendList[PlayerManager.Instance.Self.ZoneID] = new DictionaryData();
         }
         return _friendList[_self.ZoneID];
      }
      
      public function get friendListOnline() : DictionaryData
      {
         var _loc1_:* = null;
         if(friendList.length > 0)
         {
            _loc1_ = new DictionaryData();
            var _loc4_:int = 0;
            var _loc3_:* = friendList;
            for each(var _loc2_ in friendList)
            {
               if(_loc2_.playerState.StateID != 0)
               {
                  _loc1_.add(_loc2_.ID,_loc2_);
               }
            }
            return _loc1_;
         }
         return friendList;
      }
      
      public function getFriendForCustom(param1:int) : DictionaryData
      {
         var _loc2_:DictionaryData = new DictionaryData();
         if(_friendList[_self.ZoneID] == null)
         {
            _friendList[PlayerManager.Instance.Self.ZoneID] = new DictionaryData();
         }
         var _loc5_:int = 0;
         var _loc4_:* = _friendList[_self.ZoneID];
         for each(var _loc3_ in _friendList[_self.ZoneID])
         {
            if(_loc3_.Relation == param1)
            {
               _loc2_.add(_loc3_.ID,_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function deleteCustomGroup(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _friendList[_self.ZoneID];
         for each(var _loc2_ in _friendList[_self.ZoneID])
         {
            if(_loc2_.Relation == param1)
            {
               _loc2_.Relation = 0;
            }
         }
      }
      
      public function get myAcademyPlayers() : DictionaryData
      {
         return _myAcademyPlayers;
      }
      
      public function get recentContacts() : DictionaryData
      {
         if(!_recentContacts)
         {
            _recentContacts = new DictionaryData();
         }
         return _recentContacts;
      }
      
      public function set recentContacts(param1:DictionaryData) : void
      {
         _recentContacts = param1;
         dispatchEvent(new Event("recentContactsComplete"));
      }
      
      public function get onlineRecentContactList() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = recentContacts;
         for each(var _loc2_ in recentContacts)
         {
            if(_loc2_.playerState.StateID != 0 || findPlayer(_loc2_.ID) && findPlayer(_loc2_.ID).playerState.StateID != 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function get offlineRecentContactList() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = recentContacts;
         for each(var _loc2_ in recentContacts)
         {
            if(_loc2_.playerState.StateID == 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getByNameFriend(param1:String) : FriendListPlayer
      {
         var _loc4_:int = 0;
         var _loc3_:* = recentContacts;
         for each(var _loc2_ in recentContacts)
         {
            if(_loc2_.NickName == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function deleteRecentContact(param1:int) : void
      {
         recentContacts.remove(param1);
      }
      
      public function get friendAndCustomTitle() : Array
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc2_:Array = [];
         var _loc3_:int = customList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_ - 1)
         {
            _loc1_ = new FriendListPlayer();
            _loc1_.type = 0;
            _loc1_.titleType = customList[_loc4_].ID;
            _loc1_.titleIsSelected = false;
            _loc1_.titleNumText = "[" + String(getOnlineFriendForCustom(customList[_loc4_].ID).length) + "]";
            _loc1_.titleText = customList[_loc4_].Name;
            _loc2_.push(_loc1_);
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get onlineFriendList() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = friendList;
         for each(var _loc2_ in friendList)
         {
            if(_loc2_.playerState.StateID != 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getOnlineFriendForCustom(param1:int) : Array
      {
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = friendList;
         for each(var _loc3_ in friendList)
         {
            if(_loc3_.playerState.StateID != 0 && _loc3_.Relation == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function get offlineFriendList() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = friendList;
         for each(var _loc2_ in friendList)
         {
            if(_loc2_.playerState.StateID == 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getOfflineFriendForCustom(param1:int) : Array
      {
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = friendList;
         for each(var _loc3_ in friendList)
         {
            if(_loc3_.playerState.StateID == 0 && _loc3_.Relation == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function get onlineMyAcademyPlayers() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _myAcademyPlayers;
         for each(var _loc2_ in _myAcademyPlayers)
         {
            if(_loc2_.playerState.StateID != 0)
            {
               _loc1_.push(_loc2_ as FriendListPlayer);
            }
         }
         return _loc1_;
      }
      
      public function get offlineMyAcademyPlayers() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _myAcademyPlayers;
         for each(var _loc2_ in _myAcademyPlayers)
         {
            if(_loc2_.playerState.StateID == 0)
            {
               _loc1_.push(_loc2_ as FriendListPlayer);
            }
         }
         return _loc1_;
      }
      
      public function set blackList(param1:DictionaryData) : void
      {
         _blackList[_self.ZoneID] = param1;
      }
      
      public function get blackList() : DictionaryData
      {
         if(_blackList[_self.ZoneID] == null)
         {
            _blackList[PlayerManager.Instance.Self.ZoneID] = new DictionaryData();
         }
         return _blackList[_self.ZoneID];
      }
      
      public function get CMFriendList() : DictionaryData
      {
         return _cmFriendList;
      }
      
      public function set CMFriendList(param1:DictionaryData) : void
      {
         _cmFriendList = param1;
      }
      
      public function get PlayCMFriendList() : Array
      {
         if(_cmFriendList)
         {
            return _cmFriendList.filter("IsExist",true);
         }
         return [];
      }
      
      public function get UnPlayCMFriendList() : Array
      {
         if(_cmFriendList)
         {
            return _cmFriendList.filter("IsExist",false);
         }
         return [];
      }
      
      private function __updatePrivateInfo(param1:PkgEvent) : void
      {
         _self.beginChanges();
         _self.Money = param1.pkg.readInt();
         _self.DDTMoney = param1.pkg.readInt();
         _self.BandMoney = param1.pkg.readInt();
         _self.Score = param1.pkg.readInt();
         _self.Gold = param1.pkg.readInt();
         _self.badLuckNumber = param1.pkg.readInt();
         _self.damageScores = param1.pkg.readInt();
         param1.pkg.readInt();
         _self.myHonor = param1.pkg.readInt();
         _self.hardCurrency = param1.pkg.readInt();
         _self.jampsCurrency = param1.pkg.readInt();
         _self.commitChanges();
      }
      
      public function get hasTempStyle() : Boolean
      {
         return tempStyle.length > 0;
      }
      
      public function isChangeStyleTemp(param1:int) : Boolean
      {
         return changedStyle.hasOwnProperty(param1) && changedStyle[param1] != null;
      }
      
      public function setStyleTemply(param1:Object) : void
      {
         var _loc2_:PlayerInfo = findPlayer(param1.ID);
         if(_loc2_)
         {
            storeTempStyle(_loc2_);
            _loc2_.beginChanges();
            _loc2_.Sex = param1.Sex;
            _loc2_.Hide = param1.Hide;
            _loc2_.Style = param1.Style;
            _loc2_.Colors = param1.Colors;
            _loc2_.Skin = param1.Skin;
            _loc2_.commitChanges();
         }
      }
      
      private function storeTempStyle(param1:PlayerInfo) : void
      {
         var _loc2_:Object = {};
         _loc2_.Style = param1.getPrivateStyle();
         _loc2_.Hide = param1.Hide;
         _loc2_.Sex = param1.Sex;
         _loc2_.Skin = param1.Skin;
         _loc2_.Colors = param1.Colors;
         _loc2_.ID = param1.ID;
         tempStyle.push(_loc2_);
      }
      
      public function readAllTempStyleEvent() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < tempStyle.length)
         {
            _loc1_ = findPlayer(tempStyle[_loc2_].ID);
            if(_loc1_)
            {
               _loc1_.beginChanges();
               _loc1_.Sex = tempStyle[_loc2_].Sex;
               _loc1_.Hide = tempStyle[_loc2_].Hide;
               _loc1_.Style = tempStyle[_loc2_].Style;
               _loc1_.Colors = tempStyle[_loc2_].Colors;
               _loc1_.Skin = tempStyle[_loc2_].Skin;
               _loc1_.commitChanges();
            }
            _loc2_++;
         }
         tempStyle = [];
         changedStyle.clear();
      }
      
      private function __readTempStyle(param1:CrazyTankSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:int = _loc3_.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = {};
            _loc2_.Style = _loc3_.readUTF();
            _loc2_.Hide = _loc3_.readInt();
            _loc2_.Sex = _loc3_.readBoolean();
            _loc2_.Skin = _loc3_.readUTF();
            _loc2_.Colors = _loc3_.readUTF();
            _loc2_.ID = _loc3_.readInt();
            setStyleTemply(_loc2_);
            changedStyle.add(_loc2_.ID,_loc2_);
            _loc5_++;
         }
      }
      
      private function __updatePlayerInfo(param1:PkgEvent) : void
      {
         var _loc4_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:PlayerInfo = findPlayer(param1.pkg.clientId);
         if(_loc6_)
         {
            _loc6_.beginChanges();
            var _loc15_:int = 0;
            try
            {
               _loc4_ = param1.pkg;
               _loc6_.GP = _loc4_.readInt();
               _loc6_.ddtKingGrade = _loc4_.readInt();
               _loc6_.Offer = _loc4_.readInt();
               _loc6_.RichesOffer = _loc4_.readInt();
               _loc6_.RichesRob = _loc4_.readInt();
               _loc6_.WinCount = _loc4_.readInt();
               _loc6_.TotalCount = _loc4_.readInt();
               _loc6_.EscapeCount = _loc4_.readInt();
               _loc6_.Attack = _loc4_.readInt();
               _loc6_.Defence = _loc4_.readInt();
               _loc6_.Agility = _loc4_.readInt();
               _loc6_.Luck = _loc4_.readInt();
               _loc6_.MagicAttack = _loc4_.readInt();
               _loc6_.MagicDefence = _loc4_.readInt();
               _loc6_.hp = _loc4_.readInt();
               if(!isChangeStyleTemp(_loc6_.ID))
               {
                  _loc6_.Hide = _loc4_.readInt();
               }
               else
               {
                  _loc4_.readInt();
               }
               _loc11_ = _loc4_.readUTF();
               if(!isChangeStyleTemp(_loc6_.ID))
               {
                  _loc6_.Style = _loc11_;
               }
               _loc12_ = _loc11_.split(",")[6].split("|")[0];
               _loc13_ = _loc11_.split(",")[10].split("|")[0];
               if(_loc12_ == "-1" || _loc12_ == "0" || _loc12_ == "")
               {
                  _loc6_.WeaponID = -1;
               }
               else
               {
                  _loc6_.WeaponID = int(_loc12_);
               }
               if(_loc13_ == "0" || _loc13_ == "")
               {
                  _loc6_.DeputyWeaponID = -1;
               }
               else
               {
                  _loc6_.DeputyWeaponID = int(_loc13_);
               }
               if(!isChangeStyleTemp(_loc6_.ID))
               {
                  _loc6_.Colors = _loc4_.readUTF();
                  _loc6_.Skin = _loc4_.readUTF();
               }
               else
               {
                  _loc4_.readUTF();
                  _loc4_.readUTF();
               }
               _loc6_.IsShowConsortia = _loc4_.readBoolean();
               _loc6_.ConsortiaID = _loc4_.readInt();
               _loc6_.ConsortiaName = _loc4_.readUTF();
               _loc6_.badgeID = _loc4_.readInt();
               _loc14_ = _loc4_.readInt();
               _loc8_ = _loc4_.readInt();
               _loc6_.Nimbus = _loc4_.readInt();
               _loc6_.PvePermission = _loc4_.readUTF();
               _loc6_.fightLibMission = _loc4_.readUTF();
               _loc6_.FightPower = _loc4_.readInt();
               if(_loc6_.isSelf)
               {
                  _fightPower = _loc6_.FightPower;
                  if(PowerUpMovieManager.isCanPlayMovie && StateManager.currentStateType != "fighting" && StateManager.currentStateType != "fighting3d")
                  {
                     if(_loc6_.FightPower < PowerUpMovieManager.powerNum)
                     {
                        if(!_timer2.hasEventListener("timer"))
                        {
                           _timer2.addEventListener("timer",__onTimer2Handler);
                           _timer2.start();
                        }
                     }
                     if(_loc6_.FightPower > PowerUpMovieManager.powerNum)
                     {
                        if(!_timer1.hasEventListener("timer"))
                        {
                           _timer1.addEventListener("timer",__onTimer1Handler);
                           _timer1.start();
                        }
                     }
                  }
               }
               _loc6_.apprenticeshipState = _loc4_.readInt();
               _loc6_.masterID = _loc4_.readInt();
               _loc6_.setMasterOrApprentices(_loc4_.readUTF());
               _loc6_.graduatesCount = _loc4_.readInt();
               _loc6_.honourOfMaster = _loc4_.readUTF();
               _loc6_.AchievementPoint = _loc4_.readInt();
               _loc6_.honor = _loc4_.readUTF();
               _loc6_.honorId = _loc4_.readInt();
               _loc6_.LastSpaDate = _loc4_.readDate();
               _loc6_.charmGP = _loc4_.readInt();
               _loc9_ = _loc4_.readInt();
               _loc6_.shopFinallyGottenTime = _loc4_.readDate();
               _loc6_.UseOffer = _loc4_.readInt();
               _loc6_.matchInfo.dailyScore = _loc4_.readInt();
               _loc6_.matchInfo.dailyWinCount = _loc4_.readInt();
               _loc6_.matchInfo.dailyGameCount = _loc4_.readInt();
               _loc6_.matchInfo.weeklyScore = _loc4_.readInt();
               _loc6_.matchInfo.weeklyGameCount = _loc4_.readInt();
               _loc6_.leagueMoney = _loc4_.readInt();
               _loc6_.spdTexpExp = _loc4_.readInt();
               _loc6_.attTexpExp = _loc4_.readInt();
               _loc6_.defTexpExp = _loc4_.readInt();
               _loc6_.hpTexpExp = _loc4_.readInt();
               _loc6_.lukTexpExp = _loc4_.readInt();
               _loc6_.magicAtkTexpExp = _loc4_.readInt();
               _loc6_.magicDefTexpExp = _loc4_.readInt();
               _loc6_.texpTaskCount = _loc4_.readInt();
               _loc6_.texpCount = _loc4_.readInt();
               _loc6_.magicTexpCount = _loc4_.readInt();
               _loc6_.texpTaskDate = _loc4_.readDate();
               _loc5_ = _loc4_.readInt();
               _loc3_ = 0;
               while(_loc3_ < _loc5_)
               {
                  _loc7_ = _loc4_.readInt();
                  _loc10_ = _loc4_.readByte();
                  _loc6_.dungeonFlag[_loc7_] = _loc10_;
                  _loc3_++;
               }
               _loc6_.PveEpicPermission = _loc4_.readUTF();
               _loc2_ = _loc4_.readInt();
               _loc6_.evolutionGrade = _loc2_;
               _loc6_.evolutionExp = _loc4_.readInt();
               _loc6_.desertEnterCount = _loc4_.readInt();
               _loc6_.BattleCount = _loc4_.readInt();
               _loc6_.VipIntegral = _loc4_.readInt();
               _loc6_.RingExp = _loc4_.readInt();
               _loc6_.guardCoreID = _loc4_.readInt();
               _loc6_.guardCoreGrade = _loc4_.readInt();
               _loc6_.teamID = _loc4_.readInt();
               _loc6_.teamName = _loc4_.readUTF();
               _loc6_.teamTag = _loc4_.readUTF();
               _loc6_.teamGrade = _loc4_.readInt();
               _loc6_.teamWinTime = _loc4_.readInt();
               _loc6_.teamTotalTime = _loc4_.readInt();
               _loc6_.teamDivision = _loc4_.readInt();
               _loc6_.teamScore = _loc4_.readInt();
               _loc6_.teamDuty = _loc4_.readInt();
               _loc6_.teamPersonalScore = _loc4_.readInt();
            }
            catch(_loc16_:*)
            {
               _loc15_ = 1;
            }
            _loc6_.commitChanges();
            if(int(_loc15_))
            {
               throw _loc16_;
            }
         }
      }
      
      protected function __onTimer1Handler(param1:Event) : void
      {
         _timer1.stop();
         _timer1.removeEventListener("timer",__onTimer1Handler);
         PowerUpMovieManager.addedPowerNum = _fightPower - PowerUpMovieManager.powerNum;
         if(BagAndInfoManager.Instance.getBagAndGiftFrame() && (BagAndInfoManager.Instance.getBagAndGiftFrame().btnGroup.selectIndex == 0 || BagAndInfoManager.Instance.getBagAndGiftFrame().btnGroup.selectIndex == 6 || BagAndInfoManager.Instance.getBagAndGiftFrame().btnGroup.selectIndex == 8) || BagStore.instance.isInBagStoreFrame)
         {
            PowerUpMovieManager.powerNum = _fightPower;
         }
         else
         {
            PowerUpMovieManager.Instance.dispatchEvent(new Event("powerUp"));
         }
      }
      
      protected function __onTimer2Handler(param1:Event) : void
      {
         _timer2.stop();
         _timer2.removeEventListener("timer",__onTimer2Handler);
         PowerUpMovieManager.powerNum = _fightPower;
      }
      
      public function getDeputyWeaponIcon(param1:InventoryItemInfo, param2:int = 0) : DisplayObject
      {
         var _loc3_:* = null;
         if(param1)
         {
            _loc3_ = new BagCell(param1.Place,param1);
            if(param2 == 0)
            {
               return _loc3_.getContent();
            }
            if(param2 == 1)
            {
               return _loc3_.getSmallContent();
            }
         }
         return null;
      }
      
      private function __dailyAwardHandler(param1:PkgEvent) : void
      {
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc2_:int = param1.pkg.readInt();
         if(_loc2_ == 0)
         {
            CalendarManager.getInstance().dailyAwardState = _loc3_;
            MainButtnController.instance.DailyAwardState = _loc3_;
         }
         else if(_loc2_ != 1)
         {
            if(_loc2_ != 2)
            {
               if(_loc2_ == 6)
               {
                  CalendarManager.getInstance().times = param1.pkg.readInt();
               }
            }
         }
      }
      
      public function get checkEnterDungeon() : Boolean
      {
         if(Instance.Self.Grade < GameManager.MinLevelDuplicate)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.gradeLow",GameManager.MinLevelDuplicate));
            return false;
         }
         return true;
      }
      
      public function __checkCodePopup(param1:PkgEvent) : void
      {
         e = param1;
         readComplete = function(param1:Event):void
         {
            checkCodeData.pic = bitmapReader.bitmap;
            CheckCodeFrame.Instance.data = checkCodeData;
         };
         var checkCodeState:int = e.pkg.readByte();
         var backType:Boolean = e.pkg.readBoolean();
         if(checkCodeState == 1)
         {
            SoundManager.instance.play("058");
         }
         else if(checkCodeState == 2)
         {
            SoundManager.instance.play("057");
         }
         if(backType)
         {
            var type:int = e.pkg.readByte();
            if(type == 1)
            {
               CheckCodeFrame.Instance.time = 11;
            }
            else
            {
               CheckCodeFrame.Instance.time = 20;
            }
            var msg:String = e.pkg.readUTF();
            CheckCodeFrame.Instance.tip = msg;
            var checkCodeData:CheckCodeData = new CheckCodeData();
            var ba:ByteArray = new ByteArray();
            e.pkg.readBytes(ba,0,e.pkg.bytesAvailable);
            var bitmapReader:BitmapReader = new BitmapReader();
            bitmapReader.addEventListener("complete",readComplete);
            bitmapReader.readByteArray(ba);
            CheckCodeFrame.Instance.isShowed = false;
            CheckCodeFrame.Instance.show();
            return;
         }
         CheckCodeFrame.Instance.close();
      }
      
      private function __buffObtain(param1:CrazyTankSocketEvent) : void
      {
         var _loc12_:int = 0;
         var _loc11_:int = 0;
         var _loc3_:Boolean = false;
         var _loc7_:* = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc10_:* = null;
         var _loc9_:PackageIn = param1.pkg;
         if(_loc9_.clientId != _self.ID)
         {
            return;
         }
         _self.clearBuff();
         var _loc2_:int = _loc9_.readInt();
         _loc12_ = 0;
         while(_loc12_ < _loc2_)
         {
            _loc11_ = _loc9_.readInt();
            _loc3_ = _loc9_.readBoolean();
            _loc7_ = _loc9_.readDate();
            _loc4_ = _loc9_.readInt();
            _loc6_ = _loc9_.readInt();
            _loc5_ = _loc9_.readInt();
            _loc8_ = _loc9_.readInt();
            _loc10_ = new BuffInfo(_loc11_,_loc3_,_loc7_,_loc4_,_loc6_,_loc5_,_loc8_);
            _self.addBuff(_loc10_);
            _loc12_++;
         }
         param1.stopImmediatePropagation();
      }
      
      private function __buffUpdate(param1:CrazyTankSocketEvent) : void
      {
         var _loc12_:* = 0;
         var _loc11_:int = 0;
         var _loc2_:Boolean = false;
         var _loc6_:* = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:* = null;
         var _loc8_:PackageIn = param1.pkg;
         if(_loc8_.clientId != _self.ID)
         {
            return;
         }
         var _loc10_:int = _loc8_.readInt();
         _loc12_ = uint(0);
         while(_loc12_ < _loc10_)
         {
            _loc11_ = _loc8_.readInt();
            _loc2_ = _loc8_.readBoolean();
            _loc6_ = _loc8_.readDate();
            _loc3_ = _loc8_.readInt();
            _loc5_ = _loc8_.readInt();
            _loc4_ = _loc8_.readInt();
            _loc7_ = _loc8_.readInt();
            _loc9_ = new BuffInfo(_loc11_,_loc2_,_loc6_,_loc3_,_loc5_,_loc4_,_loc7_);
            if(_loc11_ == 51)
            {
               _loc9_.additionCount = KingBlessManager.instance.getOneBuffData(4);
            }
            if(_loc2_)
            {
               _self.addBuff(_loc9_);
            }
            else
            {
               _self.buffInfo.remove(_loc9_.Type);
            }
            _loc12_++;
         }
         param1.stopImmediatePropagation();
      }
      
      public function findPlayerByNickName(param1:PlayerInfo, param2:String) : PlayerInfo
      {
         if(param2)
         {
            if(_tempList[_self.ZoneID] == null)
            {
               _tempList[_self.ZoneID] = new DictionaryData();
            }
            if(_self.NickName == param2)
            {
               return _self;
            }
            var _loc6_:int = 0;
            var _loc5_:* = _friendList[_self.ZoneID];
            for each(var _loc4_ in _friendList[_self.ZoneID])
            {
               if(_loc4_.NickName == param2)
               {
                  return _loc4_;
               }
            }
            if(_tempList[_self.ZoneID][param2] != null)
            {
               return _tempList[_self.ZoneID][param2] as PlayerInfo;
            }
            var _loc8_:int = 0;
            var _loc7_:* = _tempList[_self.ZoneID];
            for each(var _loc3_ in _tempList[_self.ZoneID])
            {
               if(_loc3_.NickName == param2)
               {
                  return _loc3_;
               }
            }
            param1.NickName = param2;
            _tempList[_self.ZoneID][param2] = param1;
            return param1;
         }
         return param1;
      }
      
      public function findPlayer(param1:int, param2:int = -1, param3:String = "") : PlayerInfo
      {
         var _loc4_:* = null;
         var _loc6_:* = null;
         if(param2 == -1 || param2 == _self.ZoneID)
         {
            if(_friendList[_self.ZoneID] == null)
            {
               _friendList[_self.ZoneID] = new DictionaryData();
            }
            if(_clubPlays[_self.ZoneID] == null)
            {
               _clubPlays[_self.ZoneID] = new DictionaryData();
            }
            if(_tempList[_self.ZoneID] == null)
            {
               _tempList[_self.ZoneID] = new DictionaryData();
            }
            if(_myAcademyPlayers == null)
            {
               _myAcademyPlayers = new DictionaryData();
            }
            if(param1 == _self.ID && (param2 == -1 || param2 == _self.ZoneID))
            {
               return _self;
            }
            if(_friendList[_self.ZoneID][param1])
            {
               return _friendList[_self.ZoneID][param1];
            }
            if(_clubPlays[_self.ZoneID][param1])
            {
               return _clubPlays[_self.ZoneID][param1];
            }
            if(_tempList[_self.ZoneID][param3])
            {
               return _tempList[_self.ZoneID][param3];
            }
            if(_myAcademyPlayers[param1])
            {
               return _myAcademyPlayers[param1];
            }
            if(_tempList[_self.ZoneID][param1])
            {
               if(_tempList[_self.ZoneID][_tempList[_self.ZoneID][param1].NickName])
               {
                  return _tempList[_self.ZoneID][_tempList[_self.ZoneID][param1].NickName];
               }
               return _tempList[_self.ZoneID][param1];
            }
            var _loc8_:int = 0;
            var _loc7_:* = _tempList[_self.ZoneID];
            for each(var _loc5_ in _tempList[_self.ZoneID])
            {
               if(_loc5_.ID == param1)
               {
                  _tempList[_self.ZoneID][param1] = _loc5_;
                  return _loc5_;
               }
            }
            _loc4_ = new PlayerInfo();
            _loc4_.ID = param1;
            _loc4_.ZoneID = _self.ZoneID;
            _tempList[_self.ZoneID][param1] = _loc4_;
            return _loc4_;
         }
         if(param1 == _self.ID && (param2 == _self.ZoneID || _self.ZoneID == 0))
         {
            return _self;
         }
         if(_friendList[param2] && _friendList[param2][param1])
         {
            return _friendList[param2][param1];
         }
         if(_clubPlays[param2] && _clubPlays[param2][param1])
         {
            return _clubPlays[param2][param1];
         }
         if(_tempList[param2] && _tempList[param2][param1])
         {
            return _tempList[param2][param1];
         }
         _loc6_ = new PlayerInfo();
         _loc6_.ID = param1;
         _loc6_.ZoneID = param2;
         if(_tempList[param2] == null)
         {
            _tempList[param2] = new DictionaryData();
         }
         _tempList[param2][param1] = _loc6_;
         return _loc6_;
      }
      
      public function hasInMailTempList(param1:int) : Boolean
      {
         if(_mailTempList[_self.ZoneID] == null)
         {
            _mailTempList[_self.ZoneID] = new DictionaryData();
         }
         if(_mailTempList[_self.ZoneID][param1])
         {
            return true;
         }
         return false;
      }
      
      public function set mailTempList(param1:DictionaryData) : void
      {
         if(_mailTempList == null)
         {
            _mailTempList = new DictionaryData();
         }
         if(_mailTempList[_self.ZoneID] == null)
         {
            _mailTempList[_self.ZoneID] = new DictionaryData();
         }
         _mailTempList[_self.ZoneID] = param1;
      }
      
      public function hasInFriendList(param1:int) : Boolean
      {
         if(_friendList[_self.ZoneID] == null)
         {
            _friendList[_self.ZoneID] = new DictionaryData();
         }
         if(_friendList[_self.ZoneID][param1])
         {
            return true;
         }
         return false;
      }
      
      public function hasInClubPlays(param1:int) : Boolean
      {
         if(_clubPlays[_self.ZoneID] == null)
         {
            _clubPlays[_self.ZoneID] = new DictionaryData();
         }
         if(_clubPlays[_self.ZoneID][param1])
         {
            return true;
         }
         return false;
      }
      
      private function __selfPopChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["TotalCount"])
         {
            switch(int(PlayerManager.Instance.Self.TotalCount) - 1)
            {
               case 0:
                  StatisticManager.Instance().startAction("gameOver1","yes");
                  break;
               default:
                  StatisticManager.Instance().startAction("gameOver1","yes");
                  break;
               case 2:
                  StatisticManager.Instance().startAction("gameOver3","yes");
                  break;
               default:
                  StatisticManager.Instance().startAction("gameOver3","yes");
                  break;
               case 4:
                  StatisticManager.Instance().startAction("gameOver5","yes");
                  break;
               default:
                  StatisticManager.Instance().startAction("gameOver5","yes");
                  break;
               default:
                  StatisticManager.Instance().startAction("gameOver5","yes");
                  break;
               default:
                  StatisticManager.Instance().startAction("gameOver5","yes");
                  break;
               default:
                  StatisticManager.Instance().startAction("gameOver5","yes");
                  break;
               case 9:
                  StatisticManager.Instance().startAction("gameOver10","yes");
            }
         }
         if(param1.changedProperties["Grade"])
         {
            if(isReportGameProfile && PathManager.isDuoWanSDKInterface)
            {
               reportGameProfile();
            }
            TaskManager.instance.requestCanAcceptTask();
         }
      }
      
      private function reportGameProfile() : void
      {
         var _loc9_:String = Account.Account;
         var _loc4_:int = 0;
         var _loc8_:String = "DDT";
         var _loc7_:String = PathManager.solveFillPage();
         var _loc3_:String = "";
         if(_loc7_.indexOf("quest") != -1)
         {
            _loc3_ = "s" + _loc7_.slice(_loc7_.indexOf("quest") + 5);
         }
         var _loc6_:String = Self.NickName;
         var _loc5_:int = Self.Grade;
         var _loc2_:String = "level_change";
         var _loc1_:GameProfileParams = null;
         GameMsgCollector.instance.reportGameProfile(_loc9_,_loc4_,_loc8_,_loc3_,_loc6_,_loc5_,_loc2_,_loc1_);
      }
      
      private function __updatePet(param1:PkgEvent) : void
      {
         var _loc22_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Boolean = false;
         var _loc18_:int = 0;
         var _loc9_:int = 0;
         var _loc27_:* = null;
         var _loc10_:int = 0;
         var _loc21_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc20_:int = 0;
         var _loc26_:int = 0;
         var _loc13_:int = 0;
         var _loc16_:Boolean = false;
         var _loc6_:int = 0;
         var _loc14_:int = 0;
         var _loc24_:* = null;
         var _loc5_:* = null;
         var _loc25_:* = null;
         var _loc15_:* = null;
         var _loc17_:PackageIn = param1.pkg;
         var _loc19_:int = _loc17_.readInt();
         var _loc23_:int = _loc17_.readInt();
         var _loc7_:PlayerInfo = findPlayer(_loc19_,_loc23_);
         _loc7_.ID = _loc19_;
         var _loc2_:int = _loc17_.readInt();
         _loc22_ = 0;
         while(_loc22_ < _loc2_)
         {
            _loc11_ = _loc17_.readInt();
            _loc12_ = _loc17_.readBoolean();
            if(_loc12_)
            {
               _loc18_ = _loc17_.readInt();
               _loc9_ = _loc17_.readInt();
               _loc27_ = new PetInfo();
               _loc27_.TemplateID = _loc9_;
               _loc27_.ID = _loc18_;
               PetInfoManager.fillPetInfo(_loc27_);
               _loc27_.Name = _loc17_.readUTF();
               _loc27_.UserID = _loc17_.readInt();
               _loc27_.Attack = _loc17_.readInt();
               _loc27_.Defence = _loc17_.readInt();
               _loc27_.Luck = _loc17_.readInt();
               _loc27_.Agility = _loc17_.readInt();
               _loc27_.Blood = _loc17_.readInt();
               _loc27_.Damage = _loc17_.readInt();
               _loc27_.Guard = _loc17_.readInt();
               _loc27_.AttackGrow = _loc17_.readInt();
               _loc27_.DefenceGrow = _loc17_.readInt();
               _loc27_.LuckGrow = _loc17_.readInt();
               _loc27_.AgilityGrow = _loc17_.readInt();
               _loc27_.BloodGrow = _loc17_.readInt();
               _loc27_.DamageGrow = _loc17_.readInt();
               _loc27_.GuardGrow = _loc17_.readInt();
               _loc27_.Level = _loc17_.readInt();
               _loc27_.GP = _loc17_.readInt();
               _loc27_.MaxGP = _loc17_.readInt();
               _loc27_.Hunger = _loc17_.readInt();
               _loc27_.breakGrade = _loc17_.readInt();
               _loc27_.breakBlood = _loc17_.readUnsignedInt();
               _loc27_.breakAttack = _loc17_.readUnsignedInt();
               _loc27_.breakDefence = _loc17_.readUnsignedInt();
               _loc27_.breakAgility = _loc17_.readUnsignedInt();
               _loc27_.breakLuck = _loc17_.readUnsignedInt();
               _loc27_.PetHappyStar = _loc17_.readInt();
               _loc27_.MP = _loc17_.readInt();
               _loc27_.clearSkills();
               _loc27_.clearEquipedSkills();
               _loc10_ = _loc17_.readInt();
               _loc21_ = 0;
               while(_loc21_ < _loc10_)
               {
                  _loc3_ = _loc17_.readInt();
                  _loc4_ = new PetSkill(_loc3_);
                  _loc4_.exclusiveID = _loc17_.readInt();
                  _loc27_.addSkill(_loc4_);
                  _loc21_++;
               }
               _loc8_ = _loc17_.readInt();
               _loc20_ = 0;
               while(_loc20_ < _loc8_)
               {
                  _loc26_ = _loc17_.readInt();
                  _loc13_ = _loc17_.readInt();
                  _loc27_.equipdSkills.add(_loc26_,_loc13_);
                  _loc20_++;
               }
               _loc16_ = _loc17_.readBoolean();
               _loc27_.IsEquip = _loc16_;
               _loc27_.Place = _loc11_;
               _loc6_ = _loc17_.readInt();
               _loc14_ = 0;
               while(_loc14_ < _loc6_)
               {
                  _loc24_ = new PetEquipData();
                  _loc24_.eqType = _loc17_.readInt();
                  _loc24_.eqTemplateID = _loc17_.readInt();
                  _loc24_.startTime = _loc17_.readDateString();
                  _loc24_.ValidDate = _loc17_.readInt();
                  _loc5_ = new InventoryItemInfo();
                  _loc5_.TemplateID = _loc24_.eqTemplateID;
                  _loc5_.ValidDate = _loc24_.ValidDate;
                  _loc5_.BeginDate = _loc24_.startTime;
                  _loc5_.IsBinds = true;
                  _loc5_.IsUsed = true;
                  _loc5_.Place = _loc24_.eqType;
                  _loc5_.AttackCompose = _loc17_.readInt();
                  _loc5_.DefendCompose = _loc17_.readInt();
                  _loc5_.AgilityCompose = _loc17_.readInt();
                  _loc5_.LuckCompose = _loc17_.readInt();
                  _loc5_.ItemID = _loc17_.readInt();
                  _loc25_ = ItemManager.fill(_loc5_) as InventoryItemInfo;
                  if(_loc27_.equipList[_loc25_.Place])
                  {
                     _loc15_ = _loc27_.equipList[_loc25_.Place];
                     _loc25_.awakenEquipPro = _loc15_.awakenEquipPro;
                  }
                  _loc27_.equipList.add(_loc25_.Place,_loc25_);
                  _loc14_++;
               }
               _loc27_.currentStarExp = _loc17_.readInt();
               _loc7_.pets.add(_loc27_.Place,_loc27_);
            }
            else
            {
               _loc7_.pets.remove(_loc11_);
            }
            _loc7_.commitChanges();
            _loc22_++;
         }
         _loc7_.petsEatWeaponLevel = _loc17_.readInt();
         _loc7_.petsEatClothesLevel = _loc17_.readInt();
         _loc7_.petsEatHatLevel = _loc17_.readInt();
         dispatchEvent(new CEvent("updatePet"));
      }
      
      private function __updateOneKeyFinish(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _self.uesedFinishTime = _loc2_.readInt();
      }
      
      public function get isReportGameProfile() : Boolean
      {
         return _isReportGameProfile;
      }
      
      public function set isReportGameProfile(param1:Boolean) : void
      {
         _isReportGameProfile = param1;
      }
   }
}
