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
      
      public function chat(data:ChatData, needFormat:Boolean = true) : void
      {
         if(chatDisabled)
         {
            return;
         }
         if(needFormat)
         {
            data.msg = StringHelper.reverseHtmlTextField(data.msg);
            data.msg = FilterWordManager.filterWrodFromServer(data.msg);
            if(data.channel != 21)
            {
               ChatFormats.formatChatStyle(data);
            }
            else
            {
               ChatFormats.formatComplexChatStyle(data);
            }
         }
         data.htmlMessage = Helpers.deCodeString(data.htmlMessage);
         _model.addChat(data);
      }
      
      public function addTimePackTip(packName:String) : void
      {
         var data:ChatData = new ChatData();
         data.type = 105;
         data.channel = 7;
         data.msg = LanguageMgr.GetTranslation("ddt.timeGiftPack.tip",packName);
         ChatManager.Instance.chat(data);
      }
      
      public function get isInGame() : Boolean
      {
         return output.isInGame();
      }
      
      public function set focusFuncEnabled(value:Boolean) : void
      {
         _focusFuncEnabled = value;
      }
      
      public function get focusFuncEnabled() : Boolean
      {
         return _focusFuncEnabled;
      }
      
      public function get input() : ChatInputView
      {
         return _chatView.input;
      }
      
      public function set inputChannel(channel:int) : void
      {
         _chatView.input.channel = channel;
      }
      
      public function get lock() : Boolean
      {
         return _chatView.output.isLock;
      }
      
      public function set lock(value:Boolean) : void
      {
         _chatView.output.isLock = value;
      }
      
      public function get model() : ChatModel
      {
         return _model;
      }
      
      public function get output() : ChatOutputView
      {
         return _chatView.output;
      }
      
      public function set outputChannel(channel:int) : void
      {
         _chatView.output.channel = channel;
      }
      
      public function privateChatTo(nickname:String, id:int = 0, info:Object = null) : void
      {
         _chatView.input.setPrivateChatTo(nickname,id,info);
      }
      
      public function sendBugle(msg:String, type:int, isFastInvite:Boolean = false) : void
      {
         _isFastInvite = isFastInvite;
         if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(type,true) <= 0)
         {
            if(ShopManager.Instance.getMoneyShopItemByTemplateID(type))
            {
               input.setInputText(msg);
            }
            sysChatYellow(LanguageMgr.GetTranslation("tank.manager.ChatManager.tool"));
            if(!_shopBugle || !_shopBugle.info)
            {
               _shopBugle = new NewShopBugleView(type);
            }
            else if(_shopBugle.type != type)
            {
               _shopBugle.dispose();
               _shopBugle = null;
               _shopBugle = new NewShopBugleView(type);
            }
         }
         else
         {
            msg = Helpers.enCodeString(msg);
            if(type == 11101 && !isFastInvite)
            {
               SocketManager.Instance.out.sendSBugle(msg);
            }
            else if(type == 11102)
            {
               SocketManager.Instance.out.sendBBugle(msg,type);
            }
            else if(type == 11100)
            {
               SocketManager.Instance.out.sendCBugle(msg);
            }
            else if(isFastInvite)
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
      
      public function sendFastAuctionBugle(id:int, type:int = 11101) : void
      {
         if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(type,true) <= 0)
         {
            sysChatYellow(LanguageMgr.GetTranslation("tank.manager.ChatManager.tool"));
            if(!_shopBugle || !_shopBugle.info)
            {
               _shopBugle = new NewShopBugleView(type);
            }
            else if(_shopBugle.type != type)
            {
               _shopBugle.dispose();
               _shopBugle = null;
               _shopBugle = new NewShopBugleView(type);
            }
         }
         else
         {
            SocketManager.Instance.out.sendFastAuctionBugle(id);
         }
      }
      
      public function sendChat($chat:ChatData) : void
      {
         var i:int = 0;
         var gameControl:* = undefined;
         if($chat.msg == "showDebugStatus -fps")
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
         if($chat.msg == "updateFlashP2PKey")
         {
            for(i = 0; i < PlayerManager.Instance.onlineFriendList.length; )
            {
               SocketManager.Instance.out.sendPeerID(PlayerManager.Instance.Self.ZoneID,PlayerManager.Instance.onlineFriendList[i].ID,"");
               i++;
            }
            return;
         }
         if(GameManager.GAME_CAN_NOT_EXIT_SEND_LOG == 1 && $chat.msg == "发_送_日_志")
         {
            gameControl = getDefinitionByName("gameCommon.GameControl");
            if(gameControl)
            {
               gameControl.Instance.gameView.logTimeHandler();
            }
         }
         if(chatDisabled)
         {
            return;
         }
         if($chat.channel == 2)
         {
            if($chat.zoneID == -1 || $chat.zoneID == PlayerManager.Instance.Self.ZoneID)
            {
               sendPrivateMessage($chat.receiver,$chat.msg,$chat.receiverID,false);
            }
            else
            {
               sendAreaPrivateMessage($chat.receiver,$chat.msg,$chat.zoneID);
            }
         }
         else if($chat.channel == 15)
         {
            sendBugle($chat.msg,11100);
         }
         else if($chat.channel == 0)
         {
            sendBugle($chat.msg,11102);
         }
         else if($chat.channel == 1)
         {
            sendBugle($chat.msg,11101);
         }
         else if($chat.channel == 3)
         {
            sendMessage($chat.channel,$chat.sender,$chat.msg,false);
            dispatchEvent(new ChatEvent("sendConsortia"));
         }
         else if($chat.channel == 4)
         {
            sendMessage($chat.channel,$chat.sender,$chat.msg,true);
         }
         else if($chat.channel == 5 || $chat.channel == 9 || $chat.channel == 13 || $chat.channel == 20 || $chat.channel == 25 || $chat.channel == 99 || $chat.channel == 27)
         {
            sendMessage($chat.channel,$chat.sender,$chat.msg,false);
         }
         else if($chat.channel == 26)
         {
            sendMessage($chat.channel,$chat.sender,$chat.msg,false);
         }
      }
      
      public function sendFace(faceid:int) : void
      {
         SocketManager.Instance.out.sendFace(faceid);
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
      
      public function set state($state:int) : void
      {
         if(_state == $state)
         {
            return;
         }
         _state = $state;
         _chatView.state = _state;
         var _loc2_:* = $state != 27;
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
      
      public function sysChatRed(message:String) : void
      {
         var chatData:ChatData = new ChatData();
         chatData.channel = 6;
         chatData.msg = StringHelper.trim(message);
         chat(chatData);
      }
      
      public function sysChatConsortia(message:String) : void
      {
         var chatData:ChatData = new ChatData();
         chatData.channel = 3;
         chatData.msg = StringHelper.trim(message);
         chat(chatData);
      }
      
      public function sysChatYellow(message:String) : void
      {
         var chatData:ChatData = new ChatData();
         chatData.channel = 7;
         chatData.msg = StringHelper.trim(message);
         chat(chatData);
      }
      
      public function sysChatLinkYellow(message:String) : void
      {
         var chatData:ChatData = new ChatData();
         chatData.type = 100;
         chatData.channel = 7;
         chatData.msg = StringHelper.trim(message);
         chat(chatData);
      }
      
      public function sysChatAmaranth(message:String) : void
      {
         var chatData:ChatData = new ChatData();
         chatData.channel = 14;
         chatData.msg = StringHelper.trim(message);
         chat(chatData);
      }
      
      public function sysChatNotAgain(message:String) : void
      {
         var chatData:ChatData = new ChatData();
         chatData.type = 106;
         chatData.channel = 7;
         chatData.msg = StringHelper.trim(message);
         chat(chatData);
      }
      
      public function redPackageLink(msg:String) : void
      {
         var chatData:ChatData = new ChatData();
         chatData.type = 111;
         chatData.channel = 7;
         chatData.msg = StringHelper.trim(msg);
         chat(chatData);
      }
      
      public function get view() : ChatView
      {
         return _chatView;
      }
      
      public function get visibleSwitchEnable() : Boolean
      {
         return _visibleSwitchEnable;
      }
      
      public function set visibleSwitchEnable(value:Boolean) : void
      {
         if(_visibleSwitchEnable == value)
         {
            return;
         }
         _visibleSwitchEnable = value;
      }
      
      private function __bBugle(event:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var pkg:PackageIn = event.pkg as PackageIn;
         var cm:ChatData = new ChatData();
         cm.bigBuggleType = pkg.readInt();
         cm.channel = 0;
         cm.senderID = pkg.readInt();
         cm.receiver = "";
         cm.sender = pkg.readUTF();
         cm.msg = pkg.readUTF();
         chat(cm);
      }
      
      private function __bugleBuyHandler(event:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var pkg:PackageIn = event.pkg;
         pkg.position = 20;
         var successType:int = pkg.readInt();
         var buyFrom:int = pkg.readInt();
         if(buyFrom == 3 && successType == 1)
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
         else if(buyFrom == 5 && successType >= 1)
         {
            dispatchEvent(new Event("buybead"));
         }
      }
      
      private function __cBugle(event:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var pkg:PackageIn = event.pkg as PackageIn;
         var cm:ChatData = new ChatData();
         cm.channel = 15;
         cm.zoneID = pkg.readInt();
         cm.senderID = pkg.readInt();
         cm.receiver = "";
         cm.sender = pkg.readUTF();
         cm.msg = pkg.readUTF();
         cm.zoneName = pkg.readUTF();
         chat(cm);
      }
      
      private function __consortiaChat(event:PkgEvent) : void
      {
         var c:int = 0;
         var cm:* = null;
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var pkg:PackageIn = event.pkg as PackageIn;
         if(pkg.clientId != PlayerManager.Instance.Self.ID)
         {
            c = pkg.readByte();
            cm = new ChatData();
            cm.channel = 3;
            cm.senderID = pkg.clientId;
            cm.receiver = "";
            cm.sender = pkg.readUTF();
            cm.msg = pkg.readUTF();
            chatCheckSelf(cm);
         }
      }
      
      private function __defyAffiche(event:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var pkg:PackageIn = event.pkg as PackageIn;
         var cm:ChatData = new ChatData();
         cm.msg = pkg.readUTF();
         cm.channel = 11;
         chatCheckSelf(cm);
      }
      
      private function __getItemMsgHandler(event:PkgEvent) : void
      {
         var txt:* = null;
         var battle_str:* = null;
         var itemName:* = null;
         var itemNames:* = null;
         var str:* = null;
         var goodname:* = null;
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var pkg:PackageIn = event.pkg as PackageIn;
         var nickName:String = pkg.readUTF();
         var battle_type:int = pkg.readInt();
         var templateID:int = pkg.readInt();
         var isbinds:Boolean = pkg.readBoolean();
         var isBroadcast:int = pkg.readInt();
         var goodNum:int = pkg.readInt();
         if(battle_type == 0)
         {
            battle_str = LanguageMgr.GetTranslation("tank.game.GameView.unexpectedBattle");
         }
         else if(battle_type == 2)
         {
            battle_str = LanguageMgr.GetTranslation("tank.game.GameView.RouletteBattle");
         }
         else if(battle_type == 1)
         {
            battle_str = LanguageMgr.GetTranslation("tank.game.GameView.dungeonBattle");
         }
         else if(battle_type == 3)
         {
            battle_str = LanguageMgr.GetTranslation("tank.game.GameView.CaddyBattle");
         }
         else if(battle_type == 4)
         {
            battle_str = LanguageMgr.GetTranslation("tank.game.GameView.beadBattle");
         }
         else if(battle_type == 5)
         {
            battle_str = LanguageMgr.GetTranslation("tank.game.GameView.GiftBattle");
         }
         else if(battle_type == 11)
         {
            battle_str = LanguageMgr.GetTranslation("tank.game.GameView.BlessBattle");
         }
         else if(battle_type == 14)
         {
            battle_str = LanguageMgr.GetTranslation("tank.game.GameView.celebrationBattle");
         }
         else if(battle_type == 16)
         {
            itemName = ItemManager.Instance.getTemplateById(templateID).Name;
            battle_str = LanguageMgr.GetTranslation("tank.game.GameView.gypsyShopBought",nickName);
         }
         else if(battle_type == 17)
         {
            itemNames = ItemManager.Instance.getTemplateById(templateID).Name;
            battle_str = LanguageMgr.GetTranslation("tank.game.GameView.gypsyShopBoughtS",nickName,itemNames);
         }
         if(isBroadcast == 1)
         {
            txt = LanguageMgr.GetTranslation("tank.game.GameView.getgoodstip.broadcast","[" + nickName + "]",battle_str);
         }
         else if(isBroadcast == 2)
         {
            txt = LanguageMgr.GetTranslation("tank.game.GameView.getgoodstip",nickName,battle_str);
         }
         else if(isBroadcast == 3)
         {
            str = pkg.readUTF();
            txt = LanguageMgr.GetTranslation("tank.manager.congratulateGain","[" + nickName + "]",str);
            CaddyModel.instance.appendAwardsInfo(nickName,templateID,false,"",-1,battle_type);
         }
         else if(isBroadcast == 4)
         {
            txt = battle_str;
         }
         var itemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(templateID);
         if(itemInfo.Property1 != "31")
         {
            goodname = "[" + itemInfo.Name + "]";
         }
         else
         {
            goodname = "[" + itemInfo.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(templateID).Name + "Lv" + BeadTemplateManager.Instance.GetBeadInfobyID(templateID).BaseLevel + "]";
         }
         var data:ChatData = new ChatData();
         data.channel = 6;
         data.msg = txt + goodname + "x" + goodNum;
         var channelTag:Array = ChatFormats.getTagsByChannel(data);
         txt = StringHelper.rePlaceHtmlTextField(txt);
         var nameTag:String = ChatFormats.creatBracketsTag(txt,1);
         var goodTag:String = ChatFormats.creatGoodTag("[" + itemInfo.Name + "]" + "x" + goodNum,2,itemInfo.TemplateID,itemInfo.Quality,isbinds,data);
         data.htmlMessage = channelTag[0] + nameTag + goodTag + channelTag[1] + "<BR>";
         data.htmlMessage = Helpers.deCodeString(data.htmlMessage);
         _model.addChat(data);
      }
      
      private function __goodLinkGetHandler(e:PkgEvent) : void
      {
         var cardGroove:* = null;
         var guid:* = null;
         var cardInfo:* = null;
         var guid2:* = null;
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var info:InventoryItemInfo = new InventoryItemInfo();
         var pkg:PackageIn = e.pkg;
         var type:int = pkg.readInt();
         if(type == 4)
         {
            cardGroove = new GrooveInfo();
            guid = pkg.readUTF();
            cardGroove.CardId = pkg.readInt();
            cardGroove.Place = pkg.readInt();
            cardGroove.Type = pkg.readInt();
            cardGroove.Level = pkg.readInt();
            cardGroove.GP = pkg.readInt();
            if(CardManager.Instance.model.GrooveInfoVector)
            {
               CardManager.Instance.model.GrooveInfoVector[cardGroove.Place] = cardGroove;
            }
            else
            {
               CardManager.Instance.model.tempCardGroove = cardGroove;
            }
            model.addCardGrooveLink(guid,cardGroove);
            output.contentField.showCardGrooveLinkGoodsInfo(cardGroove,1);
            return;
         }
         if(type == 5)
         {
            cardInfo = new CardInfo();
            guid2 = pkg.readUTF();
            cardInfo.TemplateID = pkg.readInt();
            cardInfo.CardType = pkg.readInt();
            cardInfo.Attack = pkg.readInt();
            cardInfo.Defence = pkg.readInt();
            cardInfo.Agility = pkg.readInt();
            cardInfo.Luck = pkg.readInt();
            cardInfo.Damage = pkg.readInt();
            cardInfo.Guard = pkg.readInt();
            cardInfo.Place = 6;
            model.addCardInfoLink(guid2,cardInfo);
            output.contentField.showCardInfoLinkGoodsInfo(cardInfo,1);
            return;
         }
         var gUid:String = pkg.readUTF();
         info.TemplateID = pkg.readInt();
         ItemManager.fill(info);
         info.ItemID = pkg.readInt();
         info.StrengthenLevel = pkg.readInt();
         info.AttackCompose = pkg.readInt();
         info.AgilityCompose = pkg.readInt();
         info.LuckCompose = pkg.readInt();
         info.DefendCompose = pkg.readInt();
         if(EquipType.isMagicStone(info.CategoryID))
         {
            info.Attack = info.AttackCompose;
            info.Defence = info.DefendCompose;
            info.Agility = info.AgilityCompose;
            info.Luck = info.LuckCompose;
            info.Level = info.StrengthenLevel;
            info.MagicAttack = pkg.readInt();
            info.MagicDefence = pkg.readInt();
         }
         else
         {
            pkg.readInt();
            pkg.readInt();
         }
         info.ValidDate = pkg.readInt();
         info.IsBinds = pkg.readBoolean();
         info.IsJudge = pkg.readBoolean();
         info.IsUsed = pkg.readBoolean();
         if(info.IsUsed)
         {
            info.BeginDate = pkg.readUTF();
         }
         info.Hole1 = pkg.readInt();
         info.Hole2 = pkg.readInt();
         info.Hole3 = pkg.readInt();
         info.Hole4 = pkg.readInt();
         info.Hole5 = pkg.readInt();
         info.Hole6 = pkg.readInt();
         info.Hole = pkg.readUTF();
         info.Pic = pkg.readUTF();
         info.RefineryLevel = pkg.readInt();
         info.DiscolorValidDate = pkg.readDateString();
         info.Hole5Level = pkg.readByte();
         info.Hole5Exp = pkg.readInt();
         info.Hole6Level = pkg.readByte();
         info.Hole6Exp = pkg.readInt();
         info.isGold = pkg.readBoolean();
         if(info.isGold)
         {
            info.goldValidDate = pkg.readInt();
            info.goldBeginTime = pkg.readDateString();
         }
         info.MagicLevel = pkg.readInt();
         model.addLink(gUid,info);
         output.contentField.showLinkGoodsInfo(info,1);
      }
      
      private function __p2pPrivateChat(event:StreamEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var pkg:ByteArray = event.readByteArray;
         var cm:ChatData = new ChatData();
         cm.channel = 2;
         cm.receiverID = pkg.readInt();
         cm.receiver = pkg.readUTF();
         cm.sender = pkg.readUTF();
         cm.senderID = pkg.readInt();
         cm.msg = pkg.readUTF();
         cm.isAutoReply = pkg.readBoolean();
         chatCheckSelf(cm);
         if(cm.senderID != PlayerManager.Instance.Self.ID)
         {
            IMManager.Instance.saveRecentContactsID(cm.senderID);
         }
         else if(cm.receiverID != PlayerManager.Instance.Self.ID)
         {
            IMManager.Instance.saveRecentContactsID(cm.receiverID);
         }
      }
      
      private function __privateChat(event:PkgEvent) : void
      {
         var cm:* = null;
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var pkg:PackageIn = event.pkg;
         if(pkg.clientId)
         {
            cm = new ChatData();
            cm.channel = 2;
            cm.receiverID = pkg.readInt();
            cm.senderID = pkg.clientId;
            cm.receiver = pkg.readUTF();
            cm.sender = pkg.readUTF();
            cm.msg = pkg.readUTF();
            cm.isAutoReply = pkg.readBoolean();
            chatCheckSelf(cm);
            if(cm.senderID != PlayerManager.Instance.Self.ID)
            {
               IMManager.Instance.saveRecentContactsID(cm.senderID);
            }
            else if(cm.receiverID != PlayerManager.Instance.Self.ID)
            {
               IMManager.Instance.saveRecentContactsID(cm.receiverID);
            }
         }
      }
      
      private function __areaPrivateChat(event:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var pkg:PackageIn = event.pkg;
         var cm:ChatData = new ChatData();
         cm.channel = 2;
         cm.zoneName = pkg.readUTF();
         cm.sender = pkg.readUTF();
         cm.msg = pkg.readUTF();
         cm.zoneID = pkg.readInt();
         if(SharedManager.Instance.transregionalblackList[cm.sender] != null)
         {
            return;
         }
         chatCheckSelf(cm);
      }
      
      private function __receiveFace(evt:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var data:Object = {};
         data.playerid = evt.pkg.clientId;
         data.faceid = evt.pkg.readInt();
         data.delay = evt.pkg.readInt();
         dispatchEvent(new ChatEvent("addFace",data));
      }
      
      private function __sBugle(event:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var pkg:PackageIn = event.pkg as PackageIn;
         var cm:ChatData = new ChatData();
         cm.channel = 1;
         cm.senderID = pkg.readInt();
         cm.receiver = "";
         cm.sender = pkg.readUTF();
         cm.msg = pkg.readUTF();
         chat(cm);
      }
      
      private function __fastInviteCall(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg as PackageIn;
         var cm:ChatData = new ChatData();
         cm.type = 101;
         cm.channel = 1;
         cm.senderID = pkg.readInt();
         if(cm.senderID == -1 && PlayerManager.Instance.Self.ID == pkg.clientId)
         {
            PlayerManager.Instance.Self.freeInvitedUsedCnt++;
            ChatManager.Instance.dispatchEvent(new ChatEvent("freeInvited"));
         }
         cm.receiver = "";
         var sender:String = pkg.readUTF();
         if(cm.senderID == -1)
         {
            cm.sender = LanguageMgr.GetTranslation("ddt.newPlayer.smallHorn");
         }
         else
         {
            cm.sender = sender;
         }
         cm.msg = pkg.readUTF();
         cm.roomId = pkg.readInt();
         cm.password = pkg.readUTF();
         chat(cm);
      }
      
      private function __sceneChat(event:PkgEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var pkg:PackageIn = event.pkg as PackageIn;
         var cm:ChatData = new ChatData();
         cm.zoneID = pkg.readInt();
         cm.channel = pkg.readByte();
         if(pkg.readBoolean())
         {
            cm.channel = 4;
         }
         cm.senderID = pkg.clientId;
         cm.receiver = "";
         cm.sender = pkg.readUTF();
         cm.msg = pkg.readUTF();
         chatCheckSelf(cm);
         addRecentContacts(cm.senderID);
      }
      
      private function addRecentContacts(id:int) : void
      {
         var gameControl:* = undefined;
         if(StateManager.currentStateType == "dungeonRoom" || StateManager.currentStateType == "challengeRoom" || StateManager.currentStateType == "matchRoom" || StateManager.currentStateType == "missionResult" || StateManager.currentStateType == "gameLoading")
         {
            if(RoomManager.Instance.isIdenticalRoom(id))
            {
               IMManager.Instance.saveRecentContactsID(id);
            }
         }
         else if(StateManager.currentStateType == "fighting")
         {
            gameControl = getDefinitionByName("gameCommon.GameControl");
            if(gameControl)
            {
               if(gameControl.Instance.isIdenticalGame(id))
               {
                  IMManager.Instance.saveRecentContactsID(id);
               }
            }
         }
      }
      
      private function __sysNotice(event:PkgEvent) : void
      {
         var links:* = null;
         var data:* = null;
         var caddy:int = 0;
         var name:* = null;
         var id:int = 0;
         var zone:* = null;
         if(PlayerManager.Instance.Self.Grade <= 1)
         {
            return;
         }
         var type:int = event.pkg.readInt();
         var msg:String = event.pkg.readUTF();
         var o:ChatData = new ChatData();
         var isReadKey:Boolean = false;
         var _loc12_:* = type;
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
                                                                  o.channel = 7;
                                                               }
                                                               else
                                                               {
                                                                  data = {};
                                                                  data["msg"] = msg;
                                                                  data["pkg"] = event.pkg;
                                                                  ChatManager.Instance.dispatchEvent(new ChatEvent("systemPost",data));
                                                                  return;
                                                               }
                                                            }
                                                            else
                                                            {
                                                               o.channel = 7;
                                                            }
                                                         }
                                                         else
                                                         {
                                                            o.zoneID = event.pkg.readInt();
                                                            o.channel = 12;
                                                         }
                                                      }
                                                      else
                                                      {
                                                         o.zoneID = event.pkg.readInt();
                                                         o.channel = 28;
                                                      }
                                                   }
                                                }
                                                addr98:
                                                o.zoneID = event.pkg.readInt();
                                                o.channel = 12;
                                             }
                                             addr94:
                                             isReadKey = true;
                                             §§goto(addr98);
                                          }
                                          addr93:
                                          §§goto(addr94);
                                       }
                                       §§goto(addr93);
                                    }
                                    else
                                    {
                                       o.channel = 3;
                                    }
                                 }
                                 else
                                 {
                                    o.channel = 6;
                                 }
                              }
                           }
                           addr73:
                           o.channel = 7;
                        }
                        addr72:
                        §§goto(addr73);
                     }
                     addr71:
                     §§goto(addr72);
                  }
                  addr67:
                  isReadKey = true;
                  §§goto(addr71);
               }
               addr66:
               §§goto(addr67);
            }
            §§goto(addr66);
         }
         else
         {
            o.channel = 14;
         }
         if(event && event.pkg.bytesAvailable)
         {
            links = ChatHelper.readGoodsLinks(event.pkg,isReadKey);
         }
         o.type = type;
         o.zoneName = PlayerManager.Instance.getAreaNameByAreaID(o.zoneID);
         o.msg = StringHelper.rePlaceHtmlTextField(msg);
         o.link = links;
         chat(o);
         if(type == 12 && event.pkg.bytesAvailable)
         {
            caddy = event.pkg.readInt();
            if(caddy > 0)
            {
               name = event.pkg.readUTF();
               id = event.pkg.readInt();
               zone = event.pkg.readUTF();
               if(name != PlayerManager.Instance.Self.NickName)
               {
                  CaddyModel.instance.appendAwardsInfo(name,id,true,zone,o.zoneID,caddy);
               }
            }
         }
      }
      
      private function chatCheckSelf(data:ChatData) : void
      {
         var b:* = null;
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(70) && TaskManager.instance.getQuestDataByID(344) && data.channel == 3)
         {
            SocketManager.Instance.out.sendQuestCheck(344,1,0);
            SocketManager.Instance.out.syncWeakStep(70);
         }
         if(data.zoneID != -1 && data.zoneID != PlayerManager.Instance.Self.ZoneID)
         {
            if(data.sender != PlayerManager.Instance.Self.NickName || data.zoneID != PlayerManager.Instance.Self.ZoneID)
            {
               chat(data);
               return;
            }
         }
         else if(data.sender != PlayerManager.Instance.Self.NickName)
         {
            if(data.channel == 3)
            {
               b = PlayerManager.Instance.blackList;
               var _loc5_:int = 0;
               var _loc4_:* = b;
               for each(var player in b)
               {
                  if(player.NickName == data.sender)
                  {
                     return;
                  }
               }
            }
            chat(data);
         }
      }
      
      protected function __onPlayerOnline(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var name:String = pkg.readUTF();
         var titleID:int = pkg.readInt();
         var title:String = NewTitleManager.instance.titleInfo[titleID].Name;
         var data:ChatData = new ChatData();
         data.channel = 21;
         data.childChannelArr = [7,titleID,7];
         data.msg = LanguageMgr.GetTranslation("hall.player.online",title,name);
         chat(data);
      }
      
      private function onConsortiaBackMsg(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var type:int = pkg.readByte();
         var name:String = pkg.readUTF();
         var playerId:int = pkg.readInt();
         var data:ChatData = new ChatData();
         if(type == 0)
         {
            data.zoneID = PlayerManager.Instance.Self.ZoneID;
            data.zoneName = ServerManager.Instance.zoneName;
            name = ChatFormats.creatBracketsTag("[" + name + "]",1,null,data);
            data.htmlMessage = "<font color=\'#F6CF1C\'>" + LanguageMgr.GetTranslation("consortion.callBackView.chat.msg1",name) + "</font><BR>";
         }
         else if(type == 1)
         {
            name = ChatFormats.creatBracketsTag(LanguageMgr.GetTranslation("consortion.callBackView.chat.msg3"),112);
            name = "<font color=\'#FF00A6\'>" + name + "</font>";
            data.htmlMessage = "<font color=\'#F6CF1C\'>" + LanguageMgr.GetTranslation("consortion.callBackView.chat.msg2",name) + "</font><BR>";
         }
         data.channel = 3;
         chat(data,false);
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
      
      private function __fastAuctionBugle(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg as PackageIn;
         var cm:ChatData = new ChatData();
         cm.type = 107;
         cm.channel = 1;
         cm.receiver = "";
         cm.playerCharacterID = pkg.readInt();
         cm.sender = pkg.readUTF();
         cm.auctionID = pkg.readInt();
         cm.teamplateID = pkg.readInt();
         cm.itemCount = pkg.readInt();
         cm.mouthful = pkg.readInt();
         cm.payType = pkg.readInt();
         cm.price = pkg.readInt();
         cm.rise = pkg.readInt();
         cm.validDate = pkg.readInt();
         cm.auctionGoodName = ItemManager.Instance.getTemplateById(cm.teamplateID).Name;
         cm.msg = "【" + cm.sender + "】" + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellLeftView.bugleTxt",cm.price,cm.mouthful,cm.auctionGoodName,cm.itemCount);
         chat(cm);
      }
      
      private function __yearFoodIsFublish(event:Event) : void
      {
         var cm:ChatData = new ChatData();
         cm.type = 888;
         cm.channel = 1;
         cm.senderID = NewYearRiceManager.instance.model.playerID;
         cm.receiver = "";
         cm.sender = NewYearRiceManager.instance.model.playerName;
         cm.msg = "【" + cm.sender + "】" + LanguageMgr.GetTranslation("tank.newyearFood.view.bugleTxt");
         chat(cm);
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
      
      private function sendMessage(channelid:int, fromnick:String, msg:String, team:Boolean) : void
      {
         msg = Helpers.enCodeString(msg);
         var pkg:PackageOut = new PackageOut(19);
         pkg.writeByte(channelid);
         pkg.writeBoolean(team);
         pkg.writeUTF(fromnick);
         pkg.writeUTF(msg);
         SocketManager.Instance.out.sendPackage(pkg);
      }
      
      public function sendPrivateMessage(toNick:String, msg:String, toId:Number = 0, isAutoReply:Boolean = false) : void
      {
         var pkg:* = null;
         if(PathManager.flashP2PEbable && PlayerManager.Instance.findPlayer(toId).peerID != "")
         {
            msg = Helpers.enCodeString(msg);
            FlashP2PManager.Instance.sendPlivateMsg(PlayerManager.Instance.findPlayer(toId).peerID,toNick,msg,toId,isAutoReply);
         }
         else
         {
            msg = Helpers.enCodeString(msg);
            pkg = new PackageOut(37);
            pkg.writeInt(toId);
            pkg.writeUTF(toNick);
            pkg.writeUTF(PlayerManager.Instance.Self.NickName);
            pkg.writeUTF(msg);
            pkg.writeBoolean(isAutoReply);
            SocketManager.Instance.out.sendPackage(pkg);
         }
         if(RoomManager.Instance.current && !RoomManager.Instance.current.isCrossZone)
         {
            IMManager.Instance.saveRecentContactsID(toId);
         }
      }
      
      public function sendAreaPrivateMessage(toNick:String, msg:String, zoneID:int = -1) : void
      {
         msg = Helpers.enCodeString(msg);
         var pkg:PackageOut = new PackageOut(107);
         pkg.writeInt(zoneID);
         pkg.writeUTF(msg);
         pkg.writeUTF(toNick);
         SocketManager.Instance.out.sendPackage(pkg);
      }
      
      public function sendOldPlayerLoginPrompt(pkg:PackageIn) : void
      {
         var tmpName:String = pkg.readUTF();
         var chatData:ChatData = new ChatData();
         chatData.channel = 21;
         chatData.childChannelArr = [7,14];
         chatData.type = 103;
         chatData.msg = LanguageMgr.GetTranslation("oldPlayer.login.promptTxt",tmpName);
         chatData.receiver = tmpName;
         if(PlayerManager.Instance.Self.ConsortiaID != 0 && ConsortiaDutyManager.GetRight(PlayerManager.Instance.Self.Right,2))
         {
            chatData.msg = chatData.msg + ("|" + LanguageMgr.GetTranslation("oldPlayer.login.promptTxt2"));
         }
         chat(chatData);
      }
   }
}
