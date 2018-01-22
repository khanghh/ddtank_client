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
      
      public function ChatManager()
      {
         notAgainData = new DictionaryData();
         super();
      }
      
      public static function get Instance() : ChatManager
      {
         if(_instance == null)
         {
            _instance = new ChatManager();
         }
         return _instance;
      }
      
      public function chat(param1:ChatData, param2:Boolean = true) : void
      {
         if(chatDisabled)
         {
            return;
         }
         if(param2)
         {
            param1.msg = StringHelper.reverseHtmlTextField(param1.msg);
            param1.msg = FilterWordManager.filterWrodFromServer(param1.msg);
            if(param1.channel != 21)
            {
               ChatFormats.formatChatStyle(param1);
            }
            else
            {
               ChatFormats.formatComplexChatStyle(param1);
            }
         }
         param1.htmlMessage = Helpers.deCodeString(param1.htmlMessage);
         _model.addChat(param1);
      }
      
      public function addTimePackTip(param1:String) : void
      {
         var _loc2_:ChatData = new ChatData();
         _loc2_.type = 105;
         _loc2_.channel = 7;
         _loc2_.msg = LanguageMgr.GetTranslation("ddt.timeGiftPack.tip",param1);
         ChatManager.Instance.chat(_loc2_);
      }
      
      public function get isInGame() : Boolean
      {
         return output.isInGame();
      }
      
      public function set focusFuncEnabled(param1:Boolean) : void
      {
         _focusFuncEnabled = param1;
      }
      
      public function get focusFuncEnabled() : Boolean
      {
         return _focusFuncEnabled;
      }
      
      public function get input() : ChatInputView
      {
         return _chatView.input;
      }
      
      public function set inputChannel(param1:int) : void
      {
         _chatView.input.channel = param1;
      }
      
      public function get lock() : Boolean
      {
         return _chatView.output.isLock;
      }
      
      public function set lock(param1:Boolean) : void
      {
         _chatView.output.isLock = param1;
      }
      
      public function get model() : ChatModel
      {
         return _model;
      }
      
      public function get output() : ChatOutputView
      {
         return _chatView.output;
      }
      
      public function set outputChannel(param1:int) : void
      {
         _chatView.output.channel = param1;
      }
      
      public function privateChatTo(param1:String, param2:int = 0, param3:Object = null) : void
      {
         _chatView.input.setPrivateChatTo(param1,param2,param3);
      }
      
      public function sendBugle(param1:String, param2:int, param3:Boolean = false) : void
      {
         _isFastInvite = param3;
         if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(param2,true) <= 0)
         {
            if(ShopManager.Instance.getMoneyShopItemByTemplateID(param2))
            {
               input.setInputText(param1);
            }
            sysChatYellow(LanguageMgr.GetTranslation("tank.manager.ChatManager.tool"));
            if(!_shopBugle || !_shopBugle.info)
            {
               _shopBugle = new NewShopBugleView(param2);
            }
            else if(_shopBugle.type != param2)
            {
               _shopBugle.dispose();
               _shopBugle = null;
               _shopBugle = new NewShopBugleView(param2);
            }
         }
         else
         {
            param1 = Helpers.enCodeString(param1);
            if(param2 == 11101 && !param3)
            {
               SocketManager.Instance.out.sendSBugle(param1);
            }
            else if(param2 == 11102)
            {
               SocketManager.Instance.out.sendBBugle(param1,param2);
            }
            else if(param2 == 11100)
            {
               SocketManager.Instance.out.sendCBugle(param1);
            }
            else if(param3)
            {
               if(NewYearRiceManager.IsOpenFrame)
               {
                  SocketManager.Instance.out.sendInviteYearFoodRoom(false,PlayerManager.Instance.Self.ID,true);
                  return;
               }
               SocketManager.Instance.out.sendFastInviteCall();
            }
         }
      }
      
      public function sendFastAuctionBugle(param1:int, param2:int = 11101) : void
      {
         if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(param2,true) <= 0)
         {
            sysChatYellow(LanguageMgr.GetTranslation("tank.manager.ChatManager.tool"));
            if(!_shopBugle || !_shopBugle.info)
            {
               _shopBugle = new NewShopBugleView(param2);
            }
            else if(_shopBugle.type != param2)
            {
               _shopBugle.dispose();
               _shopBugle = null;
               _shopBugle = new NewShopBugleView(param2);
            }
         }
         else
         {
            SocketManager.Instance.out.sendFastAuctionBugle(param1);
         }
      }
      
      public function sendChat(param1:ChatData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = undefined;
         if(param1.msg == "showDebugStatus -fps")
         {
            if(!fpsContainer)
            {
               fpsContainer = new DebugStats();
               LayerManager.Instance.addToLayer(fpsContainer,0);
            }
            else
            {
               if(fpsContainer.parent)
               {
                  fpsContainer.parent.removeChild(fpsContainer);
               }
               fpsContainer = null;
            }
            return;
         }
         if(param1.msg == "updateFlashP2PKey")
         {
            _loc3_ = 0;
            while(_loc3_ < PlayerManager.Instance.onlineFriendList.length)
            {
               SocketManager.Instance.out.sendPeerID(PlayerManager.Instance.Self.ZoneID,PlayerManager.Instance.onlineFriendList[_loc3_].ID,"");
               _loc3_++;
            }
            return;
         }
         if(GameManager.GAME_CAN_NOT_EXIT_SEND_LOG == 1 && param1.msg == "发_送_日_志")
         {
            _loc2_ = getDefinitionByName("gameCommon.GameControl");
            if(_loc2_)
            {
               _loc2_.Instance.gameView.logTimeHandler();
            }
         }
         if(chatDisabled)
         {
            return;
         }
         if(param1.channel == 2)
         {
            if(param1.zoneID == -1 || param1.zoneID == PlayerManager.Instance.Self.ZoneID)
            {
               sendPrivateMessage(param1.receiver,param1.msg,param1.receiverID,false);
            }
            else
            {
               sendAreaPrivateMessage(param1.receiver,param1.msg,param1.zoneID);
            }
         }
         else if(param1.channel == 15)
         {
            sendBugle(param1.msg,11100);
         }
         else if(param1.channel == 0)
         {
            sendBugle(param1.msg,11102);
         }
         else if(param1.channel == 1)
         {
            sendBugle(param1.msg,11101);
         }
         else if(param1.channel == 3)
         {
            sendMessage(param1.channel,param1.sender,param1.msg,false);
            dispatchEvent(new ChatEvent("sendConsortia"));
         }
         else if(param1.channel == 4)
         {
            sendMessage(param1.channel,param1.sender,param1.msg,true);
         }
         else if(param1.channel == 5 || param1.channel == 9 || param1.channel == 13 || param1.channel == 20 || param1.channel == 25 || param1.channel == 99 || param1.channel == 27)
         {
            sendMessage(param1.channel,param1.sender,param1.msg,false);
         }
         else if(param1.channel == 26)
         {
            sendMessage(param1.channel,param1.sender,param1.msg,false);
         }
      }
      
      public function sendFace(param1:int) : void
      {
         SocketManager.Instance.out.sendFace(param1);
      }
      
      public function setFocus() : void
      {
         _chatView.input.inputField.setFocus();
      }
      
      public function releaseFocus() : void
      {
         StageReferance.stage.focus = StageReferance.stage;
      }
      
      public function setup() : void
      {
         if(_firstsetup)
         {
            if(_chatView)
            {
               return;
            }
            initView();
            initEvent();
         }
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         _chatView.state = _state;
         var _loc2_:* = param1 != 27;
         ChatManager.Instance.view.output.contentField.mouseChildren = _loc2_;
         ChatManager.Instance.view.output.contentField.mouseEnabled = _loc2_;
      }
      
      public function switchVisible() : void
      {
         if(_visibleSwitchEnable)
         {
            if(_chatView.input.parent)
            {
               _chatView.input.parent.removeChild(_chatView.input);
               _chatView.output.functionEnabled = false;
               _chatView.input.fastReplyPanel.isEditing = false;
               StageReferance.stage.focus = null;
            }
            else
            {
               _chatView.addChild(input);
               _chatView.output.functionEnabled = true;
               _chatView.input.inputField.setFocus();
            }
         }
         _chatView.input.hidePanel();
      }
      
      public function sysChatRed(param1:String) : void
      {
         var _loc2_:ChatData = new ChatData();
         _loc2_.channel = 6;
         _loc2_.msg = StringHelper.trim(param1);
         chat(_loc2_);
      }
      
      public function sysChatConsortia(param1:String) : void
      {
         var _loc2_:ChatData = new ChatData();
         _loc2_.channel = 3;
         _loc2_.msg = StringHelper.trim(param1);
         chat(_loc2_);
      }
      
      public function sysChatYellow(param1:String) : void
      {
         var _loc2_:ChatData = new ChatData();
         _loc2_.channel = 7;
         _loc2_.msg = StringHelper.trim(param1);
         chat(_loc2_);
      }
      
      public function sysChatLinkYellow(param1:String) : void
      {
         var _loc2_:ChatData = new ChatData();
         _loc2_.type = 100;
         _loc2_.channel = 7;
         _loc2_.msg = StringHelper.trim(param1);
         chat(_loc2_);
      }
      
      public function sysChatAmaranth(param1:String) : void
      {
         var _loc2_:ChatData = new ChatData();
         _loc2_.channel = 14;
         _loc2_.msg = StringHelper.trim(param1);
         chat(_loc2_);
      }
      
      public function sysChatNotAgain(param1:String) : void
      {
         var _loc2_:ChatData = new ChatData();
         _loc2_.type = 106;
         _loc2_.channel = 7;
         _loc2_.msg = StringHelper.trim(param1);
         chat(_loc2_);
      }
      
      public function redPackageLink(param1:String) : void
      {
         var _loc2_:ChatData = new ChatData();
         _loc2_.type = 111;
         _loc2_.channel = 7;
         _loc2_.msg = StringHelper.trim(param1);
         chat(_loc2_);
      }
      
      public function get view() : ChatView
      {
         return _chatView;
      }
      
      public function get visibleSwitchEnable() : Boolean
      {
         return _visibleSwitchEnable;
      }
      
      public function set visibleSwitchEnable(param1:Boolean) : void
      {
         if(_visibleSwitchEnable == param1)
         {
            return;
         }
         _visibleSwitchEnable = param1;
      }
      
      private function __bBugle(param1:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var _loc3_:PackageIn = param1.pkg as PackageIn;
         var _loc2_:ChatData = new ChatData();
         _loc2_.bigBuggleType = _loc3_.readInt();
         _loc2_.channel = 0;
         _loc2_.senderID = _loc3_.readInt();
         _loc2_.receiver = "";
         _loc2_.sender = _loc3_.readUTF();
         _loc2_.msg = _loc3_.readUTF();
         chat(_loc2_);
      }
      
      private function __bugleBuyHandler(param1:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var _loc3_:PackageIn = param1.pkg;
         _loc3_.position = 20;
         var _loc2_:int = _loc3_.readInt();
         var _loc4_:int = _loc3_.readInt();
         if(_loc4_ == 3 && _loc2_ == 1)
         {
            if(!_isFastInvite)
            {
               input.sendCurrentText();
            }
            else
            {
               sendBugle("",11101,true);
            }
         }
         else if(_loc4_ == 5 && _loc2_ >= 1)
         {
            dispatchEvent(new Event("buybead"));
         }
      }
      
      private function __cBugle(param1:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var _loc3_:PackageIn = param1.pkg as PackageIn;
         var _loc2_:ChatData = new ChatData();
         _loc2_.channel = 15;
         _loc2_.zoneID = _loc3_.readInt();
         _loc2_.senderID = _loc3_.readInt();
         _loc2_.receiver = "";
         _loc2_.sender = _loc3_.readUTF();
         _loc2_.msg = _loc3_.readUTF();
         _loc2_.zoneName = _loc3_.readUTF();
         chat(_loc2_);
      }
      
      private function __consortiaChat(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var _loc4_:PackageIn = param1.pkg as PackageIn;
         if(_loc4_.clientId != PlayerManager.Instance.Self.ID)
         {
            _loc3_ = _loc4_.readByte();
            _loc2_ = new ChatData();
            _loc2_.channel = 3;
            _loc2_.senderID = _loc4_.clientId;
            _loc2_.receiver = "";
            _loc2_.sender = _loc4_.readUTF();
            _loc2_.msg = _loc4_.readUTF();
            chatCheckSelf(_loc2_);
         }
      }
      
      private function __defyAffiche(param1:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var _loc3_:PackageIn = param1.pkg as PackageIn;
         var _loc2_:ChatData = new ChatData();
         _loc2_.msg = _loc3_.readUTF();
         _loc2_.channel = 11;
         chatCheckSelf(_loc2_);
      }
      
      private function __getItemMsgHandler(param1:PkgEvent) : void
      {
         var _loc7_:* = null;
         var _loc19_:* = null;
         var _loc2_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc17_:* = null;
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var _loc6_:PackageIn = param1.pkg as PackageIn;
         var _loc12_:String = _loc6_.readUTF();
         var _loc16_:int = _loc6_.readInt();
         var _loc9_:int = _loc6_.readInt();
         var _loc18_:Boolean = _loc6_.readBoolean();
         var _loc8_:int = _loc6_.readInt();
         var _loc13_:int = _loc6_.readInt();
         if(_loc16_ == 0)
         {
            _loc19_ = LanguageMgr.GetTranslation("tank.game.GameView.unexpectedBattle");
         }
         else if(_loc16_ == 2)
         {
            _loc19_ = LanguageMgr.GetTranslation("tank.game.GameView.RouletteBattle");
         }
         else if(_loc16_ == 1)
         {
            _loc19_ = LanguageMgr.GetTranslation("tank.game.GameView.dungeonBattle");
         }
         else if(_loc16_ == 3)
         {
            _loc19_ = LanguageMgr.GetTranslation("tank.game.GameView.CaddyBattle");
         }
         else if(_loc16_ == 4)
         {
            _loc19_ = LanguageMgr.GetTranslation("tank.game.GameView.beadBattle");
         }
         else if(_loc16_ == 5)
         {
            _loc19_ = LanguageMgr.GetTranslation("tank.game.GameView.GiftBattle");
         }
         else if(_loc16_ == 11)
         {
            _loc19_ = LanguageMgr.GetTranslation("tank.game.GameView.BlessBattle");
         }
         else if(_loc16_ == 14)
         {
            _loc19_ = LanguageMgr.GetTranslation("tank.game.GameView.celebrationBattle");
         }
         else if(_loc16_ == 16)
         {
            _loc2_ = ItemManager.Instance.getTemplateById(_loc9_).Name;
            _loc19_ = LanguageMgr.GetTranslation("tank.game.GameView.gypsyShopBought",_loc12_);
         }
         else if(_loc16_ == 17)
         {
            _loc10_ = ItemManager.Instance.getTemplateById(_loc9_).Name;
            _loc19_ = LanguageMgr.GetTranslation("tank.game.GameView.gypsyShopBoughtS",_loc12_,_loc10_);
         }
         if(_loc8_ == 1)
         {
            _loc7_ = LanguageMgr.GetTranslation("tank.game.GameView.getgoodstip.broadcast","[" + _loc12_ + "]",_loc19_);
         }
         else if(_loc8_ == 2)
         {
            _loc7_ = LanguageMgr.GetTranslation("tank.game.GameView.getgoodstip",_loc12_,_loc19_);
         }
         else if(_loc8_ == 3)
         {
            _loc11_ = _loc6_.readUTF();
            _loc7_ = LanguageMgr.GetTranslation("tank.manager.congratulateGain","[" + _loc12_ + "]",_loc11_);
            CaddyModel.instance.appendAwardsInfo(_loc12_,_loc9_,false,"",-1,_loc16_);
         }
         else if(_loc8_ == 4)
         {
            _loc7_ = _loc19_;
         }
         var _loc5_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_loc9_);
         if(_loc5_.Property1 != "31")
         {
            _loc17_ = "[" + _loc5_.Name + "]";
         }
         else
         {
            _loc17_ = "[" + _loc5_.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(_loc9_).Name + "Lv" + BeadTemplateManager.Instance.GetBeadInfobyID(_loc9_).BaseLevel + "]";
         }
         var _loc4_:ChatData = new ChatData();
         _loc4_.channel = 6;
         _loc4_.msg = _loc7_ + _loc17_ + "x" + _loc13_;
         var _loc3_:Array = ChatFormats.getTagsByChannel(_loc4_);
         _loc7_ = StringHelper.rePlaceHtmlTextField(_loc7_);
         var _loc15_:String = ChatFormats.creatBracketsTag(_loc7_,1);
         var _loc14_:String = ChatFormats.creatGoodTag("[" + _loc5_.Name + "]" + "x" + _loc13_,2,_loc5_.TemplateID,_loc5_.Quality,_loc18_,_loc4_);
         _loc4_.htmlMessage = _loc3_[0] + _loc15_ + _loc14_ + _loc3_[1] + "<BR>";
         _loc4_.htmlMessage = Helpers.deCodeString(_loc4_.htmlMessage);
         _model.addChat(_loc4_);
      }
      
      private function __goodLinkGetHandler(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var _loc9_:InventoryItemInfo = new InventoryItemInfo();
         var _loc7_:PackageIn = param1.pkg;
         var _loc8_:int = _loc7_.readInt();
         if(_loc8_ == 4)
         {
            _loc3_ = new GrooveInfo();
            _loc2_ = _loc7_.readUTF();
            _loc3_.CardId = _loc7_.readInt();
            _loc3_.Place = _loc7_.readInt();
            _loc3_.Type = _loc7_.readInt();
            _loc3_.Level = _loc7_.readInt();
            _loc3_.GP = _loc7_.readInt();
            if(CardManager.Instance.model.GrooveInfoVector)
            {
               CardManager.Instance.model.GrooveInfoVector[_loc3_.Place] = _loc3_;
            }
            else
            {
               CardManager.Instance.model.tempCardGroove = _loc3_;
            }
            model.addCardGrooveLink(_loc2_,_loc3_);
            output.contentField.showCardGrooveLinkGoodsInfo(_loc3_,1);
            return;
         }
         if(_loc8_ == 5)
         {
            _loc4_ = new CardInfo();
            _loc5_ = _loc7_.readUTF();
            _loc4_.TemplateID = _loc7_.readInt();
            _loc4_.CardType = _loc7_.readInt();
            _loc4_.Attack = _loc7_.readInt();
            _loc4_.Defence = _loc7_.readInt();
            _loc4_.Agility = _loc7_.readInt();
            _loc4_.Luck = _loc7_.readInt();
            _loc4_.Damage = _loc7_.readInt();
            _loc4_.Guard = _loc7_.readInt();
            _loc4_.Place = 6;
            model.addCardInfoLink(_loc5_,_loc4_);
            output.contentField.showCardInfoLinkGoodsInfo(_loc4_,1);
            return;
         }
         var _loc6_:String = _loc7_.readUTF();
         _loc9_.TemplateID = _loc7_.readInt();
         ItemManager.fill(_loc9_);
         _loc9_.ItemID = _loc7_.readInt();
         _loc9_.StrengthenLevel = _loc7_.readInt();
         _loc9_.AttackCompose = _loc7_.readInt();
         _loc9_.AgilityCompose = _loc7_.readInt();
         _loc9_.LuckCompose = _loc7_.readInt();
         _loc9_.DefendCompose = _loc7_.readInt();
         if(EquipType.isMagicStone(_loc9_.CategoryID))
         {
            _loc9_.Attack = _loc9_.AttackCompose;
            _loc9_.Defence = _loc9_.DefendCompose;
            _loc9_.Agility = _loc9_.AgilityCompose;
            _loc9_.Luck = _loc9_.LuckCompose;
            _loc9_.Level = _loc9_.StrengthenLevel;
            _loc9_.MagicAttack = _loc7_.readInt();
            _loc9_.MagicDefence = _loc7_.readInt();
         }
         else
         {
            _loc7_.readInt();
            _loc7_.readInt();
         }
         _loc9_.ValidDate = _loc7_.readInt();
         _loc9_.IsBinds = _loc7_.readBoolean();
         _loc9_.IsJudge = _loc7_.readBoolean();
         _loc9_.IsUsed = _loc7_.readBoolean();
         if(_loc9_.IsUsed)
         {
            _loc9_.BeginDate = _loc7_.readUTF();
         }
         _loc9_.Hole1 = _loc7_.readInt();
         _loc9_.Hole2 = _loc7_.readInt();
         _loc9_.Hole3 = _loc7_.readInt();
         _loc9_.Hole4 = _loc7_.readInt();
         _loc9_.Hole5 = _loc7_.readInt();
         _loc9_.Hole6 = _loc7_.readInt();
         _loc9_.Hole = _loc7_.readUTF();
         _loc9_.Pic = _loc7_.readUTF();
         _loc9_.RefineryLevel = _loc7_.readInt();
         _loc9_.DiscolorValidDate = _loc7_.readDateString();
         _loc9_.Hole5Level = _loc7_.readByte();
         _loc9_.Hole5Exp = _loc7_.readInt();
         _loc9_.Hole6Level = _loc7_.readByte();
         _loc9_.Hole6Exp = _loc7_.readInt();
         _loc9_.isGold = _loc7_.readBoolean();
         if(_loc9_.isGold)
         {
            _loc9_.goldValidDate = _loc7_.readInt();
            _loc9_.goldBeginTime = _loc7_.readDateString();
         }
         _loc9_.MagicLevel = _loc7_.readInt();
         model.addLink(_loc6_,_loc9_);
         output.contentField.showLinkGoodsInfo(_loc9_,1);
      }
      
      private function __p2pPrivateChat(param1:StreamEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var _loc3_:ByteArray = param1.readByteArray;
         var _loc2_:ChatData = new ChatData();
         _loc2_.channel = 2;
         _loc2_.receiverID = _loc3_.readInt();
         _loc2_.receiver = _loc3_.readUTF();
         _loc2_.sender = _loc3_.readUTF();
         _loc2_.senderID = _loc3_.readInt();
         _loc2_.msg = _loc3_.readUTF();
         _loc2_.isAutoReply = _loc3_.readBoolean();
         chatCheckSelf(_loc2_);
         if(_loc2_.senderID != PlayerManager.Instance.Self.ID)
         {
            IMManager.Instance.saveRecentContactsID(_loc2_.senderID);
         }
         else if(_loc2_.receiverID != PlayerManager.Instance.Self.ID)
         {
            IMManager.Instance.saveRecentContactsID(_loc2_.receiverID);
         }
      }
      
      private function __privateChat(param1:PkgEvent) : void
      {
         var _loc2_:* = null;
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var _loc3_:PackageIn = param1.pkg;
         if(_loc3_.clientId)
         {
            _loc2_ = new ChatData();
            _loc2_.channel = 2;
            _loc2_.receiverID = _loc3_.readInt();
            _loc2_.senderID = _loc3_.clientId;
            _loc2_.receiver = _loc3_.readUTF();
            _loc2_.sender = _loc3_.readUTF();
            _loc2_.msg = _loc3_.readUTF();
            _loc2_.isAutoReply = _loc3_.readBoolean();
            chatCheckSelf(_loc2_);
            if(_loc2_.senderID != PlayerManager.Instance.Self.ID)
            {
               IMManager.Instance.saveRecentContactsID(_loc2_.senderID);
            }
            else if(_loc2_.receiverID != PlayerManager.Instance.Self.ID)
            {
               IMManager.Instance.saveRecentContactsID(_loc2_.receiverID);
            }
         }
      }
      
      private function __areaPrivateChat(param1:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:ChatData = new ChatData();
         _loc2_.channel = 2;
         _loc2_.zoneName = _loc3_.readUTF();
         _loc2_.sender = _loc3_.readUTF();
         _loc2_.msg = _loc3_.readUTF();
         _loc2_.zoneID = _loc3_.readInt();
         if(SharedManager.Instance.transregionalblackList[_loc2_.sender] != null)
         {
            return;
         }
         chatCheckSelf(_loc2_);
      }
      
      private function __receiveFace(param1:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var _loc2_:Object = {};
         _loc2_.playerid = param1.pkg.clientId;
         _loc2_.faceid = param1.pkg.readInt();
         _loc2_.delay = param1.pkg.readInt();
         dispatchEvent(new ChatEvent("addFace",_loc2_));
      }
      
      private function __sBugle(param1:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var _loc3_:PackageIn = param1.pkg as PackageIn;
         var _loc2_:ChatData = new ChatData();
         _loc2_.channel = 1;
         _loc2_.senderID = _loc3_.readInt();
         _loc2_.receiver = "";
         _loc2_.sender = _loc3_.readUTF();
         _loc2_.msg = _loc3_.readUTF();
         chat(_loc2_);
      }
      
      private function __fastInviteCall(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg as PackageIn;
         var _loc3_:ChatData = new ChatData();
         _loc3_.type = 101;
         _loc3_.channel = 1;
         _loc3_.senderID = _loc4_.readInt();
         if(_loc3_.senderID == -1 && PlayerManager.Instance.Self.ID == _loc4_.clientId)
         {
            PlayerManager.Instance.Self.freeInvitedUsedCnt++;
            ChatManager.Instance.dispatchEvent(new ChatEvent("freeInvited"));
         }
         _loc3_.receiver = "";
         var _loc2_:String = _loc4_.readUTF();
         if(_loc3_.senderID == -1)
         {
            _loc3_.sender = LanguageMgr.GetTranslation("ddt.newPlayer.smallHorn");
         }
         else
         {
            _loc3_.sender = _loc2_;
         }
         _loc3_.msg = _loc4_.readUTF();
         _loc3_.roomId = _loc4_.readInt();
         _loc3_.password = _loc4_.readUTF();
         chat(_loc3_);
      }
      
      private function __sceneChat(param1:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var _loc3_:PackageIn = param1.pkg as PackageIn;
         var _loc2_:ChatData = new ChatData();
         _loc2_.zoneID = _loc3_.readInt();
         _loc2_.channel = _loc3_.readByte();
         if(_loc3_.readBoolean())
         {
            _loc2_.channel = 4;
         }
         _loc2_.senderID = _loc3_.clientId;
         _loc2_.receiver = "";
         _loc2_.sender = _loc3_.readUTF();
         _loc2_.msg = _loc3_.readUTF();
         chatCheckSelf(_loc2_);
         addRecentContacts(_loc2_.senderID);
      }
      
      private function addRecentContacts(param1:int) : void
      {
         var _loc2_:* = undefined;
         if(StateManager.currentStateType == "dungeonRoom" || StateManager.currentStateType == "challengeRoom" || StateManager.currentStateType == "matchRoom" || StateManager.currentStateType == "missionResult" || StateManager.currentStateType == "gameLoading")
         {
            if(RoomManager.Instance.isIdenticalRoom(param1))
            {
               IMManager.Instance.saveRecentContactsID(param1);
            }
         }
         else if(StateManager.currentStateType == "fighting")
         {
            _loc2_ = getDefinitionByName("gameCommon.GameControl");
            if(_loc2_)
            {
               if(_loc2_.Instance.isIdenticalGame(param1))
               {
                  IMManager.Instance.saveRecentContactsID(param1);
               }
            }
         }
      }
      
      private function __sysNotice(param1:PkgEvent) : void
      {
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc11_:* = null;
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var _loc9_:int = param1.pkg.readInt();
         var _loc10_:String = param1.pkg.readUTF();
         var _loc7_:ChatData = new ChatData();
         var _loc5_:Boolean = false;
         var _loc12_:* = _loc9_;
         if(0 !== _loc12_)
         {
            if(1 !== _loc12_)
            {
               if(5 !== _loc12_)
               {
                  if(20 !== _loc12_)
                  {
                     if(21 !== _loc12_)
                     {
                        if(2 !== _loc12_)
                        {
                           if(6 !== _loc12_)
                           {
                              if(7 !== _loc12_)
                              {
                                 if(3 !== _loc12_)
                                 {
                                    if(8 !== _loc12_)
                                    {
                                       if(10 !== _loc12_)
                                       {
                                          if(11 !== _loc12_)
                                          {
                                             if(18 !== _loc12_)
                                             {
                                                if(19 !== _loc12_)
                                                {
                                                   if(13 !== _loc12_)
                                                   {
                                                      if(14 !== _loc12_)
                                                      {
                                                         if(12 !== _loc12_)
                                                         {
                                                            if(9 !== _loc12_)
                                                            {
                                                               if(4 !== _loc12_)
                                                               {
                                                                  _loc7_.channel = 7;
                                                               }
                                                               else
                                                               {
                                                                  _loc6_ = {};
                                                                  _loc6_["msg"] = _loc10_;
                                                                  _loc6_["pkg"] = param1.pkg;
                                                                  ChatManager.Instance.dispatchEvent(new ChatEvent("systemPost",_loc6_));
                                                                  return;
                                                               }
                                                            }
                                                            else
                                                            {
                                                               _loc7_.channel = 7;
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _loc7_.zoneID = param1.pkg.readInt();
                                                            _loc7_.channel = 12;
                                                         }
                                                      }
                                                      else
                                                      {
                                                         _loc7_.zoneID = param1.pkg.readInt();
                                                         _loc7_.channel = 28;
                                                      }
                                                   }
                                                }
                                                addr74:
                                                _loc7_.zoneID = param1.pkg.readInt();
                                                _loc7_.channel = 12;
                                             }
                                             addr71:
                                             _loc5_ = true;
                                             §§goto(addr74);
                                          }
                                          addr70:
                                          §§goto(addr71);
                                       }
                                       §§goto(addr70);
                                    }
                                    else
                                    {
                                       _loc7_.channel = 3;
                                    }
                                 }
                                 else
                                 {
                                    _loc7_.channel = 6;
                                 }
                              }
                           }
                           addr53:
                           _loc7_.channel = 7;
                        }
                        addr52:
                        §§goto(addr53);
                     }
                     addr51:
                     §§goto(addr52);
                  }
                  addr48:
                  _loc5_ = true;
                  §§goto(addr51);
               }
               addr47:
               §§goto(addr48);
            }
            §§goto(addr47);
         }
         else
         {
            _loc7_.channel = 14;
         }
         if(param1 && param1.pkg.bytesAvailable)
         {
            _loc8_ = ChatHelper.readGoodsLinks(param1.pkg,_loc5_);
         }
         _loc7_.type = _loc9_;
         _loc7_.zoneName = PlayerManager.Instance.getAreaNameByAreaID(_loc7_.zoneID);
         _loc7_.msg = StringHelper.rePlaceHtmlTextField(_loc10_);
         _loc7_.link = _loc8_;
         chat(_loc7_);
         if(_loc9_ == 12 && param1.pkg.bytesAvailable)
         {
            _loc3_ = param1.pkg.readInt();
            if(_loc3_ > 0)
            {
               _loc4_ = param1.pkg.readUTF();
               _loc2_ = param1.pkg.readInt();
               _loc11_ = param1.pkg.readUTF();
               if(_loc4_ != PlayerManager.Instance.Self.NickName)
               {
                  CaddyModel.instance.appendAwardsInfo(_loc4_,_loc2_,true,_loc11_,_loc7_.zoneID,_loc3_);
               }
            }
         }
      }
      
      private function chatCheckSelf(param1:ChatData) : void
      {
         var _loc3_:* = null;
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(70) && TaskManager.instance.getQuestDataByID(344) && param1.channel == 3)
         {
            SocketManager.Instance.out.sendQuestCheck(344,1,0);
            SocketManager.Instance.out.syncWeakStep(70);
         }
         if(param1.zoneID != -1 && param1.zoneID != PlayerManager.Instance.Self.ZoneID)
         {
            if(param1.sender != PlayerManager.Instance.Self.NickName || param1.zoneID != PlayerManager.Instance.Self.ZoneID)
            {
               chat(param1);
               return;
            }
         }
         else if(param1.sender != PlayerManager.Instance.Self.NickName)
         {
            if(param1.channel == 3)
            {
               _loc3_ = PlayerManager.Instance.blackList;
               var _loc5_:int = 0;
               var _loc4_:* = _loc3_;
               for each(var _loc2_ in _loc3_)
               {
                  if(_loc2_.NickName == param1.sender)
                  {
                     return;
                  }
               }
            }
            chat(param1);
         }
      }
      
      protected function __onPlayerOnline(param1:PkgEvent) : void
      {
         var _loc6_:PackageIn = param1.pkg;
         var _loc4_:String = _loc6_.readUTF();
         var _loc3_:int = _loc6_.readInt();
         var _loc2_:String = NewTitleManager.instance.titleInfo[_loc3_].Name;
         var _loc5_:ChatData = new ChatData();
         _loc5_.channel = 21;
         _loc5_.childChannelArr = [7,_loc3_,7];
         _loc5_.msg = LanguageMgr.GetTranslation("hall.player.online",_loc2_,_loc4_);
         chat(_loc5_);
      }
      
      private function onConsortiaBackMsg(param1:PkgEvent) : void
      {
         var _loc5_:PackageIn = param1.pkg;
         var _loc6_:int = _loc5_.readByte();
         var _loc3_:String = _loc5_.readUTF();
         var _loc2_:int = _loc5_.readInt();
         var _loc4_:ChatData = new ChatData();
         if(_loc6_ == 0)
         {
            _loc4_.zoneID = PlayerManager.Instance.Self.ZoneID;
            _loc4_.zoneName = ServerManager.Instance.zoneName;
            _loc3_ = ChatFormats.creatBracketsTag("[" + _loc3_ + "]",1,null,_loc4_);
            _loc4_.htmlMessage = "<font color=\'#F6CF1C\'>" + LanguageMgr.GetTranslation("consortion.callBackView.chat.msg1",_loc3_) + "</font><BR>";
         }
         else if(_loc6_ == 1)
         {
            _loc3_ = ChatFormats.creatBracketsTag(LanguageMgr.GetTranslation("consortion.callBackView.chat.msg3"),112);
            _loc3_ = "<font color=\'#FF00A6\'>" + _loc3_ + "</font>";
            _loc4_.htmlMessage = "<font color=\'#F6CF1C\'>" + LanguageMgr.GetTranslation("consortion.callBackView.chat.msg2",_loc3_) + "</font><BR>";
         }
         _loc4_.channel = 3;
         chat(_loc4_,false);
      }
      
      private function initEvent() : void
      {
         if(!SHIELD_NOTICE)
         {
            SocketManager.Instance.addEventListener("fastInviteCall",__fastInviteCall);
            SocketManager.Instance.addEventListener("fast_auction_bugle",__fastAuctionBugle);
            SocketManager.Instance.addEventListener(PkgEvent.format(71),__sBugle);
            SocketManager.Instance.addEventListener(PkgEvent.format(72),__bBugle);
            SocketManager.Instance.addEventListener(PkgEvent.format(73),__cBugle);
            SocketManager.Instance.addEventListener(PkgEvent.format(14),__getItemMsgHandler);
            IMManager.Instance.addEventListener("isFublish",__yearFoodIsFublish);
         }
         SocketManager.Instance.addEventListener(PkgEvent.format(37),__privateChat);
         SocketManager.Instance.addEventListener(PkgEvent.format(107),__areaPrivateChat);
         SocketManager.Instance.addEventListener(PkgEvent.format(19),__sceneChat);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,20),__consortiaChat);
         SocketManager.Instance.addEventListener(PkgEvent.format(20),__receiveFace);
         SocketManager.Instance.addEventListener(PkgEvent.format(10),__sysNotice);
         SocketManager.Instance.addEventListener(PkgEvent.format(123),__defyAffiche);
         SocketManager.Instance.addEventListener(PkgEvent.format(44),__bugleBuyHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(119),__goodLinkGetHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(262,6),__onPlayerOnline);
         SocketManager.Instance.addEventListener(PkgEvent.format(343,16),onConsortiaBackMsg);
         FlashP2PManager.Instance.addEventListener("PrivateMsg",__p2pPrivateChat);
      }
      
      private function __fastAuctionBugle(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg as PackageIn;
         var _loc2_:ChatData = new ChatData();
         _loc2_.type = 107;
         _loc2_.channel = 1;
         _loc2_.receiver = "";
         _loc2_.playerCharacterID = _loc3_.readInt();
         _loc2_.sender = _loc3_.readUTF();
         _loc2_.auctionID = _loc3_.readInt();
         _loc2_.teamplateID = _loc3_.readInt();
         _loc2_.itemCount = _loc3_.readInt();
         _loc2_.mouthful = _loc3_.readInt();
         _loc2_.payType = _loc3_.readInt();
         _loc2_.price = _loc3_.readInt();
         _loc2_.rise = _loc3_.readInt();
         _loc2_.validDate = _loc3_.readInt();
         _loc2_.auctionGoodName = ItemManager.Instance.getTemplateById(_loc2_.teamplateID).Name;
         _loc2_.msg = "【" + _loc2_.sender + "】" + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellLeftView.bugleTxt",_loc2_.price,_loc2_.mouthful,_loc2_.auctionGoodName,_loc2_.itemCount);
         chat(_loc2_);
      }
      
      private function __yearFoodIsFublish(param1:Event) : void
      {
         var _loc2_:ChatData = new ChatData();
         _loc2_.type = 888;
         _loc2_.channel = 1;
         _loc2_.senderID = NewYearRiceManager.instance.model.playerID;
         _loc2_.receiver = "";
         _loc2_.sender = NewYearRiceManager.instance.model.playerName;
         _loc2_.msg = "【" + _loc2_.sender + "】" + LanguageMgr.GetTranslation("tank.newyearFood.view.bugleTxt");
         chat(_loc2_);
      }
      
      private function initView() : void
      {
         ChatFormats.setup();
         _model = new ChatModel();
         _chatView = ComponentFactory.Instance.creatCustomObject("chat.View");
         state = 0;
         inputChannel = 5;
         outputChannel = 0;
      }
      
      private function sendMessage(param1:int, param2:String, param3:String, param4:Boolean) : void
      {
         param3 = Helpers.enCodeString(param3);
         var _loc5_:PackageOut = new PackageOut(19);
         _loc5_.writeByte(param1);
         _loc5_.writeBoolean(param4);
         _loc5_.writeUTF(param2);
         _loc5_.writeUTF(param3);
         SocketManager.Instance.out.sendPackage(_loc5_);
      }
      
      public function sendPrivateMessage(param1:String, param2:String, param3:Number = 0, param4:Boolean = false) : void
      {
         var _loc5_:* = null;
         if(PathManager.flashP2PEbable && PlayerManager.Instance.findPlayer(param3).peerID != "")
         {
            param2 = Helpers.enCodeString(param2);
            FlashP2PManager.Instance.sendPlivateMsg(PlayerManager.Instance.findPlayer(param3).peerID,param1,param2,param3,param4);
         }
         else
         {
            param2 = Helpers.enCodeString(param2);
            _loc5_ = new PackageOut(37);
            _loc5_.writeInt(param3);
            _loc5_.writeUTF(param1);
            _loc5_.writeUTF(PlayerManager.Instance.Self.NickName);
            _loc5_.writeUTF(param2);
            _loc5_.writeBoolean(param4);
            SocketManager.Instance.out.sendPackage(_loc5_);
         }
         if(RoomManager.Instance.current && !RoomManager.Instance.current.isCrossZone)
         {
            IMManager.Instance.saveRecentContactsID(param3);
         }
      }
      
      public function sendAreaPrivateMessage(param1:String, param2:String, param3:int = -1) : void
      {
         param2 = Helpers.enCodeString(param2);
         var _loc4_:PackageOut = new PackageOut(107);
         _loc4_.writeInt(param3);
         _loc4_.writeUTF(param2);
         _loc4_.writeUTF(param1);
         SocketManager.Instance.out.sendPackage(_loc4_);
      }
      
      public function sendOldPlayerLoginPrompt(param1:PackageIn) : void
      {
         var _loc2_:String = param1.readUTF();
         var _loc3_:ChatData = new ChatData();
         _loc3_.channel = 21;
         _loc3_.childChannelArr = [7,14];
         _loc3_.type = 103;
         _loc3_.msg = LanguageMgr.GetTranslation("oldPlayer.login.promptTxt",_loc2_);
         _loc3_.receiver = _loc2_;
         if(PlayerManager.Instance.Self.ConsortiaID != 0 && ConsortiaDutyManager.GetRight(PlayerManager.Instance.Self.Right,2))
         {
            _loc3_.msg = _loc3_.msg + ("|" + LanguageMgr.GetTranslation("oldPlayer.login.promptTxt2"));
         }
         chat(_loc3_);
      }
   }
}
