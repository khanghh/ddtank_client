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
      
      public function SharedManager(){super();}
      
      public static function get Instance() : SharedManager{return null;}
      
      public function get manualNewPages() : Array{return null;}
      
      public function set manualNewPages(param1:Array) : void{}
      
      public function get manualNewChapters() : Array{return null;}
      
      public function set manualNewChapters(param1:Array) : void{}
      
      public function get allowSound() : Boolean{return false;}
      
      public function set allowSound(param1:Boolean) : void{}
      
      public function get allowMusic() : Boolean{return false;}
      
      public function set allowMusic(param1:Boolean) : void{}
      
      private function checkAllMusicClose() : void{}
      
      public function get autoSnsSend() : Boolean{return false;}
      
      public function set autoSnsSend(param1:Boolean) : void{}
      
      public function get allowSnsSend() : Boolean{return false;}
      
      public function get autoVip() : Boolean{return false;}
      
      public function set autoVip(param1:Boolean) : void{}
      
      public function get autoCelebration() : Boolean{return false;}
      
      public function set autoCelebration(param1:Boolean) : void{}
      
      public function get autoCaddy() : Boolean{return false;}
      
      public function set autoCaddy(param1:Boolean) : void{}
      
      public function get autoOfferPack() : Boolean{return false;}
      
      public function set autoOfferPack(param1:Boolean) : void{}
      
      public function get autoBead() : Boolean{return false;}
      
      public function set autoWishBead(param1:Boolean) : void{}
      
      public function get autoWishBead() : Boolean{return false;}
      
      public function set autoBead(param1:Boolean) : void{}
      
      public function get edictumVersion() : String{return null;}
      
      public function set edictumVersion(param1:String) : void{}
      
      public function get propLayerMode() : int{return 0;}
      
      public function set propLayerMode(param1:int) : void{}
      
      public function set allowSnsSend(param1:Boolean) : void{}
      
      public function get showInvateWindow() : Boolean{return false;}
      
      public function set showInvateWindow(param1:Boolean) : void{}
      
      public function get isCommunity() : Boolean{return false;}
      
      public function set isCommunity(param1:Boolean) : void{}
      
      public function get isWishPop() : Boolean{return false;}
      
      public function set isWishPop(param1:Boolean) : void{}
      
      public function get isFirstWish() : Boolean{return false;}
      
      public function set isFirstWish(param1:Boolean) : void{}
      
      public function setup() : void{}
      
      public function reset() : void{}
      
      private function load() : void{}
      
      public function save() : void{}
      
      public function changed() : void{}
      
      public function set propTransparent(param1:Boolean) : void{}
      
      public function get propTransparent() : Boolean{return false;}
   }
}
