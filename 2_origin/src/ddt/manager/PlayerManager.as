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
      
      public static function readLuckyPropertyName(id:int) : String
      {
         switch(int(id) - 1)
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
      
      public function set curcentId(value:int) : void
      {
         _curcentId = value;
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
      
      public function setup(acc:AccountInfo) : void
      {
         _account = acc;
         customList = new Vector.<CustomInfo>();
         _friendList = new DictionaryData();
         _blackList = new DictionaryData();
         initEvents();
      }
      
      public function get Account() : AccountInfo
      {
         return _account;
      }
      
      public function getDressEquipPlace(info:InventoryItemInfo) : int
      {
         var toPlace:int = 0;
         var j:int = 0;
         var i:int = 0;
         if(EquipType.isWeddingRing(info) && Self.Bag.getItemAt(16) == null)
         {
            return 16;
         }
         var toPlaces:Array = EquipType.CategeryIdToPlace(info.CategoryID,info.Place);
         if(toPlaces.length == 1)
         {
            toPlace = toPlaces[0];
         }
         else
         {
            j = 0;
            for(i = 0; i < toPlaces.length; )
            {
               if(PlayerManager.Instance.Self.Bag.getItemAt(toPlaces[i]) == null)
               {
                  toPlace = toPlaces[i];
                  break;
               }
               j++;
               if(j == toPlaces.length)
               {
                  toPlace = toPlaces[0];
               }
               i++;
            }
         }
         return toPlace;
      }
      
      private function __updateInventorySlot(evt:PkgEvent) : void
      {
         var i:int = 0;
         var slot:int = 0;
         var isUpdate:Boolean = false;
         var item:* = null;
         var date:* = null;
         var sign:Boolean = false;
         var pkg:PackageIn = evt.pkg as PackageIn;
         var bagType:int = pkg.readInt();
         var len:int = pkg.readInt();
         var bag:BagInfo = _self.getBag(bagType);
         if(bagType == 21)
         {
            sign = true;
         }
         bag.beginChanges();
         var _loc12_:int = 0;
         try
         {
            for(i = 0; i < len; )
            {
               slot = pkg.readInt();
               isUpdate = pkg.readBoolean();
               if(isUpdate)
               {
                  item = bag.getItemAt(slot);
                  if(item == null)
                  {
                     item = new InventoryItemInfo();
                     item.Place = slot;
                  }
                  item.UserID = pkg.readInt();
                  item.ItemID = pkg.readInt();
                  item.Count = pkg.readInt();
                  item.Place = pkg.readInt();
                  item.TemplateID = pkg.readInt();
                  item.AttackCompose = pkg.readInt();
                  item.DefendCompose = pkg.readInt();
                  item.AgilityCompose = pkg.readInt();
                  item.LuckCompose = pkg.readInt();
                  item.StrengthenLevel = pkg.readInt();
                  item.StrengthenExp = pkg.readInt();
                  item.IsBinds = pkg.readBoolean();
                  item.IsJudge = pkg.readBoolean();
                  item.BeginDate = pkg.readDateString();
                  item.ValidDate = pkg.readInt();
                  item.Color = pkg.readUTF();
                  item.Skin = pkg.readUTF();
                  item.IsUsed = pkg.readBoolean();
                  item.Hole1 = pkg.readInt();
                  item.Hole2 = pkg.readInt();
                  item.Hole3 = pkg.readInt();
                  item.Hole4 = pkg.readInt();
                  item.Hole5 = pkg.readInt();
                  item.Hole6 = pkg.readInt();
                  ItemManager.fill(item);
                  item.Pic = pkg.readUTF();
                  item.RefineryLevel = pkg.readInt();
                  item.DiscolorValidDate = pkg.readDateString();
                  item.StrengthenTimes = pkg.readInt();
                  item.Hole5Level = pkg.readByte();
                  item.Hole5Exp = pkg.readInt();
                  item.Hole6Level = pkg.readByte();
                  item.Hole6Exp = pkg.readInt();
                  item.curExp = pkg.readInt();
                  item.cellLocked = pkg.readBoolean();
                  item.isGold = pkg.readBoolean();
                  if(item.isGold)
                  {
                     item.goldValidDate = pkg.readInt();
                     item.goldBeginTime = pkg.readDateString();
                  }
                  item.latentEnergyCurStr = pkg.readUTF();
                  item.latentEnergyNewStr = pkg.readUTF();
                  item.latentEnergyEndTime = pkg.readDate();
                  date = new Date();
                  date.time;
                  if(EquipType.isMagicStone(item.CategoryID))
                  {
                     item.Level = item.StrengthenLevel;
                     item.Attack = item.AttackCompose;
                     item.Defence = item.DefendCompose;
                     item.Agility = item.AgilityCompose;
                     item.Luck = item.LuckCompose;
                     item.MagicAttack = pkg.readInt();
                     item.MagicDefence = pkg.readInt();
                  }
                  else
                  {
                     pkg.readInt();
                     pkg.readInt();
                  }
                  item.goodsLock = pkg.readBoolean();
                  item.MagicExp = pkg.readInt();
                  item.MagicLevel = pkg.readInt();
                  if(EquipType.isWeddingRing(item))
                  {
                     item.RingExp = _self.RingExp;
                  }
                  if(int(PlayerManager._instance.Self.Grade) >= 10 && !item.IsUsed && bagType == 0 && !BagAndInfoManager.Instance.isInBagAndInfoView && SystemOpenPromptManager.instance.isShowNewEuipTip && !BagStore.instance.isInBagStoreFrame && _playerEquipCategaryIdArr.indexOf(item.CategoryID) != -1 && int(PlayerManager._instance.Self.Grade) >= int(item.Property1))
                  {
                     showTipWithEquip(item);
                  }
                  bag.addItem(item);
                  if(item.Place == 15 && bagType == 0 && item.UserID == Self.ID)
                  {
                     _self.DeputyWeaponID = item.TemplateID;
                  }
                  if(PathManager.solveExternalInterfaceEnabel() && bagType == 12 && item.StrengthenLevel >= 7)
                  {
                     ExternalInterfaceManager.sendToAgent(3,Self.ID,Self.NickName,ServerManager.Instance.zoneName,item.StrengthenLevel);
                  }
                  trace(bagType + "全部：",item.Name,item.latentEnergyEndTime.fullYear,item.latentEnergyEndTime.month,item.latentEnergyEndTime.date);
               }
               else
               {
                  bag.removeItemAt(slot);
               }
               i++;
            }
         }
         catch(_loc13_:*)
         {
            _loc12_ = 1;
         }
         bag.commiteChanges();
         if(!int(_loc12_))
         {
            if(sign)
            {
               dispatchEvent(new BeadEvent("equip",0));
            }
            BuriedManager.Instance.dispatchEvent(new BuriedEvent("buried_UpDate_Stone_Count"));
            if(bagType == 0)
            {
               dispatchEvent(new Event("bag_update"));
            }
            else if(bagType == 1)
            {
               dispatchEvent(new Event("propbag_update"));
            }
            dispatchEvent(new CEvent("bring_up"));
            return;
         }
         throw _loc13_;
      }
      
      public function getPlaceOfEquip(item:InventoryItemInfo) : int
      {
         var placeArr:* = null;
         if(EquipType.isWeddingRing(item))
         {
            placeArr = [16];
         }
         else
         {
            placeArr = EquipType.CategeryIdToPlace(item.CategoryID);
         }
         var arr:Array = _self.Bag.findIsEquipedByPlace(placeArr);
         if(arr.length > 0)
         {
            return arr[0];
         }
         return -1;
      }
      
      private function showTipWithEquip(item:InventoryItemInfo) : void
      {
         var placeArr:* = null;
         if(EquipType.isWeddingRing(item))
         {
            placeArr = [16];
         }
         else
         {
            placeArr = EquipType.CategeryIdToPlace(item.CategoryID);
         }
         var arr:Array = _self.Bag.findIsEquipedByPlace(placeArr);
         if(arr.length > 0)
         {
            SystemOpenPromptManager.instance.showEquipTipFrame(item);
         }
      }
      
      private function __itemEquip(evt:PkgEvent) : void
      {
         var _itemNum:int = 0;
         var i:* = 0;
         var item:* = null;
         var beadCount:int = 0;
         var m:* = 0;
         var bead:* = null;
         var count:int = 0;
         var j:int = 0;
         var gemstoneInfo:* = null;
         var str:* = null;
         var arr:* = null;
         var list:* = undefined;
         var t_i:int = 0;
         var gems1:* = null;
         var ginfo:* = null;
         var k:int = 0;
         var tmp:* = null;
         var equip:* = null;
         var horseIndex:int = 0;
         var size:int = 0;
         var equipGhost:* = null;
         var bagType:int = 0;
         var place:int = 0;
         var idx:int = 0;
         var bag:* = null;
         var chipCount:int = 0;
         var cot:int = 0;
         var chip:* = null;
         var mainPro:* = null;
         var cCot:int = 0;
         var subPro:* = null;
         var totemGradeLen:int = 0;
         var index:int = 0;
         var pkg:PackageIn = evt.pkg;
         pkg.deCompress();
         var _id:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var nickName:String = pkg.readUTF();
         var info:PlayerInfo = findPlayer(_id,zoneId,nickName);
         info.ID = _id;
         if(info != null)
         {
            info.beginChanges();
            info.Agility = pkg.readInt();
            info.Attack = pkg.readInt();
            if(!PlayerManager.Instance.isChangeStyleTemp(_id))
            {
               info.Colors = pkg.readUTF();
               info.Skin = pkg.readUTF();
            }
            else
            {
               pkg.readUTF();
               pkg.readUTF();
               info.Colors = changedStyle[_id]["Colors"];
               info.Skin = changedStyle[_id]["Skin"];
            }
            info.Defence = pkg.readInt();
            info.GP = pkg.readInt();
            info.Grade = pkg.readInt();
            info.ddtKingGrade = pkg.readInt();
            info.Luck = pkg.readInt();
            info.hp = pkg.readInt();
            if(!PlayerManager.Instance.isChangeStyleTemp(_id))
            {
               info.Hide = pkg.readInt();
            }
            else
            {
               pkg.readInt();
               info.Hide = changedStyle[_id]["Hide"];
            }
            info.Repute = pkg.readInt();
            if(!PlayerManager.Instance.isChangeStyleTemp(_id))
            {
               info.Sex = pkg.readBoolean();
               info.Style = pkg.readUTF();
            }
            else
            {
               pkg.readBoolean();
               pkg.readUTF();
               info.Sex = changedStyle[_id]["Sex"];
               info.Style = changedStyle[_id]["Style"];
            }
            info.Offer = pkg.readInt();
            info.NickName = nickName;
            info.typeVIP = pkg.readByte();
            info.VIPLevel = pkg.readInt();
            info.isOpenKingBless = pkg.readBoolean();
            info.WinCount = pkg.readInt();
            info.TotalCount = pkg.readInt();
            info.EscapeCount = pkg.readInt();
            info.ConsortiaID = pkg.readInt();
            info.ConsortiaName = pkg.readUTF();
            info.badgeID = pkg.readInt();
            info.RichesOffer = pkg.readInt();
            info.RichesRob = pkg.readInt();
            info.IsMarried = pkg.readBoolean();
            info.SpouseID = pkg.readInt();
            info.SpouseName = pkg.readUTF();
            info.DutyName = pkg.readUTF();
            info.Nimbus = pkg.readInt();
            info.FightPower = pkg.readInt();
            info.apprenticeshipState = pkg.readInt();
            info.masterID = pkg.readInt();
            info.setMasterOrApprentices(pkg.readUTF());
            info.graduatesCount = pkg.readInt();
            info.honourOfMaster = pkg.readUTF();
            info.AchievementPoint = pkg.readInt();
            info.honor = pkg.readUTF();
            info.LastLoginDate = pkg.readDate();
            info.spdTexpExp = pkg.readInt();
            info.attTexpExp = pkg.readInt();
            info.defTexpExp = pkg.readInt();
            info.hpTexpExp = pkg.readInt();
            info.lukTexpExp = pkg.readInt();
            info.magicAtkTexpExp = pkg.readInt();
            info.magicDefTexpExp = pkg.readInt();
            info.DailyLeagueFirst = pkg.readBoolean();
            info.DailyLeagueLastScore = pkg.readInt();
            info.totemId = pkg.readInt();
            info.necklaceExp = pkg.readInt();
            info.isAttest = pkg.readBoolean();
            info.curHorseLevel = pkg.readInt();
            info.RingExp = pkg.readInt();
            info.commitChanges();
            _itemNum = pkg.readInt();
            info.Bag.beginChanges();
            if(!(info is SelfInfo))
            {
               info.Bag.clearnAll();
            }
            for(i = uint(0); i < _itemNum; )
            {
               item = new InventoryItemInfo();
               item.BagType = pkg.readByte();
               item.UserID = pkg.readInt();
               item.ItemID = pkg.readInt();
               item.Count = pkg.readInt();
               item.Place = pkg.readInt();
               item.TemplateID = pkg.readInt();
               item.AttackCompose = pkg.readInt();
               item.DefendCompose = pkg.readInt();
               item.AgilityCompose = pkg.readInt();
               item.LuckCompose = pkg.readInt();
               item.StrengthenLevel = pkg.readInt();
               item.IsBinds = pkg.readBoolean();
               item.IsJudge = pkg.readBoolean();
               item.BeginDate = pkg.readDateString();
               item.ValidDate = pkg.readInt();
               item.Color = pkg.readUTF();
               item.Skin = pkg.readUTF();
               item.IsUsed = pkg.readBoolean();
               ItemManager.fill(item);
               item.Hole1 = pkg.readInt();
               item.Hole2 = pkg.readInt();
               item.Hole3 = pkg.readInt();
               item.Hole4 = pkg.readInt();
               item.Hole5 = pkg.readInt();
               item.Hole6 = pkg.readInt();
               item.Pic = pkg.readUTF();
               item.RefineryLevel = pkg.readInt();
               item.DiscolorValidDate = pkg.readDateString();
               item.Hole5Level = pkg.readByte();
               item.Hole5Exp = pkg.readInt();
               item.Hole6Level = pkg.readByte();
               item.Hole6Exp = pkg.readInt();
               item.curExp = pkg.readInt();
               item.isGold = pkg.readBoolean();
               if(item.isGold)
               {
                  item.goldValidDate = pkg.readInt();
                  item.goldBeginTime = pkg.readDateString();
               }
               item.latentEnergyCurStr = pkg.readUTF();
               item.latentEnergyNewStr = pkg.readUTF();
               item.latentEnergyEndTime = pkg.readDate();
               item.MagicLevel = pkg.readInt();
               if(EquipType.isWeddingRing(item))
               {
                  item.RingExp = info.RingExp;
               }
               if(item.Place == 18)
               {
               }
               info.Bag.addItem(item);
               i++;
            }
            beadCount = pkg.readInt();
            if(!(info is SelfInfo))
            {
               info.BeadBag.clearnAll();
            }
            info.BeadBag.beginChanges();
            for(m = uint(0); m < beadCount; )
            {
               bead = new InventoryItemInfo();
               bead.BagType = pkg.readByte();
               bead.UserID = pkg.readInt();
               bead.ItemID = pkg.readInt();
               bead.Count = pkg.readInt();
               bead.Place = pkg.readInt();
               bead.TemplateID = pkg.readInt();
               bead.AttackCompose = pkg.readInt();
               bead.DefendCompose = pkg.readInt();
               bead.AgilityCompose = pkg.readInt();
               bead.LuckCompose = pkg.readInt();
               bead.StrengthenLevel = pkg.readInt();
               bead.IsBinds = pkg.readBoolean();
               bead.IsJudge = pkg.readBoolean();
               bead.BeginDate = pkg.readDateString();
               bead.ValidDate = pkg.readInt();
               bead.Color = pkg.readUTF();
               bead.Skin = pkg.readUTF();
               bead.IsUsed = pkg.readBoolean();
               ItemManager.fill(bead);
               bead.Hole1 = pkg.readInt();
               bead.Hole2 = pkg.readInt();
               bead.Hole3 = pkg.readInt();
               bead.Hole4 = pkg.readInt();
               bead.Hole5 = pkg.readInt();
               bead.Hole6 = pkg.readInt();
               bead.Pic = pkg.readUTF();
               bead.RefineryLevel = pkg.readInt();
               bead.DiscolorValidDate = pkg.readDateString();
               bead.Hole5Level = pkg.readByte();
               bead.Hole5Exp = pkg.readInt();
               bead.Hole6Level = pkg.readByte();
               bead.Hole6Exp = pkg.readInt();
               bead.isGold = pkg.readBoolean();
               info.BeadBag.addItem(bead);
               m++;
            }
            count = pkg.readInt();
            gemstoneInfoList = new Vector.<GemstonInitInfo>();
            for(j = 0; j < count; )
            {
               gemstoneInfo = new GemstonInitInfo();
               gemstoneInfo.figSpiritId = pkg.readInt();
               str = pkg.readUTF();
               arr = rezArr(str);
               list = new Vector.<GemstListInfo>();
               for(t_i = 0; t_i < 3; )
               {
                  gems1 = arr[t_i].split(",");
                  ginfo = new GemstListInfo();
                  ginfo.fightSpiritId = gemstoneInfo.figSpiritId;
                  ginfo.level = gems1[0];
                  ginfo.exp = gems1[1];
                  ginfo.place = gems1[2];
                  list.push(ginfo);
                  t_i++;
               }
               gemstoneInfo.equipPlace = pkg.readInt();
               if(info.Bag.getItemAt(gemstoneInfo.equipPlace))
               {
                  info.Bag.getItemAt(gemstoneInfo.equipPlace).gemstoneList = list;
               }
               gemstoneInfo.list = list;
               gemstoneInfoList.push(gemstoneInfo);
               j++;
            }
            info.gemstoneList = gemstoneInfoList;
            info.evolutionGrade = pkg.readInt();
            info.evolutionExp = pkg.readInt();
            info.MagicAttack = pkg.readInt();
            info.MagicDefence = pkg.readInt();
            count = pkg.readInt();
            for(k = 0; k <= count - 1; )
            {
               tmp = new MagicStoneInfo();
               tmp.place = pkg.readInt();
               tmp.templateId = pkg.readInt();
               tmp.level = pkg.readInt();
               tmp.attack = pkg.readInt();
               tmp.defence = pkg.readInt();
               tmp.agility = pkg.readInt();
               tmp.luck = pkg.readInt();
               tmp.magicAttack = pkg.readInt();
               tmp.magicDefence = pkg.readInt();
               equip = info.Bag.getItemAt(tmp.place);
               if(equip)
               {
                  equip.magicStoneAttr = tmp;
               }
               k++;
            }
            info.MountsType = pkg.readInt();
            for(horseIndex = 0; horseIndex < 9; )
            {
               info.horseAmuletProperty[horseIndex] = pkg.readInt();
               horseIndex++;
            }
            info.horseAmuletHp = pkg.readInt();
            info.manualProInfo.manual_Level = pkg.readInt();
            info.manualProInfo.pro_Agile = pkg.readInt();
            info.manualProInfo.pro_Armor = pkg.readInt();
            info.manualProInfo.pro_Attack = pkg.readInt();
            info.manualProInfo.pro_Damage = pkg.readInt();
            info.manualProInfo.pro_Defense = pkg.readInt();
            info.manualProInfo.pro_HP = pkg.readInt();
            info.manualProInfo.pro_Lucky = pkg.readInt();
            info.manualProInfo.pro_MagicAttack = pkg.readInt();
            info.manualProInfo.pro_MagicResistance = pkg.readInt();
            info.manualProInfo.pro_Stamina = pkg.readInt();
            info.guardCoreGrade = pkg.readInt();
            info.guardCoreID = pkg.readInt();
            size = pkg.readInt();
            if(size > 0)
            {
               equipGhost = null;
               bagType = 0;
               place = 0;
               for(idx = 0; idx < size; )
               {
                  bagType = pkg.readInt();
                  place = pkg.readInt();
                  equipGhost = new EquipGhostData(bagType,place);
                  equipGhost.level = pkg.readInt();
                  equipGhost.totalGhost = pkg.readInt();
                  info.addGhostData(equipGhost);
                  idx++;
               }
            }
            info.teamID = pkg.readInt();
            info.teamName = pkg.readUTF();
            info.teamTag = pkg.readUTF();
            info.teamGrade = pkg.readInt();
            info.teamWinTime = pkg.readInt();
            info.teamTotalTime = pkg.readInt();
            info.teamDivision = pkg.readInt();
            info.teamScore = pkg.readInt();
            info.teamDuty = pkg.readInt();
            info.teamPersonalScore = pkg.readInt();
            bag = new MarkBagData();
            chipCount = pkg.readInt();
            for(cot = 0; cot < chipCount; )
            {
               chip = new MarkChipData();
               chip.itemID = pkg.readInt();
               chip.templateId = pkg.readInt();
               chip.position = pkg.readInt();
               chip.isExist = pkg.readBoolean();
               if(!chip.isExist)
               {
                  pkg.readBoolean();
               }
               else
               {
                  pkg.readBoolean();
                  chip.isbind = pkg.readBoolean();
                  chip.bornLv = pkg.readInt();
                  chip.hammerLv = pkg.readInt();
                  chip.hLv = pkg.readInt();
                  mainPro = new MarkProData();
                  mainPro.type = pkg.readInt();
                  mainPro.value = pkg.readInt();
                  mainPro.attachValue = pkg.readInt();
                  chip.mainPro = mainPro;
                  chip.props = new Vector.<MarkProData>();
                  for(cCot = 0; cCot < 4; )
                  {
                     subPro = new MarkProData();
                     subPro.type = pkg.readInt();
                     subPro.value = pkg.readInt();
                     subPro.attachValue = pkg.readInt();
                     subPro.hummerCount = pkg.readInt();
                     chip.props.push(subPro);
                     cCot++;
                  }
                  bag.chips[chip.itemID] = chip;
               }
               cot++;
            }
            info.Markbag = bag;
            totemGradeLen = pkg.readInt();
            for(index = 0; index < totemGradeLen; )
            {
               info.addTotemGrade(pkg.readInt(),pkg.readInt());
               index++;
            }
            info.Bag.commiteChanges();
            info.BeadBag.commiteChanges();
            info.commitChanges();
            dispatchEvent(new CEvent("playerEquipItem",_id));
         }
      }
      
      private function rezArr(str:String) : Array
      {
         var arr:Array = str.split("|");
         return arr;
      }
      
      private function __onsItemEquip(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var _id:int = pkg.readInt();
         var nickName:String = pkg.readUTF();
         var info:PlayerInfo = findPlayer(_id);
         if(info != null)
         {
            info.beginChanges();
            info.Agility = pkg.readInt();
            info.Attack = pkg.readInt();
            if(!PlayerManager.Instance.isChangeStyleTemp(_id))
            {
               info.Colors = pkg.readUTF();
               info.Skin = pkg.readUTF();
            }
            else
            {
               pkg.readUTF();
               pkg.readUTF();
               info.Colors = changedStyle[_id]["Colors"];
               info.Skin = changedStyle[_id]["Skin"];
            }
            info.Defence = pkg.readInt();
            info.GP = pkg.readInt();
            info.Grade = pkg.readInt();
            info.ddtKingGrade = pkg.readInt();
            info.Luck = pkg.readInt();
            if(!PlayerManager.Instance.isChangeStyleTemp(_id))
            {
               info.Hide = pkg.readInt();
            }
            else
            {
               pkg.readInt();
               info.Hide = changedStyle[_id]["Hide"];
            }
            info.Repute = pkg.readInt();
            if(!PlayerManager.Instance.isChangeStyleTemp(_id))
            {
               info.Sex = pkg.readBoolean();
               info.Style = pkg.readUTF();
            }
            else
            {
               pkg.readBoolean();
               pkg.readUTF();
               info.Sex = changedStyle[_id]["Sex"];
               info.Style = changedStyle[_id]["Style"];
            }
            info.Offer = pkg.readInt();
            info.NickName = nickName;
            info.typeVIP = pkg.readByte();
            info.VIPLevel = pkg.readInt();
            info.WinCount = pkg.readInt();
            info.TotalCount = pkg.readInt();
            info.EscapeCount = pkg.readInt();
            info.ConsortiaID = pkg.readInt();
            info.ConsortiaName = pkg.readUTF();
            info.RichesOffer = pkg.readInt();
            info.RichesRob = pkg.readInt();
            info.IsMarried = pkg.readBoolean();
            info.SpouseID = pkg.readInt();
            info.SpouseName = pkg.readUTF();
            info.DutyName = pkg.readUTF();
            info.Nimbus = pkg.readInt();
            info.FightPower = pkg.readInt();
            info.apprenticeshipState = pkg.readInt();
            info.masterID = pkg.readInt();
            info.setMasterOrApprentices(pkg.readUTF());
            info.graduatesCount = pkg.readInt();
            info.honourOfMaster = pkg.readUTF();
            info.AchievementPoint = pkg.readInt();
            info.honor = pkg.readUTF();
            info.LastLoginDate = pkg.readDate();
            info.commitChanges();
            info.Bag.beginChanges();
            info.Bag.commiteChanges();
            info.commitChanges();
         }
         super.dispatchEvent(new CityWideEvent("ons_playerInfo",info));
      }
      
      protected function __onGetBagLockedList(e:PkgEvent) : void
      {
         e = e;
         formatArr = function(arr:Array, length:int):void
         {
            var i:int = 0;
            if(arr.length == length)
            {
               return;
            }
            for(i = arr.length; i < length; )
            {
               arr.unshift("0");
               i++;
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
      
      public function isBagLockedPSWNeeded(type:int) : Boolean
      {
         var result:Boolean = false;
         if(_bagLockStateList == null)
         {
            return true;
         }
         if(type < 0 || type >= _bagLockStateList.length)
         {
            return true;
         }
         var len:int = _bagLockStateList.length;
         if(_bagLockStateList[len - type - 1] == 0)
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
      
      public function submitBagLockPSWNeededList(list:Array) : void
      {
         var n:int = 0;
         var i:int = 0;
         for(n = list.length; n < 32; )
         {
            list.unshift(0);
            n++;
         }
         var bytes:ByteArray = new ByteArray();
         for(i = 0; i < list.length; )
         {
            bytes.writeByte((list[i + 0] << 7) + (list[i + 1] << 6) + (list[i + 2] << 5) + (list[i + 3] << 4) + (list[i + 4] << 3) + (list[i + 5] << 2) + (list[i + 6] << 1) + list[i + 7]);
            i = i + 8;
         }
         GameInSocketOut.sendBagLockStates(bytes);
      }
      
      private function __bagLockedHandler(evt:PkgEvent) : void
      {
         var userId:int = evt.pkg.readInt();
         var type:int = evt.pkg.readInt();
         var isSussect:Boolean = evt.pkg.readBoolean();
         var boo:Boolean = evt.pkg.readBoolean();
         var msg:String = evt.pkg.readUTF();
         var count:int = evt.pkg.readInt();
         var questionOne:String = evt.pkg.readUTF();
         var questionTwo:String = evt.pkg.readUTF();
         if(isSussect)
         {
            switch(int(type) - 1)
            {
               case 0:
                  _self.bagPwdState = true;
                  _self.bagLocked = true;
                  _self.onReceiveTypes("changePassword");
                  BaglockedManager.PWD = BaglockedManager.TEMP_PWD;
                  MessageTipManager.getInstance().show(msg);
                  break;
               case 1:
                  _self.bagPwdState = true;
                  _self.bagLocked = false;
                  if(!ServerManager.AUTO_UNLOCK)
                  {
                     if(msg != "")
                     {
                        MessageTipManager.getInstance().show(msg);
                     }
                     ServerManager.AUTO_UNLOCK = false;
                  }
                  BaglockedManager.PWD = BaglockedManager.TEMP_PWD;
                  _self.onReceiveTypes("clearSuccess");
                  break;
               case 2:
                  _self.onReceiveTypes("updateSuccess");
                  BaglockedManager.PWD = BaglockedManager.TEMP_PWD;
                  MessageTipManager.getInstance().show(msg);
                  break;
               case 3:
                  _self.bagPwdState = false;
                  _self.bagLocked = false;
                  _self.onReceiveTypes("afterDel");
                  MessageTipManager.getInstance().show(msg);
                  break;
               case 4:
                  _self.bagPwdState = true;
                  _self.bagLocked = true;
                  MessageTipManager.getInstance().show(msg);
               default:
                  _self.bagPwdState = true;
                  _self.bagLocked = true;
                  MessageTipManager.getInstance().show(msg);
            }
         }
         else
         {
            MessageTipManager.getInstance().show(msg);
         }
      }
      
      private function __friendAdd(evt:PkgEvent) : void
      {
         var info:* = null;
         var existInfo:* = null;
         var pkg:PackageIn = evt.pkg;
         var b:Boolean = pkg.readBoolean();
         if(b)
         {
            info = new FriendListPlayer();
            info.beginChanges();
            info.ID = pkg.readInt();
            info.NickName = pkg.readUTF();
            info.typeVIP = pkg.readByte();
            info.VIPLevel = pkg.readInt();
            info.Sex = pkg.readBoolean();
            existInfo = findPlayer(info.ID);
            if(!PlayerManager.Instance.isChangeStyleTemp(info.ID))
            {
               info.Style = pkg.readUTF();
               info.Colors = pkg.readUTF();
               info.Skin = pkg.readUTF();
            }
            else
            {
               pkg.readUTF();
               pkg.readUTF();
               pkg.readUTF();
               info.Style = existInfo.Style;
               info.Colors = existInfo.Colors;
               info.Skin = existInfo.Skin;
            }
            info.playerState = new PlayerState(pkg.readInt());
            info.Grade = pkg.readInt();
            info.ddtKingGrade = pkg.readInt();
            if(!PlayerManager.Instance.isChangeStyleTemp(info.ID))
            {
               info.Hide = pkg.readInt();
            }
            else
            {
               pkg.readInt();
               info.Hide = existInfo.Hide;
            }
            info.ConsortiaName = pkg.readUTF();
            info.TotalCount = pkg.readInt();
            info.EscapeCount = pkg.readInt();
            info.WinCount = pkg.readInt();
            info.Offer = pkg.readInt();
            info.Repute = pkg.readInt();
            info.Relation = pkg.readInt();
            info.LoginName = pkg.readUTF();
            info.Nimbus = pkg.readInt();
            info.FightPower = pkg.readInt();
            info.apprenticeshipState = pkg.readInt();
            info.masterID = pkg.readInt();
            info.setMasterOrApprentices(pkg.readUTF());
            info.graduatesCount = pkg.readInt();
            info.honourOfMaster = pkg.readUTF();
            info.AchievementPoint = pkg.readInt();
            info.honor = pkg.readUTF();
            info.IsMarried = pkg.readBoolean();
            info.isOld = pkg.readBoolean();
            info.LastLoginDate = pkg.readDate();
            info.ImagePath = pkg.readUTF();
            info.IsShow = pkg.readBoolean();
            info.isAttest = pkg.readBoolean();
            info.commitChanges();
            if(info.Relation != 1)
            {
               addFriend(info);
               if(PathInfo.isUserAddFriend)
               {
                  new AddCommunityFriend(info.LoginName,info.NickName);
               }
            }
            else
            {
               addBlackList(info);
            }
            dispatchEvent(new IMEvent("addnewfriend",info));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.playerManager.addFriend.isRefused"));
         }
      }
      
      public function isNeedPSW(type:int) : Boolean
      {
         return false;
      }
      
      public function addFriend(player:PlayerInfo) : void
      {
         if(!blackList && !friendList)
         {
            return;
         }
         blackList.remove(player.ID);
         friendList.add(player.ID,player);
      }
      
      public function addBlackList(player:FriendListPlayer) : void
      {
         if(!blackList && !friendList)
         {
            return;
         }
         friendList.remove(player.ID);
         blackList.add(player.ID,player);
      }
      
      public function removeFriend(id:int) : void
      {
         if(!blackList && !friendList)
         {
            return;
         }
         friendList.remove(id);
         blackList.remove(id);
      }
      
      private function __friendRemove(evt:PkgEvent) : void
      {
         removeFriend(evt.pkg.clientId);
      }
      
      private function __playerState(evt:PkgEvent) : void
      {
         var obj:* = null;
         var pkg:PackageIn = evt.pkg;
         if(pkg.clientId != _self.ID)
         {
            obj = {};
            obj["clientId"] = pkg.clientId;
            obj["state"] = pkg.readInt();
            obj["typeVip"] = pkg.readByte();
            obj["viplevel"] = pkg.readInt();
            obj["isSameCity"] = pkg.readBoolean();
            playerStateChange(obj);
            ConsortionModelManager.Instance.model.consortiaPlayerStateChange(obj.clientId,obj.state);
         }
      }
      
      private function spouseStateChange(state:int) : void
      {
         var msg:* = null;
         if(state == 1)
         {
            msg = !!Self.Sex?LanguageMgr.GetTranslation("ddt.manager.playerManager.wifeOnline",Self.SpouseName):LanguageMgr.GetTranslation("ddt.manager.playerManager.hushandOnline",Self.SpouseName);
            ChatManager.Instance.sysChatYellow(msg);
         }
      }
      
      private function masterStateChange(state:int, clientId:int) : void
      {
         var msg:* = null;
         if(state == 1 && clientId != Self.SpouseID)
         {
            if(clientId == Self.masterID)
            {
               msg = LanguageMgr.GetTranslation("ddt.manager.playerManager.masterState",Self.getMasterOrApprentices()[clientId]);
            }
            else if(Self.getMasterOrApprentices()[clientId])
            {
               msg = LanguageMgr.GetTranslation("ddt.manager.playerManager.ApprenticeState",Self.getMasterOrApprentices()[clientId]);
            }
            else
            {
               return;
            }
            ChatManager.Instance.sysChatYellow(msg);
         }
      }
      
      private function playerStateChange(obj:Object) : void
      {
         var strII:* = null;
         var beforeState:int = 0;
         var playerInfo:* = null;
         var info:PlayerInfo = friendList[obj.clientId];
         if(info)
         {
            if(info.playerState.StateID != obj.state || info.typeVIP != obj.typeVIP || info.isSameCity != obj.isSameCity)
            {
               info.typeVIP = obj.typeVip;
               info.VIPLevel = obj.viplevel;
               info.isSameCity = obj.isSameCity;
               if(obj.state == 1)
               {
                  info.LastLoginDate = TimeManager.Instance.serverDate;
               }
               strII = "";
               beforeState = info.playerState.StateID;
               if(info.playerState.StateID != obj.state)
               {
                  info.playerState = new PlayerState(obj.state);
                  friendList.add(obj.clientId,info);
                  if(beforeState == 4)
                  {
                     return;
                  }
                  if(obj.clientId == Self.SpouseID)
                  {
                     spouseStateChange(obj.state);
                     return;
                  }
                  if(obj.clientId == Self.masterID || Self.getMasterOrApprentices()[obj.clientId])
                  {
                     masterStateChange(obj.state,obj.clientId);
                     return;
                  }
                  if(obj.state == 1 && SharedManager.Instance.showOL)
                  {
                     strII = LanguageMgr.GetTranslation("tank.view.chat.ChatInputView.friend") + "[" + info.NickName + "]" + LanguageMgr.GetTranslation("tank.manager.PlayerManger.friendOnline");
                     ChatManager.Instance.sysChatYellow(strII);
                     return;
                  }
                  return;
               }
            }
            friendList.add(obj.clientId,info);
         }
         else if(myAcademyPlayers)
         {
            playerInfo = myAcademyPlayers[obj.clientId];
            if(playerInfo)
            {
               if(playerInfo.playerState.StateID != obj.state || playerInfo.IsVIP != obj.typeVip)
               {
                  playerInfo.typeVIP = obj.typeVip;
                  playerInfo.VIPLevel = obj.viplevel;
                  playerInfo.playerState = new PlayerState(obj.state);
                  myAcademyPlayers.add(obj.clientId,playerInfo);
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
      
      private function __useRoomBordenBoxHanlder(e:PkgEvent) : void
      {
         var item:* = null;
         var pkg:PackageIn = e.pkg as PackageIn;
         var bag:BagInfo = _self.getBag(43);
         bag.beginChanges();
         if(item == null)
         {
            item = new InventoryItemInfo();
         }
         var itemName:String = pkg.readUTF();
         item.Count = pkg.readInt();
         item.ItemID = pkg.readInt();
         item.TemplateID = pkg.readInt();
         item.ValidDate = pkg.readInt();
         item.BeginDate = pkg.readDateString();
         item.IsUsed = pkg.readBoolean();
         item.IsBinds = true;
         ItemManager.fill(item);
         bag.items.add(item.ItemID,item);
         BagAndInfoManager.Instance.showPreviewFrame(itemName,[item]);
      }
      
      private function __updateRoomBordenBag(e:PkgEvent) : void
      {
         var i:int = 0;
         var item:* = null;
         var pkg:PackageIn = e.pkg as PackageIn;
         var bag:BagInfo = _self.getBag(43);
         bag.beginChanges();
         var bol:Boolean = pkg.readBoolean();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            item = new InventoryItemInfo();
            item.ItemID = pkg.readInt();
            item.TemplateID = pkg.readInt();
            item.ValidDate = pkg.readInt();
            item.BeginDate = pkg.readDateString();
            item.IsUsed = pkg.readBoolean();
            item.BagType = 43;
            item.IsBinds = true;
            ItemManager.fill(item);
            if(bol)
            {
               bag.items.add(item.ItemID,item);
            }
            else
            {
               bag.items.remove(item.ItemID);
            }
            i++;
         }
         curcentId = pkg.readInt();
         if(!bol)
         {
            bag.dispatchEvent(new BagEvent("update",null));
         }
      }
      
      private function __gameRate(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var experience_Rate:int = pkg.readInt();
         _self.experience_Rate = Number((experience_Rate / 100).toFixed(1));
         var offer_Rate:int = pkg.readInt();
         _self.offer_Rate = Number((offer_Rate / 100).toFixed(1));
      }
      
      private function __vipMerryDiscountInfo(event:CrazyTankSocketEvent) : void
      {
         var beginTime:* = null;
         var endTime:* = null;
         var merryDiscountInfo:* = null;
         var vipDiscountInfo:* = null;
         var arr:* = null;
         var i:int = 0;
         var kingBuffDiscountInfo:* = null;
         var array:* = null;
         var k:int = 0;
         var pkg:PackageIn = event.pkg;
         var type:int = pkg.readInt();
         var bool:Boolean = pkg.readBoolean();
         if(type == 1)
         {
            merryDiscountArr = ["0","0","0"];
            if(bool)
            {
               merryDiscountInfo = pkg.readUTF();
               beginTime = pkg.readUTF();
               endTime = pkg.readUTF();
               merryDiscountTime = beginTime + "--" + endTime;
               merryDiscountArr = merryDiscountInfo.split("|");
               merryActivity = true;
            }
            else
            {
               merryDiscountArr = ServerConfigManager.instance.weddingMoney;
               merryDiscountArr.push(ServerConfigManager.instance.divorcedMoney);
               merryActivity = false;
            }
         }
         else if(type == 2)
         {
            vipDiscountArr = ["0","0","0"];
            vipPriceArr = ["0","0","0"];
            if(bool)
            {
               vipDiscountInfo = pkg.readUTF();
               arr = vipDiscountInfo.split("|");
               for(i = 0; i < arr.length; )
               {
                  vipDiscountArr[i] = arr[i].split(",")[1];
                  vipPriceArr[i] = arr[i].split(",")[0];
                  i++;
               }
               beginTime = pkg.readUTF();
               endTime = pkg.readUTF();
               vipDiscountTime = beginTime + "--" + endTime;
               vipActivity = true;
            }
            else
            {
               vipPriceArr = ServerConfigManager.instance.VIPRenewalPrice;
               vipActivity = false;
            }
         }
         else if(type == 3)
         {
            kingBuffDiscountArr = ["0","0","0"];
            kingBuffPriceArr = ["0","0","0"];
            if(bool)
            {
               kingBuffDiscountInfo = pkg.readUTF();
               array = kingBuffDiscountInfo.split("|");
               for(k = 0; k < array.length; )
               {
                  kingBuffDiscountArr[k] = array[k].split(",")[1];
                  kingBuffPriceArr[k] = array[k].split(",")[0];
                  k++;
               }
               beginTime = pkg.readUTF();
               endTime = pkg.readUTF();
               kingBuffDiscountTime = beginTime + "--" + endTime;
               kingBuffActivity = true;
            }
            else
            {
               kingBuffActivity = false;
            }
         }
      }
      
      private function __onGetPlayerRspecial(e:PkgEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         var ticketNum:int = 0;
         var uploadNum:int = 0;
         var dic:* = null;
         var index:int = 0;
         var num:int = 0;
         var mapID:int = 0;
         var value:int = 0;
         var pkg:PackageIn = e.pkg;
         var type:int = pkg.readInt();
         if(type == 1)
         {
            ticketNum = e.pkg.readInt();
            uploadNum = e.pkg.readInt();
            _self.uploadNum = uploadNum;
            _self.ticketNum = ticketNum;
         }
         else if(type == 2)
         {
            count = pkg.readInt();
            dic = new DictionaryData();
            for(i = 0; i < count; )
            {
               index = pkg.readInt();
               num = pkg.readInt();
               dic.add(index,num);
               i++;
            }
            _self.ringUseNum = dic;
         }
         else if(type == 3)
         {
            count = pkg.readInt();
            for(i = 0; i < count; )
            {
               mapID = pkg.readInt();
               value = pkg.readInt();
               _self.setDungeonCount(mapID,value);
               i++;
            }
         }
      }
      
      protected function __totalCharge(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _self.totalCharge = pkg.readInt();
      }
      
      protected function __onUpdateDungeonExp(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _self.DungeonExpReceiveNum = pkg.readInt();
         _self.DungeonExpTotalNum = pkg.readInt();
      }
      
      protected function __updatePeerID(event:PkgEvent) : void
      {
         var zoneID:int = event.pkg.readInt();
         var userID:int = event.pkg.readInt();
         var player:PlayerInfo = findPlayer(userID,zoneID);
         player.peerID = event.pkg.readUTF();
         FlashP2PManager.Instance.addReadStream(player.peerID,player.ID);
      }
      
      protected function __updateEnergyHandler(event:PkgEvent) : void
      {
         Self.energy = event.pkg.readInt();
         Self.buyEnergyCount = event.pkg.readInt();
      }
      
      protected function __necklaceStrengthInfoUpadte(event:PkgEvent) : void
      {
         Self.necklaceExp = event.pkg.readInt();
         Self.necklaceExpAdd = event.pkg.readInt();
      }
      
      protected function __updateAreaInfo(event:PkgEvent) : void
      {
         var i:int = 0;
         var areaInfo:* = null;
         var len:int = event.pkg.readInt();
         for(i = 0; i < len; )
         {
            areaInfo = new AreaInfo();
            areaInfo.areaID = event.pkg.readInt();
            areaInfo.areaName = event.pkg.readUTF();
            _areaList.add(areaInfo.areaName,areaInfo);
            i++;
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
         for each(var i in _areaList)
         {
            if(i.areaID == Self.ZoneID)
            {
               return i.areaName;
            }
         }
         return "";
      }
      
      public function getAreaNameByAreaID(areaID:int) : String
      {
         var _loc4_:int = 0;
         var _loc3_:* = _areaList;
         for each(var i in _areaList)
         {
            if(i.areaID == areaID)
            {
               return i.areaName;
            }
         }
         return "";
      }
      
      private function __onOpenHole(pEvent:PkgEvent) : void
      {
         var pkg:PackageIn = pEvent.pkg as PackageIn;
         var id:int = pkg.readInt();
         BeadModel.drillInfo.clear();
         BeadModel.drillInfo.add(131,pkg.readInt());
         BeadModel.drillInfo.add(141,pkg.readInt());
         BeadModel.drillInfo.add(151,pkg.readInt());
         BeadModel.drillInfo.add(161,pkg.readInt());
         BeadModel.drillInfo.add(171,pkg.readInt());
         BeadModel.drillInfo.add(181,pkg.readInt());
         BeadModel.drillInfo.add(132,pkg.readInt());
         BeadModel.drillInfo.add(142,pkg.readInt());
         BeadModel.drillInfo.add(152,pkg.readInt());
         BeadModel.drillInfo.add(162,pkg.readInt());
         BeadModel.drillInfo.add(172,pkg.readInt());
         BeadModel.drillInfo.add(182,pkg.readInt());
         dispatchEvent(new BeadEvent("openBeadHole",0));
      }
      
      protected function __updatePlayerProperty(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var arr:Array = ["Attack","Defence","Agility","Luck"];
         var dic:DictionaryData = new DictionaryData();
         var tmp:DictionaryData = null;
         var playerId:int = -1;
         playerId = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var _loc13_:* = 0;
         var _loc12_:* = arr;
         for each(var s in arr)
         {
            var _loc11_:* = new DictionaryData();
            dic[s] = _loc11_;
            tmp = _loc11_;
            pkg.readInt();
            tmp["Texp"] = pkg.readInt();
            tmp["Card"] = pkg.readInt();
            tmp["Pet"] = pkg.readInt();
            tmp["Suit"] = pkg.readInt();
            tmp["gem"] = pkg.readInt();
            tmp["Bead"] = pkg.readInt();
            tmp["Avatar"] = pkg.readInt();
            tmp["MagicStone"] = pkg.readInt();
            tmp["Temple"] = pkg.readInt();
            tmp["PetAtlas"] = pkg.readInt();
         }
         _loc11_ = new DictionaryData();
         dic["MagicAttack"] = _loc11_;
         tmp = _loc11_;
         tmp["MagicStone"] = pkg.readInt();
         tmp["Horse"] = pkg.readInt();
         tmp["HorsePicCherish"] = pkg.readInt();
         tmp["Enchant"] = pkg.readInt();
         tmp["Suit"] = pkg.readInt();
         tmp["Texp"] = pkg.readInt();
         tmp["Card"] = pkg.readInt();
         tmp["Temple"] = 0;
         _loc13_ = new DictionaryData();
         dic["MagicDefence"] = _loc13_;
         tmp = _loc13_;
         tmp["MagicStone"] = pkg.readInt();
         tmp["Horse"] = pkg.readInt();
         tmp["HorsePicCherish"] = pkg.readInt();
         tmp["Enchant"] = pkg.readInt();
         tmp["Suit"] = pkg.readInt();
         tmp["Temple"] = pkg.readInt();
         tmp["Texp"] = pkg.readInt();
         tmp["Card"] = pkg.readInt();
         _loc12_ = new DictionaryData();
         dic["HP"] = _loc12_;
         tmp = _loc12_;
         pkg.readInt();
         tmp["Texp"] = pkg.readInt();
         tmp["Pet"] = pkg.readInt();
         tmp["Bead"] = pkg.readInt();
         tmp["Suit"] = pkg.readInt();
         tmp["gem"] = pkg.readInt();
         tmp["Avatar"] = pkg.readInt();
         tmp["Horse"] = pkg.readInt();
         tmp["HorsePicCherish"] = pkg.readInt();
         tmp["Temple"] = pkg.readInt();
         dic["Damage"] = new DictionaryData();
         dic["Damage"]["Suit"] = pkg.readInt();
         dic["Armor"] = new DictionaryData();
         dic["Armor"]["Suit"] = pkg.readInt();
         dic["Damage"]["Bead"] = pkg.readInt();
         dic["Damage"]["Avatar"] = pkg.readInt();
         dic["Damage"]["Horse"] = pkg.readInt();
         dic["Damage"]["HorsePicCherish"] = pkg.readInt();
         dic["Damage"]["Texp"] = pkg.readInt();
         dic["Armor"]["Bead"] = pkg.readInt();
         dic["Armor"]["Avatar"] = pkg.readInt();
         dic["Armor"]["Horse"] = pkg.readInt();
         dic["Armor"]["HorsePicCherish"] = pkg.readInt();
         dic["Armor"]["Temple"] = pkg.readInt();
         dic["Armor"]["Texp"] = pkg.readInt();
         dic["Armor"]["Pet"] = pkg.readInt();
         SyahManager.Instance.totalDamage = pkg.readInt();
         SyahManager.Instance.totalArmor = pkg.readInt();
         var info:PlayerInfo = findPlayer(playerId,zoneId);
         info.fineSuitExp = pkg.readInt();
         info.cardAchievementHp = pkg.readInt();
         info.cardAchievementDamage = pkg.readInt();
         info.cardAchievementArmor = pkg.readInt();
         dic["Damage"]["mark"] = pkg.readInt();
         dic["Armor"]["mark"] = pkg.readInt();
         dic["Attack"]["mark"] = pkg.readInt();
         dic["Defence"]["mark"] = pkg.readInt();
         dic["Agility"]["mark"] = pkg.readInt();
         dic["Luck"]["mark"] = pkg.readInt();
         dic["HP"]["mark"] = pkg.readInt();
         dic["MagicAttack"]["mark"] = pkg.readInt();
         dic["MagicDefence"]["mark"] = pkg.readInt();
         dic["Attack"]["marKing"] = pkg.readInt();
         dic["Defence"]["marKing"] = pkg.readInt();
         dic["Agility"]["marKing"] = pkg.readInt();
         dic["Luck"]["marKing"] = pkg.readInt();
         dic["MagicAttack"]["marKing"] = pkg.readInt();
         dic["MagicDefence"]["marKing"] = pkg.readInt();
         dic["Attack"]["titleAdd"] = pkg.readInt();
         dic["Defence"]["titleAdd"] = pkg.readInt();
         dic["Agility"]["titleAdd"] = pkg.readInt();
         dic["Luck"]["titleAdd"] = pkg.readInt();
         dic["Attack"]["dig"] = pkg.readInt();
         dic["Defence"]["dig"] = pkg.readInt();
         dic["Agility"]["dig"] = pkg.readInt();
         dic["Luck"]["dig"] = pkg.readInt();
         dic["MagicAttack"]["dig"] = pkg.readInt();
         dic["MagicDefence"]["dig"] = pkg.readInt();
         dic["MagicAttack"]["magicHouse"] = 10 * pkg.readInt();
         dic["MagicDefence"]["magicHouse"] = 10 * pkg.readInt();
         dic["SecondPro"] = new DictionaryData();
         dic["SecondPro"]["Crit"] = pkg.readInt();
         dic["SecondPro"]["Tenacity"] = pkg.readInt();
         dic["SecondPro"]["SunderArmor"] = pkg.readInt();
         dic["SecondPro"]["AvoidInjury"] = pkg.readInt();
         dic["SecondPro"]["Kill"] = pkg.readInt();
         dic["SecondPro"]["WillFight"] = pkg.readInt();
         dic["SecondPro"]["ViolenceInjury"] = pkg.readInt();
         dic["SecondPro"]["Speed"] = pkg.readInt();
         dic["SecondPro"]["Guard"] = pkg.readInt();
         FineSuitManager.Instance.updateFineSuitProperty(info.fineSuitExp,dic);
         var isSelf:Boolean = info.isSelf;
         TotemManager.instance.updatePropertyAddtion(info.totemId,dic,!!isSelf?null:info.totemGrades);
         info.propertyAddition = dic;
         dispatchEvent(new Event("updatePlayerState"));
         info.commitChanges();
      }
      
      public function get propertyAdditions() : DictionaryData
      {
         return _propertyAdditions;
      }
      
      private function __roomListPass(evt:CrazyTankSocketEvent) : void
      {
         var id:int = evt.pkg.readInt();
         var passInput:PassInputFrame = ComponentFactory.Instance.creat("asset.ddtroomList.RoomList.passInputFrame");
         LayerManager.Instance.addToLayer(passInput,3,true,1);
         passInput.ID = id;
      }
      
      private function __sameCity(event:PkgEvent) : void
      {
         var i:int = 0;
         var id:int = 0;
         var len:int = event.pkg.readInt();
         while(i < len)
         {
            id = event.pkg.readInt();
            findPlayer(id,Self.ZoneID).isSameCity = true;
            if(!_sameCityList)
            {
               _sameCityList = [];
            }
            _sameCityList.push(id);
            i++;
         }
         initSameCity();
      }
      
      private function initSameCity() : void
      {
         var i:int = 0;
         if(!_sameCityList)
         {
            _sameCityList = [];
         }
         i = 0;
         while(i < _sameCityList.length)
         {
            findPlayer(_sameCityList[i]).isSameCity = true;
            i++;
         }
         _friendList[_self.ZoneID].dispatchEvent(new DictionaryEvent("update"));
      }
      
      private function __chatFilteringFriendsShare(event:PkgEvent) : void
      {
         if(!_cmFriendList)
         {
            return;
         }
         var pkg:PackageIn = event.pkg;
         var playerID:int = pkg.readInt();
         var notifyMsg:String = pkg.readUTF();
         var isHasInfo:Boolean = false;
         var _loc8_:int = 0;
         var _loc7_:* = _cmFriendList;
         for each(var info in _cmFriendList)
         {
            if(info.UserId == playerID)
            {
               isHasInfo = true;
            }
         }
         if(isHasInfo)
         {
            ChatManager.Instance.sysChatYellow(notifyMsg);
         }
      }
      
      private function __updateUerGuild(event:PkgEvent) : void
      {
         var i:int = 0;
         var bit:int = 0;
         var b:ByteArray = new ByteArray();
         var l:int = event.pkg.readInt();
         for(i = 0; i < l; )
         {
            bit = event.pkg.readByte();
            b.writeByte(bit);
            i++;
         }
         _self.weaklessGuildProgress = b;
      }
      
      private function __getCards(event:PkgEvent) : void
      {
         var i:int = 0;
         var place:int = 0;
         var b:Boolean = false;
         var cardInfo:* = null;
         var tempArr:* = undefined;
         var adinfo:* = null;
         _whoGetCards = true;
         var isSelfAddCard:* = false;
         var pkg:PackageIn = event.pkg;
         var userId:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var len:int = pkg.readInt();
         var info:PlayerInfo = findPlayer(userId,zoneId);
         for(i = 0; i < len; )
         {
            place = pkg.readInt();
            b = pkg.readBoolean();
            if(b)
            {
               cardInfo = new CardInfo();
               cardInfo.CardID = pkg.readInt();
               cardInfo.CardType = pkg.readInt();
               cardInfo.UserID = pkg.readInt();
               cardInfo.Place = pkg.readInt();
               cardInfo.TemplateID = pkg.readInt();
               cardInfo.isFirstGet = pkg.readBoolean();
               cardInfo.Attack = pkg.readInt();
               cardInfo.Defence = pkg.readInt();
               cardInfo.Agility = pkg.readInt();
               cardInfo.Luck = pkg.readInt();
               cardInfo.Damage = pkg.readInt();
               cardInfo.Guard = pkg.readInt();
               if(CaddyModel.instance.type == 6 || CaddyModel.instance.type == 9 || CaddyModel.instance.type == 8)
               {
                  if(cardInfo.TemplateID != 0)
                  {
                     _self.cardInfo = cardInfo;
                     dispatchEvent(new Event("cards_name"));
                  }
               }
               if(cardInfo.Place <= 4 && cardInfo.TemplateID > 0)
               {
                  info.cardEquipDic.add(cardInfo.Place,cardInfo);
               }
               else if(cardInfo.Place <= 4 && cardInfo.TemplateID == 0)
               {
                  info.cardEquipDic.remove(place);
               }
               else if(cardInfo.Place > 4 && cardInfo.TemplateID == 0)
               {
                  info.cardBagDic.remove(place);
               }
               else
               {
                  info.cardBagDic.add(cardInfo.Place,cardInfo);
                  tempArr = new Vector.<AwardsInfo>();
                  adinfo = new AwardsInfo();
                  adinfo.name = cardInfo.templateInfo.Name;
                  adinfo.TemplateId = cardInfo.TemplateID;
                  adinfo.channel = cardInfo.CardType;
                  adinfo.zone = String(cardInfo.Place);
                  adinfo.zoneID = 0;
                  tempArr.push(adinfo);
                  CaddyModel.instance.addAwardsInfoByArr(tempArr);
                  if(!isSelfAddCard)
                  {
                     isSelfAddCard = userId == Self.ID;
                  }
               }
            }
            else if(place <= 4)
            {
               info.cardEquipDic.remove(place);
            }
            else
            {
               info.cardBagDic.remove(place);
            }
            if(isSelfAddCard)
            {
               SocketManager.Instance.out.requestCardAchievement();
            }
            i++;
         }
      }
      
      public function get whoGetCards() : Boolean
      {
         return _whoGetCards;
      }
      
      public function set whoGetCards(value:Boolean) : void
      {
         _whoGetCards = value;
      }
      
      private function __sysNotice(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var sysNoticeType:int = pkg.readInt();
         var msg:String = pkg.readUTF();
         var type:int = pkg.readByte();
         var tmp0Length:int = pkg.readInt();
         var cardTempID:int = pkg.readInt();
         var cardID:int = pkg.readInt();
         var itemGuid:String = pkg.readUTF();
         var chatMsg:ChatData = new ChatData();
         chatMsg.type = 1;
         chatMsg.msg = msg;
         chatMsg.channel = sysNoticeType;
         trace("---------------------");
         trace(chatMsg.msg);
      }
      
      private function __canReLoadGift(event:PkgEvent) : void
      {
         var b:Boolean = event.pkg.readBoolean();
         if(b)
         {
            SocketManager.Instance.out.sendPlayerGift(_self.ID);
         }
      }
      
      private function __addGiftItem(event:PkgEvent) : void
      {
         var i:int = 0;
         var pkg:PackageIn = event.pkg;
         var templateId:int = pkg.readInt();
         var amount:int = pkg.readInt();
         var len:int = _self.myGiftData.length;
         if(len != 0)
         {
            for(i = 0; i < len; )
            {
               if(_self.myGiftData[i].TemplateID == templateId)
               {
                  _self.myGiftData[i].amount = amount;
                  dispatchEvent(new DictionaryEvent("update",_self.myGiftData[i]));
                  break;
               }
               if(i == len - 1)
               {
                  addItem(templateId,amount);
               }
               i++;
            }
         }
         else
         {
            addItem(templateId,amount);
         }
         GiftManager.Instance.loadRecord("GiftRecieveLog.ashx",_self.ID);
      }
      
      private function addItem(templateId:int, amount:int) : void
      {
         var cellInfo:MyGiftCellInfo = new MyGiftCellInfo();
         cellInfo.TemplateID = templateId;
         cellInfo.amount = amount;
         _self.myGiftData.push(cellInfo);
         dispatchEvent(new DictionaryEvent("add",_self.myGiftData[_self.myGiftData.length - 1]));
      }
      
      private function __getGifts(event:PkgEvent) : void
      {
         var list:* = undefined;
         var i:int = 0;
         var cellInfo:* = null;
         var list2:* = undefined;
         var j:int = 0;
         var cellInfo2:* = null;
         var num:int = 0;
         var pkg:PackageIn = event.pkg;
         var id:int = pkg.readInt();
         var info:PlayerInfo = findPlayer(id);
         if(id == _self.ID)
         {
            _self.charmGP = pkg.readInt();
            num = pkg.readInt();
            list = new Vector.<MyGiftCellInfo>();
            for(i = 0; i < num; )
            {
               cellInfo = new MyGiftCellInfo();
               cellInfo.TemplateID = pkg.readInt();
               cellInfo.amount = pkg.readInt();
               list.push(cellInfo);
               i++;
            }
            _self.myGiftData = list;
            dispatchEvent(new Event("selfGiftInfoChange"));
         }
         else
         {
            info.beginChanges();
            info.charmGP = pkg.readInt();
            num = pkg.readInt();
            list2 = new Vector.<MyGiftCellInfo>();
            for(j = 0; j < num; )
            {
               cellInfo2 = new MyGiftCellInfo();
               cellInfo2.TemplateID = pkg.readInt();
               cellInfo2.amount = pkg.readInt();
               list2.push(cellInfo2);
               j++;
            }
            info.myGiftData = list2;
            info.commitChanges();
            dispatchEvent(new Event("giftInfoChange"));
         }
      }
      
      private function __upVipInfo(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         _self.typeVIP = pkg.readByte();
         _self.VIPLevel = pkg.readInt();
         _self.VIPExp = pkg.readInt();
         _self.VIPExpireDay = pkg.readDate();
         _self.LastDate = pkg.readDate();
         _self.VIPNextLevelDaysNeeded = pkg.readInt();
         _self.canTakeVipReward = pkg.readBoolean();
         dispatchEvent(new Event("VIPStateChange"));
      }
      
      public function setupFriendList(analyzer:FriendListAnalyzer) : void
      {
         customList = analyzer.customList;
         friendList = analyzer.friendlist;
         blackList = analyzer.blackList;
         initSameCity();
      }
      
      public function setupEnergyData(analyzer:EnergyDataAnalyzer) : void
      {
         energyData = analyzer.data;
      }
      
      public function checkHasGroupName(name:String) : Boolean
      {
         var i:int = 0;
         for(i = 0; i < customList.length; )
         {
            if(customList[i].Name == name)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.addFirend.repet"),0,true);
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function setupMyacademyPlayers(analyzer:MyAcademyPlayersAnalyze) : void
      {
         _myAcademyPlayers = analyzer.myAcademyPlayers;
      }
      
      private function romoveAcademyPlayers() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _myAcademyPlayers;
         for each(var i in _myAcademyPlayers)
         {
            friendList.remove(i.ID);
         }
      }
      
      public function setupRecentContacts(analyzer:RecentContactsAnalyze) : void
      {
         recentContacts = analyzer.recentContacts;
      }
      
      public function set friendList(value:DictionaryData) : void
      {
         _friendList[_self.ZoneID] = value;
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
         var list:* = null;
         if(friendList.length > 0)
         {
            list = new DictionaryData();
            var _loc4_:int = 0;
            var _loc3_:* = friendList;
            for each(var info in friendList)
            {
               if(info.playerState.StateID != 0)
               {
                  list.add(info.ID,info);
               }
            }
            return list;
         }
         return friendList;
      }
      
      public function getFriendForCustom(relation:int) : DictionaryData
      {
         var temp:DictionaryData = new DictionaryData();
         if(_friendList[_self.ZoneID] == null)
         {
            _friendList[PlayerManager.Instance.Self.ZoneID] = new DictionaryData();
         }
         var _loc5_:int = 0;
         var _loc4_:* = _friendList[_self.ZoneID];
         for each(var info in _friendList[_self.ZoneID])
         {
            if(info.Relation == relation)
            {
               temp.add(info.ID,info);
            }
         }
         return temp;
      }
      
      public function deleteCustomGroup(relation:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _friendList[_self.ZoneID];
         for each(var info in _friendList[_self.ZoneID])
         {
            if(info.Relation == relation)
            {
               info.Relation = 0;
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
      
      public function set recentContacts(value:DictionaryData) : void
      {
         _recentContacts = value;
         dispatchEvent(new Event("recentContactsComplete"));
      }
      
      public function get onlineRecentContactList() : Array
      {
         var temp:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = recentContacts;
         for each(var i in recentContacts)
         {
            if(i.playerState.StateID != 0 || findPlayer(i.ID) && findPlayer(i.ID).playerState.StateID != 0)
            {
               temp.push(i);
            }
         }
         return temp;
      }
      
      public function get offlineRecentContactList() : Array
      {
         var temp:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = recentContacts;
         for each(var i in recentContacts)
         {
            if(i.playerState.StateID == 0)
            {
               temp.push(i);
            }
         }
         return temp;
      }
      
      public function getByNameFriend(name:String) : FriendListPlayer
      {
         var _loc4_:int = 0;
         var _loc3_:* = recentContacts;
         for each(var info in recentContacts)
         {
            if(info.NickName == name)
            {
               return info;
            }
         }
         return null;
      }
      
      public function deleteRecentContact(id:int) : void
      {
         recentContacts.remove(id);
      }
      
      public function get friendAndCustomTitle() : Array
      {
         var i:int = 0;
         var title:* = null;
         var _titleList:Array = [];
         var len:int = customList.length;
         for(i = 0; i < len - 1; )
         {
            title = new FriendListPlayer();
            title.type = 0;
            title.titleType = customList[i].ID;
            title.titleIsSelected = false;
            title.titleNumText = "[" + String(getOnlineFriendForCustom(customList[i].ID).length) + "]";
            title.titleText = customList[i].Name;
            _titleList.push(title);
            i++;
         }
         return _titleList;
      }
      
      public function get onlineFriendList() : Array
      {
         var temp:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = friendList;
         for each(var i in friendList)
         {
            if(i.playerState.StateID != 0)
            {
               temp.push(i);
            }
         }
         return temp;
      }
      
      public function getOnlineFriendForCustom(relation:int) : Array
      {
         var temp:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = friendList;
         for each(var i in friendList)
         {
            if(i.playerState.StateID != 0 && i.Relation == relation)
            {
               temp.push(i);
            }
         }
         return temp;
      }
      
      public function get offlineFriendList() : Array
      {
         var temp:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = friendList;
         for each(var i in friendList)
         {
            if(i.playerState.StateID == 0)
            {
               temp.push(i);
            }
         }
         return temp;
      }
      
      public function getOfflineFriendForCustom(relation:int) : Array
      {
         var temp:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = friendList;
         for each(var i in friendList)
         {
            if(i.playerState.StateID == 0 && i.Relation == relation)
            {
               temp.push(i);
            }
         }
         return temp;
      }
      
      public function get onlineMyAcademyPlayers() : Array
      {
         var temp:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _myAcademyPlayers;
         for each(var i in _myAcademyPlayers)
         {
            if(i.playerState.StateID != 0)
            {
               temp.push(i as FriendListPlayer);
            }
         }
         return temp;
      }
      
      public function get offlineMyAcademyPlayers() : Array
      {
         var temp:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _myAcademyPlayers;
         for each(var i in _myAcademyPlayers)
         {
            if(i.playerState.StateID == 0)
            {
               temp.push(i as FriendListPlayer);
            }
         }
         return temp;
      }
      
      public function set blackList(value:DictionaryData) : void
      {
         _blackList[_self.ZoneID] = value;
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
      
      public function set CMFriendList(value:DictionaryData) : void
      {
         _cmFriendList = value;
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
      
      private function __updatePrivateInfo(e:PkgEvent) : void
      {
         _self.beginChanges();
         _self.Money = e.pkg.readInt();
         _self.DDTMoney = e.pkg.readInt();
         _self.BandMoney = e.pkg.readInt();
         _self.Score = e.pkg.readInt();
         _self.Gold = e.pkg.readInt();
         _self.badLuckNumber = e.pkg.readInt();
         _self.damageScores = e.pkg.readInt();
         e.pkg.readInt();
         _self.myHonor = e.pkg.readInt();
         _self.hardCurrency = e.pkg.readInt();
         _self.jampsCurrency = e.pkg.readInt();
         _self.commitChanges();
      }
      
      public function get hasTempStyle() : Boolean
      {
         return tempStyle.length > 0;
      }
      
      public function isChangeStyleTemp(id:int) : Boolean
      {
         return changedStyle.hasOwnProperty(id) && changedStyle[id] != null;
      }
      
      public function setStyleTemply(tempPlayerStyle:Object) : void
      {
         var player:PlayerInfo = findPlayer(tempPlayerStyle.ID);
         if(player)
         {
            storeTempStyle(player);
            player.beginChanges();
            player.Sex = tempPlayerStyle.Sex;
            player.Hide = tempPlayerStyle.Hide;
            player.Style = tempPlayerStyle.Style;
            player.Colors = tempPlayerStyle.Colors;
            player.Skin = tempPlayerStyle.Skin;
            player.commitChanges();
         }
      }
      
      private function storeTempStyle(player:PlayerInfo) : void
      {
         var o:Object = {};
         o.Style = player.getPrivateStyle();
         o.Hide = player.Hide;
         o.Sex = player.Sex;
         o.Skin = player.Skin;
         o.Colors = player.Colors;
         o.ID = player.ID;
         tempStyle.push(o);
      }
      
      public function readAllTempStyleEvent() : void
      {
         var i:int = 0;
         var player:* = null;
         for(i = 0; i < tempStyle.length; )
         {
            player = findPlayer(tempStyle[i].ID);
            if(player)
            {
               player.beginChanges();
               player.Sex = tempStyle[i].Sex;
               player.Hide = tempStyle[i].Hide;
               player.Style = tempStyle[i].Style;
               player.Colors = tempStyle[i].Colors;
               player.Skin = tempStyle[i].Skin;
               player.commitChanges();
            }
            i++;
         }
         tempStyle = [];
         changedStyle.clear();
      }
      
      private function __readTempStyle(evt:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var o:* = null;
         var pkg:PackageIn = evt.pkg;
         var len:int = pkg.readInt();
         for(i = 0; i < len; )
         {
            o = {};
            o.Style = pkg.readUTF();
            o.Hide = pkg.readInt();
            o.Sex = pkg.readBoolean();
            o.Skin = pkg.readUTF();
            o.Colors = pkg.readUTF();
            o.ID = pkg.readInt();
            setStyleTemply(o);
            changedStyle.add(o.ID,o);
            i++;
         }
      }
      
      private function __updatePlayerInfo(evt:PkgEvent) : void
      {
         var pkg:* = null;
         var style:* = null;
         var arm:* = null;
         var offHand:* = null;
         var unknown1:int = 0;
         var unknown2:int = 0;
         var unknown3:int = 0;
         var len:int = 0;
         var n:int = 0;
         var mapId:int = 0;
         var flag:int = 0;
         var gradeId:int = 0;
         var info:PlayerInfo = findPlayer(evt.pkg.clientId);
         if(info)
         {
            info.beginChanges();
            var _loc15_:int = 0;
            try
            {
               pkg = evt.pkg;
               info.GP = pkg.readInt();
               info.ddtKingGrade = pkg.readInt();
               info.Offer = pkg.readInt();
               info.RichesOffer = pkg.readInt();
               info.RichesRob = pkg.readInt();
               info.WinCount = pkg.readInt();
               info.TotalCount = pkg.readInt();
               info.EscapeCount = pkg.readInt();
               info.Attack = pkg.readInt();
               info.Defence = pkg.readInt();
               info.Agility = pkg.readInt();
               info.Luck = pkg.readInt();
               info.MagicAttack = pkg.readInt();
               info.MagicDefence = pkg.readInt();
               info.hp = pkg.readInt();
               if(!isChangeStyleTemp(info.ID))
               {
                  info.Hide = pkg.readInt();
               }
               else
               {
                  pkg.readInt();
               }
               style = pkg.readUTF();
               if(!isChangeStyleTemp(info.ID))
               {
                  info.Style = style;
               }
               arm = style.split(",")[6].split("|")[0];
               offHand = style.split(",")[10].split("|")[0];
               if(arm == "-1" || arm == "0" || arm == "")
               {
                  info.WeaponID = -1;
               }
               else
               {
                  info.WeaponID = int(arm);
               }
               if(offHand == "0" || offHand == "")
               {
                  info.DeputyWeaponID = -1;
               }
               else
               {
                  info.DeputyWeaponID = int(offHand);
               }
               if(!isChangeStyleTemp(info.ID))
               {
                  info.Colors = pkg.readUTF();
                  info.Skin = pkg.readUTF();
               }
               else
               {
                  pkg.readUTF();
                  pkg.readUTF();
               }
               info.IsShowConsortia = pkg.readBoolean();
               info.ConsortiaID = pkg.readInt();
               info.ConsortiaName = pkg.readUTF();
               info.badgeID = pkg.readInt();
               unknown1 = pkg.readInt();
               unknown2 = pkg.readInt();
               info.Nimbus = pkg.readInt();
               info.PvePermission = pkg.readUTF();
               info.fightLibMission = pkg.readUTF();
               info.FightPower = pkg.readInt();
               if(info.isSelf)
               {
                  _fightPower = info.FightPower;
                  if(PowerUpMovieManager.isCanPlayMovie && StateManager.currentStateType != "fighting" && StateManager.currentStateType != "fighting3d")
                  {
                     if(info.FightPower < PowerUpMovieManager.powerNum)
                     {
                        if(!_timer2.hasEventListener("timer"))
                        {
                           _timer2.addEventListener("timer",__onTimer2Handler);
                           _timer2.start();
                        }
                     }
                     if(info.FightPower > PowerUpMovieManager.powerNum)
                     {
                        if(!_timer1.hasEventListener("timer"))
                        {
                           _timer1.addEventListener("timer",__onTimer1Handler);
                           _timer1.start();
                        }
                     }
                  }
               }
               info.apprenticeshipState = pkg.readInt();
               info.masterID = pkg.readInt();
               info.setMasterOrApprentices(pkg.readUTF());
               info.graduatesCount = pkg.readInt();
               info.honourOfMaster = pkg.readUTF();
               info.AchievementPoint = pkg.readInt();
               info.honor = pkg.readUTF();
               info.honorId = pkg.readInt();
               info.LastSpaDate = pkg.readDate();
               info.charmGP = pkg.readInt();
               unknown3 = pkg.readInt();
               info.shopFinallyGottenTime = pkg.readDate();
               info.UseOffer = pkg.readInt();
               info.matchInfo.dailyScore = pkg.readInt();
               info.matchInfo.dailyWinCount = pkg.readInt();
               info.matchInfo.dailyGameCount = pkg.readInt();
               info.matchInfo.weeklyScore = pkg.readInt();
               info.matchInfo.weeklyGameCount = pkg.readInt();
               info.leagueMoney = pkg.readInt();
               info.spdTexpExp = pkg.readInt();
               info.attTexpExp = pkg.readInt();
               info.defTexpExp = pkg.readInt();
               info.hpTexpExp = pkg.readInt();
               info.lukTexpExp = pkg.readInt();
               info.magicAtkTexpExp = pkg.readInt();
               info.magicDefTexpExp = pkg.readInt();
               info.texpTaskCount = pkg.readInt();
               info.texpCount = pkg.readInt();
               info.magicTexpCount = pkg.readInt();
               info.texpTaskDate = pkg.readDate();
               len = pkg.readInt();
               for(n = 0; n < len; )
               {
                  mapId = pkg.readInt();
                  flag = pkg.readByte();
                  info.dungeonFlag[mapId] = flag;
                  n++;
               }
               info.PveEpicPermission = pkg.readUTF();
               gradeId = pkg.readInt();
               info.evolutionGrade = gradeId;
               info.evolutionExp = pkg.readInt();
               info.desertEnterCount = pkg.readInt();
               info.BattleCount = pkg.readInt();
               info.VipIntegral = pkg.readInt();
               info.RingExp = pkg.readInt();
               info.guardCoreID = pkg.readInt();
               info.guardCoreGrade = pkg.readInt();
               info.teamID = pkg.readInt();
               info.teamName = pkg.readUTF();
               info.teamTag = pkg.readUTF();
               info.teamGrade = pkg.readInt();
               info.teamWinTime = pkg.readInt();
               info.teamTotalTime = pkg.readInt();
               info.teamDivision = pkg.readInt();
               info.teamScore = pkg.readInt();
               info.teamDuty = pkg.readInt();
               info.teamPersonalScore = pkg.readInt();
               info.critTexpExp = pkg.readInt();
               info.sunderArmorTexpExp = pkg.readInt();
               info.critDmgTexpExp = pkg.readInt();
               info.speedTexpExp = pkg.readInt();
               info.uniqueSkillTexpExp = pkg.readInt();
               info.dmgTexpExp = pkg.readInt();
               info.armorDefTexpExp = pkg.readInt();
               info.nsTexpCount = pkg.readInt();
            }
            catch(_loc16_:*)
            {
               _loc15_ = 1;
            }
            info.commitChanges();
            if(int(_loc15_))
            {
               throw _loc16_;
            }
         }
      }
      
      protected function __onTimer1Handler(event:Event) : void
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
      
      protected function __onTimer2Handler(event:Event) : void
      {
         _timer2.stop();
         _timer2.removeEventListener("timer",__onTimer2Handler);
         PowerUpMovieManager.powerNum = _fightPower;
      }
      
      public function getDeputyWeaponIcon(deputyWeapon:InventoryItemInfo, type:int = 0) : DisplayObject
      {
         var cell:* = null;
         if(deputyWeapon)
         {
            cell = new BagCell(deputyWeapon.Place,deputyWeapon);
            if(type == 0)
            {
               return cell.getContent();
            }
            if(type == 1)
            {
               return cell.getSmallContent();
            }
         }
         return null;
      }
      
      private function __dailyAwardHandler(evt:PkgEvent) : void
      {
         var bool:Boolean = evt.pkg.readBoolean();
         var getWay:int = evt.pkg.readInt();
         if(getWay == 0)
         {
            CalendarManager.getInstance().dailyAwardState = bool;
            MainButtnController.instance.DailyAwardState = bool;
         }
         else if(getWay != 1)
         {
            if(getWay != 2)
            {
               if(getWay == 6)
               {
                  CalendarManager.getInstance().times = evt.pkg.readInt();
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
      
      public function __checkCodePopup(e:PkgEvent) : void
      {
         e = e;
         readComplete = function(e:Event):void
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
      
      private function __buffObtain(evt:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var type:int = 0;
         var isExist:Boolean = false;
         var beginData:* = null;
         var validDate:int = 0;
         var value:int = 0;
         var validCount:int = 0;
         var TemplateID:int = 0;
         var buff:* = null;
         var pkg:PackageIn = evt.pkg;
         if(pkg.clientId != _self.ID)
         {
            return;
         }
         _self.clearBuff();
         var lth:int = pkg.readInt();
         for(i = 0; i < lth; )
         {
            type = pkg.readInt();
            isExist = pkg.readBoolean();
            beginData = pkg.readDate();
            validDate = pkg.readInt();
            value = pkg.readInt();
            validCount = pkg.readInt();
            TemplateID = pkg.readInt();
            buff = new BuffInfo(type,isExist,beginData,validDate,value,validCount,TemplateID);
            _self.addBuff(buff);
            i++;
         }
         evt.stopImmediatePropagation();
      }
      
      private function __buffUpdate(evt:CrazyTankSocketEvent) : void
      {
         var i:* = 0;
         var type:int = 0;
         var isExist:Boolean = false;
         var beginData:* = null;
         var validDate:int = 0;
         var value:int = 0;
         var validCount:int = 0;
         var TemplateID:int = 0;
         var buff:* = null;
         var pkg:PackageIn = evt.pkg;
         if(pkg.clientId != _self.ID)
         {
            return;
         }
         var len:int = pkg.readInt();
         for(i = uint(0); i < len; )
         {
            type = pkg.readInt();
            isExist = pkg.readBoolean();
            beginData = pkg.readDate();
            validDate = pkg.readInt();
            value = pkg.readInt();
            validCount = pkg.readInt();
            TemplateID = pkg.readInt();
            buff = new BuffInfo(type,isExist,beginData,validDate,value,validCount,TemplateID);
            if(type == 51)
            {
               buff.additionCount = KingBlessManager.instance.getOneBuffData(4);
            }
            if(isExist)
            {
               _self.addBuff(buff);
            }
            else
            {
               _self.buffInfo.remove(buff.Type);
            }
            i++;
         }
         evt.stopImmediatePropagation();
      }
      
      public function findPlayerByNickName(info:PlayerInfo, nickName:String) : PlayerInfo
      {
         if(nickName)
         {
            if(_tempList[_self.ZoneID] == null)
            {
               _tempList[_self.ZoneID] = new DictionaryData();
            }
            if(_self.NickName == nickName)
            {
               return _self;
            }
            var _loc6_:int = 0;
            var _loc5_:* = _friendList[_self.ZoneID];
            for each(var playerInfo in _friendList[_self.ZoneID])
            {
               if(playerInfo.NickName == nickName)
               {
                  return playerInfo;
               }
            }
            if(_tempList[_self.ZoneID][nickName] != null)
            {
               return _tempList[_self.ZoneID][nickName] as PlayerInfo;
            }
            var _loc8_:int = 0;
            var _loc7_:* = _tempList[_self.ZoneID];
            for each(var player in _tempList[_self.ZoneID])
            {
               if(player.NickName == nickName)
               {
                  return player;
               }
            }
            info.NickName = nickName;
            _tempList[_self.ZoneID][nickName] = info;
            return info;
         }
         return info;
      }
      
      public function findPlayer(id:int, zoneID:int = -1, nickName:String = "") : PlayerInfo
      {
         var player:* = null;
         var player1:* = null;
         if(zoneID == -1 || zoneID == _self.ZoneID)
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
            if(id == _self.ID && (zoneID == -1 || zoneID == _self.ZoneID))
            {
               return _self;
            }
            if(_friendList[_self.ZoneID][id])
            {
               return _friendList[_self.ZoneID][id];
            }
            if(_clubPlays[_self.ZoneID][id])
            {
               return _clubPlays[_self.ZoneID][id];
            }
            if(_tempList[_self.ZoneID][nickName])
            {
               return _tempList[_self.ZoneID][nickName];
            }
            if(_myAcademyPlayers[id])
            {
               return _myAcademyPlayers[id];
            }
            if(_tempList[_self.ZoneID][id])
            {
               if(_tempList[_self.ZoneID][_tempList[_self.ZoneID][id].NickName])
               {
                  return _tempList[_self.ZoneID][_tempList[_self.ZoneID][id].NickName];
               }
               return _tempList[_self.ZoneID][id];
            }
            var _loc8_:int = 0;
            var _loc7_:* = _tempList[_self.ZoneID];
            for each(var tempInfo in _tempList[_self.ZoneID])
            {
               if(tempInfo.ID == id)
               {
                  _tempList[_self.ZoneID][id] = tempInfo;
                  return tempInfo;
               }
            }
            player = new PlayerInfo();
            player.ID = id;
            player.ZoneID = _self.ZoneID;
            _tempList[_self.ZoneID][id] = player;
            return player;
         }
         if(id == _self.ID && (zoneID == _self.ZoneID || _self.ZoneID == 0))
         {
            return _self;
         }
         if(_friendList[zoneID] && _friendList[zoneID][id])
         {
            return _friendList[zoneID][id];
         }
         if(_clubPlays[zoneID] && _clubPlays[zoneID][id])
         {
            return _clubPlays[zoneID][id];
         }
         if(_tempList[zoneID] && _tempList[zoneID][id])
         {
            return _tempList[zoneID][id];
         }
         player1 = new PlayerInfo();
         player1.ID = id;
         player1.ZoneID = zoneID;
         if(_tempList[zoneID] == null)
         {
            _tempList[zoneID] = new DictionaryData();
         }
         _tempList[zoneID][id] = player1;
         return player1;
      }
      
      public function hasInMailTempList(id:int) : Boolean
      {
         if(_mailTempList[_self.ZoneID] == null)
         {
            _mailTempList[_self.ZoneID] = new DictionaryData();
         }
         if(_mailTempList[_self.ZoneID][id])
         {
            return true;
         }
         return false;
      }
      
      public function set mailTempList(value:DictionaryData) : void
      {
         if(_mailTempList == null)
         {
            _mailTempList = new DictionaryData();
         }
         if(_mailTempList[_self.ZoneID] == null)
         {
            _mailTempList[_self.ZoneID] = new DictionaryData();
         }
         _mailTempList[_self.ZoneID] = value;
      }
      
      public function hasInFriendList(id:int) : Boolean
      {
         if(_friendList[_self.ZoneID] == null)
         {
            _friendList[_self.ZoneID] = new DictionaryData();
         }
         if(_friendList[_self.ZoneID][id])
         {
            return true;
         }
         return false;
      }
      
      public function hasInClubPlays(id:int) : Boolean
      {
         if(_clubPlays[_self.ZoneID] == null)
         {
            _clubPlays[_self.ZoneID] = new DictionaryData();
         }
         if(_clubPlays[_self.ZoneID][id])
         {
            return true;
         }
         return false;
      }
      
      private function __selfPopChange(e:PlayerPropertyEvent) : void
      {
         if(e.changedProperties["TotalCount"])
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
         if(e.changedProperties["Grade"])
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
         var passport:String = Account.Account;
         var udbid:int = 0;
         var gameddt:String = "DDT";
         var sitePath:String = PathManager.solveFillPage();
         var gameServer:String = "";
         if(sitePath.indexOf("quest") != -1)
         {
            gameServer = "s" + sitePath.slice(sitePath.indexOf("quest") + 5);
         }
         var roleName:String = Self.NickName;
         var roleLevel:int = Self.Grade;
         var gameEvent:String = "level_change";
         var otherParams:GameProfileParams = null;
         GameMsgCollector.instance.reportGameProfile(passport,udbid,gameddt,gameServer,roleName,roleLevel,gameEvent,otherParams);
      }
      
      private function __updatePet(event:PkgEvent) : void
      {
         var i:int = 0;
         var place:int = 0;
         var isUpdate:Boolean = false;
         var pid:int = 0;
         var ptid:int = 0;
         var p:* = null;
         var skillCount:int = 0;
         var k:int = 0;
         var skillid:int = 0;
         var petskill:* = null;
         var activedSkillCount:int = 0;
         var j:int = 0;
         var splace:int = 0;
         var sid:int = 0;
         var isEquip:Boolean = false;
         var petEquipCount:int = 0;
         var p_i:int = 0;
         var equipData:* = null;
         var equInfo:* = null;
         var newInfo:* = null;
         var temInfo:* = null;
         var pkg:PackageIn = event.pkg;
         var playerid:int = pkg.readInt();
         var zoneId:int = pkg.readInt();
         var info:PlayerInfo = findPlayer(playerid,zoneId);
         info.ID = playerid;
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            place = pkg.readInt();
            isUpdate = pkg.readBoolean();
            if(isUpdate)
            {
               pid = pkg.readInt();
               ptid = pkg.readInt();
               p = new PetInfo();
               p.TemplateID = ptid;
               p.ID = pid;
               PetInfoManager.fillPetInfo(p);
               p.Name = pkg.readUTF();
               p.UserID = pkg.readInt();
               p.Attack = pkg.readInt();
               p.Defence = pkg.readInt();
               p.Luck = pkg.readInt();
               p.Agility = pkg.readInt();
               p.Blood = pkg.readInt();
               p.Damage = pkg.readInt();
               p.Guard = pkg.readInt();
               p.AttackGrow = pkg.readInt();
               p.DefenceGrow = pkg.readInt();
               p.LuckGrow = pkg.readInt();
               p.AgilityGrow = pkg.readInt();
               p.BloodGrow = pkg.readInt();
               p.DamageGrow = pkg.readInt();
               p.GuardGrow = pkg.readInt();
               p.Level = pkg.readInt();
               p.GP = pkg.readInt();
               p.MaxGP = pkg.readInt();
               p.Hunger = pkg.readInt();
               p.breakGrade = pkg.readInt();
               p.breakBlood = pkg.readUnsignedInt();
               p.breakAttack = pkg.readUnsignedInt();
               p.breakDefence = pkg.readUnsignedInt();
               p.breakAgility = pkg.readUnsignedInt();
               p.breakLuck = pkg.readUnsignedInt();
               p.PetHappyStar = pkg.readInt();
               p.MP = pkg.readInt();
               p.clearSkills();
               p.clearEquipedSkills();
               skillCount = pkg.readInt();
               for(k = 0; k < skillCount; )
               {
                  skillid = pkg.readInt();
                  petskill = new PetSkill(skillid);
                  petskill.exclusiveID = pkg.readInt();
                  p.addSkill(petskill);
                  k++;
               }
               activedSkillCount = pkg.readInt();
               for(j = 0; j < activedSkillCount; )
               {
                  splace = pkg.readInt();
                  sid = pkg.readInt();
                  p.equipdSkills.add(splace,sid);
                  j++;
               }
               isEquip = pkg.readBoolean();
               p.IsEquip = isEquip;
               p.Place = place;
               petEquipCount = pkg.readInt();
               for(p_i = 0; p_i < petEquipCount; )
               {
                  equipData = new PetEquipData();
                  equipData.eqType = pkg.readInt();
                  equipData.eqTemplateID = pkg.readInt();
                  equipData.startTime = pkg.readDateString();
                  equipData.ValidDate = pkg.readInt();
                  equInfo = new InventoryItemInfo();
                  equInfo.TemplateID = equipData.eqTemplateID;
                  equInfo.ValidDate = equipData.ValidDate;
                  equInfo.BeginDate = equipData.startTime;
                  equInfo.IsBinds = true;
                  equInfo.IsUsed = true;
                  equInfo.Place = equipData.eqType;
                  equInfo.AttackCompose = pkg.readInt();
                  equInfo.DefendCompose = pkg.readInt();
                  equInfo.AgilityCompose = pkg.readInt();
                  equInfo.LuckCompose = pkg.readInt();
                  equInfo.ItemID = pkg.readInt();
                  newInfo = ItemManager.fill(equInfo) as InventoryItemInfo;
                  if(p.equipList[newInfo.Place])
                  {
                     temInfo = p.equipList[newInfo.Place];
                     newInfo.awakenEquipPro = temInfo.awakenEquipPro;
                  }
                  p.equipList.add(newInfo.Place,newInfo);
                  p_i++;
               }
               p.currentStarExp = pkg.readInt();
               info.pets.add(p.Place,p);
            }
            else
            {
               info.pets.remove(place);
            }
            info.commitChanges();
            i++;
         }
         info.petsEatWeaponLevel = pkg.readInt();
         info.petsEatClothesLevel = pkg.readInt();
         info.petsEatHatLevel = pkg.readInt();
         dispatchEvent(new CEvent("updatePet"));
      }
      
      private function __updateOneKeyFinish(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _self.uesedFinishTime = pkg.readInt();
      }
      
      public function get isReportGameProfile() : Boolean
      {
         return _isReportGameProfile;
      }
      
      public function set isReportGameProfile(value:Boolean) : void
      {
         _isReportGameProfile = value;
      }
   }
}
