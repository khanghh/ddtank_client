package ddt.data.player
{
   import cardSystem.CardManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.SetsInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.BuffInfo;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.GameEvent;
   import ddt.events.WebSpeedEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   import explorerManual.data.model.PlayerManualProInfo;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import gemstone.info.GemstonInitInfo;
   import giftSystem.MyGiftCellInfo;
   import horse.HorseAmuletManager;
   import mark.MarkMgr;
   import mark.data.MarkBagData;
   import mark.data.MarkChipData;
   import mark.data.MarkProData;
   import mark.data.MarkSuitTemplateData;
   import pet.data.PetInfo;
   import road7th.data.DictionaryData;
   import store.data.StoreEquipExperience;
   import store.equipGhost.data.EquipGhostData;
   import store.view.embed.EmbedUpLevelCell;
   import totem.TotemManager;
   import trainer.controller.NewHandGuideManager;
   
   public class PlayerInfo extends BasePlayer
   {
      
      public static const SEX:String = "Sex";
      
      public static const STYLE:String = "Style";
      
      public static const HIDE:String = "Hide";
      
      public static const SKIN:String = "Skin";
      
      public static const COLORS:String = "Colors";
      
      public static const NIMBUS:String = "Nimbus";
      
      public static const GOLD:String = "Gold";
      
      public static const MONEY:String = "Money";
      
      public static const DDT_MONEY:String = "Money";
      
      public static const BandMONEY:String = "BandMoney";
      
      public static const JampsCurrency:String = "jampsCurrency";
      
      public static const Energy:String = "Energy";
      
      public static const BuyEnergyCount:String = "BuyEnergyCount";
      
      public static const PETSCORE:String = "PetScore";
      
      public static const ARM:String = "WeaponID";
      
      public static const UPDATE_SHOP_FINALLY_TIME:String = "shopFinallyGottenTime";
      
      public static const MOUNTS_TYPE:String = "mountsType";
      
      public static const PETSID:String = "petsID";
      
      public static const CHARM_LEVEL_NEED_EXP:Array = [0,10,50,120,210,320,450,600,770,960,1170,1410,1680,1980,2310,2670,3060,3480,3930,4410,4920,5470,6060,6690,7360,8070,8820,9610,10440,11310,12220,13190,14220,15310,16460,17670,18940,20270,21660,23110,25110,27660,30760,34410,38610,43360,48660,54510,60910,67860,75360,83460,92160,101460,111360,121860,132960,144660,156960,169860,183360,197460,212160,227460,243360,259860,276960,294660,312960,331860,351360,371460,392160,413460,435360,457860,480960,504660,528960,553860,579360,605460,632160,659460,687360,715860,744960,774660,804960,835860,867360,899460,932160,965460,999360,1033860,1068960,1104660,1140960,1177860];
      
      public static const CHARM_LEVEL_ALL_EXP:Array = [0,10,60,180,390,710,1160,1760,2530,3490,4660,6070,7750,9730,12040,14710,17770,21250,25180,29590,34510,39980,46040,52730,60090,68160,76980,86590,97030,108340,120560,133750,147970,163280,179740,197410,216350,236620,258280,281390,306500,334160,364920,399330,437940,481300,529960,584470,645380,713240,788600,872060,964220,1065680,1177040,1298900,1431860,1576520,1733480,1903340,2086700,2284160,2496320,2723780,2967140,3227000,3503960,3798620,4111580,4443440,4794800,5166260,5558420,5971880,6407240,6865100,7346060,7850720,8379680,8933540,9512900,10118360,10750520,11409980,12097340,12813200,13558160,14332820,15137780,15973640,16841000,17740460,18672620,19638080,20637440,21671300,22740260,23844920,24985880,26163740];
      
      public static const MAX_CHARM_LEVEL:int = 100;
      
      public static const ESSENCE:String = "Essence";
       
      
      public var petsEatWeaponLevel:int;
      
      public var petsEatClothesLevel:int;
      
      public var petsEatHatLevel:int;
      
      public var Markbag:MarkBagData;
      
      private var _curcentRoomBordenTemplateId:int;
      
      public var signMsg:String = "";
      
      private var _lastLuckNum:int;
      
      private var _luckyNum:int;
      
      private var _lastLuckyNumDate:Date;
      
      private var _attachtype:int = -1;
      
      private var _attachvalue:int;
      
      private var _hide:int;
      
      private var _hidehat:Boolean;
      
      private var _hideGlass:Boolean = false;
      
      private var _suitesHide:Boolean = false;
      
      private var _showSuits:Boolean = true;
      
      private var _wingHide:Boolean = false;
      
      private var _nimbus:int;
      
      private var _modifyStyle:String;
      
      private var _style:String;
      
      private var _tutorialProgress:int;
      
      private var _colors:String = "|,|,,,,||,,,,";
      
      private var _intuitionalColor:String = "";
      
      private var _skin:String;
      
      private var _paopaoType:int = 0;
      
      public var SuperAttack:int;
      
      public var Delay:int;
      
      private var _attack:int;
      
      private var _answerSite:int;
      
      private var _defence:int;
      
      private var _luck:int;
      
      private var _hp:int;
      
      public var increaHP:int;
      
      private var _agility:int;
      
      private var _magicAttack:int;
      
      private var _magicDefence:int;
      
      private var _dungeonFlag:Object;
      
      private var _propertyAddition:DictionaryData;
      
      private var _bag:BagInfo;
      
      public var _beadBag:BagInfo;
      
      private var _deputyWeaponID:int = 0;
      
      private var _webSpeed:int;
      
      private var _weaponID:int;
      
      protected var _buffInfo:DictionaryData;
      
      private var _pvePermission:String;
      
      public var _isDupSimpleTip:Boolean = false;
      
      private var _fightLibMission:String;
      
      private var _lastSpaDate:Object;
      
      private var _pveEpicPermission:String;
      
      private var _masterOrApprentices:DictionaryData;
      
      private var _masterID:int;
      
      private var _graduatesCount:int;
      
      private var _honourOfMaster:String = "";
      
      public var _freezesDate:Date;
      
      private var _myGiftData:Vector.<MyGiftCellInfo>;
      
      private var _charmLevel:int;
      
      private var _charmGP:int;
      
      private var _cardEquipDic:DictionaryData;
      
      private var _cardBagDic:DictionaryData;
      
      public var OptionOnOff:int;
      
      private var _shopFinallyGottenTime:Date;
      
      private var _lastDate:Date;
      
      private var _isSameCity:Boolean;
      
      private var _IsShowConsortia:Boolean;
      
      private var _badLuckNumber:int;
      
      protected var _isSelf:Boolean = false;
      
      protected var _pets:DictionaryData;
      
      private var _damageScores:int = 0;
      
      private var _embedUpLevelCell:EmbedUpLevelCell;
      
      private var _totemId:int;
      
      private var _gemstoneList:Vector.<GemstonInitInfo>;
      
      private var _hardCurrency:int;
      
      private var _jampsCurrency:int;
      
      private var _leagueMoney:int;
      
      private var _necklaceExp:int;
      
      private var _necklaceLevel:int;
      
      private var _necklaceExpAdd:int;
      
      private var _pvpBadgeId:int;
      
      public var Damage:int;
      
      public var Blood:int;
      
      public var Energy:int;
      
      public var Guard:int;
      
      private var _isTrusteeship:Boolean;
      
      private var _fightStatus:int;
      
      private var _accumulativeLoginDays:int;
      
      private var _accumulativeAwardDays:int;
      
      private var _evolutionGrade:int;
      
      public var DungeonExpTotalNum:int;
      
      public var DungeonExpReceiveNum:int;
      
      private var _evolutionExp:int;
      
      private var _horseInBookRidingID:int = 0;
      
      private var _horsePicCherishBlood:int;
      
      private var _horsePicCherishGuard:int;
      
      private var _horsePicCherishHurt:int;
      
      private var _horsePicCherishMagicAttack:int;
      
      private var _horsePicCherishMagicDefence:int;
      
      private var _horsePicCherishDic:DictionaryData;
      
      private var _peerID:String;
      
      public var curHorseLevel:int;
      
      private var _fineSuitExp:int;
      
      public var cardAchievementDamage:int;
      
      public var cardAchievementArmor:int;
      
      public var cardAchievementHp:int;
      
      private var _guardCoreGrade:int;
      
      private var _guardCoreID:int;
      
      private var _experience_Rate:Number;
      
      private var _offer_Rate:Number;
      
      private var _trailEliteLevel:int;
      
      private var _stive:int;
      
      private var _manualProInfo:PlayerManualProInfo;
      
      private var _horseAmuletHp:int;
      
      public var horseAmuletProperty:Array;
      
      private var _ghostDic:Dictionary = null;
      
      public function PlayerInfo()
      {
         _buffInfo = new DictionaryData();
         horseAmuletProperty = [];
         super();
      }
      
      public function get curcentRoomBordenTemplateId() : int
      {
         return _curcentRoomBordenTemplateId;
      }
      
      public function set curcentRoomBordenTemplateId(param1:int) : void
      {
         _curcentRoomBordenTemplateId = param1;
      }
      
      override public function updateProperties() : void
      {
         if(_changedPropeties["WeaponID"] || _changedPropeties["Sex"] || _changedPropeties["Style"] || _changedPropeties["Hide"] || _changedPropeties["Skin"] || _changedPropeties["Colors"] || _changedPropeties["Nimbus"])
         {
            parseHide();
            parseStyle();
            parseColos();
            _showSuits = _modifyStyle.split(",")[7].split("|")[0] != "13101" && _modifyStyle.split(",")[7].split("|")[0] != "13201";
            _changedPropeties["Style"] = true;
         }
         super.updateProperties();
      }
      
      private function parseHide() : void
      {
         _hidehat = String(_hide).charAt(8) == "2";
         _hideGlass = String(_hide).charAt(7) == "2";
         _suitesHide = String(_hide).charAt(6) == "2";
         _wingHide = String(_hide).charAt(5) == "2";
      }
      
      private function parseStyle() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(_style == null || _style == "")
         {
            _style = ",,,,,,,,,";
         }
         var _loc1_:Array = _style.split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = getTID(_loc1_[_loc3_]);
            if((_loc2_ == "" || _loc2_ == "0" || _loc2_ == "-1") && _loc3_ + 1 != 7 && _loc3_ < 7)
            {
               _loc1_[_loc3_] = replaceTID(_loc1_[_loc3_],String(_loc3_ + 1) + (!!Sex?"1":"2") + "01");
            }
            else if((_loc2_ == "" || _loc2_ == "0" || _loc2_ == "-1") && _loc3_ + 1 == 7)
            {
               _loc1_[_loc3_] = replaceTID(_loc1_[_loc3_],"7001",false);
            }
            if((_loc2_ == "" || _loc2_ == "0" || _loc2_ == "-1") && _loc3_ == 7)
            {
               _loc1_[_loc3_] = replaceTID(_loc1_[_loc3_],"13" + (!!Sex?"1":"2") + "01");
            }
            if((_loc2_ == "" || _loc2_ == "0" || _loc2_ == "-1") && _loc3_ == 8)
            {
               _loc1_[_loc3_] = replaceTID(_loc1_[_loc3_],"15001");
            }
            if((_loc2_ == "" || _loc2_ == "0" || _loc2_ == "-1") && _loc3_ == 9)
            {
               _loc1_[_loc3_] = replaceTID(_loc1_[_loc3_],"16000");
            }
            _loc3_++;
         }
         if(_hidehat || _hideGlass || _suitesHide || _wingHide)
         {
            if(_hidehat)
            {
               _loc1_[0] = replaceTID(_loc1_[0],"1" + (!!Sex?"1":"2") + "01");
            }
            if(_hideGlass)
            {
               _loc1_[1] = replaceTID(_loc1_[1],"2" + (!!Sex?"1":"2") + "01");
            }
            if(_suitesHide)
            {
               _loc1_[7] = replaceTID(_loc1_[7],"13" + (!!Sex?"1":"2") + "01");
            }
            if(_wingHide)
            {
               _loc1_[8] = replaceTID(_loc1_[8],"15001");
            }
         }
         _modifyStyle = _loc1_.join(",");
      }
      
      public function get lastLuckNum() : int
      {
         return _lastLuckNum;
      }
      
      public function set lastLuckNum(param1:int) : void
      {
         if(_lastLuckNum == param1)
         {
            return;
         }
         _lastLuckNum = param1;
         onPropertiesChanged("luckynum");
      }
      
      public function get luckyNum() : int
      {
         return _luckyNum;
      }
      
      public function set luckyNum(param1:int) : void
      {
         if(_luckyNum == param1)
         {
            return;
         }
         _luckyNum = param1;
      }
      
      public function get lastLuckyNumDate() : Date
      {
         return _lastLuckyNumDate;
      }
      
      public function set lastLuckyNumDate(param1:Date) : void
      {
         if(_lastLuckyNumDate == param1)
         {
            return;
         }
         _lastLuckyNumDate = param1;
      }
      
      public function get attachtype() : int
      {
         return _attachtype;
      }
      
      public function get attachvalue() : int
      {
         return _attachvalue;
      }
      
      private function parseColos() : void
      {
         var _loc2_:Array = _colors.split(",");
         var _loc1_:Array = _loc2_[EquipType.CategeryIdToPlace(6)[0]].split("|");
         _loc2_[EquipType.CategeryIdToPlace(6)[0]] = _loc1_[0] + "|" + _skin + "|" + (_loc1_[2] == undefined?"":_loc1_[2]);
         _loc1_ = _loc2_[EquipType.CategeryIdToPlace(5)[0]].split("|");
         _loc2_[EquipType.CategeryIdToPlace(5)[0]] = _loc1_[0] + "|" + _skin + "|" + (_loc1_[2] == undefined?"":_loc1_[2]);
         _colors = _loc2_.join(",");
      }
      
      public function get Hide() : int
      {
         return _hide;
      }
      
      public function set Hide(param1:int) : void
      {
         if(_hide == param1)
         {
            return;
         }
         _hide = param1;
         onPropertiesChanged("Hide");
      }
      
      public function getHatHide() : Boolean
      {
         return _hidehat;
      }
      
      public function setHatHide(param1:Boolean) : void
      {
         Hide = int(String(_hide).slice(0,8) + (!!param1?"2":"1") + String(_hide).slice(9));
      }
      
      public function getGlassHide() : Boolean
      {
         return _hideGlass;
      }
      
      public function setGlassHide(param1:Boolean) : void
      {
         Hide = int(String(_hide).slice(0,7) + (!!param1?"2":"1") + String(_hide).slice(8,9));
      }
      
      public function getSuitesHide() : Boolean
      {
         return _suitesHide;
      }
      
      public function setSuiteHide(param1:Boolean) : void
      {
         Hide = int(String(_hide).slice(0,6) + (!!param1?"2":"1") + String(_hide).slice(7,9));
      }
      
      public function getShowSuits() : Boolean
      {
         return _showSuits;
      }
      
      public function get wingHide() : Boolean
      {
         return _wingHide;
      }
      
      public function set wingHide(param1:Boolean) : void
      {
         Hide = int(String(_hide).slice(0,5) + (!!param1?"2":"1") + String(_hide).slice(6,9));
      }
      
      public function set Nimbus(param1:int) : void
      {
         if(_nimbus == param1)
         {
            return;
         }
         _nimbus = param1;
         onPropertiesChanged("Nimbus");
      }
      
      public function get Nimbus() : int
      {
         return _nimbus;
      }
      
      public function getHaveLight() : Boolean
      {
         if(Nimbus < 100)
         {
            return false;
         }
         if(Nimbus > 999)
         {
            return String(Nimbus).charAt(0) != "0" || String(Nimbus).charAt(1) != "0";
         }
         return String(Nimbus).charAt(0) != "0";
      }
      
      public function getHaveCircle() : Boolean
      {
         if(Nimbus == 0)
         {
            return false;
         }
         if(Nimbus > 999)
         {
            return String(Nimbus).charAt(2) != "0" || String(Nimbus).charAt(3) != "0";
         }
         if(Nimbus > 99)
         {
            return String(Nimbus).charAt(1) != "0" || String(Nimbus).charAt(2) != "0";
         }
         return String(Nimbus).charAt(0) != "0";
      }
      
      public function get Style() : String
      {
         if(_style == null)
         {
            return null;
         }
         return _modifyStyle;
      }
      
      public function set Style(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(_style == param1)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         var _loc5_:Array = param1.split(",");
         if(_loc5_.length < 10)
         {
            _loc2_ = 10 - _loc5_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc5_.push("|");
               _loc4_++;
            }
            param1 = _loc5_.join(",");
         }
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc3_++;
         }
         _style = param1;
         onPropertiesChanged("Style");
      }
      
      public function getHairType() : int
      {
         return int(ItemManager.Instance.getTemplateById(_modifyStyle.split(",")[EquipType.CategeryIdToPlace(1)[0]].split("|")[0]).Property1);
      }
      
      public function getSuitsType() : int
      {
         var _loc1_:int = ItemManager.Instance.getTemplateById(_modifyStyle.split(",")[7].split("|")[0]).Property1;
         if(_loc1_)
         {
            return _loc1_;
         }
         return 2;
      }
      
      public function getPrivateStyle() : String
      {
         return _style;
      }
      
      public function get TutorialProgress() : int
      {
         return _tutorialProgress;
      }
      
      public function set TutorialProgress(param1:int) : void
      {
         if(_tutorialProgress == param1)
         {
            return;
         }
         _tutorialProgress = param1;
         onPropertiesChanged("TutorialProgress");
      }
      
      public function setPartStyle(param1:int, param2:int, param3:int = -1, param4:String = "", param5:Boolean = true) : void
      {
         if(Style == null)
         {
            return;
         }
         var _loc6_:Array = _style.split(",");
         if(param1 == 7)
         {
            _loc6_[EquipType.CategeryIdToPlace(param1)[0]] = replaceTID(_loc6_[EquipType.CategeryIdToPlace(param1)[0]],param3 == -1 || param3 == 0?"7001":String(param3),false);
         }
         else if(param1 == 13)
         {
            _loc6_[7] = replaceTID(_loc6_[7],param3 == -1 || param3 == 0?String(param1) + "101":String(param3));
         }
         else if(param1 == 15)
         {
            _loc6_[8] = replaceTID(_loc6_[8],param3 == -1 || param3 == 0?"15001":String(param3));
         }
         else
         {
            _loc6_[EquipType.CategeryIdToPlace(param1)[0]] = replaceTID(_loc6_[EquipType.CategeryIdToPlace(param1)[0]],param3 == -1 || param3 == 0?String(param1) + String(param2) + "01":String(param3));
         }
         _style = _loc6_.join(",");
         onPropertiesChanged("Style");
         setPartColor(param1,param4);
      }
      
      private function jionPic(param1:String, param2:String) : String
      {
         return param1 + "|" + param2;
      }
      
      private function getTID(param1:String) : String
      {
         return param1.split("|")[0];
      }
      
      private function replaceTID(param1:String, param2:String, param3:Boolean = true) : String
      {
         return param2 + "|" + (!!param3?ItemManager.Instance.getTemplateById(int(param2)).Pic:param1.split("|")[1]);
      }
      
      public function getPartStyle(param1:int) : int
      {
         return int(Style.split(",")[param1 - 1].split("|")[0]);
      }
      
      public function get Colors() : String
      {
         return _colors;
      }
      
      public function set Colors(param1:String) : void
      {
         if(_intuitionalColor == param1)
         {
            return;
         }
         _intuitionalColor = param1;
         if(colorEqual(_colors,param1))
         {
            return;
         }
         _colors = param1;
         onPropertiesChanged("Colors");
      }
      
      public function getDressColor() : String
      {
         return _intuitionalColor;
      }
      
      private function colorEqual(param1:String, param2:String) : Boolean
      {
         var _loc5_:int = 0;
         if(param1 == param2)
         {
            return true;
         }
         var _loc4_:Array = param1.split(",");
         var _loc3_:Array = param2.split(",");
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc5_ == 4)
            {
               if(_loc4_[_loc5_].split("|").length > 2)
               {
                  _loc4_[_loc5_] = _loc4_[_loc5_].split("|")[0] + "||" + _loc4_[_loc5_].split("|")[2];
               }
            }
            if(_loc4_[_loc5_] != _loc3_[_loc5_])
            {
               if(!((_loc4_[_loc5_] == "|" || _loc4_[_loc5_] == "||" || _loc4_[_loc5_] == "") && (_loc3_[_loc5_] == "|" || _loc3_[_loc5_] == "||" || _loc3_[_loc5_] == "")))
               {
                  return false;
               }
            }
            _loc5_++;
         }
         return true;
      }
      
      public function setPartColor(param1:int, param2:String) : void
      {
         var _loc3_:Array = _colors.split(",");
         if(param1 != 13)
         {
            _loc3_[EquipType.CategeryIdToPlace(param1)[0]] = param2;
         }
         Colors = _loc3_.join(",");
         onPropertiesChanged("Colors");
      }
      
      public function getPartColor(param1:int) : String
      {
         var _loc2_:Array = Colors.split(",");
         return _loc2_[param1 - 1];
      }
      
      public function setSkinColor(param1:String) : void
      {
         Skin = param1;
      }
      
      public function set Skin(param1:String) : void
      {
         if(_skin == param1)
         {
            return;
         }
         _skin = param1;
         onPropertiesChanged("Colors");
      }
      
      public function get Skin() : String
      {
         return getSkinColor();
      }
      
      public function getSkinColor() : String
      {
         var _loc2_:Array = Colors.split(",");
         if(_loc2_[EquipType.CategeryIdToPlace(6)[0]] == undefined)
         {
            return "";
         }
         var _loc1_:String = _loc2_[EquipType.CategeryIdToPlace(6)[0]].split("|")[1];
         return _loc1_ == null?"":_loc1_;
      }
      
      public function clearColors() : void
      {
         Colors = ",,,,,,,,";
      }
      
      public function updateStyle(param1:Boolean, param2:int, param3:String, param4:String, param5:String) : void
      {
         beginChanges();
         Sex = param1;
         Hide = param2;
         Style = param3;
         Colors = param4;
         Skin = param5;
         commitChanges();
      }
      
      public function get paopaoType() : int
      {
         var _loc1_:String = _style.split(",")[9].split("|")[0];
         _loc1_.slice(4);
         if(_loc1_ == null || _loc1_ == "" || _loc1_ == "0" || _loc1_ == "-1")
         {
            return 0;
         }
         return int(_loc1_.slice(3));
      }
      
      public function get Attack() : int
      {
         return _attack;
      }
      
      public function set Attack(param1:int) : void
      {
         if(_attack == param1)
         {
            return;
         }
         _attack = param1;
         onPropertiesChanged("Attack");
      }
      
      public function set userGuildProgress(param1:int) : void
      {
         _answerSite = param1;
         TutorialProgress = param1;
         NewHandGuideManager.Instance.progress = param1;
      }
      
      public function get userGuildProgress() : int
      {
         return _answerSite;
      }
      
      public function get Defence() : int
      {
         return _defence;
      }
      
      public function set Defence(param1:int) : void
      {
         if(_defence == param1)
         {
            return;
         }
         _defence = param1;
         onPropertiesChanged("Defence");
      }
      
      public function get Luck() : int
      {
         return _luck;
      }
      
      public function set Luck(param1:int) : void
      {
         if(_luck == param1)
         {
            return;
         }
         _luck = param1;
         onPropertiesChanged("Luck");
      }
      
      public function get hp() : int
      {
         return _hp;
      }
      
      public function set hp(param1:int) : void
      {
         if(_hp != param1)
         {
            increaHP = param1 - _hp;
         }
         _hp = param1;
      }
      
      public function get Agility() : int
      {
         return _agility;
      }
      
      public function set Agility(param1:int) : void
      {
         if(_agility == param1)
         {
            return;
         }
         _agility = param1;
         onPropertiesChanged("Agility");
      }
      
      public function get MagicAttack() : int
      {
         return _magicAttack;
      }
      
      public function set MagicAttack(param1:int) : void
      {
         if(_magicAttack == param1)
         {
            return;
         }
         _magicAttack = param1;
         onPropertiesChanged("MagicAttack");
      }
      
      public function get MagicDefence() : int
      {
         return _magicDefence;
      }
      
      public function set MagicDefence(param1:int) : void
      {
         if(_magicDefence == param1)
         {
            return;
         }
         _magicDefence = param1;
         onPropertiesChanged("MagicDefence");
      }
      
      public function setAttackDefenseValues(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         Attack = param1;
         Defence = param2;
         Agility = param3;
         Luck = param4;
         MagicAttack = param5;
         MagicDefence = param6;
         onPropertiesChanged("setAttackDefenseValues");
      }
      
      public function get dungeonFlag() : Object
      {
         if(_dungeonFlag == null)
         {
            _dungeonFlag = {};
         }
         return _dungeonFlag;
      }
      
      public function set dungeonFlag(param1:Object) : void
      {
         if(_dungeonFlag == param1)
         {
            return;
         }
         _dungeonFlag = param1;
      }
      
      public function get propertyAddition() : DictionaryData
      {
         if(!_propertyAddition)
         {
            _propertyAddition = new DictionaryData();
         }
         return _propertyAddition;
      }
      
      public function set propertyAddition(param1:DictionaryData) : void
      {
         _propertyAddition = param1;
      }
      
      public function getPropertyAdditionByType(param1:String) : DictionaryData
      {
         return _propertyAddition[param1];
      }
      
      public function get Bag() : BagInfo
      {
         if(_bag == null)
         {
            _bag = new BagInfo(0,46);
         }
         return _bag;
      }
      
      public function get BeadBag() : BagInfo
      {
         if(_beadBag == null)
         {
            _beadBag = new BagInfo(21,178);
         }
         return _beadBag;
      }
      
      public function get DeputyWeapon() : InventoryItemInfo
      {
         var _loc1_:Array = Bag.findBodyThingByCategory(17).concat(Bag.findBodyThingByCategory(31));
         if(_loc1_.length > 0)
         {
            return _loc1_[0] as InventoryItemInfo;
         }
         return null;
      }
      
      public function set DeputyWeaponID(param1:int) : void
      {
         if(_deputyWeaponID == param1)
         {
            return;
         }
         _deputyWeaponID = param1;
         onPropertiesChanged("DeputyWeaponID");
      }
      
      public function get DeputyWeaponID() : int
      {
         return _deputyWeaponID;
      }
      
      public function get webSpeed() : int
      {
         return _webSpeed;
      }
      
      public function set webSpeed(param1:int) : void
      {
         _webSpeed = param1;
         dispatchEvent(new WebSpeedEvent("stateChange"));
      }
      
      public function get WeaponID() : int
      {
         return _weaponID;
      }
      
      public function set WeaponID(param1:int) : void
      {
         if(_weaponID == param1)
         {
            return;
         }
         _weaponID = param1;
         onPropertiesChanged("WeaponID");
      }
      
      public function set paopaoType(param1:int) : void
      {
         _paopaoType = param1;
         onPropertiesChanged("paopaoType");
      }
      
      public function get buffInfo#1() : DictionaryData
      {
         return _buffInfo;
      }
      
      protected function set buffInfo#6(param1:DictionaryData) : void
      {
         _buffInfo = param1;
         onPropertiesChanged("buffInfo");
      }
      
      public function addBuff(param1:BuffInfo) : void
      {
         _buffInfo.add(param1.Type,param1);
      }
      
      public function clearBuff() : void
      {
         _buffInfo.clear();
      }
      
      public function hasBuff(param1:int) : Boolean
      {
         if(param1 == 15)
         {
            return true;
         }
         var _loc2_:BuffInfo = getBuff(param1);
         return _loc2_ != null && _loc2_.IsExist;
      }
      
      public function getBuff(param1:int) : BuffInfo
      {
         return _buffInfo[param1];
      }
      
      public function get PvePermission() : String
      {
         return _pvePermission;
      }
      
      public function set PvePermission(param1:String) : void
      {
         if(_pvePermission == param1)
         {
            return;
         }
         if(param1 == "")
         {
            _pvePermission = "11111111111111111111111111111111111111111111111111";
         }
         else
         {
            if(_pvePermission != null)
            {
               if(_pvePermission.substr(0,1) == "1" && param1.substr(0,1) == "3")
               {
                  _isDupSimpleTip = true;
               }
            }
            _pvePermission = param1;
         }
         onPropertiesChanged("PvePermission");
      }
      
      public function get fightLibMission() : String
      {
         return _fightLibMission == null || _fightLibMission == ""?"0000000000":_fightLibMission;
      }
      
      public function set fightLibMission(param1:String) : void
      {
         _fightLibMission = param1;
         onPropertiesChanged("fightLibMission");
      }
      
      public function get LastSpaDate() : Object
      {
         return _lastSpaDate;
      }
      
      public function set LastSpaDate(param1:Object) : void
      {
         _lastSpaDate = param1;
      }
      
      public function set PveEpicPermission(param1:String) : void
      {
         if(this._pveEpicPermission == param1)
         {
            return;
         }
         this._pveEpicPermission = param1;
         onPropertiesChanged("PveEpicPermission");
      }
      
      public function get PveEpicPermission() : String
      {
         return _pveEpicPermission;
      }
      
      public function setMasterOrApprentices(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         if(!_masterOrApprentices)
         {
            _masterOrApprentices = new DictionaryData();
         }
         _masterOrApprentices.clear();
         if(param1 != "")
         {
            _loc3_ = param1.split(",");
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc2_ = _loc3_[_loc4_].split("|");
               _masterOrApprentices.add(int(_loc2_[0]),_loc2_[1]);
               _loc4_++;
            }
         }
         onPropertiesChanged("masterOrApprentices");
      }
      
      public function getMasterOrApprentices() : DictionaryData
      {
         if(!_masterOrApprentices)
         {
            _masterOrApprentices = new DictionaryData();
         }
         return _masterOrApprentices;
      }
      
      public function set masterID(param1:int) : void
      {
         _masterID = param1;
      }
      
      public function get masterID() : int
      {
         return _masterID;
      }
      
      public function isMyMaster(param1:int) : Boolean
      {
         return param1 == _masterID;
      }
      
      public function isMyApprent(param1:int) : Boolean
      {
         return _masterOrApprentices[param1];
      }
      
      public function set graduatesCount(param1:int) : void
      {
         _graduatesCount = param1;
      }
      
      public function get graduatesCount() : int
      {
         return _graduatesCount;
      }
      
      public function set honourOfMaster(param1:String) : void
      {
         _honourOfMaster = param1;
      }
      
      public function get honourOfMaster() : String
      {
         return _honourOfMaster;
      }
      
      public function set freezesDate(param1:Date) : void
      {
         _freezesDate = param1;
      }
      
      public function get freezesDate() : Date
      {
         return _freezesDate;
      }
      
      public function set myGiftData(param1:Vector.<MyGiftCellInfo>) : void
      {
         _myGiftData = param1;
         onPropertiesChanged("myGiftData");
      }
      
      public function get myGiftData() : Vector.<MyGiftCellInfo>
      {
         if(_myGiftData == null)
         {
            _myGiftData = new Vector.<MyGiftCellInfo>();
         }
         return _myGiftData;
      }
      
      public function get giftSum() : int
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = myGiftData;
         for each(var _loc2_ in myGiftData)
         {
            _loc1_ = _loc1_ + _loc2_.amount;
         }
         return _loc1_;
      }
      
      public function set charmLevel(param1:int) : void
      {
         _charmLevel = param1;
         onPropertiesChanged("GiftLevel");
      }
      
      public function get charmLevel() : int
      {
         if(charmGP <= 0)
         {
            return 1;
         }
         return _charmLevel;
      }
      
      public function set charmGP(param1:int) : void
      {
         _charmGP = param1;
         charmLevel = getCharLevel(param1);
         onPropertiesChanged("GiftGp");
      }
      
      private function getCharLevel(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < CHARM_LEVEL_ALL_EXP.length)
         {
            if(param1 >= CHARM_LEVEL_ALL_EXP[100 - 1])
            {
               _loc2_ = 100;
               break;
            }
            if(param1 < CHARM_LEVEL_ALL_EXP[_loc3_])
            {
               _loc2_ = _loc3_;
               break;
            }
            if(param1 <= 0)
            {
               _loc2_ = 1;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get charmGP() : int
      {
         return _charmGP;
      }
      
      public function get cardEquipDic() : DictionaryData
      {
         if(_cardEquipDic == null)
         {
            _cardEquipDic = new DictionaryData();
         }
         return _cardEquipDic;
      }
      
      public function set cardEquipDic(param1:DictionaryData) : void
      {
         if(_cardEquipDic == param1)
         {
            return;
         }
         _cardEquipDic = param1;
         onPropertiesChanged("cardEquipDic");
      }
      
      public function get cardBagDic() : DictionaryData
      {
         if(_cardBagDic == null)
         {
            _cardBagDic = new DictionaryData();
         }
         return _cardBagDic;
      }
      
      public function set cardBagDic(param1:DictionaryData) : void
      {
         if(_cardBagDic == param1)
         {
            return;
         }
         _cardBagDic = param1;
         onPropertiesChanged("cardBagDic");
      }
      
      public function getCardInfoByID(param1:int) : CardInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _cardBagDic;
         for each(var _loc2_ in _cardBagDic)
         {
            if(_loc2_.TemplateID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getCardNumByType(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = _cardBagDic;
         for each(var _loc3_ in _cardBagDic)
         {
            if(_loc3_.CardType <= param1 || _loc3_.CardType == 4)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function checkCurrentCardSets(param1:int, param2:int = 3) : Boolean
      {
         var _loc3_:* = null;
         var _loc5_:SetsInfo = CardManager.Instance.getCardSuitByID(param1);
         var _loc7_:int = 0;
         var _loc6_:* = _loc5_.cardIdVec;
         for each(var _loc4_ in _loc5_.cardIdVec)
         {
            _loc3_ = getCardInfoByID(_loc4_);
            if(_loc3_ == null || _loc3_.CardType > param2 && _loc3_.CardType != 4)
            {
               return false;
            }
         }
         return true;
      }
      
      public function getCurrentCardSetsNum(param1:int, param2:int = 3) : int
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc6_:SetsInfo = CardManager.Instance.getCardSuitByID(param1);
         var _loc8_:int = 0;
         var _loc7_:* = _loc6_.cardIdVec;
         for each(var _loc5_ in _loc6_.cardIdVec)
         {
            _loc4_ = getCardInfoByID(_loc5_);
            if(_loc4_ && (_loc4_.CardType <= param2 || _loc4_.CardType == 4))
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      public function gainCardSetsNum(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = CardManager.Instance.model.setsSortRuleVector;
         for each(var _loc3_ in CardManager.Instance.model.setsSortRuleVector)
         {
            if(PlayerManager.Instance.Self.checkCurrentCardSets(int(_loc3_.ID),param1))
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function getOptionState(param1:int) : Boolean
      {
         return (OptionOnOff & param1) == param1;
      }
      
      public function get shopFinallyGottenTime() : Date
      {
         return _shopFinallyGottenTime;
      }
      
      public function set shopFinallyGottenTime(param1:Date) : void
      {
         if(_shopFinallyGottenTime == param1)
         {
            return;
         }
         _shopFinallyGottenTime = param1;
         dispatchEvent(new Event("shopFinallyGottenTime"));
      }
      
      public function getLastDate() : int
      {
         var _loc3_:int = 0;
         var _loc1_:Date = TimeManager.Instance.Now();
         var _loc2_:int = (_loc1_.valueOf() - _lastDate.valueOf()) / 3600000;
         _loc3_ = _loc2_ < 1?1:_loc2_;
         return _loc3_;
      }
      
      public function set lastDate(param1:Date) : void
      {
         _lastDate = param1;
      }
      
      public function get lastDate() : Date
      {
         return _lastDate;
      }
      
      public function get isSameCity() : Boolean
      {
         return _isSameCity;
      }
      
      public function set isSameCity(param1:Boolean) : void
      {
         _isSameCity = param1;
      }
      
      public function set IsShowConsortia(param1:Boolean) : void
      {
         if(_IsShowConsortia == param1)
         {
            return;
         }
         _IsShowConsortia = param1;
         onPropertiesChanged("IsShowConsortia");
      }
      
      public function get IsShowConsortia() : Boolean
      {
         return _IsShowConsortia;
      }
      
      public function get showDesignation() : String
      {
         var _loc1_:String = !!IsShowConsortia?ConsortiaName:honor;
         if(!_loc1_)
         {
            _loc1_ = ConsortiaName;
         }
         if(!_loc1_)
         {
            _loc1_ = honor;
         }
         return _loc1_;
      }
      
      public function get badLuckNumber() : int
      {
         return _badLuckNumber;
      }
      
      public function set badLuckNumber(param1:int) : void
      {
         if(_badLuckNumber != param1)
         {
            _badLuckNumber = param1;
            onPropertiesChanged("BadLuckNumber");
         }
      }
      
      public function shouldShowAcademyIcon() : Boolean
      {
         return false;
      }
      
      public function get isSelf() : Boolean
      {
         return _isSelf;
      }
      
      public function set isSelf(param1:Boolean) : void
      {
         _isSelf = param1;
      }
      
      public function get pets() : DictionaryData
      {
         if(_pets == null)
         {
            _pets = new DictionaryData();
         }
         return _pets;
      }
      
      public function get currentPet() : PetInfo
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _pets;
         for each(var _loc2_ in _pets)
         {
            if(_loc2_.IsEquip)
            {
               _loc1_ = _loc2_;
            }
         }
         return _loc1_;
      }
      
      public function set damageScores(param1:int) : void
      {
         if(_damageScores == param1)
         {
            return;
         }
         _damageScores = param1;
         onPropertiesChanged("damageScores");
      }
      
      public function get damageScores() : int
      {
         return _damageScores;
      }
      
      public function get embedUpLevelCell() : EmbedUpLevelCell
      {
         return _embedUpLevelCell;
      }
      
      public function set embedUpLevelCell(param1:EmbedUpLevelCell) : void
      {
         _embedUpLevelCell = param1;
      }
      
      public function get totemId() : int
      {
         return _totemId;
      }
      
      public function set totemId(param1:int) : void
      {
         _totemId = param1;
         TotemManager.instance.updatePropertyAddtion(_totemId,propertyAddition);
      }
      
      public function set gemstoneList(param1:Vector.<GemstonInitInfo>) : void
      {
         _gemstoneList = param1;
      }
      
      public function get gemstoneList() : Vector.<GemstonInitInfo>
      {
         return _gemstoneList;
      }
      
      public function get hardCurrency() : int
      {
         return _hardCurrency;
      }
      
      public function set hardCurrency(param1:int) : void
      {
         if(_hardCurrency == param1)
         {
            return;
         }
         _hardCurrency = param1;
         onPropertiesChanged("hardCurrency");
      }
      
      public function get jampsCurrency() : int
      {
         return _jampsCurrency;
      }
      
      public function set jampsCurrency(param1:int) : void
      {
         if(_jampsCurrency == param1)
         {
            return;
         }
         _jampsCurrency = param1;
         onPropertiesChanged("jampsCurrency");
      }
      
      public function get leagueMoney() : int
      {
         return _leagueMoney;
      }
      
      public function set leagueMoney(param1:int) : void
      {
         _leagueMoney = param1;
         onPropertiesChanged("leagueMoney");
      }
      
      public function get necklaceExp() : int
      {
         return _necklaceExp;
      }
      
      public function set necklaceExp(param1:int) : void
      {
         _necklaceExp = param1;
         necklaceLevel = StoreEquipExperience.getNecklaceLevelByGP(_necklaceExp);
         onPropertiesChanged("necklaceExp");
      }
      
      public function get necklaceLevel() : int
      {
         return _necklaceLevel;
      }
      
      public function set necklaceLevel(param1:int) : void
      {
         _necklaceLevel = param1;
         onPropertiesChanged("necklaceLevel");
      }
      
      public function get necklaceExpAdd() : int
      {
         return _necklaceExpAdd;
      }
      
      public function set necklaceExpAdd(param1:int) : void
      {
         _necklaceExpAdd = param1;
         onPropertiesChanged("necklaceExpAdd");
      }
      
      public function get pvpBadgeId() : int
      {
         return _pvpBadgeId;
      }
      
      public function set pvpBadgeId(param1:int) : void
      {
         _pvpBadgeId = param1;
      }
      
      public function get isTrusteeship() : Boolean
      {
         return _isTrusteeship;
      }
      
      public function set isTrusteeship(param1:Boolean) : void
      {
         _isTrusteeship = param1;
         dispatchEvent(new GameEvent("trusteeshipChange",param1));
      }
      
      public function get fightStatus() : int
      {
         return _fightStatus;
      }
      
      public function set fightStatus(param1:int) : void
      {
         _fightStatus = param1;
         dispatchEvent(new GameEvent("gameFightStatusChange",param1));
      }
      
      public function get accumulativeLoginDays() : int
      {
         return _accumulativeLoginDays;
      }
      
      public function set accumulativeLoginDays(param1:int) : void
      {
         _accumulativeLoginDays = param1;
      }
      
      public function get accumulativeAwardDays() : int
      {
         return _accumulativeAwardDays;
      }
      
      public function set accumulativeAwardDays(param1:int) : void
      {
         _accumulativeAwardDays = param1;
      }
      
      public function get evolutionGrade() : int
      {
         return _evolutionGrade;
      }
      
      public function set evolutionGrade(param1:int) : void
      {
         _evolutionGrade = param1;
      }
      
      public function get evolutionExp() : int
      {
         return _evolutionExp;
      }
      
      public function set evolutionExp(param1:int) : void
      {
         _evolutionExp = param1;
      }
      
      public function get horsePicCherishBlood() : int
      {
         return _horsePicCherishBlood;
      }
      
      public function set horsePicCherishBlood(param1:int) : void
      {
         _horsePicCherishBlood = param1;
      }
      
      public function get horsePicCherishGuard() : int
      {
         return _horsePicCherishGuard;
      }
      
      public function set horsePicCherishGuard(param1:int) : void
      {
         _horsePicCherishGuard = param1;
      }
      
      public function get horsePicCherishHurt() : int
      {
         return _horsePicCherishHurt;
      }
      
      public function set horsePicCherishHurt(param1:int) : void
      {
         _horsePicCherishHurt = param1;
      }
      
      public function get horsePicCherishMagicAttack() : int
      {
         return _horsePicCherishMagicAttack;
      }
      
      public function set horsePicCherishMagicAttack(param1:int) : void
      {
         _horsePicCherishMagicAttack = param1;
      }
      
      public function get horsePicCherishMagicDefence() : int
      {
         return _horsePicCherishMagicDefence;
      }
      
      public function set horsePicCherishMagicDefence(param1:int) : void
      {
         _horsePicCherishMagicDefence = param1;
      }
      
      public function get horsePicCherishDic() : DictionaryData
      {
         if(_horsePicCherishDic == null)
         {
            _horsePicCherishDic = new DictionaryData();
         }
         return _horsePicCherishDic;
      }
      
      public function set peerID(param1:String) : void
      {
         _peerID = param1;
      }
      
      public function get peerID() : String
      {
         return _peerID;
      }
      
      public function get horseInBookRidingID() : int
      {
         return _horseInBookRidingID;
      }
      
      public function set horseInBookRidingID(param1:int) : void
      {
         _horseInBookRidingID = param1;
      }
      
      public function get fineSuitExp() : int
      {
         return _fineSuitExp;
      }
      
      public function set fineSuitExp(param1:int) : void
      {
         if(_fineSuitExp == param1)
         {
            return;
         }
         _fineSuitExp = param1;
      }
      
      public function get guardCoreGrade() : int
      {
         return _guardCoreGrade;
      }
      
      public function set guardCoreGrade(param1:int) : void
      {
         if(_guardCoreGrade == param1)
         {
            return;
         }
         _guardCoreGrade = param1;
         onPropertiesChanged("GuardCoreGrade");
      }
      
      public function get guardCoreID() : int
      {
         return _guardCoreID;
      }
      
      public function set guardCoreID(param1:int) : void
      {
         if(_guardCoreID == param1)
         {
            return;
         }
         _guardCoreID = param1;
         onPropertiesChanged("GuardCoreID");
      }
      
      public function get experience_Rate() : Number
      {
         return _experience_Rate;
      }
      
      public function set experience_Rate(param1:Number) : void
      {
         _experience_Rate = param1;
      }
      
      public function get offer_Rate() : Number
      {
         return _offer_Rate;
      }
      
      public function set offer_Rate(param1:Number) : void
      {
         _offer_Rate = param1;
      }
      
      public function get trailEliteLevel() : int
      {
         return _trailEliteLevel;
      }
      
      public function set trailEliteLevel(param1:int) : void
      {
         _trailEliteLevel = param1;
      }
      
      public function get manualProInfo() : PlayerManualProInfo
      {
         if(_manualProInfo == null)
         {
            _manualProInfo = new PlayerManualProInfo();
         }
         return _manualProInfo;
      }
      
      public function get horseAmuletHp() : int
      {
         if(isSelf)
         {
            return HorseAmuletManager.instance.getHorseAmuletHp();
         }
         return _horseAmuletHp;
      }
      
      public function set horseAmuletHp(param1:int) : void
      {
         _horseAmuletHp = param1;
      }
      
      public function addGhostData(param1:EquipGhostData) : void
      {
         if(_ghostDic == null)
         {
            _ghostDic = new Dictionary(true);
         }
         _ghostDic[param1.categoryID] = param1;
      }
      
      public function getGhostData(param1:int, param2:int) : EquipGhostData
      {
         var _loc3_:int = BagInfo.parseCategoryID(param1,param2);
         return getGhostDataByCategoryID(_loc3_);
      }
      
      public function getGhostDataByCategoryID(param1:int) : EquipGhostData
      {
         if(_ghostDic == null)
         {
            return null;
         }
         if(param1 == 27)
         {
            param1 = 7;
         }
         return _ghostDic[param1];
      }
      
      public function getMarkChipCntByPlace(param1:int) : int
      {
         var _loc3_:int = 0;
         if(ID == PlayerManager.Instance.Self.ID)
         {
            _loc3_ = MarkMgr.inst.model.getChipsCount(param1);
         }
         else
         {
            var _loc5_:int = 0;
            var _loc4_:* = Markbag.chips;
            for each(var _loc2_ in Markbag.chips)
            {
               if(_loc2_.equipType == param1)
               {
                  _loc3_++;
               }
            }
         }
         return _loc3_;
      }
      
      public function getMarkChipPropsByPlace(param1:int) : Dictionary
      {
         var _loc4_:* = null;
         var _loc5_:Dictionary = null;
         if(ID == PlayerManager.Instance.Self.ID)
         {
            _loc5_ = MarkMgr.inst.calculateEquipProps(param1);
         }
         else
         {
            _loc5_ = new Dictionary();
            _loc4_ = null;
            var _loc10_:int = 0;
            var _loc9_:* = Markbag.chips;
            for each(var _loc2_ in Markbag.chips)
            {
               if(_loc2_.equipType == param1)
               {
                  _loc4_ = _loc2_.mainPro;
                  var _loc6_:* = _loc4_.type;
                  _loc5_[_loc6_] = _loc5_[_loc6_] || new MarkProData();
                  _loc5_[_loc4_.type].type = _loc2_.mainPro.type;
                  _loc5_[_loc4_.type].value = _loc5_[_loc4_.type].value + _loc4_.value;
                  _loc5_[_loc4_.type].attachValue = _loc5_[_loc4_.type].attachValue + _loc4_.attachValue;
                  var _loc8_:int = 0;
                  var _loc7_:* = _loc2_.props;
                  for each(var _loc3_ in _loc2_.props)
                  {
                     _loc6_ = _loc3_.type;
                     _loc5_[_loc6_] = _loc5_[_loc6_] || new MarkProData();
                     _loc5_[_loc3_.type].type = _loc3_.type;
                     _loc5_[_loc3_.type].value = _loc5_[_loc3_.type].value + _loc3_.value;
                     _loc5_[_loc3_.type].attachValue = _loc5_[_loc3_.type].attachValue + _loc3_.attachValue;
                  }
                  continue;
               }
            }
         }
         return _loc5_;
      }
      
      public function getSuitListByPlace(param1:int) : Array
      {
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc4_:Array = [];
         if(ID == PlayerManager.Instance.Self.ID)
         {
            _loc6_ = MarkMgr.inst.model.getSuitList(param1);
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               _loc4_.push(_loc6_[_loc7_].id);
               _loc7_++;
            }
         }
         else
         {
            _loc5_ = new Dictionary();
            var _loc10_:int = 0;
            var _loc9_:* = Markbag.chips;
            for each(var _loc2_ in Markbag.chips)
            {
               if(_loc2_.equipType == param1)
               {
                  var _loc8_:* = MarkMgr.inst.model.cfgChip[_loc2_.templateId].SetID;
                  _loc5_[_loc8_] = _loc5_[_loc8_] || [];
                  _loc5_[MarkMgr.inst.model.cfgChip[_loc2_.templateId].SetID].push(_loc2_);
               }
            }
            var _loc12_:int = 0;
            var _loc11_:* = MarkMgr.inst.model.cfgSuit;
            for each(var _loc3_ in MarkMgr.inst.model.cfgSuit)
            {
               if(_loc5_[_loc3_.SetId] && _loc3_.Demand <= _loc5_[_loc3_.SetId].length)
               {
                  _loc4_.push(_loc3_.Id);
               }
            }
         }
         return _loc4_;
      }
      
      public function clone() : PlayerInfo
      {
         var _loc1_:PlayerInfo = new PlayerInfo();
         ObjectUtils.copyProperties(_loc1_,this);
         return _loc1_;
      }
   }
}
