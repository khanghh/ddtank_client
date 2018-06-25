package ddt.manager
{
   import ddt.events.SharedEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.SharedObject;
   import flash.utils.Dictionary;
   
   [Event(name="change",type="flash.events.Event")]
   public class SharedManager extends EventDispatcher
   {
      
      public static var RIGHT_PROP:Array = [10001,10003,10002,10004,10005,10006,10007];
      
      public static const KEY_SET_ABLE:Array = [10001,10003,10002,10004,10005,10006,10007,10008];
      
      private static var instance:SharedManager = new SharedManager();
       
      
      private var _allowMusic:Boolean = true;
      
      private var _allowSound:Boolean = true;
      
      public var showTopMessageBar:Boolean = true;
      
      private var _showInvateWindow:Boolean = true;
      
      public var showParticle:Boolean = true;
      
      public var showOL:Boolean = true;
      
      public var showCI:Boolean = true;
      
      public var showHat:Boolean = true;
      
      public var showGlass:Boolean = true;
      
      public var showSuit:Boolean = true;
      
      public var fastReplys:Object;
      
      public var musicVolumn:int = 50;
      
      public var soundVolumn:int = 50;
      
      public var StrengthMoney:int = 1000;
      
      public var ComposeMoney:int = 1000;
      
      public var FusionMoney:int = 1000;
      
      public var TransferMoney:int = 1000;
      
      public var KeyAutoSnap:Boolean = true;
      
      public var ShowBattleGuide:Boolean = true;
      
      public var isHintPropExpire:Boolean = true;
      
      public var AutoReady:Boolean = true;
      
      public var GameKeySets:Object;
      
      public var AuctionInfos:Object;
      
      public var AuctionIDs:Object;
      
      public var setBagLocked:Boolean = false;
      
      public var hasStrength3:Object;
      
      public var recentContactsID:Object;
      
      public var StoreBuyInfo:Object;
      
      public var deadtip:int = 0;
      
      public var hasCheckedOverFrameRate:Boolean = false;
      
      public var hasEnteredFightLib:Object;
      
      public var isAffirm:Boolean = true;
      
      public var recommendNum:int = 0;
      
      public var isRecommend:Boolean = false;
      
      public var unAcceptAnswer:Array;
      
      public var isSetingMovieClip:Boolean = true;
      
      public var isRefreshSkill:Boolean = false;
      
      public var voteData:Dictionary;
      
      public var giftFirstShow:Boolean = true;
      
      public var isAuctionHouseTodayUseBugle:Boolean = true;
      
      public var cardSystemShow:Boolean = true;
      
      public var texpSystemShow:Boolean = true;
      
      public var divorceBoolean:Boolean = true;
      
      public var isRemindSnowPackDouble:Boolean = false;
      
      public var friendBrithdayName:String = "";
      
      private var _autoSnsSend:Boolean = false;
      
      public var stoneFriend:Boolean = true;
      
      public var spacialReadedMail:Dictionary;
      
      public var deleteMail:Dictionary;
      
      public var privateChatRecord:Dictionary;
      
      public var teamChatRecord:Dictionary;
      
      public var autoWish:Boolean = false;
      
      public var isRemindRoll:Boolean = false;
      
      public var isRemindRollBind:Boolean = false;
      
      public var isRemindOverCard:Boolean = false;
      
      public var isRemindOverCardBind:Boolean = false;
      
      public var transregionalblackList:Dictionary;
      
      public var isRemindTreasureBind:Boolean = true;
      
      public var isTreasureBind:Boolean = false;
      
      public var lastBuyCount:int;
      
      public var friendshipEffect:Boolean;
      
      public var guardEffect:Boolean;
      
      private var _manualNewChapters:Array;
      
      private var _manualNewPages:Array;
      
      public var isBuyexclude:Boolean = false;
      
      public var isBuyexcludeBind:Boolean = true;
      
      private var _allowSnsSend:Boolean = false;
      
      private var _autoVip:Boolean = false;
      
      private var _autoCelebration:Boolean = false;
      
      private var _autoCaddy:Boolean = false;
      
      private var _autoOfferPack:Boolean = false;
      
      private var _autoBead:Boolean = false;
      
      private var _autoWishBead:Boolean = false;
      
      private var _edictumVersion:String = "";
      
      private var _propLayerMode:int = 2;
      
      private var _isCommunity:Boolean = false;
      
      private var _isWishPop:Boolean;
      
      private var _isFirstWish:Boolean;
      
      public var isRefreshPet:Boolean = false;
      
      public var isRefreshBand:Boolean = false;
      
      public var isWorldBossBuyBuff:Boolean = false;
      
      public var isWorldBossBindBuyBuff:Boolean = false;
      
      public var isWorldBossBuyBuffFull:Boolean = false;
      
      public var isWorldBossBindBuyBuffFull:Boolean = false;
      
      public var isResurrect:Boolean = false;
      
      public var isResurrectBind:Boolean = true;
      
      public var isReFight:Boolean = false;
      
      public var isReFightBind:Boolean = true;
      
      public var isBuyInteger:Boolean = false;
      
      public var isBuyIntegerBind:Boolean = true;
      
      public var isBuyHit:Boolean = false;
      
      public var isBuyHitBind:Boolean = true;
      
      public var isShowDdtImportantView:Boolean = true;
      
      public var awayAutoReply:Object;
      
      public var busyAutoReply:Object;
      
      public var noDistrubAutoReply:Object;
      
      public var shoppingAutoReply:Object;
      
      public var halliconExperienceStep:int = 0;
      
      public var isDragonBoatOpenFrame:Boolean = false;
      
      public var flashInfoExist:Boolean;
      
      private var _propTransparent:Boolean = false;
      
      public var homeFightReviveAlert:Boolean = false;
      
      public var boxType:int = 1;
      
      public function SharedManager()
      {
         fastReplys = {};
         GameKeySets = {};
         AuctionInfos = {};
         AuctionIDs = {};
         hasStrength3 = {};
         recentContactsID = {};
         StoreBuyInfo = {};
         hasEnteredFightLib = {};
         unAcceptAnswer = [];
         voteData = new Dictionary();
         spacialReadedMail = new Dictionary();
         deleteMail = new Dictionary();
         privateChatRecord = new Dictionary();
         teamChatRecord = new Dictionary();
         transregionalblackList = new Dictionary();
         _manualNewChapters = [];
         _manualNewPages = [];
         awayAutoReply = {};
         busyAutoReply = {};
         noDistrubAutoReply = {};
         shoppingAutoReply = {};
         super();
      }
      
      public static function get Instance() : SharedManager
      {
         return instance;
      }
      
      public function get manualNewPages() : Array
      {
         return _manualNewPages;
      }
      
      public function set manualNewPages(value:Array) : void
      {
         _manualNewPages = value;
      }
      
      public function get manualNewChapters() : Array
      {
         return _manualNewChapters;
      }
      
      public function set manualNewChapters(value:Array) : void
      {
         _manualNewChapters = value;
      }
      
      public function get allowSound() : Boolean
      {
         return _allowSound;
      }
      
      public function set allowSound(value:Boolean) : void
      {
         _allowSound = value;
         checkAllMusicClose();
      }
      
      public function get allowMusic() : Boolean
      {
         return _allowMusic;
      }
      
      public function set allowMusic(value:Boolean) : void
      {
         _allowMusic = value;
         checkAllMusicClose();
      }
      
      private function checkAllMusicClose() : void
      {
         var transform:SoundTransform = SoundMixer.soundTransform;
         if(!_allowSound && !_allowMusic)
         {
            transform.volume = 0;
         }
         else
         {
            transform.volume = 1;
         }
         SoundMixer.soundTransform = transform;
      }
      
      public function get autoSnsSend() : Boolean
      {
         return _autoSnsSend;
      }
      
      public function set autoSnsSend(value:Boolean) : void
      {
         if(_autoSnsSend == value)
         {
            return;
         }
         _autoSnsSend = value;
         save();
      }
      
      public function get allowSnsSend() : Boolean
      {
         return _allowSnsSend;
      }
      
      public function get autoVip() : Boolean
      {
         return _autoVip;
      }
      
      public function set autoVip(val:Boolean) : void
      {
         if(_autoVip != val)
         {
            _autoVip = val;
            save();
         }
      }
      
      public function get autoCelebration() : Boolean
      {
         return _autoCelebration;
      }
      
      public function set autoCelebration(value:Boolean) : void
      {
         if(_autoCelebration != value)
         {
            _autoCelebration = value;
            save();
         }
      }
      
      public function get autoCaddy() : Boolean
      {
         return _autoCaddy;
      }
      
      public function set autoCaddy(val:Boolean) : void
      {
         if(_autoCaddy != val)
         {
            _autoCaddy = val;
            save();
         }
      }
      
      public function get autoOfferPack() : Boolean
      {
         return _autoOfferPack;
      }
      
      public function set autoOfferPack(val:Boolean) : void
      {
         if(_autoOfferPack != val)
         {
            _autoOfferPack = val;
            save();
         }
      }
      
      public function get autoBead() : Boolean
      {
         return _autoBead;
      }
      
      public function set autoWishBead(val:Boolean) : void
      {
         if(_autoWishBead != val)
         {
            _autoWishBead = val;
            save();
         }
      }
      
      public function get autoWishBead() : Boolean
      {
         return _autoWishBead;
      }
      
      public function set autoBead(val:Boolean) : void
      {
         if(_autoBead != val)
         {
            _autoBead = val;
            save();
         }
      }
      
      public function get edictumVersion() : String
      {
         return _edictumVersion;
      }
      
      public function set edictumVersion(value:String) : void
      {
         if(_edictumVersion != value)
         {
            _edictumVersion = value;
            save();
         }
      }
      
      public function get propLayerMode() : int
      {
         if(PlayerManager.Instance.Self.Grade < 4)
         {
            return 2;
         }
         return _propLayerMode;
      }
      
      public function set propLayerMode(val:int) : void
      {
         if(_propLayerMode != val)
         {
            _propLayerMode = val;
            save();
         }
      }
      
      public function set allowSnsSend(value:Boolean) : void
      {
         if(_allowSnsSend == value)
         {
            return;
         }
         _allowSnsSend = value;
         save();
      }
      
      public function get showInvateWindow() : Boolean
      {
         return _showInvateWindow;
      }
      
      public function set showInvateWindow(value:Boolean) : void
      {
         _showInvateWindow = value;
      }
      
      public function get isCommunity() : Boolean
      {
         return _isCommunity;
      }
      
      public function set isCommunity(value:Boolean) : void
      {
         _isCommunity = value;
      }
      
      public function get isWishPop() : Boolean
      {
         return _isWishPop;
      }
      
      public function set isWishPop(value:Boolean) : void
      {
         _isWishPop = value;
      }
      
      public function get isFirstWish() : Boolean
      {
         return _isFirstWish;
      }
      
      public function set isFirstWish(value:Boolean) : void
      {
         _isFirstWish = value;
      }
      
      public function setup() : void
      {
         load();
      }
      
      public function reset() : void
      {
         var so:SharedObject = SharedObject.getLocal("road");
         so.clear();
         so.flush(20971520);
      }
      
      private function load() : void
      {
         var so:* = null;
         var i:int = 0;
         var j:int = 0;
         var _loc21_:int = 0;
         try
         {
            so = SharedObject.getLocal("road");
            AuctionInfos = {};
            if(so && so.data)
            {
               if(so.data["allowMusic"] != undefined)
               {
                  allowMusic = so.data["allowMusic"];
               }
               if(so.data["allowSound"] != undefined)
               {
                  allowSound = so.data["allowSound"];
               }
               if(so.data["showTopMessageBar"] != undefined)
               {
                  showTopMessageBar = so.data["showTopMessageBar"];
               }
               if(so.data["showInvateWindow"] != undefined)
               {
                  showInvateWindow = so.data["showInvateWindow"];
               }
               if(so.data["showParticle"] != undefined)
               {
                  showParticle = so.data["showParticle"];
               }
               if(so.data["showOL"] != undefined)
               {
                  showOL = so.data["showOL"];
               }
               if(so.data["showCI"] != undefined)
               {
                  showCI = so.data["showCI"];
               }
               if(so.data["showHat"] != undefined)
               {
                  showHat = so.data["showHat"];
               }
               if(so.data["showGlass"] != undefined)
               {
                  showGlass = so.data["showGlass"];
               }
               if(so.data["showSuit"] != undefined)
               {
                  showSuit = so.data["showSuit"];
               }
               if(so.data["musicVolumn"] != undefined)
               {
                  musicVolumn = so.data["musicVolumn"];
               }
               if(so.data["soundVolumn"] != undefined)
               {
                  soundVolumn = so.data["soundVolumn"];
               }
               if(so.data["KeyAutoSnap"] != undefined)
               {
                  KeyAutoSnap = so.data["KeyAutoSnap"];
               }
               if(so.data["giftFirstShow"] != undefined)
               {
                  giftFirstShow = so.data["giftFirstShow"];
               }
               if(so.data["cardSystemShow"] != undefined)
               {
                  cardSystemShow = so.data["cardSystemShow"];
               }
               if(so.data["texpSystemShow"] != undefined)
               {
                  texpSystemShow = so.data["texpSystemShow"];
               }
               if(so.data["divorceBoolean"] != undefined)
               {
                  divorceBoolean = so.data["divorceBoolean"];
               }
               if(so.data["friendBrithdayName"] != undefined)
               {
                  friendBrithdayName = so.data["friendBrithdayName"];
               }
               if(so.data["AutoReady"] != undefined)
               {
                  AutoReady = so.data["AutoReady"];
               }
               if(so.data["ShowBattleGuide"] != undefined)
               {
                  ShowBattleGuide = so.data["ShowBattleGuide"];
               }
               if(so.data["isHintPropExpire"] != undefined)
               {
                  isHintPropExpire = so.data["isHintPropExpire"];
               }
               if(so.data["hasCheckedOverFrameRate"] != undefined)
               {
                  hasCheckedOverFrameRate = so.data["hasCheckedOverFrameRate"];
               }
               if(so.data["isRecommend"] != undefined)
               {
                  isRecommend = so.data["isRecommend"];
               }
               if(so.data["recommendNum"] != undefined)
               {
                  recommendNum = so.data["recommendNum"];
               }
               if(so.data["isSetingMovieClip"] != undefined)
               {
                  isSetingMovieClip = so.data["isSetingMovieClip"];
               }
               if(so.data["propLayerMode"] != undefined)
               {
                  _propLayerMode = so.data["propLayerMode"];
               }
               if(so.data["autoCaddy"] != undefined)
               {
                  _autoCaddy = so.data["autoCaddy"];
               }
               if(so.data["autoOfferPack"] != undefined)
               {
                  _autoOfferPack = so.data["autoOfferPack"];
               }
               if(so.data["autoBead"] != undefined)
               {
                  _autoBead = so.data["autoBead"];
               }
               if(so.data["edictumVersion"] != undefined)
               {
                  _edictumVersion = so.data["edictumVersion"];
               }
               if(so.data["isFirstWish"] != undefined)
               {
                  _isFirstWish = so.data["isFirstWish"];
               }
               if(so.data["stoneFriend"] != undefined)
               {
                  stoneFriend = so.data["stoneFriend"];
               }
               if(so.data["halliconExperienceStep"] != undefined)
               {
                  halliconExperienceStep = so.data["halliconExperienceStep"];
               }
               if(so.data["isRefreshSkill"] != undefined)
               {
                  isRefreshSkill = so.data["isRefreshSkill"];
               }
               if(so.data["autoCelebration"] != undefined)
               {
                  _autoCelebration = so.data["autoCelebration"];
               }
               if(so.data["hasStrength3"] != undefined)
               {
                  var _loc23_:int = 0;
                  var _loc22_:* = so.data["hasStrength3"];
                  for(var key in so.data["hasStrength3"])
                  {
                     hasStrength3[key] = so.data["hasStrength3"][key];
                  }
               }
               if(so.data["recentContactsID"] != undefined)
               {
                  var _loc25_:int = 0;
                  var _loc24_:* = so.data["recentContactsID"];
                  for(var keyII in so.data["recentContactsID"])
                  {
                     recentContactsID[keyII] = so.data["recentContactsID"][keyII];
                  }
               }
               if(so.data["voteData"] != undefined)
               {
                  var _loc27_:int = 0;
                  var _loc26_:* = so.data["voteData"];
                  for(var keyIII in so.data["voteData"])
                  {
                     voteData[keyIII] = so.data["voteData"][keyIII];
                  }
               }
               if(so.data["spacialReadedMail"] != undefined)
               {
                  var _loc29_:int = 0;
                  var _loc28_:* = so.data["spacialReadedMail"];
                  for(var keyIV in so.data["spacialReadedMail"])
                  {
                     spacialReadedMail[keyIV] = so.data["spacialReadedMail"][keyIV];
                  }
               }
               if(so.data["deleteMail"] != undefined)
               {
                  var _loc31_:int = 0;
                  var _loc30_:* = so.data["deleteMail"];
                  for(var keyV in so.data["deleteMail"])
                  {
                     deleteMail[keyV] = so.data["deleteMail"][keyV];
                  }
               }
               if(so.data["privateChatRecord"] != undefined)
               {
                  var _loc33_:int = 0;
                  var _loc32_:* = so.data["privateChatRecord"];
                  for(var keyP in so.data["privateChatRecord"])
                  {
                     privateChatRecord[keyP] = so.data["privateChatRecord"][keyP];
                  }
               }
               if(so.data["teamChatRecord"] != undefined)
               {
                  var _loc35_:int = 0;
                  var _loc34_:* = so.data["teamChatRecord"];
                  for(var kyeL in so.data["teamChatRecord"])
                  {
                     teamChatRecord[keyP] = so.data["teamChatRecord"][keyP];
                  }
               }
               if(so.data["transregionalblackList"] != undefined)
               {
                  var _loc37_:int = 0;
                  var _loc36_:* = so.data["transregionalblackList"];
                  for(var keyT in so.data["transregionalblackList"])
                  {
                     transregionalblackList[keyT] = so.data["transregionalblackList"][keyT];
                  }
               }
               if(so.data["GameKeySets"] != undefined)
               {
                  for(i = 1; i < KEY_SET_ABLE.length + 1; )
                  {
                     GameKeySets[i] = so.data["GameKeySets"][i];
                     i++;
                  }
               }
               else
               {
                  j = 0;
                  while(j < KEY_SET_ABLE.length)
                  {
                     GameKeySets[j + 1] = KEY_SET_ABLE[j];
                     j++;
                  }
               }
               if(so.data["AuctionInfos"] != undefined)
               {
                  var _loc39_:int = 0;
                  var _loc38_:* = so.data["AuctionInfos"];
                  for(var k in so.data["AuctionInfos"])
                  {
                     AuctionInfos[k] = so.data["AuctionInfos"][k];
                  }
               }
               if(so.data["AuctionIDs"] != undefined)
               {
                  AuctionIDs = so.data["AuctionIDs"];
                  var _loc41_:int = 0;
                  var _loc40_:* = so.data["AuctionInfos"];
                  for(var id in so.data["AuctionInfos"])
                  {
                     AuctionIDs[id] = so.data["AuctionInfos"][id];
                  }
               }
               if(so.data["setBagLocked" + PlayerManager.Instance.Self.ID] != undefined)
               {
                  setBagLocked = so.data["setBagLocked"];
               }
               if(so.data["deadtip"] != undefined)
               {
                  deadtip = so.data["deadtip"];
               }
               if(so.data["StoreBuyInfo"] != undefined)
               {
                  var _loc43_:int = 0;
                  var _loc42_:* = so.data["StoreBuyInfo"];
                  for(var key1 in so.data["StoreBuyInfo"])
                  {
                     StoreBuyInfo[key1] = so.data["StoreBuyInfo"][key1];
                  }
               }
               if(so.data["hasEnteredFightLib"] != undefined)
               {
                  var _loc45_:int = 0;
                  var _loc44_:* = so.data["hasEnteredFightLib"];
                  for(var key2 in so.data["hasEnteredFightLib"])
                  {
                     hasEnteredFightLib[key2] = so.data["hasEnteredFightLib"][key2];
                  }
               }
               if(so.data["isAffirm"] != isAffirm)
               {
                  isAffirm = so.data["isAffirm"];
               }
               if(so.data["fastReplys"] != undefined)
               {
                  var _loc47_:int = 0;
                  var _loc46_:* = so.data["fastReplys"];
                  for(var key3 in so.data["fastReplys"])
                  {
                     fastReplys[key3] = so.data["fastReplys"][key3];
                  }
               }
               if(so.data["autoSnsSend"] != undefined)
               {
                  _autoSnsSend = so.data["autoSnsSend"];
               }
               if(so.data["allowSnsSend"] != undefined)
               {
                  _allowSnsSend = so.data["allowSnsSend"];
               }
               if(so.data["AwayAutoReply"] != undefined)
               {
                  var _loc49_:int = 0;
                  var _loc48_:* = so.data["AwayAutoReply"];
                  for(var key4 in so.data["AwayAutoReply"])
                  {
                     awayAutoReply[key4] = so.data["AwayAutoReply"][key4];
                  }
               }
               if(so.data["BusyAutoReply"] != undefined)
               {
                  var _loc51_:int = 0;
                  var _loc50_:* = so.data["BusyAutoReply"];
                  for(var key5 in so.data["BusyAutoReply"])
                  {
                     busyAutoReply[key5] = so.data["BusyAutoReply"][key5];
                  }
               }
               if(so.data["NoDistrubAutoReply"] != undefined)
               {
                  var _loc53_:int = 0;
                  var _loc52_:* = so.data["NoDistrubAutoReply"];
                  for(var key6 in so.data["NoDistrubAutoReply"])
                  {
                     noDistrubAutoReply[key6] = so.data["NoDistrubAutoReply"][key6];
                  }
               }
               if(so.data["ShoppingAutoReply"] != undefined)
               {
                  var _loc55_:int = 0;
                  var _loc54_:* = so.data["ShoppingAutoReply"];
                  for(var key7 in so.data["ShoppingAutoReply"])
                  {
                     shoppingAutoReply[key7] = so.data["ShoppingAutoReply"][key7];
                  }
               }
               if(so.data["isCommunity"] != undefined)
               {
                  isCommunity = so.data["isCommunity"];
               }
               if(so.data["isWishPop"] != undefined)
               {
                  isWishPop = so.data["isWishPop"];
               }
               if(so.data["autoWish"] != undefined)
               {
                  autoWish = so.data["autoWish"];
               }
               if(so.data["isRefreshPet"] != undefined)
               {
                  isRefreshPet = so.data["isRefreshPet"];
               }
               if(so.data["isWorldBossBuyBuff"] != undefined)
               {
                  isWorldBossBuyBuff = so.data["isWorldBossBuyBuff"];
               }
               if(so.data["isWorldBossBindBuyBuff"] != undefined)
               {
                  isWorldBossBindBuyBuff = so.data["isWorldBossBindBuyBuff"];
               }
               if(so.data["isWorldBossBuyBuffFull"] != undefined)
               {
                  isWorldBossBuyBuffFull = so.data["isWorldBossBuyBuffFull"];
               }
               if(so.data["isWorldBossBindBuyBuffFull"] != undefined)
               {
                  isWorldBossBindBuyBuffFull = so.data["isWorldBossBindBuyBuffFull"];
               }
               if(so.data["isResurrect"] != undefined)
               {
                  isResurrect = so.data["isResurrect"];
               }
               if(so.data["isReFight"] != undefined)
               {
                  isReFight = so.data["isReFight"];
               }
               if(so.data["isDragonBoatOpenFrame"] != undefined)
               {
                  isDragonBoatOpenFrame = so.data["isDragonBoatOpenFrame"];
               }
               if(so.data["isShowDdtImportantView"] != undefined)
               {
                  isShowDdtImportantView = so.data["isShowDdtImportantView"];
               }
               if(so.data["flashInfoExist"] != undefined)
               {
                  flashInfoExist = so.data["flashInfoExist"];
               }
               if(so.data["friendshipEffect"] != undefined)
               {
                  friendshipEffect = so.data["friendshipEffect"];
               }
               if(so.data["guardEffect"] != undefined)
               {
                  guardEffect = so.data["guardEffect"];
               }
               if(so.data["manualNewDebris"] != undefined)
               {
                  manualNewChapters = so.data["manualNewDebris"];
               }
               if(so.data["manualNewPages"] != undefined)
               {
                  manualNewPages = so.data["manualNewPages"];
               }
            }
         }
         catch(e:Error)
         {
            _loc21_ = 0;
         }
      }
      
      public function save() : void
      {
         var so:* = null;
         var obj:* = null;
         try
         {
            so = SharedObject.getLocal("road");
            so.data["allowMusic"] = allowMusic;
            so.data["allowSound"] = allowSound;
            so.data["showTopMessageBar"] = showTopMessageBar;
            so.data["showInvateWindow"] = showInvateWindow;
            so.data["showParticle"] = showParticle;
            so.data["showOL"] = showOL;
            so.data["showCI"] = showCI;
            so.data["showHat"] = showHat;
            so.data["showGlass"] = showGlass;
            so.data["showSuit"] = showSuit;
            so.data["musicVolumn"] = musicVolumn;
            so.data["soundVolumn"] = soundVolumn;
            so.data["KeyAutoSnap"] = KeyAutoSnap;
            so.data["giftFirstShow"] = giftFirstShow;
            so.data["cardSystemShow"] = cardSystemShow;
            so.data["texpSystemShow"] = texpSystemShow;
            so.data["divorceBoolean"] = divorceBoolean;
            so.data["friendBrithdayName"] = friendBrithdayName;
            so.data["AutoReady"] = AutoReady;
            so.data["ShowBattleGuide"] = ShowBattleGuide;
            so.data["isHintPropExpire"] = isHintPropExpire;
            so.data["hasCheckedOverFrameRate"] = hasCheckedOverFrameRate;
            so.data["isAffirm"] = isAffirm;
            so.data["isRecommend"] = isRecommend;
            so.data["recommendNum"] = recommendNum;
            so.data["isSetingMovieClip"] = isSetingMovieClip;
            so.data["propLayerMode"] = propLayerMode;
            so.data["autoCaddy"] = _autoCaddy;
            so.data["autoOfferPack"] = _autoOfferPack;
            so.data["autoBead"] = _autoBead;
            so.data["edictumVersion"] = _edictumVersion;
            so.data["stoneFriend"] = stoneFriend;
            so.data["autoCelebration"] = _autoCelebration;
            so.data["isRefreshPet"] = isRefreshSkill;
            obj = {};
            var _loc6_:int = 0;
            var _loc5_:* = GameKeySets;
            for(var i in GameKeySets)
            {
               obj[i] = GameKeySets[i];
            }
            so.data["GameKeySets"] = obj;
            if(AuctionInfos)
            {
               so.data["AuctionInfos"] = AuctionInfos;
            }
            if(hasStrength3)
            {
               so.data["hasStrength3"] = hasStrength3;
            }
            if(recentContactsID)
            {
               so.data["recentContactsID"] = recentContactsID;
            }
            if(voteData)
            {
               so.data["voteData"] = voteData;
            }
            if(spacialReadedMail)
            {
               so.data["spacialReadedMail"] = spacialReadedMail;
            }
            if(deleteMail)
            {
               so.data["deleteMail"] = deleteMail;
            }
            if(privateChatRecord)
            {
               so.data["privateChatRecord"] = privateChatRecord;
            }
            if(teamChatRecord)
            {
               so.data["teamChatRecord"] = teamChatRecord;
            }
            if(transregionalblackList)
            {
               so.data["transregionalblackList"] = transregionalblackList;
            }
            if(hasEnteredFightLib)
            {
               so.data["hasEnteredFightLib"] = hasEnteredFightLib;
            }
            if(fastReplys)
            {
               so.data["fastReplys"] = fastReplys;
            }
            if(autoWish)
            {
               so.data["autoWish"] = autoWish;
            }
            so.data["isRefreshPet"] = isRefreshPet;
            so.data["isWorldBossBuyBuff"] = isWorldBossBuyBuff;
            so.data["isWorldBossBindBuyBuff"] = isWorldBossBindBuyBuff;
            so.data["isWorldBossBuyBuffFull"] = isWorldBossBuyBuffFull;
            so.data["isWorldBossBindBuyBuffFull"] = isWorldBossBindBuyBuffFull;
            so.data["isResurrect"] = isResurrect;
            so.data["isReFight"] = isReFight;
            so.data["AuctionIDs"] = AuctionIDs;
            so.data["setBagLocked"] = setBagLocked;
            so.data["deadtip"] = deadtip;
            so.data["StoreBuyInfo"] = StoreBuyInfo;
            so.data["halliconExperienceStep"] = halliconExperienceStep;
            so.data["autoSnsSend"] = _autoSnsSend;
            so.data["allowSnsSend"] = _allowSnsSend;
            so.data["AwayAutoReply"] = awayAutoReply;
            so.data["BusyAutoReply"] = busyAutoReply;
            so.data["NoDistrubAutoReply"] = noDistrubAutoReply;
            so.data["ShoppingAutoReply"] = shoppingAutoReply;
            so.data["isCommunity"] = isCommunity;
            so.data["isWishPop"] = isWishPop;
            so.data["isFirstWish"] = isFirstWish;
            so.data["isDragonBoatOpenFrame"] = isDragonBoatOpenFrame;
            so.data["isShowDdtImportantView"] = isShowDdtImportantView;
            so.data["flashInfoExist"] = flashInfoExist;
            so.data["friendshipEffect"] = friendshipEffect;
            so.data["guardEffect"] = guardEffect;
            so.data["manualNewDebris"] = manualNewChapters;
            so.data["manualNewPages"] = manualNewPages;
            so.flush(20971520);
         }
         catch(e:Error)
         {
         }
         changed();
      }
      
      public function changed() : void
      {
         SoundManager.instance.setConfig(allowMusic,allowSound,musicVolumn,soundVolumn);
         var _loc3_:int = 0;
         var _loc2_:* = GameKeySets;
         for(var i in GameKeySets)
         {
            if(RIGHT_PROP[int(int(i) - 1)])
            {
               RIGHT_PROP[int(int(i) - 1)] = GameKeySets[i];
            }
         }
         dispatchEvent(new Event("change"));
      }
      
      public function set propTransparent(val:Boolean) : void
      {
         if(_propTransparent != val)
         {
            _propTransparent = val;
            dispatchEvent(new SharedEvent("transparentChanged"));
         }
      }
      
      public function get propTransparent() : Boolean
      {
         return _propTransparent;
      }
   }
}
