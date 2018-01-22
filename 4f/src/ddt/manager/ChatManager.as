package ddt.manager
{
   import cardSystem.CardManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.GrooveInfo;
   import com.pickgliss.debug.DebugStats;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.utils.ChatHelper;
   import ddt.utils.FilterWordManager;
   import ddt.utils.Helpers;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatEvent;
   import ddt.view.chat.ChatFormats;
   import ddt.view.chat.ChatInputView;
   import ddt.view.chat.ChatModel;
   import ddt.view.chat.ChatOutputView;
   import ddt.view.chat.ChatView;
   import ddt.view.chat.chat_system;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import flashP2P.FlashP2PManager;
   import flashP2P.event.StreamEvent;
   import game.GameManager;
   import newTitle.NewTitleManager;
   import newYearRice.NewYearRiceManager;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import road7th.comm.PackageOut;
   import road7th.data.DictionaryData;
   import road7th.utils.StringHelper;
   import room.RoomManager;
   import shop.view.NewShopBugleView;
   
   use namespace chat_system;
   
   public final class ChatManager extends EventDispatcher
   {
      
      public static const CHAT_HALL_STATE:int = 0;
      
      public static const CHAT_GAME_STATE:int = 1;
      
      public static const CHAT_CLUB_STATE:int = 2;
      
      public static const CHAT_WEDDINGLIST_STATE:int = 3;
      
      public static const CHAT_WEDDINGROOM_STATE:int = 4;
      
      public static const CHAT_ROOM_STATE:int = 5;
      
      public static const CHAT_ROOMLIST_STATE:int = 6;
      
      public static const CHAT_DUNGEONLIST_STATE:int = 7;
      
      public static const CHAT_GAMEOVER_STATE:int = 8;
      
      public static const CHAT_GAME_LOADING:int = 9;
      
      public static const CHAT_DUNGEON_STATE:int = 10;
      
      public static const CHAT_CONSORTIA_CHAT_VIEW:int = 12;
      
      public static const CHAT_CONSORTIA_ALL:int = 13;
      
      public static const CHAT_CIVIL_VIEW:int = 14;
      
      public static const CHAT_TOFFLIST_VIEW:int = 15;
      
      public static const CHAT_SHOP_STATE:int = 16;
      
      public static const CHAT_HOTSPRING_VIEW:int = 17;
      
      public static const CHAT_HOTSPRING_ROOM_VIEW:int = 18;
      
      public static const CHAT_HOTSPRING_ROOM_GOLD_VIEW:int = 19;
      
      public static const CHAT_TRAINER_STATE:int = 20;
      
      public static const CHAT_GAMEOVER_TROPHY:int = 21;
      
      public static const CHAT_TRAINER_ROOM_LOADING:int = 22;
      
      public static const CHAT_LITTLEHALL:int = 26;
      
      public static const CHAT_LITTLEGAME:int = 24;
      
      public static const CHAT_FARM:int = 27;
      
      public static const CHAT_FIGHT_LIB:int = 23;
      
      public static const CHAT_ACADEMY_VIEW:int = 25;
      
      private static const CHAT_LEVEL:int = 1;
      
      public static const CHAT_WORLDBOS_ROOM:int = 28;
      
      public static const CHAT_CHRISTMAS_ROOM:int = 21;
      
      public static const CHAT_CONSORTIABATTLE_SCENE:int = 29;
      
      public static const CHAT_SEVENDOUBLEGAME_SECENE:int = 30;
      
      public static const CHAT_TREASURE_STATE:int = 30;
      
      public static const CHAT_ESCORT_SECENE:int = 99;
      
      public static const SUPER_WINNER_ROOM:int = 31;
      
      public static const CHAT_CATCH_INSECT:int = 32;
      
      public static const CHAT_HOME:int = 33;
      
      public static const CHAT_HOUSE:int = 34;
      
      public static const CHAT_DEMON_CHI_YOU:int = 35;
      
      public static const CHAT_CONSORTIA_DOMAIN:int = 35;
      
      public static const CHAT_CONSORTIA_GAURD:int = 37;
      
      public static var SHIELD_NOTICE:Boolean = false;
      
      public static var HALL_CHAT_LOCK:Boolean = true;
      
      private static var _instance:ChatManager;
       
      
      private var _shopBugle:NewShopBugleView;
      
      private var _isFastInvite:Boolean = false;
      
      public var chatDisabled:Boolean = false;
      
      private var _chatView:ChatView;
      
      private var _model:ChatModel;
      
      private var _state:int = -1;
      
      private var _visibleSwitchEnable:Boolean = false;
      
      private var _focusFuncEnabled:Boolean = true;
      
      private var fpsContainer:DebugStats;
      
      private var _firstsetup:Boolean = true;
      
      public var notAgainData:DictionaryData;
      
      public function ChatManager(){super();}
      
      public static function get Instance() : ChatManager{return null;}
      
      public function chat(param1:ChatData, param2:Boolean = true) : void{}
      
      public function addTimePackTip(param1:String) : void{}
      
      public function get isInGame() : Boolean{return false;}
      
      public function set focusFuncEnabled(param1:Boolean) : void{}
      
      public function get focusFuncEnabled() : Boolean{return false;}
      
      public function get input() : ChatInputView{return null;}
      
      public function set inputChannel(param1:int) : void{}
      
      public function get lock() : Boolean{return false;}
      
      public function set lock(param1:Boolean) : void{}
      
      public function get model() : ChatModel{return null;}
      
      public function get output() : ChatOutputView{return null;}
      
      public function set outputChannel(param1:int) : void{}
      
      public function privateChatTo(param1:String, param2:int = 0, param3:Object = null) : void{}
      
      public function sendBugle(param1:String, param2:int, param3:Boolean = false) : void{}
      
      public function sendFastAuctionBugle(param1:int, param2:int = 11101) : void{}
      
      public function sendChat(param1:ChatData) : void{}
      
      public function sendFace(param1:int) : void{}
      
      public function setFocus() : void{}
      
      public function releaseFocus() : void{}
      
      public function setup() : void{}
      
      public function get state() : int{return 0;}
      
      public function set state(param1:int) : void{}
      
      public function switchVisible() : void{}
      
      public function sysChatRed(param1:String) : void{}
      
      public function sysChatConsortia(param1:String) : void{}
      
      public function sysChatYellow(param1:String) : void{}
      
      public function sysChatLinkYellow(param1:String) : void{}
      
      public function sysChatAmaranth(param1:String) : void{}
      
      public function sysChatNotAgain(param1:String) : void{}
      
      public function redPackageLink(param1:String) : void{}
      
      public function get view() : ChatView{return null;}
      
      public function get visibleSwitchEnable() : Boolean{return false;}
      
      public function set visibleSwitchEnable(param1:Boolean) : void{}
      
      private function __bBugle(param1:PkgEvent) : void{}
      
      private function __bugleBuyHandler(param1:PkgEvent) : void{}
      
      private function __cBugle(param1:PkgEvent) : void{}
      
      private function __consortiaChat(param1:PkgEvent) : void{}
      
      private function __defyAffiche(param1:PkgEvent) : void{}
      
      private function __getItemMsgHandler(param1:PkgEvent) : void{}
      
      private function __goodLinkGetHandler(param1:PkgEvent) : void{}
      
      private function __p2pPrivateChat(param1:StreamEvent) : void{}
      
      private function __privateChat(param1:PkgEvent) : void{}
      
      private function __areaPrivateChat(param1:PkgEvent) : void{}
      
      private function __receiveFace(param1:PkgEvent) : void{}
      
      private function __sBugle(param1:PkgEvent) : void{}
      
      private function __fastInviteCall(param1:CrazyTankSocketEvent) : void{}
      
      private function __sceneChat(param1:PkgEvent) : void{}
      
      private function addRecentContacts(param1:int) : void{}
      
      private function __sysNotice(param1:PkgEvent) : void{}
      
      private function chatCheckSelf(param1:ChatData) : void{}
      
      protected function __onPlayerOnline(param1:PkgEvent) : void{}
      
      private function onConsortiaBackMsg(param1:PkgEvent) : void{}
      
      private function initEvent() : void{}
      
      private function __fastAuctionBugle(param1:CrazyTankSocketEvent) : void{}
      
      private function __yearFoodIsFublish(param1:Event) : void{}
      
      private function initView() : void{}
      
      private function sendMessage(param1:int, param2:String, param3:String, param4:Boolean) : void{}
      
      public function sendPrivateMessage(param1:String, param2:String, param3:Number = 0, param4:Boolean = false) : void{}
      
      public function sendAreaPrivateMessage(param1:String, param2:String, param3:int = -1) : void{}
      
      public function sendOldPlayerLoginPrompt(param1:PackageIn) : void{}
   }
}
