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
      
      private var _totemGrades:DictionaryData;
      
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
         _totemGrades = new DictionaryData();
         horseAmuletProperty = [];
         super();
      }
      
      public function get curcentRoomBordenTemplateId() : int
      {
         return _curcentRoomBordenTemplateId;
      }
      
      public function set curcentRoomBordenTemplateId(value:int) : void
      {
         _curcentRoomBordenTemplateId = value;
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
         var i:int = 0;
         var tid:* = null;
         if(_style == null || _style == "")
         {
            _style = ",,,,,,,,,";
         }
         var s:Array = _style.split(",");
         for(i = 0; i < s.length; )
         {
            tid = getTID(s[i]);
            if((tid == "" || tid == "0" || tid == "-1") && i + 1 != 7 && i < 7)
            {
               s[i] = replaceTID(s[i],String(i + 1) + (!!Sex?"1":"2") + "01");
            }
            else if((tid == "" || tid == "0" || tid == "-1") && i + 1 == 7)
            {
               s[i] = replaceTID(s[i],"7001",false);
            }
            if((tid == "" || tid == "0" || tid == "-1") && i == 7)
            {
               s[i] = replaceTID(s[i],"13" + (!!Sex?"1":"2") + "01");
            }
            if((tid == "" || tid == "0" || tid == "-1") && i == 8)
            {
               s[i] = replaceTID(s[i],"15001");
            }
            if((tid == "" || tid == "0" || tid == "-1") && i == 9)
            {
               s[i] = replaceTID(s[i],"16000");
            }
            i++;
         }
         if(_hidehat || _hideGlass || _suitesHide || _wingHide)
         {
            if(_hidehat)
            {
               s[0] = replaceTID(s[0],"1" + (!!Sex?"1":"2") + "01");
            }
            if(_hideGlass)
            {
               s[1] = replaceTID(s[1],"2" + (!!Sex?"1":"2") + "01");
            }
            if(_suitesHide)
            {
               s[7] = replaceTID(s[7],"13" + (!!Sex?"1":"2") + "01");
            }
            if(_wingHide)
            {
               s[8] = replaceTID(s[8],"15001");
            }
         }
         _modifyStyle = s.join(",");
      }
      
      public function get lastLuckNum() : int
      {
         return _lastLuckNum;
      }
      
      public function set lastLuckNum(value:int) : void
      {
         if(_lastLuckNum == value)
         {
            return;
         }
         _lastLuckNum = value;
         onPropertiesChanged("luckynum");
      }
      
      public function get luckyNum() : int
      {
         return _luckyNum;
      }
      
      public function set luckyNum(value:int) : void
      {
         if(_luckyNum == value)
         {
            return;
         }
         _luckyNum = value;
      }
      
      public function get lastLuckyNumDate() : Date
      {
         return _lastLuckyNumDate;
      }
      
      public function set lastLuckyNumDate(value:Date) : void
      {
         if(_lastLuckyNumDate == value)
         {
            return;
         }
         _lastLuckyNumDate = value;
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
         var arr:Array = _colors.split(",");
         var t:Array = arr[EquipType.CategeryIdToPlace(6)[0]].split("|");
         arr[EquipType.CategeryIdToPlace(6)[0]] = t[0] + "|" + _skin + "|" + (t[2] == undefined?"":t[2]);
         t = arr[EquipType.CategeryIdToPlace(5)[0]].split("|");
         arr[EquipType.CategeryIdToPlace(5)[0]] = t[0] + "|" + _skin + "|" + (t[2] == undefined?"":t[2]);
         _colors = arr.join(",");
      }
      
      public function get Hide() : int
      {
         return _hide;
      }
      
      public function set Hide(value:int) : void
      {
         if(_hide == value)
         {
            return;
         }
         _hide = value;
         onPropertiesChanged("Hide");
      }
      
      public function getHatHide() : Boolean
      {
         return _hidehat;
      }
      
      public function setHatHide(value:Boolean) : void
      {
         Hide = int(String(_hide).slice(0,8) + (!!value?"2":"1") + String(_hide).slice(9));
      }
      
      public function getGlassHide() : Boolean
      {
         return _hideGlass;
      }
      
      public function setGlassHide(value:Boolean) : void
      {
         Hide = int(String(_hide).slice(0,7) + (!!value?"2":"1") + String(_hide).slice(8,9));
      }
      
      public function getSuitesHide() : Boolean
      {
         return _suitesHide;
      }
      
      public function setSuiteHide(value:Boolean) : void
      {
         Hide = int(String(_hide).slice(0,6) + (!!value?"2":"1") + String(_hide).slice(7,9));
      }
      
      public function getShowSuits() : Boolean
      {
         return _showSuits;
      }
      
      public function get wingHide() : Boolean
      {
         return _wingHide;
      }
      
      public function set wingHide(value:Boolean) : void
      {
         Hide = int(String(_hide).slice(0,5) + (!!value?"2":"1") + String(_hide).slice(6,9));
      }
      
      public function set Nimbus(nim:int) : void
      {
         if(_nimbus == nim)
         {
            return;
         }
         _nimbus = nim;
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
      
      public function set Style(value:String) : void
      {
         var addFixStyleCount:int = 0;
         var i:int = 0;
         var j:int = 0;
         if(_style == value)
         {
            return;
         }
         if(value == null)
         {
            return;
         }
         var styleValues:Array = value.split(",");
         if(styleValues.length < 10)
         {
            addFixStyleCount = 10 - styleValues.length;
            for(i = 0; i < addFixStyleCount; )
            {
               styleValues.push("|");
               i++;
            }
            value = styleValues.join(",");
         }
         j = 0;
         while(j < 10)
         {
            j++;
         }
         _style = value;
         onPropertiesChanged("Style");
      }
      
      public function getHairType() : int
      {
         return int(ItemManager.Instance.getTemplateById(_modifyStyle.split(",")[EquipType.CategeryIdToPlace(1)[0]].split("|")[0]).Property1);
      }
      
      public function getSuitsType() : int
      {
         var rInt:int = ItemManager.Instance.getTemplateById(_modifyStyle.split(",")[7].split("|")[0]).Property1;
         if(rInt)
         {
            return rInt;
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
      
      public function set TutorialProgress(value:int) : void
      {
         if(_tutorialProgress == value)
         {
            return;
         }
         _tutorialProgress = value;
         onPropertiesChanged("TutorialProgress");
      }
      
      public function setPartStyle(categoryId:int, needsex:int, templateId:int = -1, color:String = "", dispatch:Boolean = true) : void
      {
         if(Style == null)
         {
            return;
         }
         var arr:Array = _style.split(",");
         if(categoryId == 7)
         {
            arr[EquipType.CategeryIdToPlace(categoryId)[0]] = replaceTID(arr[EquipType.CategeryIdToPlace(categoryId)[0]],templateId == -1 || templateId == 0?"7001":String(templateId),false);
         }
         else if(categoryId == 13)
         {
            arr[7] = replaceTID(arr[7],templateId == -1 || templateId == 0?String(categoryId) + "101":String(templateId));
         }
         else if(categoryId == 15)
         {
            arr[8] = replaceTID(arr[8],templateId == -1 || templateId == 0?"15001":String(templateId));
         }
         else
         {
            arr[EquipType.CategeryIdToPlace(categoryId)[0]] = replaceTID(arr[EquipType.CategeryIdToPlace(categoryId)[0]],templateId == -1 || templateId == 0?String(categoryId) + String(needsex) + "01":String(templateId));
         }
         _style = arr.join(",");
         onPropertiesChanged("Style");
         setPartColor(categoryId,color);
      }
      
      private function jionPic(tid:String, pic:String) : String
      {
         return tid + "|" + pic;
      }
      
      private function getTID(s:String) : String
      {
         return s.split("|")[0];
      }
      
      private function replaceTID(original:String, tid:String, useTemplatePic:Boolean = true) : String
      {
         return tid + "|" + (!!useTemplatePic?ItemManager.Instance.getTemplateById(int(tid)).Pic:original.split("|")[1]);
      }
      
      public function getPartStyle(categoryId:int) : int
      {
         return int(Style.split(",")[categoryId - 1].split("|")[0]);
      }
      
      public function get Colors() : String
      {
         return _colors;
      }
      
      public function set Colors(value:String) : void
      {
         if(_intuitionalColor == value)
         {
            return;
         }
         _intuitionalColor = value;
         if(colorEqual(_colors,value))
         {
            return;
         }
         _colors = value;
         onPropertiesChanged("Colors");
      }
      
      public function getDressColor() : String
      {
         return _intuitionalColor;
      }
      
      private function colorEqual(color_1:String, color_2:String) : Boolean
      {
         var i:int = 0;
         if(color_1 == color_2)
         {
            return true;
         }
         var colors1:Array = color_1.split(",");
         var colors2:Array = color_2.split(",");
         for(i = 0; i < colors2.length; )
         {
            if(i == 4)
            {
               if(colors1[i].split("|").length > 2)
               {
                  colors1[i] = colors1[i].split("|")[0] + "||" + colors1[i].split("|")[2];
               }
            }
            if(colors1[i] != colors2[i])
            {
               if(!((colors1[i] == "|" || colors1[i] == "||" || colors1[i] == "") && (colors2[i] == "|" || colors2[i] == "||" || colors2[i] == "")))
               {
                  return false;
               }
            }
            i++;
         }
         return true;
      }
      
      public function setPartColor(id:int, color:String) : void
      {
         var arr:Array = _colors.split(",");
         if(id != 13)
         {
            arr[EquipType.CategeryIdToPlace(id)[0]] = color;
         }
         Colors = arr.join(",");
         onPropertiesChanged("Colors");
      }
      
      public function getPartColor(id:int) : String
      {
         var arr:Array = Colors.split(",");
         return arr[id - 1];
      }
      
      public function setSkinColor(color:String) : void
      {
         Skin = color;
      }
      
      public function set Skin(color:String) : void
      {
         if(_skin == color)
         {
            return;
         }
         _skin = color;
         onPropertiesChanged("Colors");
      }
      
      public function get Skin() : String
      {
         return getSkinColor();
      }
      
      public function getSkinColor() : String
      {
         var arr:Array = Colors.split(",");
         if(arr[EquipType.CategeryIdToPlace(6)[0]] == undefined)
         {
            return "";
         }
         var t:String = arr[EquipType.CategeryIdToPlace(6)[0]].split("|")[1];
         return t == null?"":t;
      }
      
      public function clearColors() : void
      {
         Colors = ",,,,,,,,";
      }
      
      public function updateStyle(sex:Boolean, hide:int, style:String, colors:String, skin:String) : void
      {
         beginChanges();
         Sex = sex;
         Hide = hide;
         Style = style;
         Colors = colors;
         Skin = skin;
         commitChanges();
      }
      
      public function get paopaoType() : int
      {
         var st:String = _style.split(",")[9].split("|")[0];
         st.slice(4);
         if(st == null || st == "" || st == "0" || st == "-1")
         {
            return 0;
         }
         return int(st.slice(3));
      }
      
      public function get Attack() : int
      {
         return _attack;
      }
      
      public function set Attack(value:int) : void
      {
         if(_attack == value)
         {
            return;
         }
         _attack = value;
         onPropertiesChanged("Attack");
      }
      
      public function set userGuildProgress(p:int) : void
      {
         _answerSite = p;
         TutorialProgress = p;
         NewHandGuideManager.Instance.progress = p;
      }
      
      public function get userGuildProgress() : int
      {
         return _answerSite;
      }
      
      public function get Defence() : int
      {
         return _defence;
      }
      
      public function set Defence(value:int) : void
      {
         if(_defence == value)
         {
            return;
         }
         _defence = value;
         onPropertiesChanged("Defence");
      }
      
      public function get Luck() : int
      {
         return _luck;
      }
      
      public function set Luck(value:int) : void
      {
         if(_luck == value)
         {
            return;
         }
         _luck = value;
         onPropertiesChanged("Luck");
      }
      
      public function get hp() : int
      {
         return _hp;
      }
      
      public function set hp(value:int) : void
      {
         if(_hp != value)
         {
            increaHP = value - _hp;
         }
         _hp = value;
      }
      
      public function get Agility() : int
      {
         return _agility;
      }
      
      public function set Agility(value:int) : void
      {
         if(_agility == value)
         {
            return;
         }
         _agility = value;
         onPropertiesChanged("Agility");
      }
      
      public function get MagicAttack() : int
      {
         return _magicAttack;
      }
      
      public function set MagicAttack(value:int) : void
      {
         if(_magicAttack == value)
         {
            return;
         }
         _magicAttack = value;
         onPropertiesChanged("MagicAttack");
      }
      
      public function get MagicDefence() : int
      {
         return _magicDefence;
      }
      
      public function set MagicDefence(value:int) : void
      {
         if(_magicDefence == value)
         {
            return;
         }
         _magicDefence = value;
         onPropertiesChanged("MagicDefence");
      }
      
      public function setAttackDefenseValues(attack:int, defense:int, agility:int, luck:int, magicAttack:int, magicDefence:int) : void
      {
         Attack = attack;
         Defence = defense;
         Agility = agility;
         Luck = luck;
         MagicAttack = magicAttack;
         MagicDefence = magicDefence;
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
      
      public function set dungeonFlag(value:Object) : void
      {
         if(_dungeonFlag == value)
         {
            return;
         }
         _dungeonFlag = value;
      }
      
      public function get propertyAddition() : DictionaryData
      {
         if(!_propertyAddition)
         {
            _propertyAddition = new DictionaryData();
         }
         return _propertyAddition;
      }
      
      public function set propertyAddition(val:DictionaryData) : void
      {
         _propertyAddition = val;
      }
      
      public function getPropertyAdditionByType(type:String) : DictionaryData
      {
         if(_propertyAddition && _propertyAddition.hasKey(type))
         {
            return _propertyAddition[type];
         }
         return null;
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
         var arr:Array = Bag.findBodyThingByCategory(17).concat(Bag.findBodyThingByCategory(31));
         if(arr.length > 0)
         {
            return arr[0] as InventoryItemInfo;
         }
         return null;
      }
      
      public function set DeputyWeaponID(value:int) : void
      {
         if(_deputyWeaponID == value)
         {
            return;
         }
         _deputyWeaponID = value;
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
      
      public function set webSpeed(value:int) : void
      {
         _webSpeed = value;
         dispatchEvent(new WebSpeedEvent("stateChange"));
      }
      
      public function get WeaponID() : int
      {
         return _weaponID;
      }
      
      public function set WeaponID(value:int) : void
      {
         if(_weaponID == value)
         {
            return;
         }
         _weaponID = value;
         onPropertiesChanged("WeaponID");
      }
      
      public function set paopaoType(type:int) : void
      {
         _paopaoType = type;
         onPropertiesChanged("paopaoType");
      }
      
      public function get buffInfo#1() : DictionaryData
      {
         return _buffInfo;
      }
      
      protected function set buffInfo#6(buffs:DictionaryData) : void
      {
         _buffInfo = buffs;
         onPropertiesChanged("buffInfo");
      }
      
      public function addBuff(buff:BuffInfo) : void
      {
         _buffInfo.add(buff.Type,buff);
      }
      
      public function clearBuff() : void
      {
         _buffInfo.clear();
      }
      
      public function hasBuff(buffType:int) : Boolean
      {
         if(buffType == 15)
         {
            return true;
         }
         var buff:BuffInfo = getBuff(buffType);
         return buff != null && buff.IsExist;
      }
      
      public function getBuff(buffType:int) : BuffInfo
      {
         return _buffInfo[buffType];
      }
      
      public function get PvePermission() : String
      {
         return _pvePermission;
      }
      
      public function set PvePermission(permission:String) : void
      {
         if(_pvePermission == permission)
         {
            return;
         }
         if(permission == "")
         {
            _pvePermission = "11111111111111111111111111111111111111111111111111";
         }
         else
         {
            if(_pvePermission != null)
            {
               if(_pvePermission.substr(0,1) == "1" && permission.substr(0,1) == "3")
               {
                  _isDupSimpleTip = true;
               }
            }
            _pvePermission = permission;
         }
         onPropertiesChanged("PvePermission");
      }
      
      public function get fightLibMission() : String
      {
         return _fightLibMission == null || _fightLibMission == ""?"0000000000":_fightLibMission;
      }
      
      public function set fightLibMission(value:String) : void
      {
         _fightLibMission = value;
         onPropertiesChanged("fightLibMission");
      }
      
      public function get LastSpaDate() : Object
      {
         return _lastSpaDate;
      }
      
      public function set LastSpaDate(value:Object) : void
      {
         _lastSpaDate = value;
      }
      
      public function set PveEpicPermission(value:String) : void
      {
         if(this._pveEpicPermission == value)
         {
            return;
         }
         this._pveEpicPermission = value;
         onPropertiesChanged("PveEpicPermission");
      }
      
      public function get PveEpicPermission() : String
      {
         return _pveEpicPermission;
      }
      
      public function setMasterOrApprentices(value:String) : void
      {
         var nickNames:* = null;
         var i:int = 0;
         var idOrNickName:* = null;
         if(!_masterOrApprentices)
         {
            _masterOrApprentices = new DictionaryData();
         }
         _masterOrApprentices.clear();
         if(value != "")
         {
            nickNames = value.split(",");
            for(i = 0; i < nickNames.length; )
            {
               idOrNickName = nickNames[i].split("|");
               _masterOrApprentices.add(int(idOrNickName[0]),idOrNickName[1]);
               i++;
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
      
      public function set masterID(value:int) : void
      {
         _masterID = value;
      }
      
      public function get masterID() : int
      {
         return _masterID;
      }
      
      public function isMyMaster(id:int) : Boolean
      {
         return id == _masterID;
      }
      
      public function isMyApprent(id:int) : Boolean
      {
         return _masterOrApprentices[id];
      }
      
      public function set graduatesCount(value:int) : void
      {
         _graduatesCount = value;
      }
      
      public function get graduatesCount() : int
      {
         return _graduatesCount;
      }
      
      public function set honourOfMaster(value:String) : void
      {
         _honourOfMaster = value;
      }
      
      public function get honourOfMaster() : String
      {
         return _honourOfMaster;
      }
      
      public function set freezesDate(value:Date) : void
      {
         _freezesDate = value;
      }
      
      public function get freezesDate() : Date
      {
         return _freezesDate;
      }
      
      public function set myGiftData(list:Vector.<MyGiftCellInfo>) : void
      {
         _myGiftData = list;
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
         var sum:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = myGiftData;
         for each(var info in myGiftData)
         {
            sum = sum + info.amount;
         }
         return sum;
      }
      
      public function set charmLevel(value:int) : void
      {
         _charmLevel = value;
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
      
      public function set charmGP(value:int) : void
      {
         _charmGP = value;
         charmLevel = getCharLevel(value);
         onPropertiesChanged("GiftGp");
      }
      
      private function getCharLevel(value:int) : int
      {
         var i:int = 0;
         var level:* = 0;
         for(i = 0; i < CHARM_LEVEL_ALL_EXP.length; )
         {
            if(value >= CHARM_LEVEL_ALL_EXP[100 - 1])
            {
               level = 100;
               break;
            }
            if(value < CHARM_LEVEL_ALL_EXP[i])
            {
               level = i;
               break;
            }
            if(value <= 0)
            {
               level = 1;
               break;
            }
            i++;
         }
         return level;
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
      
      public function set cardEquipDic(value:DictionaryData) : void
      {
         if(_cardEquipDic == value)
         {
            return;
         }
         _cardEquipDic = value;
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
      
      public function set cardBagDic(value:DictionaryData) : void
      {
         if(_cardBagDic == value)
         {
            return;
         }
         _cardBagDic = value;
         onPropertiesChanged("cardBagDic");
      }
      
      public function getCardInfoByID(id:int) : CardInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _cardBagDic;
         for each(var cardInfo in _cardBagDic)
         {
            if(cardInfo.TemplateID == id)
            {
               return cardInfo;
            }
         }
         return null;
      }
      
      public function getCardNumByType(type:int) : int
      {
         var count:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = _cardBagDic;
         for each(var cardInfo in _cardBagDic)
         {
            if(cardInfo.CardType <= type || cardInfo.CardType == 4)
            {
               count++;
            }
         }
         return count;
      }
      
      public function checkCurrentCardSets(id:int, type:int = 3) : Boolean
      {
         var cardInfo:* = null;
         var cardSetsInfo:SetsInfo = CardManager.Instance.getCardSuitByID(id);
         var _loc7_:int = 0;
         var _loc6_:* = cardSetsInfo.cardIdVec;
         for each(var cardID in cardSetsInfo.cardIdVec)
         {
            cardInfo = getCardInfoByID(cardID);
            if(cardInfo == null || cardInfo.CardType > type && cardInfo.CardType != 4)
            {
               return false;
            }
         }
         return true;
      }
      
      public function getCurrentCardSetsNum(id:int, type:int = 3) : int
      {
         var cardInfo:* = null;
         var count:int = 0;
         var cardSetsInfo:SetsInfo = CardManager.Instance.getCardSuitByID(id);
         var _loc8_:int = 0;
         var _loc7_:* = cardSetsInfo.cardIdVec;
         for each(var cardID in cardSetsInfo.cardIdVec)
         {
            cardInfo = getCardInfoByID(cardID);
            if(cardInfo && (cardInfo.CardType <= type || cardInfo.CardType == 4))
            {
               count++;
            }
         }
         return count;
      }
      
      public function gainCardSetsNum(type:int) : int
      {
         var count:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = CardManager.Instance.model.setsSortRuleVector;
         for each(var item in CardManager.Instance.model.setsSortRuleVector)
         {
            if(PlayerManager.Instance.Self.checkCurrentCardSets(int(item.ID),type))
            {
               count++;
            }
         }
         return count;
      }
      
      public function getOptionState(OptionType:int) : Boolean
      {
         return (OptionOnOff & OptionType) == OptionType;
      }
      
      public function get shopFinallyGottenTime() : Date
      {
         return _shopFinallyGottenTime;
      }
      
      public function set shopFinallyGottenTime(value:Date) : void
      {
         if(_shopFinallyGottenTime == value)
         {
            return;
         }
         _shopFinallyGottenTime = value;
         dispatchEvent(new Event("shopFinallyGottenTime"));
      }
      
      public function getLastDate() : int
      {
         var totalHours:int = 0;
         var now:Date = TimeManager.Instance.Now();
         var hours:int = (now.valueOf() - _lastDate.valueOf()) / 3600000;
         totalHours = hours < 1?1:hours;
         return totalHours;
      }
      
      public function set lastDate(value:Date) : void
      {
         _lastDate = value;
      }
      
      public function get lastDate() : Date
      {
         return _lastDate;
      }
      
      public function get isSameCity() : Boolean
      {
         return _isSameCity;
      }
      
      public function set isSameCity(value:Boolean) : void
      {
         _isSameCity = value;
      }
      
      public function set IsShowConsortia(boo:Boolean) : void
      {
         if(_IsShowConsortia == boo)
         {
            return;
         }
         _IsShowConsortia = boo;
         onPropertiesChanged("IsShowConsortia");
      }
      
      public function get IsShowConsortia() : Boolean
      {
         return _IsShowConsortia;
      }
      
      public function get showDesignation() : String
      {
         var str:String = !!IsShowConsortia?ConsortiaName:honor;
         if(!str)
         {
            str = ConsortiaName;
         }
         if(!str)
         {
            str = honor;
         }
         return str;
      }
      
      public function get badLuckNumber() : int
      {
         return _badLuckNumber;
      }
      
      public function set badLuckNumber(value:int) : void
      {
         if(_badLuckNumber != value)
         {
            _badLuckNumber = value;
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
      
      public function set isSelf(value:Boolean) : void
      {
         _isSelf = value;
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
         var resultPetInfo:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _pets;
         for each(var petInfo in _pets)
         {
            if(petInfo.IsEquip)
            {
               resultPetInfo = petInfo;
            }
         }
         return resultPetInfo;
      }
      
      public function set damageScores(value:int) : void
      {
         if(_damageScores == value)
         {
            return;
         }
         _damageScores = value;
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
      
      public function set embedUpLevelCell(value:EmbedUpLevelCell) : void
      {
         _embedUpLevelCell = value;
      }
      
      public function get totemId() : int
      {
         return _totemId;
      }
      
      public function set totemId(value:int) : void
      {
         _totemId = value;
      }
      
      public function addTotemGrade(totemID:int, grade:int) : void
      {
         if(!_totemGrades.hasKey(totemID))
         {
            _totemGrades.add(totemID,grade);
         }
         else
         {
            _totemGrades[totemID] = grade;
         }
      }
      
      public function getTotemGradeByID(chapterID:int) : int
      {
         if(_totemGrades.hasKey(chapterID))
         {
            return _totemGrades[chapterID];
         }
         return 0;
      }
      
      public function get totemGrades() : DictionaryData
      {
         if(_totemGrades == null)
         {
            _totemGrades = new DictionaryData();
         }
         return _totemGrades;
      }
      
      public function set gemstoneList(list:Vector.<GemstonInitInfo>) : void
      {
         _gemstoneList = list;
      }
      
      public function get gemstoneList() : Vector.<GemstonInitInfo>
      {
         return _gemstoneList;
      }
      
      public function get hardCurrency() : int
      {
         return _hardCurrency;
      }
      
      public function set hardCurrency(value:int) : void
      {
         if(_hardCurrency == value)
         {
            return;
         }
         _hardCurrency = value;
         onPropertiesChanged("hardCurrency");
      }
      
      public function get jampsCurrency() : int
      {
         return _jampsCurrency;
      }
      
      public function set jampsCurrency(value:int) : void
      {
         if(_jampsCurrency == value)
         {
            return;
         }
         _jampsCurrency = value;
         onPropertiesChanged("jampsCurrency");
      }
      
      public function get leagueMoney() : int
      {
         return _leagueMoney;
      }
      
      public function set leagueMoney(value:int) : void
      {
         _leagueMoney = value;
         onPropertiesChanged("leagueMoney");
      }
      
      public function get necklaceExp() : int
      {
         return _necklaceExp;
      }
      
      public function set necklaceExp(value:int) : void
      {
         _necklaceExp = value;
         necklaceLevel = StoreEquipExperience.getNecklaceLevelByGP(_necklaceExp);
         onPropertiesChanged("necklaceExp");
      }
      
      public function get necklaceLevel() : int
      {
         return _necklaceLevel;
      }
      
      public function set necklaceLevel(value:int) : void
      {
         _necklaceLevel = value;
         onPropertiesChanged("necklaceLevel");
      }
      
      public function get necklaceExpAdd() : int
      {
         return _necklaceExpAdd;
      }
      
      public function set necklaceExpAdd(value:int) : void
      {
         _necklaceExpAdd = value;
         onPropertiesChanged("necklaceExpAdd");
      }
      
      public function get pvpBadgeId() : int
      {
         return _pvpBadgeId;
      }
      
      public function set pvpBadgeId(value:int) : void
      {
         _pvpBadgeId = value;
      }
      
      public function get isTrusteeship() : Boolean
      {
         return _isTrusteeship;
      }
      
      public function set isTrusteeship(value:Boolean) : void
      {
         _isTrusteeship = value;
         dispatchEvent(new GameEvent("trusteeshipChange",value));
      }
      
      public function get fightStatus() : int
      {
         return _fightStatus;
      }
      
      public function set fightStatus(value:int) : void
      {
         _fightStatus = value;
         dispatchEvent(new GameEvent("gameFightStatusChange",value));
      }
      
      public function get accumulativeLoginDays() : int
      {
         return _accumulativeLoginDays;
      }
      
      public function set accumulativeLoginDays(value:int) : void
      {
         _accumulativeLoginDays = value;
      }
      
      public function get accumulativeAwardDays() : int
      {
         return _accumulativeAwardDays;
      }
      
      public function set accumulativeAwardDays(value:int) : void
      {
         _accumulativeAwardDays = value;
      }
      
      public function get evolutionGrade() : int
      {
         return _evolutionGrade;
      }
      
      public function set evolutionGrade(value:int) : void
      {
         _evolutionGrade = value;
      }
      
      public function get evolutionExp() : int
      {
         return _evolutionExp;
      }
      
      public function set evolutionExp(value:int) : void
      {
         _evolutionExp = value;
      }
      
      public function get horsePicCherishBlood() : int
      {
         return _horsePicCherishBlood;
      }
      
      public function set horsePicCherishBlood(value:int) : void
      {
         _horsePicCherishBlood = value;
      }
      
      public function get horsePicCherishGuard() : int
      {
         return _horsePicCherishGuard;
      }
      
      public function set horsePicCherishGuard(value:int) : void
      {
         _horsePicCherishGuard = value;
      }
      
      public function get horsePicCherishHurt() : int
      {
         return _horsePicCherishHurt;
      }
      
      public function set horsePicCherishHurt(value:int) : void
      {
         _horsePicCherishHurt = value;
      }
      
      public function get horsePicCherishMagicAttack() : int
      {
         return _horsePicCherishMagicAttack;
      }
      
      public function set horsePicCherishMagicAttack(value:int) : void
      {
         _horsePicCherishMagicAttack = value;
      }
      
      public function get horsePicCherishMagicDefence() : int
      {
         return _horsePicCherishMagicDefence;
      }
      
      public function set horsePicCherishMagicDefence(value:int) : void
      {
         _horsePicCherishMagicDefence = value;
      }
      
      public function get horsePicCherishDic() : DictionaryData
      {
         if(_horsePicCherishDic == null)
         {
            _horsePicCherishDic = new DictionaryData();
         }
         return _horsePicCherishDic;
      }
      
      public function set peerID(id:String) : void
      {
         _peerID = id;
      }
      
      public function get peerID() : String
      {
         return _peerID;
      }
      
      public function get horseInBookRidingID() : int
      {
         return _horseInBookRidingID;
      }
      
      public function set horseInBookRidingID(value:int) : void
      {
         _horseInBookRidingID = value;
      }
      
      public function get fineSuitExp() : int
      {
         return _fineSuitExp;
      }
      
      public function set fineSuitExp(value:int) : void
      {
         if(_fineSuitExp == value)
         {
            return;
         }
         _fineSuitExp = value;
      }
      
      public function get guardCoreGrade() : int
      {
         return _guardCoreGrade;
      }
      
      public function set guardCoreGrade(value:int) : void
      {
         if(_guardCoreGrade == value)
         {
            return;
         }
         _guardCoreGrade = value;
         onPropertiesChanged("GuardCoreGrade");
      }
      
      public function get guardCoreID() : int
      {
         return _guardCoreID;
      }
      
      public function set guardCoreID(value:int) : void
      {
         if(_guardCoreID == value)
         {
            return;
         }
         _guardCoreID = value;
         onPropertiesChanged("GuardCoreID");
      }
      
      public function get experience_Rate() : Number
      {
         return _experience_Rate;
      }
      
      public function set experience_Rate(value:Number) : void
      {
         _experience_Rate = value;
      }
      
      public function get offer_Rate() : Number
      {
         return _offer_Rate;
      }
      
      public function set offer_Rate(value:Number) : void
      {
         _offer_Rate = value;
      }
      
      public function get trailEliteLevel() : int
      {
         return _trailEliteLevel;
      }
      
      public function set trailEliteLevel(value:int) : void
      {
         _trailEliteLevel = value;
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
      
      public function set horseAmuletHp(value:int) : void
      {
         _horseAmuletHp = value;
      }
      
      public function addGhostData(data:EquipGhostData) : void
      {
         if(_ghostDic == null)
         {
            _ghostDic = new Dictionary(true);
         }
         _ghostDic[data.categoryID] = data;
      }
      
      public function getGhostData(bagType:int, place:int) : EquipGhostData
      {
         var categoryID:int = BagInfo.parseCategoryID(bagType,place);
         return getGhostDataByCategoryID(categoryID);
      }
      
      public function getGhostDataByCategoryID(categoryID:int) : EquipGhostData
      {
         if(_ghostDic == null)
         {
            return null;
         }
         if(categoryID == 27)
         {
            categoryID = 7;
         }
         return _ghostDic[categoryID];
      }
      
      public function getMarkChipCntByPlace(place:int) : int
      {
         var cnt:int = 0;
         if(ID == PlayerManager.Instance.Self.ID)
         {
            cnt = MarkMgr.inst.model.getChipsCount(place);
         }
         else
         {
            var _loc5_:int = 0;
            var _loc4_:* = Markbag.chips;
            for each(var chip in Markbag.chips)
            {
               if(chip.equipType == place)
               {
                  cnt++;
               }
            }
         }
         return cnt;
      }
      
      public function getMarkChipPropsByPlace(place:int) : Dictionary
      {
         var pro:* = null;
         var props:Dictionary = null;
         if(ID == PlayerManager.Instance.Self.ID)
         {
            props = MarkMgr.inst.calculateEquipProps(place);
         }
         else
         {
            props = new Dictionary();
            pro = null;
            var _loc10_:int = 0;
            var _loc9_:* = Markbag.chips;
            for each(var chip in Markbag.chips)
            {
               if(chip.equipType == place)
               {
                  pro = chip.mainPro;
                  var _loc6_:* = pro.type;
                  props[_loc6_] = props[_loc6_] || new MarkProData();
                  props[pro.type].type = chip.mainPro.type;
                  props[pro.type].value = props[pro.type].value + pro.value;
                  props[pro.type].attachValue = props[pro.type].attachValue + pro.attachValue;
                  var _loc8_:int = 0;
                  var _loc7_:* = chip.props;
                  for each(var item in chip.props)
                  {
                     _loc6_ = item.type;
                     props[_loc6_] = props[_loc6_] || new MarkProData();
                     props[item.type].type = item.type;
                     props[item.type].value = props[item.type].value + item.value;
                     props[item.type].attachValue = props[item.type].attachValue + item.attachValue;
                  }
                  continue;
               }
            }
         }
         return props;
      }
      
      public function getSuitListByPlace(place:int) : Array
      {
         var tmp:* = null;
         var i:int = 0;
         var dic:* = null;
         var arr:Array = [];
         if(ID == PlayerManager.Instance.Self.ID)
         {
            tmp = MarkMgr.inst.model.getSuitList(place);
            for(i = 0; i < tmp.length; )
            {
               arr.push(tmp[i].id);
               i++;
            }
         }
         else
         {
            dic = new Dictionary();
            var _loc10_:int = 0;
            var _loc9_:* = Markbag.chips;
            for each(var chip in Markbag.chips)
            {
               if(chip.equipType == place)
               {
                  var _loc8_:* = MarkMgr.inst.model.cfgChip[chip.templateId].SetID;
                  dic[_loc8_] = dic[_loc8_] || [];
                  dic[MarkMgr.inst.model.cfgChip[chip.templateId].SetID].push(chip);
               }
            }
            var _loc12_:int = 0;
            var _loc11_:* = MarkMgr.inst.model.cfgSuit;
            for each(var it in MarkMgr.inst.model.cfgSuit)
            {
               if(dic[it.SetId] && it.Demand <= dic[it.SetId].length)
               {
                  arr.push(it.Id);
               }
            }
         }
         return arr;
      }
      
      public function clone() : PlayerInfo
      {
         var tempPlayerInfo:PlayerInfo = new PlayerInfo();
         ObjectUtils.copyProperties(tempPlayerInfo,this);
         return tempPlayerInfo;
      }
   }
}
