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
      
      public function set manualNewPages(param1:Array) : void
      {
         _manualNewPages = param1;
      }
      
      public function get manualNewChapters() : Array
      {
         return _manualNewChapters;
      }
      
      public function set manualNewChapters(param1:Array) : void
      {
         _manualNewChapters = param1;
      }
      
      public function get allowSound() : Boolean
      {
         return _allowSound;
      }
      
      public function set allowSound(param1:Boolean) : void
      {
         _allowSound = param1;
         checkAllMusicClose();
      }
      
      public function get allowMusic() : Boolean
      {
         return _allowMusic;
      }
      
      public function set allowMusic(param1:Boolean) : void
      {
         _allowMusic = param1;
         checkAllMusicClose();
      }
      
      private function checkAllMusicClose() : void
      {
         var _loc1_:SoundTransform = SoundMixer.soundTransform;
         if(!_allowSound && !_allowMusic)
         {
            _loc1_.volume = 0;
         }
         else
         {
            _loc1_.volume = 1;
         }
         SoundMixer.soundTransform = _loc1_;
      }
      
      public function get autoSnsSend() : Boolean
      {
         return _autoSnsSend;
      }
      
      public function set autoSnsSend(param1:Boolean) : void
      {
         if(_autoSnsSend == param1)
         {
            return;
         }
         _autoSnsSend = param1;
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
      
      public function set autoVip(param1:Boolean) : void
      {
         if(_autoVip != param1)
         {
            _autoVip = param1;
            save();
         }
      }
      
      public function get autoCelebration() : Boolean
      {
         return _autoCelebration;
      }
      
      public function set autoCelebration(param1:Boolean) : void
      {
         if(_autoCelebration != param1)
         {
            _autoCelebration = param1;
            save();
         }
      }
      
      public function get autoCaddy() : Boolean
      {
         return _autoCaddy;
      }
      
      public function set autoCaddy(param1:Boolean) : void
      {
         if(_autoCaddy != param1)
         {
            _autoCaddy = param1;
            save();
         }
      }
      
      public function get autoOfferPack() : Boolean
      {
         return _autoOfferPack;
      }
      
      public function set autoOfferPack(param1:Boolean) : void
      {
         if(_autoOfferPack != param1)
         {
            _autoOfferPack = param1;
            save();
         }
      }
      
      public function get autoBead() : Boolean
      {
         return _autoBead;
      }
      
      public function set autoWishBead(param1:Boolean) : void
      {
         if(_autoWishBead != param1)
         {
            _autoWishBead = param1;
            save();
         }
      }
      
      public function get autoWishBead() : Boolean
      {
         return _autoWishBead;
      }
      
      public function set autoBead(param1:Boolean) : void
      {
         if(_autoBead != param1)
         {
            _autoBead = param1;
            save();
         }
      }
      
      public function get edictumVersion() : String
      {
         return _edictumVersion;
      }
      
      public function set edictumVersion(param1:String) : void
      {
         if(_edictumVersion != param1)
         {
            _edictumVersion = param1;
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
      
      public function set propLayerMode(param1:int) : void
      {
         if(_propLayerMode != param1)
         {
            _propLayerMode = param1;
            save();
         }
      }
      
      public function set allowSnsSend(param1:Boolean) : void
      {
         if(_allowSnsSend == param1)
         {
            return;
         }
         _allowSnsSend = param1;
         save();
      }
      
      public function get showInvateWindow() : Boolean
      {
         return _showInvateWindow;
      }
      
      public function set showInvateWindow(param1:Boolean) : void
      {
         _showInvateWindow = param1;
      }
      
      public function get isCommunity() : Boolean
      {
         return _isCommunity;
      }
      
      public function set isCommunity(param1:Boolean) : void
      {
         _isCommunity = param1;
      }
      
      public function get isWishPop() : Boolean
      {
         return _isWishPop;
      }
      
      public function set isWishPop(param1:Boolean) : void
      {
         _isWishPop = param1;
      }
      
      public function get isFirstWish() : Boolean
      {
         return _isFirstWish;
      }
      
      public function set isFirstWish(param1:Boolean) : void
      {
         _isFirstWish = param1;
      }
      
      public function setup() : void
      {
         load();
      }
      
      public function reset() : void
      {
         var _loc1_:SharedObject = SharedObject.getLocal("road");
         _loc1_.clear();
         _loc1_.flush(20971520);
      }
      
      private function load() : void
      {
         var _loc7_:* = null;
         var _loc16_:int = 0;
         var _loc12_:int = 0;
         var _loc21_:int = 0;
         try
         {
            _loc7_ = SharedObject.getLocal("road");
            AuctionInfos = {};
            if(_loc7_ && _loc7_.data)
            {
               if(_loc7_.data["allowMusic"] != undefined)
               {
                  allowMusic = _loc7_.data["allowMusic"];
               }
               if(_loc7_.data["allowSound"] != undefined)
               {
                  allowSound = _loc7_.data["allowSound"];
               }
               if(_loc7_.data["showTopMessageBar"] != undefined)
               {
                  showTopMessageBar = _loc7_.data["showTopMessageBar"];
               }
               if(_loc7_.data["showInvateWindow"] != undefined)
               {
                  showInvateWindow = _loc7_.data["showInvateWindow"];
               }
               if(_loc7_.data["showParticle"] != undefined)
               {
                  showParticle = _loc7_.data["showParticle"];
               }
               if(_loc7_.data["showOL"] != undefined)
               {
                  showOL = _loc7_.data["showOL"];
               }
               if(_loc7_.data["showCI"] != undefined)
               {
                  showCI = _loc7_.data["showCI"];
               }
               if(_loc7_.data["showHat"] != undefined)
               {
                  showHat = _loc7_.data["showHat"];
               }
               if(_loc7_.data["showGlass"] != undefined)
               {
                  showGlass = _loc7_.data["showGlass"];
               }
               if(_loc7_.data["showSuit"] != undefined)
               {
                  showSuit = _loc7_.data["showSuit"];
               }
               if(_loc7_.data["musicVolumn"] != undefined)
               {
                  musicVolumn = _loc7_.data["musicVolumn"];
               }
               if(_loc7_.data["soundVolumn"] != undefined)
               {
                  soundVolumn = _loc7_.data["soundVolumn"];
               }
               if(_loc7_.data["KeyAutoSnap"] != undefined)
               {
                  KeyAutoSnap = _loc7_.data["KeyAutoSnap"];
               }
               if(_loc7_.data["giftFirstShow"] != undefined)
               {
                  giftFirstShow = _loc7_.data["giftFirstShow"];
               }
               if(_loc7_.data["cardSystemShow"] != undefined)
               {
                  cardSystemShow = _loc7_.data["cardSystemShow"];
               }
               if(_loc7_.data["texpSystemShow"] != undefined)
               {
                  texpSystemShow = _loc7_.data["texpSystemShow"];
               }
               if(_loc7_.data["divorceBoolean"] != undefined)
               {
                  divorceBoolean = _loc7_.data["divorceBoolean"];
               }
               if(_loc7_.data["friendBrithdayName"] != undefined)
               {
                  friendBrithdayName = _loc7_.data["friendBrithdayName"];
               }
               if(_loc7_.data["AutoReady"] != undefined)
               {
                  AutoReady = _loc7_.data["AutoReady"];
               }
               if(_loc7_.data["ShowBattleGuide"] != undefined)
               {
                  ShowBattleGuide = _loc7_.data["ShowBattleGuide"];
               }
               if(_loc7_.data["isHintPropExpire"] != undefined)
               {
                  isHintPropExpire = _loc7_.data["isHintPropExpire"];
               }
               if(_loc7_.data["hasCheckedOverFrameRate"] != undefined)
               {
                  hasCheckedOverFrameRate = _loc7_.data["hasCheckedOverFrameRate"];
               }
               if(_loc7_.data["isRecommend"] != undefined)
               {
                  isRecommend = _loc7_.data["isRecommend"];
               }
               if(_loc7_.data["recommendNum"] != undefined)
               {
                  recommendNum = _loc7_.data["recommendNum"];
               }
               if(_loc7_.data["isSetingMovieClip"] != undefined)
               {
                  isSetingMovieClip = _loc7_.data["isSetingMovieClip"];
               }
               if(_loc7_.data["propLayerMode"] != undefined)
               {
                  _propLayerMode = _loc7_.data["propLayerMode"];
               }
               if(_loc7_.data["autoCaddy"] != undefined)
               {
                  _autoCaddy = _loc7_.data["autoCaddy"];
               }
               if(_loc7_.data["autoOfferPack"] != undefined)
               {
                  _autoOfferPack = _loc7_.data["autoOfferPack"];
               }
               if(_loc7_.data["autoBead"] != undefined)
               {
                  _autoBead = _loc7_.data["autoBead"];
               }
               if(_loc7_.data["edictumVersion"] != undefined)
               {
                  _edictumVersion = _loc7_.data["edictumVersion"];
               }
               if(_loc7_.data["isFirstWish"] != undefined)
               {
                  _isFirstWish = _loc7_.data["isFirstWish"];
               }
               if(_loc7_.data["stoneFriend"] != undefined)
               {
                  stoneFriend = _loc7_.data["stoneFriend"];
               }
               if(_loc7_.data["halliconExperienceStep"] != undefined)
               {
                  halliconExperienceStep = _loc7_.data["halliconExperienceStep"];
               }
               if(_loc7_.data["isRefreshSkill"] != undefined)
               {
                  isRefreshSkill = _loc7_.data["isRefreshSkill"];
               }
               if(_loc7_.data["autoCelebration"] != undefined)
               {
                  _autoCelebration = _loc7_.data["autoCelebration"];
               }
               if(_loc7_.data["hasStrength3"] != undefined)
               {
                  var _loc23_:int = 0;
                  var _loc22_:* = _loc7_.data["hasStrength3"];
                  for(var _loc20_ in _loc7_.data["hasStrength3"])
                  {
                     hasStrength3[_loc20_] = _loc7_.data["hasStrength3"][_loc20_];
                  }
               }
               if(_loc7_.data["recentContactsID"] != undefined)
               {
                  var _loc25_:int = 0;
                  var _loc24_:* = _loc7_.data["recentContactsID"];
                  for(var _loc19_ in _loc7_.data["recentContactsID"])
                  {
                     recentContactsID[_loc19_] = _loc7_.data["recentContactsID"][_loc19_];
                  }
               }
               if(_loc7_.data["voteData"] != undefined)
               {
                  var _loc27_:int = 0;
                  var _loc26_:* = _loc7_.data["voteData"];
                  for(var _loc18_ in _loc7_.data["voteData"])
                  {
                     voteData[_loc18_] = _loc7_.data["voteData"][_loc18_];
                  }
               }
               if(_loc7_.data["spacialReadedMail"] != undefined)
               {
                  var _loc29_:int = 0;
                  var _loc28_:* = _loc7_.data["spacialReadedMail"];
                  for(var _loc11_ in _loc7_.data["spacialReadedMail"])
                  {
                     spacialReadedMail[_loc11_] = _loc7_.data["spacialReadedMail"][_loc11_];
                  }
               }
               if(_loc7_.data["deleteMail"] != undefined)
               {
                  var _loc31_:int = 0;
                  var _loc30_:* = _loc7_.data["deleteMail"];
                  for(var _loc6_ in _loc7_.data["deleteMail"])
                  {
                     deleteMail[_loc6_] = _loc7_.data["deleteMail"][_loc6_];
                  }
               }
               if(_loc7_.data["privateChatRecord"] != undefined)
               {
                  var _loc33_:int = 0;
                  var _loc32_:* = _loc7_.data["privateChatRecord"];
                  for(var _loc4_ in _loc7_.data["privateChatRecord"])
                  {
                     privateChatRecord[_loc4_] = _loc7_.data["privateChatRecord"][_loc4_];
                  }
               }
               if(_loc7_.data["teamChatRecord"] != undefined)
               {
                  var _loc35_:int = 0;
                  var _loc34_:* = _loc7_.data["teamChatRecord"];
                  for(var _loc15_ in _loc7_.data["teamChatRecord"])
                  {
                     teamChatRecord[_loc4_] = _loc7_.data["teamChatRecord"][_loc4_];
                  }
               }
               if(_loc7_.data["transregionalblackList"] != undefined)
               {
                  var _loc37_:int = 0;
                  var _loc36_:* = _loc7_.data["transregionalblackList"];
                  for(var _loc9_ in _loc7_.data["transregionalblackList"])
                  {
                     transregionalblackList[_loc9_] = _loc7_.data["transregionalblackList"][_loc9_];
                  }
               }
               if(_loc7_.data["GameKeySets"] != undefined)
               {
                  _loc16_ = 1;
                  while(_loc16_ < KEY_SET_ABLE.length + 1)
                  {
                     GameKeySets[_loc16_] = _loc7_.data["GameKeySets"][_loc16_];
                     _loc16_++;
                  }
               }
               else
               {
                  _loc12_ = 0;
                  while(_loc12_ < KEY_SET_ABLE.length)
                  {
                     GameKeySets[_loc12_ + 1] = KEY_SET_ABLE[_loc12_];
                     _loc12_++;
                  }
               }
               if(_loc7_.data["AuctionInfos"] != undefined)
               {
                  var _loc39_:int = 0;
                  var _loc38_:* = _loc7_.data["AuctionInfos"];
                  for(var _loc14_ in _loc7_.data["AuctionInfos"])
                  {
                     AuctionInfos[_loc14_] = _loc7_.data["AuctionInfos"][_loc14_];
                  }
               }
               if(_loc7_.data["AuctionIDs"] != undefined)
               {
                  AuctionIDs = _loc7_.data["AuctionIDs"];
                  var _loc41_:int = 0;
                  var _loc40_:* = _loc7_.data["AuctionInfos"];
                  for(var _loc17_ in _loc7_.data["AuctionInfos"])
                  {
                     AuctionIDs[_loc17_] = _loc7_.data["AuctionInfos"][_loc17_];
                  }
               }
               if(_loc7_.data["setBagLocked" + PlayerManager.Instance.Self.ID] != undefined)
               {
                  setBagLocked = _loc7_.data["setBagLocked"];
               }
               if(_loc7_.data["deadtip"] != undefined)
               {
                  deadtip = _loc7_.data["deadtip"];
               }
               if(_loc7_.data["StoreBuyInfo"] != undefined)
               {
                  var _loc43_:int = 0;
                  var _loc42_:* = _loc7_.data["StoreBuyInfo"];
                  for(var _loc10_ in _loc7_.data["StoreBuyInfo"])
                  {
                     StoreBuyInfo[_loc10_] = _loc7_.data["StoreBuyInfo"][_loc10_];
                  }
               }
               if(_loc7_.data["hasEnteredFightLib"] != undefined)
               {
                  var _loc45_:int = 0;
                  var _loc44_:* = _loc7_.data["hasEnteredFightLib"];
                  for(var _loc8_ in _loc7_.data["hasEnteredFightLib"])
                  {
                     hasEnteredFightLib[_loc8_] = _loc7_.data["hasEnteredFightLib"][_loc8_];
                  }
               }
               if(_loc7_.data["isAffirm"] != isAffirm)
               {
                  isAffirm = _loc7_.data["isAffirm"];
               }
               if(_loc7_.data["fastReplys"] != undefined)
               {
                  var _loc47_:int = 0;
                  var _loc46_:* = _loc7_.data["fastReplys"];
                  for(var _loc2_ in _loc7_.data["fastReplys"])
                  {
                     fastReplys[_loc2_] = _loc7_.data["fastReplys"][_loc2_];
                  }
               }
               if(_loc7_.data["autoSnsSend"] != undefined)
               {
                  _autoSnsSend = _loc7_.data["autoSnsSend"];
               }
               if(_loc7_.data["allowSnsSend"] != undefined)
               {
                  _allowSnsSend = _loc7_.data["allowSnsSend"];
               }
               if(_loc7_.data["AwayAutoReply"] != undefined)
               {
                  var _loc49_:int = 0;
                  var _loc48_:* = _loc7_.data["AwayAutoReply"];
                  for(var _loc1_ in _loc7_.data["AwayAutoReply"])
                  {
                     awayAutoReply[_loc1_] = _loc7_.data["AwayAutoReply"][_loc1_];
                  }
               }
               if(_loc7_.data["BusyAutoReply"] != undefined)
               {
                  var _loc51_:int = 0;
                  var _loc50_:* = _loc7_.data["BusyAutoReply"];
                  for(var _loc5_ in _loc7_.data["BusyAutoReply"])
                  {
                     busyAutoReply[_loc5_] = _loc7_.data["BusyAutoReply"][_loc5_];
                  }
               }
               if(_loc7_.data["NoDistrubAutoReply"] != undefined)
               {
                  var _loc53_:int = 0;
                  var _loc52_:* = _loc7_.data["NoDistrubAutoReply"];
                  for(var _loc3_ in _loc7_.data["NoDistrubAutoReply"])
                  {
                     noDistrubAutoReply[_loc3_] = _loc7_.data["NoDistrubAutoReply"][_loc3_];
                  }
               }
               if(_loc7_.data["ShoppingAutoReply"] != undefined)
               {
                  var _loc55_:int = 0;
                  var _loc54_:* = _loc7_.data["ShoppingAutoReply"];
                  for(var _loc13_ in _loc7_.data["ShoppingAutoReply"])
                  {
                     shoppingAutoReply[_loc13_] = _loc7_.data["ShoppingAutoReply"][_loc13_];
                  }
               }
               if(_loc7_.data["isCommunity"] != undefined)
               {
                  isCommunity = _loc7_.data["isCommunity"];
               }
               if(_loc7_.data["isWishPop"] != undefined)
               {
                  isWishPop = _loc7_.data["isWishPop"];
               }
               if(_loc7_.data["autoWish"] != undefined)
               {
                  autoWish = _loc7_.data["autoWish"];
               }
               if(_loc7_.data["isRefreshPet"] != undefined)
               {
                  isRefreshPet = _loc7_.data["isRefreshPet"];
               }
               if(_loc7_.data["isWorldBossBuyBuff"] != undefined)
               {
                  isWorldBossBuyBuff = _loc7_.data["isWorldBossBuyBuff"];
               }
               if(_loc7_.data["isWorldBossBindBuyBuff"] != undefined)
               {
                  isWorldBossBindBuyBuff = _loc7_.data["isWorldBossBindBuyBuff"];
               }
               if(_loc7_.data["isWorldBossBuyBuffFull"] != undefined)
               {
                  isWorldBossBuyBuffFull = _loc7_.data["isWorldBossBuyBuffFull"];
               }
               if(_loc7_.data["isWorldBossBindBuyBuffFull"] != undefined)
               {
                  isWorldBossBindBuyBuffFull = _loc7_.data["isWorldBossBindBuyBuffFull"];
               }
               if(_loc7_.data["isResurrect"] != undefined)
               {
                  isResurrect = _loc7_.data["isResurrect"];
               }
               if(_loc7_.data["isReFight"] != undefined)
               {
                  isReFight = _loc7_.data["isReFight"];
               }
               if(_loc7_.data["isDragonBoatOpenFrame"] != undefined)
               {
                  isDragonBoatOpenFrame = _loc7_.data["isDragonBoatOpenFrame"];
               }
               if(_loc7_.data["isShowDdtImportantView"] != undefined)
               {
                  isShowDdtImportantView = _loc7_.data["isShowDdtImportantView"];
               }
               if(_loc7_.data["flashInfoExist"] != undefined)
               {
                  flashInfoExist = _loc7_.data["flashInfoExist"];
               }
               if(_loc7_.data["friendshipEffect"] != undefined)
               {
                  friendshipEffect = _loc7_.data["friendshipEffect"];
               }
               if(_loc7_.data["guardEffect"] != undefined)
               {
                  guardEffect = _loc7_.data["guardEffect"];
               }
               if(_loc7_.data["manualNewDebris"] != undefined)
               {
                  manualNewChapters = _loc7_.data["manualNewDebris"];
               }
               if(_loc7_.data["manualNewPages"] != undefined)
               {
                  manualNewPages = _loc7_.data["manualNewPages"];
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
         var _loc1_:* = null;
         var _loc2_:* = null;
         try
         {
            _loc1_ = SharedObject.getLocal("road");
            _loc1_.data["allowMusic"] = allowMusic;
            _loc1_.data["allowSound"] = allowSound;
            _loc1_.data["showTopMessageBar"] = showTopMessageBar;
            _loc1_.data["showInvateWindow"] = showInvateWindow;
            _loc1_.data["showParticle"] = showParticle;
            _loc1_.data["showOL"] = showOL;
            _loc1_.data["showCI"] = showCI;
            _loc1_.data["showHat"] = showHat;
            _loc1_.data["showGlass"] = showGlass;
            _loc1_.data["showSuit"] = showSuit;
            _loc1_.data["musicVolumn"] = musicVolumn;
            _loc1_.data["soundVolumn"] = soundVolumn;
            _loc1_.data["KeyAutoSnap"] = KeyAutoSnap;
            _loc1_.data["giftFirstShow"] = giftFirstShow;
            _loc1_.data["cardSystemShow"] = cardSystemShow;
            _loc1_.data["texpSystemShow"] = texpSystemShow;
            _loc1_.data["divorceBoolean"] = divorceBoolean;
            _loc1_.data["friendBrithdayName"] = friendBrithdayName;
            _loc1_.data["AutoReady"] = AutoReady;
            _loc1_.data["ShowBattleGuide"] = ShowBattleGuide;
            _loc1_.data["isHintPropExpire"] = isHintPropExpire;
            _loc1_.data["hasCheckedOverFrameRate"] = hasCheckedOverFrameRate;
            _loc1_.data["isAffirm"] = isAffirm;
            _loc1_.data["isRecommend"] = isRecommend;
            _loc1_.data["recommendNum"] = recommendNum;
            _loc1_.data["isSetingMovieClip"] = isSetingMovieClip;
            _loc1_.data["propLayerMode"] = propLayerMode;
            _loc1_.data["autoCaddy"] = _autoCaddy;
            _loc1_.data["autoOfferPack"] = _autoOfferPack;
            _loc1_.data["autoBead"] = _autoBead;
            _loc1_.data["edictumVersion"] = _edictumVersion;
            _loc1_.data["stoneFriend"] = stoneFriend;
            _loc1_.data["autoCelebration"] = _autoCelebration;
            _loc1_.data["isRefreshPet"] = isRefreshSkill;
            _loc2_ = {};
            var _loc6_:int = 0;
            var _loc5_:* = GameKeySets;
            for(var _loc3_ in GameKeySets)
            {
               _loc2_[_loc3_] = GameKeySets[_loc3_];
            }
            _loc1_.data["GameKeySets"] = _loc2_;
            if(AuctionInfos)
            {
               _loc1_.data["AuctionInfos"] = AuctionInfos;
            }
            if(hasStrength3)
            {
               _loc1_.data["hasStrength3"] = hasStrength3;
            }
            if(recentContactsID)
            {
               _loc1_.data["recentContactsID"] = recentContactsID;
            }
            if(voteData)
            {
               _loc1_.data["voteData"] = voteData;
            }
            if(spacialReadedMail)
            {
               _loc1_.data["spacialReadedMail"] = spacialReadedMail;
            }
            if(deleteMail)
            {
               _loc1_.data["deleteMail"] = deleteMail;
            }
            if(privateChatRecord)
            {
               _loc1_.data["privateChatRecord"] = privateChatRecord;
            }
            if(teamChatRecord)
            {
               _loc1_.data["teamChatRecord"] = teamChatRecord;
            }
            if(transregionalblackList)
            {
               _loc1_.data["transregionalblackList"] = transregionalblackList;
            }
            if(hasEnteredFightLib)
            {
               _loc1_.data["hasEnteredFightLib"] = hasEnteredFightLib;
            }
            if(fastReplys)
            {
               _loc1_.data["fastReplys"] = fastReplys;
            }
            if(autoWish)
            {
               _loc1_.data["autoWish"] = autoWish;
            }
            _loc1_.data["isRefreshPet"] = isRefreshPet;
            _loc1_.data["isWorldBossBuyBuff"] = isWorldBossBuyBuff;
            _loc1_.data["isWorldBossBindBuyBuff"] = isWorldBossBindBuyBuff;
            _loc1_.data["isWorldBossBuyBuffFull"] = isWorldBossBuyBuffFull;
            _loc1_.data["isWorldBossBindBuyBuffFull"] = isWorldBossBindBuyBuffFull;
            _loc1_.data["isResurrect"] = isResurrect;
            _loc1_.data["isReFight"] = isReFight;
            _loc1_.data["AuctionIDs"] = AuctionIDs;
            _loc1_.data["setBagLocked"] = setBagLocked;
            _loc1_.data["deadtip"] = deadtip;
            _loc1_.data["StoreBuyInfo"] = StoreBuyInfo;
            _loc1_.data["halliconExperienceStep"] = halliconExperienceStep;
            _loc1_.data["autoSnsSend"] = _autoSnsSend;
            _loc1_.data["allowSnsSend"] = _allowSnsSend;
            _loc1_.data["AwayAutoReply"] = awayAutoReply;
            _loc1_.data["BusyAutoReply"] = busyAutoReply;
            _loc1_.data["NoDistrubAutoReply"] = noDistrubAutoReply;
            _loc1_.data["ShoppingAutoReply"] = shoppingAutoReply;
            _loc1_.data["isCommunity"] = isCommunity;
            _loc1_.data["isWishPop"] = isWishPop;
            _loc1_.data["isFirstWish"] = isFirstWish;
            _loc1_.data["isDragonBoatOpenFrame"] = isDragonBoatOpenFrame;
            _loc1_.data["isShowDdtImportantView"] = isShowDdtImportantView;
            _loc1_.data["flashInfoExist"] = flashInfoExist;
            _loc1_.data["friendshipEffect"] = friendshipEffect;
            _loc1_.data["guardEffect"] = guardEffect;
            _loc1_.data["manualNewDebris"] = manualNewChapters;
            _loc1_.data["manualNewPages"] = manualNewPages;
            _loc1_.flush(20971520);
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
         for(var _loc1_ in GameKeySets)
         {
            if(RIGHT_PROP[int(int(_loc1_) - 1)])
            {
               RIGHT_PROP[int(int(_loc1_) - 1)] = GameKeySets[_loc1_];
            }
         }
         dispatchEvent(new Event("change"));
      }
      
      public function set propTransparent(param1:Boolean) : void
      {
         if(_propTransparent != param1)
         {
            _propTransparent = param1;
            dispatchEvent(new SharedEvent("transparentChanged"));
         }
      }
      
      public function get propTransparent() : Boolean
      {
         return _propTransparent;
      }
   }
}
