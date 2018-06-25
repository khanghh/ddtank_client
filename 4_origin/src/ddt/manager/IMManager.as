package ddt.manager
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.data.CMFriendInfo;
   import ddt.data.InviteInfo;
   import ddt.data.analyze.LoadCMFriendList;
   import ddt.data.analyze.RecentContactsAnalyze;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.FilterWordManager;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.im.FriendGroupFrame;
   import ddt.view.im.MessageBox;
   import ddt.view.im.PrivateChatFrame;
   import ddtBuried.BuriedManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import flash.utils.Timer;
   import game.GameManager;
   import gypsyShop.ctrl.GypsyShopManager;
   import im.IMEvent;
   import im.PresentRecordInfo;
   import invite.InviteManager;
   import newYearRice.NewYearRiceManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.utils.StringHelper;
   import room.RoomManager;
   import roomList.RoomListEnumerate;
   import wonderfulActivity.WonderfulActivityManager;
   
   public class IMManager extends EventDispatcher
   {
      
      public static const CMFRIEND_COMPLETE:String = "CMFriendComplete";
      
      public static const HAS_NEW_MESSAGE:String = "hasNewMessage";
      
      public static const NO_MESSAGE:String = "nomessage";
      
      public static const ALERT_MESSAGE:String = "alertMessage";
      
      public static const MAX_MESSAGE_IN_BOX:int = 10;
      
      public static var IS_SHOW_SUB:Boolean;
      
      public static var isInIM:Boolean = false;
      
      public static const ISFUBLISH:String = "isFublish";
      
      private static var _instance:IMManager;
       
      
      private var _existChat:Vector.<PresentRecordInfo>;
      
      private var _name:String;
      
      private var _baseAlerFrame:BaseAlerFrame;
      
      private var _recentContactsList:Array;
      
      private var _isLoadRecentContacts:Boolean;
      
      private var _loader:DisplayLoader;
      
      private var _talkTimer:Timer;
      
      public var isLoadComplete:Boolean = false;
      
      public var privateChatFocus:Boolean;
      
      public var changeID:int;
      
      public var cancelflashState:Boolean;
      
      private var _teamChatFrame:Object;
      
      private var _lastTeamId:int;
      
      private var _privateFrame:PrivateChatFrame;
      
      private var _lastId:int;
      
      private var _changeInfo:PlayerInfo;
      
      private var _messageBox:MessageBox;
      
      private var _timer:Timer;
      
      private var _groupFrame:FriendGroupFrame;
      
      private var _tempLock:Boolean;
      
      private var _id:int;
      
      private var _groupId:int;
      
      private var _groupName:String;
      
      private var _deleteRecentContact:int;
      
      private var _isAddCMFriend:Boolean = true;
      
      private var _prohibitInviteList:DictionaryData;
      
      public function IMManager()
      {
         _talkTimer = new Timer(1000);
         super();
         _existChat = new Vector.<PresentRecordInfo>();
         _prohibitInviteList = new DictionaryData();
      }
      
      public static function get Instance() : IMManager
      {
         if(_instance == null)
         {
            _instance = new IMManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(160,51),__privateTalkHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(70),__receiveInvite);
         SocketManager.Instance.addEventListener(PkgEvent.format(160,166),__friendResponse);
         SocketManager.Instance.addEventListener(PkgEvent.format(160,52),__teamTalkHandler);
         NewYearRiceManager.instance.addEventListener("yearFoodRoomInvite",__yearFoodRoomInvite);
         addEventListener("challenge",__onChanllengeClick);
         loadIcon();
      }
      
      private function __yearFoodRoomInvite(event:CrazyTankSocketEvent) : void
      {
         var alert1:* = null;
         var pkg:PackageIn = event.pkg;
         NewYearRiceManager.instance.model.playerID = pkg.readInt();
         NewYearRiceManager.instance.model.playerName = pkg.readUTF();
         var isPublish:Boolean = pkg.readBoolean();
         if(getInviteState() && InviteManager.Instance.enabled && !isPublish)
         {
            alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("NewYearRiceMainView.view.Invite",NewYearRiceManager.instance.model.playerName),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            alert1.addEventListener("response",__inviteNewYearRice);
         }
         else
         {
            dispatchEvent(new Event("isFublish"));
         }
      }
      
      private function __inviteNewYearRice(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__inviteNewYearRice);
         alert.disposeChildren = true;
         alert.dispose();
         alert = null;
         if(e.responseCode == 3)
         {
            SocketManager.Instance.out.sendInviteYearFoodRoom(true,NewYearRiceManager.instance.model.playerID);
         }
      }
      
      protected function __onChanllengeClick(e:Event) : void
      {
         if(PlayerTipManager.instance.info.Grade < 12)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.cantBeChallenged",12));
            return;
         }
         if(PlayerTipManager.instance.info.playerState.StateID == 0 && PlayerTipManager.instance.info is FriendListPlayer)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.friendOffline"));
            return;
         }
         var i:int = Math.random() * RoomListEnumerate.PREWORD.length;
         GameInSocketOut.sendCreateRoom(RoomListEnumerate.PREWORD[i],1,2,"");
         RoomManager.Instance.tempInventPlayerID = PlayerTipManager.instance.info.ID;
      }
      
      private function __privateTalkHandler(event:PkgEvent) : void
      {
         var tempInfo:* = null;
         var i:int = 0;
         var n:int = 0;
         var player:* = null;
         var pkg:PackageIn = event.pkg;
         var playerId:int = pkg.readInt();
         var playerName:String = pkg.readUTF();
         var date:Date = pkg.readDate();
         var content:String = pkg.readUTF();
         var autoReply:Boolean = pkg.readBoolean();
         for(i = 0; i < _existChat.length; )
         {
            if(_existChat[i].id == playerId)
            {
               tempInfo = _existChat[i];
               tempInfo.addMessage(playerName,date,content);
               if(playerName != PlayerManager.Instance.Self.NickName)
               {
                  if(!_talkTimer.running && _privateFrame != null)
                  {
                     SoundManager.instance.play("200");
                     _talkTimer.start();
                     _talkTimer.addEventListener("timer",__stopTalkTime);
                  }
                  _existChat.splice(i,1);
                  _existChat.unshift(tempInfo);
               }
               break;
            }
            i++;
         }
         if(tempInfo == null)
         {
            tempInfo = new PresentRecordInfo();
            tempInfo.id = playerId;
            tempInfo.addMessage(playerName,date,content);
            _existChat.unshift(tempInfo);
         }
         saveInShared(tempInfo);
         getMessage();
         saveRecentContactsID(tempInfo.id);
         if(_privateFrame != null && _privateFrame.parent && _privateFrame.playerInfo.ID == playerId)
         {
            for(n = 0; n < _existChat.length; )
            {
               if(_existChat[n].id == playerId)
               {
                  _privateFrame.addMessage(_existChat[n].lastMessage);
                  _existChat[n].exist = 0;
                  break;
               }
               n++;
            }
         }
         else
         {
            setExist(playerId,2);
            changeID = playerId;
            cancelflashState = false;
            dispatchEvent(new Event("hasNewMessage"));
         }
         if(PlayerManager.Instance.Self.playerState.AutoReply != "" && playerName != PlayerManager.Instance.Self.NickName && !autoReply)
         {
            player = PlayerManager.Instance.findPlayer(playerId) as PlayerInfo;
            if(player && player.playerState.StateID == 1)
            {
               SocketManager.Instance.out.sendOneOnOneTalk(playerId,FilterWordManager.filterWrod(PlayerManager.Instance.Self.playerState.AutoReply),true);
            }
         }
      }
      
      private function __stopTalkTime(event:TimerEvent) : void
      {
         _talkTimer.stop();
         _talkTimer.removeEventListener("timer",__stopTalkTime);
      }
      
      public function setExist(id:int, exist:int, isTeamChat:Boolean = false) : void
      {
         var i:int = 0;
         var j:int = 0;
         if(isTeamChat)
         {
            for(i = 0; i < _existChat.length; )
            {
               if(_existChat[i].teamId == id)
               {
                  _existChat[i].exist = exist;
                  break;
               }
               i++;
            }
         }
         else
         {
            j = 0;
            while(j < _existChat.length)
            {
               if(_existChat[j].id == id)
               {
                  _existChat[j].exist = exist;
                  break;
               }
               j++;
            }
         }
      }
      
      private function TeamSaveShared(tempInfo:PresentRecordInfo) : void
      {
         var message:* = undefined;
         if(SharedManager.Instance.teamChatRecord[tempInfo.teamId] == null)
         {
            SharedManager.Instance.teamChatRecord[tempInfo.teamId] = tempInfo.recordMessage;
         }
         else
         {
            message = SharedManager.Instance.teamChatRecord[tempInfo.teamId];
            if(message != tempInfo.recordMessage)
            {
               message.push(tempInfo.lastRecordMessage);
            }
            SharedManager.Instance.teamChatRecord[tempInfo.teamId] = message;
         }
         SharedManager.Instance.save();
      }
      
      private function saveInShared(tempInfo:PresentRecordInfo) : void
      {
         var message:* = undefined;
         if(SharedManager.Instance.privateChatRecord[tempInfo.id] == null)
         {
            SharedManager.Instance.privateChatRecord[tempInfo.id] = tempInfo.recordMessage;
         }
         else
         {
            message = SharedManager.Instance.privateChatRecord[tempInfo.id];
            if(message != tempInfo.recordMessage)
            {
               message.push(tempInfo.lastRecordMessage);
            }
            SharedManager.Instance.privateChatRecord[tempInfo.id] = message;
         }
         SharedManager.Instance.save();
      }
      
      private function __teamTalkHandler(e:PkgEvent) : void
      {
         var tempInfo:* = null;
         var i:int = 0;
         var n:int = 0;
         var pkg:PackageIn = e.pkg;
         var teamId:int = pkg.readInt();
         var playerName:String = pkg.readUTF();
         var date:Date = pkg.readDate();
         var content:String = pkg.readUTF();
         for(i = 0; i < _existChat.length; )
         {
            if(_existChat[i].teamId == teamId)
            {
               tempInfo = _existChat[i];
               tempInfo.addMessage(playerName,date,content);
               if(playerName != PlayerManager.Instance.Self.NickName)
               {
                  _existChat.splice(i,1);
                  _existChat.unshift(tempInfo);
               }
               break;
            }
            i++;
         }
         if(tempInfo == null)
         {
            tempInfo = new PresentRecordInfo();
            tempInfo.teamId = teamId;
            tempInfo.addMessage(playerName,date,content);
            _existChat.unshift(tempInfo);
         }
         TeamSaveShared(tempInfo);
         getMessage();
         if(_teamChatFrame != null && _teamChatFrame.parent)
         {
            for(n = 0; n < _existChat.length; )
            {
               if(_existChat[n].teamId == teamId)
               {
                  _teamChatFrame.addMessage(_existChat[n].lastMessage);
                  _existChat[n].exist = 0;
                  break;
               }
               n++;
            }
         }
         else
         {
            setExist(teamId,2,true);
            changeID = teamId;
            cancelflashState = false;
            dispatchEvent(new Event("hasNewMessage"));
         }
      }
      
      public function alertTeamChatFrame(id:int = 0) : void
      {
         var i:int = 0;
         var messages:* = undefined;
         var tempInfo:* = null;
         if(_teamChatFrame == null)
         {
            _teamChatFrame = ClassUtils.CreatInstance("team.view.im.TeamIMFrame");
         }
         if(_privateFrame && _privateFrame.parent)
         {
            setExist(_lastId,1);
            _privateFrame.parent.removeChild(_privateFrame);
            _lastId = 0;
         }
         if(id != 0)
         {
            _lastTeamId = id;
         }
         else
         {
            _lastTeamId = _existChat[0].id;
         }
         for(i = 0; i < _existChat.length; )
         {
            if(_existChat[i].teamId == id)
            {
               _existChat[i].exist = 0;
               messages = _existChat[i].messages;
               _teamChatFrame.addAllMessage(messages);
               tempInfo = _existChat[i];
               dispatchEvent(new Event("alertMessage"));
               _existChat.splice(i,1);
               _existChat.push(tempInfo);
               break;
            }
            i++;
         }
         if(!hasUnreadMessage())
         {
            dispatchEvent(new Event("nomessage"));
         }
         getMessage();
         if(_teamChatFrame)
         {
            LayerManager.Instance.addToLayer(_teamChatFrame as Sprite,2,true);
         }
      }
      
      public function alertPrivateFrame(id:int = 0) : void
      {
         var i:int = 0;
         var messages:* = undefined;
         var tempInfo:* = null;
         if(_privateFrame == null)
         {
            _privateFrame = ComponentFactory.Instance.creatComponentByStylename("privateChatFrame");
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(27))
         {
            return;
         }
         if(id == 0 && (_existChat.length == 0 || _existChat.length == 1 && _privateFrame.parent))
         {
            return;
         }
         if(id != 0 && _lastId == id)
         {
            return;
         }
         if(_teamChatFrame && _teamChatFrame.parent)
         {
            setExist(_lastTeamId,1,true);
            _teamChatFrame.parent.removeChild(_teamChatFrame as Sprite);
         }
         if(_privateFrame.parent)
         {
            setExist(_lastId,1);
            _privateFrame.parent.removeChild(_privateFrame);
         }
         if(id != 0)
         {
            _changeInfo = PlayerManager.Instance.findPlayer(id);
            _lastId = id;
         }
         else
         {
            _changeInfo = PlayerManager.Instance.findPlayer(_existChat[0].id);
            _lastId = _existChat[0].id;
         }
         try
         {
            _privateFrame.playerInfo = _changeInfo;
         }
         catch(e:Error)
         {
            SocketManager.Instance.out.sendItemEquip(_changeInfo.ID,false);
            _changeInfo.addEventListener("propertychange",__IDChange);
         }
         i = 0;
         while(i < _existChat.length)
         {
            if(_existChat[i].id == _lastId)
            {
               _existChat[i].exist = 0;
               messages = _existChat[i].messages;
               _privateFrame.addAllMessage(messages);
               tempInfo = _existChat[i];
               changeID = _existChat[i].id;
               dispatchEvent(new Event("alertMessage"));
               _existChat.splice(i,1);
               _existChat.push(tempInfo);
               break;
            }
            i++;
         }
         if(!hasUnreadMessage())
         {
            dispatchEvent(new Event("nomessage"));
         }
         getMessage();
         saveRecentContactsID(id);
         LayerManager.Instance.addToLayer(_privateFrame,2,true);
      }
      
      public function cancelFlash() : void
      {
         cancelflashState = true;
         dispatchEvent(new Event("nomessage"));
      }
      
      public function hasUnreadMessage() : Boolean
      {
         var i:int = 0;
         for(i = 0; i < _existChat.length; )
         {
            if(_existChat[i].exist == 2)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      protected function __IDChange(event:PlayerPropertyEvent) : void
      {
         _changeInfo.removeEventListener("propertychange",__IDChange);
         _privateFrame.playerInfo = _changeInfo;
      }
      
      public function hidePrivateFrame(id:int) : void
      {
         var i:int = 0;
         StageReferance.stage.focus = StageReferance.stage;
         for(i = 0; i < _existChat.length; )
         {
            if(id != _existChat[i].id)
            {
               if(i == _existChat.length - 1)
               {
                  createPresentRecordInfo(id);
               }
               i++;
               continue;
            }
            break;
         }
         if(_existChat.length == 0)
         {
            createPresentRecordInfo(id);
         }
         _lastId = 0;
         if(_privateFrame.parent)
         {
            _privateFrame.parent.removeChild(_privateFrame);
         }
         setExist(id,1);
      }
      
      public function hideTeamChatFrame(id:int) : void
      {
         var i:int = 0;
         StageReferance.stage.focus = StageReferance.stage;
         for(i = 0; i < _existChat.length; )
         {
            if(id != _existChat[i].teamId)
            {
               if(i == _existChat.length - 1)
               {
                  createPresentRecordInfo(id,true);
               }
               i++;
               continue;
            }
            break;
         }
         if(_existChat.length == 0)
         {
            createPresentRecordInfo(id,true);
         }
         _lastId = 0;
         if(_teamChatFrame.parent)
         {
            _teamChatFrame.parent.removeChild(_teamChatFrame);
         }
         setExist(id,1,true);
      }
      
      private function createPresentRecordInfo(id:int, isTeamChat:Boolean = false) : void
      {
         var tempInfo:* = null;
         tempInfo = new PresentRecordInfo();
         if(isTeamChat)
         {
            tempInfo.teamId = id;
         }
         else
         {
            tempInfo.id = id;
         }
         tempInfo.exist = 1;
         _existChat.push(tempInfo);
      }
      
      public function disposeTeamChatFrame() : void
      {
         _lastTeamId = 0;
         if(_teamChatFrame)
         {
            ObjectUtils.disposeObject(_teamChatFrame);
         }
         _teamChatFrame = null;
         removeTeamMessage(PlayerManager.Instance.Self.teamID);
      }
      
      public function disposePrivateFrame(id:int) : void
      {
         StageReferance.stage.focus = StageReferance.stage;
         _lastId = 0;
         if(_privateFrame.parent)
         {
            _privateFrame.parent.removeChild(_privateFrame);
         }
         removePrivateMessage(id);
      }
      
      public function removeTeamMessage(id:int) : void
      {
         var i:int = 0;
         for(i = 0; i < _existChat.length; )
         {
            if(_existChat[i].teamId == id)
            {
               _existChat.splice(i,1);
               break;
            }
            i++;
         }
      }
      
      public function removePrivateMessage(id:int) : void
      {
         var i:int = 0;
         for(i = 0; i < _existChat.length; )
         {
            if(_existChat[i].id == id)
            {
               changeID = id;
               dispatchEvent(new Event("alertMessage"));
               _existChat.splice(i,1);
               break;
            }
            i++;
         }
         if(!hasUnreadMessage())
         {
            dispatchEvent(new Event("nomessage"));
         }
      }
      
      public function showMessageBox(obj:DisplayObject) : void
      {
         var pos:* = null;
         if(_messageBox == null)
         {
            _messageBox = new MessageBox();
            _timer = new Timer(200);
            _timer.addEventListener("timer",__timerHandler);
         }
         if(getMessage().length > 0)
         {
            LayerManager.Instance.addToLayer(_messageBox,2);
            pos = obj.localToGlobal(new Point(0,0));
            _messageBox.y = pos.y - _messageBox.height;
            _messageBox.x = pos.x - _messageBox.width / 2 + obj.width / 2;
            if(_messageBox.x + _messageBox.width > StageReferance.stageWidth)
            {
               _messageBox.x = StageReferance.stageWidth - _messageBox.width - 10;
            }
         }
         _timer.stop();
      }
      
      public function getMessage() : Vector.<PresentRecordInfo>
      {
         var i:int = 0;
         var temp:Vector.<PresentRecordInfo> = new Vector.<PresentRecordInfo>();
         if(_messageBox)
         {
            for(i = 0; i < _existChat.length; )
            {
               if(_existChat[i].exist != 0)
               {
                  temp.push(_existChat[i]);
               }
               if(temp.length != 10)
               {
                  i++;
                  continue;
               }
               break;
            }
            _messageBox.message = temp;
         }
         return temp;
      }
      
      protected function __timerHandler(event:TimerEvent) : void
      {
         if(!_messageBox.overState)
         {
            _messageBox.parent.removeChild(_messageBox);
            _timer.stop();
         }
      }
      
      public function hideMessageBox() : void
      {
         if(_messageBox && _messageBox.parent && _timer)
         {
            _timer.reset();
            _timer.start();
         }
      }
      
      public function setupRecentContactsList() : void
      {
         if(!_recentContactsList)
         {
            _recentContactsList = [];
         }
         _recentContactsList = SharedManager.Instance.recentContactsID[PlayerManager.Instance.Self.ID];
         _isLoadRecentContacts = true;
      }
      
      public function show() : void
      {
         AssetModuleLoader.addModelLoader("ddtim",6);
         AssetModuleLoader.startCodeLoader(dispatchShow);
      }
      
      private function dispatchShow() : void
      {
         dispatchEvent(new IMEvent("imOpenView"));
      }
      
      public function get icon() : Bitmap
      {
         return _loader.content as Bitmap;
      }
      
      private function loadIcon() : void
      {
         _loader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.CommunityIcon(),0) as BitmapLoader;
      }
      
      private function __friendResponse(evt:PkgEvent) : void
      {
         var str:* = null;
         var id:int = evt.pkg.clientId;
         var idtemp:int = evt.pkg.readInt();
         var _nick:String = evt.pkg.readUTF();
         var isSameCity:Boolean = evt.pkg.readBoolean();
         if(isSameCity)
         {
            str = LanguageMgr.GetTranslation("tank.view.im.IMController.sameCityfriend");
            str = str.replace(/r/g,"[" + _nick + "]");
         }
         else
         {
            str = "[" + _nick + "]" + LanguageMgr.GetTranslation("tank.view.im.IMController.friend");
         }
         ChatManager.Instance.sysChatYellow(str);
      }
      
      private function __receiveInvite(evt:PkgEvent) : void
      {
         var pkg:* = null;
         var info:* = null;
         if(getInviteState() && InviteManager.Instance.enabled)
         {
            if(PlayerManager.Instance.Self.Grade < 4)
            {
               return;
            }
            if(!SharedManager.Instance.showInvateWindow)
            {
               return;
            }
            pkg = evt.pkg;
            info = new InviteInfo();
            info.playerid = pkg.readInt();
            info.roomid = pkg.readInt();
            info.mapid = pkg.readInt();
            info.secondType = pkg.readByte();
            info.gameMode = pkg.readByte();
            info.hardLevel = pkg.readByte();
            info.levelLimits = pkg.readByte();
            info.nickname = pkg.readUTF();
            info.isAttest = pkg.readBoolean();
            info.typeVIP = pkg.readByte();
            info.VIPLevel = pkg.readInt();
            info.RN = pkg.readUTF();
            info.password = pkg.readUTF();
            info.barrierNum = pkg.readInt();
            info.isOpenBoss = pkg.readBoolean();
            info.power = pkg.readInt();
            info.level = pkg.readInt();
            info.isOld = pkg.readBoolean();
            if(info.gameMode > 2 && PlayerManager.Instance.Self.Grade < GameManager.MinLevelDuplicate)
            {
               return;
            }
            if(WonderfulActivityManager.Instance.frameFlag || BuriedManager.Instance.isOpening)
            {
               return;
            }
            startReceiveInvite(info);
         }
      }
      
      private function startReceiveInvite(info:InviteInfo) : void
      {
         if(_prohibitInviteList[info.nickname])
         {
            return;
         }
         SoundManager.instance.play("018");
         var lastFocusObject:InteractiveObject = StageReferance.stage.focus;
         InviteManager.Instance.showResponseInviteFrame(info);
         if(lastFocusObject is TextField)
         {
            if(TextField(lastFocusObject).type == "input")
            {
               StageReferance.stage.focus = lastFocusObject;
            }
         }
      }
      
      private function getInviteState() : Boolean
      {
         if(!SharedManager.Instance.showInvateWindow)
         {
            return false;
         }
         if(BagStore.instance.storeOpenAble)
         {
            return false;
         }
         if(GypsyShopManager.getInstance().gypsyShopFrameIsShowing)
         {
            return false;
         }
         var _loc1_:* = StateManager.currentStateType;
         if("main" !== _loc1_)
         {
            if("roomlist" !== _loc1_)
            {
               if("dungeon" !== _loc1_)
               {
                  if("braveDoorRoom" !== _loc1_)
                  {
                     return false;
                  }
               }
               addr39:
               return true;
            }
            addr38:
            §§goto(addr39);
         }
         §§goto(addr38);
      }
      
      public function addFriend(name:String) : void
      {
         if(isMaxFriend())
         {
            return;
         }
         _name = name;
         if(!checkFriendExist(_name))
         {
            alertGroupFrame(_name);
         }
      }
      
      public function isMaxFriend() : Boolean
      {
         var len:int = 0;
         if(PlayerManager.Instance.Self.IsVIP)
         {
            len = PlayerManager.Instance.Self.VIPLevel + 2;
         }
         if(PlayerManager.Instance.friendList.length >= 200 + len * 50)
         {
            _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.im.IMController.addFriend",200 + len * 50),"","",false,false,false,2);
            _baseAlerFrame.addEventListener("response",__close);
            return true;
         }
         return false;
      }
      
      private function alertGroupFrame(name:String) : void
      {
         if(_groupFrame == null)
         {
            _groupFrame = ComponentFactory.Instance.creatComponentByStylename("friendGroupFrame");
            _groupFrame.nickName = name;
         }
         LayerManager.Instance.addToLayer(_groupFrame,1,true,1);
         _tempLock = ChatManager.Instance.lock;
         StageReferance.stage.focus = _groupFrame;
      }
      
      public function clearGroupFrame() : void
      {
         _groupFrame = null;
      }
      
      private function __close(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__close);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
      }
      
      public function addBlackList(name:String) : void
      {
         if(PlayerManager.Instance.blackList.length >= 200)
         {
            _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.im.IMController.addBlackList"),"","",false,false,false,2);
            _baseAlerFrame.addEventListener("response",__closeII);
            return;
         }
         _name = name;
         if(!checkBlackListExit(name))
         {
            if(_baseAlerFrame)
            {
               _baseAlerFrame.removeEventListener("response",__frameEventII);
               _baseAlerFrame.dispose();
               _baseAlerFrame = null;
            }
            _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.im.IMController.issure"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true);
            _baseAlerFrame.addEventListener("response",__frameEvent);
            _tempLock = ChatManager.Instance.lock;
         }
      }
      
      private function __closeII(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__closeII);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
      }
      
      private function __frameEvent(evt:FrameEvent) : void
      {
         if(StateManager.currentStateType == "main")
         {
            ChatManager.Instance.lock = _tempLock;
         }
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               if(_baseAlerFrame)
               {
                  _baseAlerFrame.removeEventListener("response",__frameEvent);
                  _baseAlerFrame.dispose();
                  _baseAlerFrame = null;
                  break;
               }
               break;
            case 2:
            case 3:
            case 4:
               if(_baseAlerFrame)
               {
                  _baseAlerFrame.removeEventListener("response",__frameEvent);
                  _baseAlerFrame.dispose();
                  _baseAlerFrame = null;
               }
               __addBlack();
         }
      }
      
      private function __frameEventII(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(StateManager.currentStateType == "main")
         {
            ChatManager.Instance.lock = _tempLock;
         }
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               if(_baseAlerFrame)
               {
                  _baseAlerFrame.removeEventListener("response",__frameEventII);
                  _baseAlerFrame.dispose();
                  _baseAlerFrame = null;
                  break;
               }
               break;
            case 2:
            case 3:
            case 4:
               if(_baseAlerFrame)
               {
                  _baseAlerFrame.removeEventListener("response",__frameEventII);
                  _baseAlerFrame.dispose();
                  _baseAlerFrame = null;
               }
               alertGroupFrame(_name);
         }
      }
      
      private function __addBlack() : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendAddFriend(_name,1);
         _name = "";
      }
      
      private function checkBlackListExit(s:String) : Boolean
      {
         if(s == PlayerManager.Instance.Self.NickName)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.im.IMController.cannot"));
            return true;
         }
         var f:DictionaryData = PlayerManager.Instance.blackList;
         var _loc5_:int = 0;
         var _loc4_:* = f;
         for each(var i in f)
         {
            if(i.NickName == s)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.im.IMController.thisplayer"));
               return true;
            }
         }
         return false;
      }
      
      private function checkFriendExist(s:String) : Boolean
      {
         if(!s)
         {
            return true;
         }
         if(s.toLowerCase() == PlayerManager.Instance.Self.NickName.toLowerCase())
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.im.IMController.cannotAddSelfFriend"));
            return true;
         }
         var f:DictionaryData = PlayerManager.Instance.friendList;
         var _loc7_:int = 0;
         var _loc6_:* = f;
         for each(var i in f)
         {
            if(i.NickName == s)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.im.IMController.chongfu"));
               return true;
            }
         }
         var b:DictionaryData = PlayerManager.Instance.blackList;
         var _loc9_:int = 0;
         var _loc8_:* = b;
         for each(var j in b)
         {
            if(j.NickName == s)
            {
               _name = s;
               _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.im.IMController.thisone"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               _baseAlerFrame.addEventListener("response",__frameEventII);
               return true;
            }
         }
         return false;
      }
      
      public function deleteFriend(id:int, isDeleteBlack:Boolean = false) : void
      {
         _id = id;
         disposeAlert();
         if(!isDeleteBlack)
         {
            _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.im.IMFriendItem.deleteFriend"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
            _baseAlerFrame.addEventListener("response",__frameEventIII);
         }
         else
         {
            _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.im.IMBlackItem.sure"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
            _baseAlerFrame.addEventListener("response",__frameEventIII);
         }
      }
      
      public function deleteGroup(groupId:int, groupName:String) : void
      {
         _groupId = groupId;
         _groupName = groupName;
         disposeAlert();
         _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.im.IMGourp.sure",groupName),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
         _baseAlerFrame.addEventListener("response",__deleteGroupEvent);
      }
      
      private function __deleteGroupEvent(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               disposeAlert();
               break;
            case 2:
            case 3:
            case 4:
               disposeAlert();
               SocketManager.Instance.out.sendCustomFriends(2,_groupId,_groupName);
         }
      }
      
      private function __frameEventIII(evt:FrameEvent) : void
      {
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               disposeAlert();
               break;
            case 2:
            case 3:
            case 4:
               disposeAlert();
               SocketManager.Instance.out.sendDelFriend(_id);
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.im.IMController.success"));
               _id = -1;
         }
      }
      
      private function disposeAlert() : void
      {
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__frameEventIII);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
      }
      
      public function deleteRecentContacts(ID:int = 0) : void
      {
         if(!_recentContactsList)
         {
            return;
         }
         _deleteRecentContact = ID;
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__deleteRecentContact);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
         _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("im.IMController.deleteRecentContactsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
         _baseAlerFrame.addEventListener("response",__deleteRecentContact);
      }
      
      private function __deleteRecentContact(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               if(_baseAlerFrame)
               {
                  _baseAlerFrame.removeEventListener("response",__deleteRecentContact);
                  _baseAlerFrame.dispose();
                  _baseAlerFrame = null;
                  break;
               }
               break;
            case 2:
            case 3:
            case 4:
               if(_baseAlerFrame)
               {
                  _baseAlerFrame.removeEventListener("response",__deleteRecentContact);
                  _baseAlerFrame.dispose();
                  _baseAlerFrame = null;
               }
               if(testIdentical(_deleteRecentContact) != -1)
               {
                  _recentContactsList.splice(testIdentical(_deleteRecentContact),1);
                  if(_deleteRecentContact != 0)
                  {
                     PlayerManager.Instance.deleteRecentContact(_deleteRecentContact);
                  }
               }
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.im.IMController.success"));
               SharedManager.Instance.recentContactsID[PlayerManager.Instance.Self.ID] = _recentContactsList;
               SharedManager.Instance.save();
               _isLoadRecentContacts = true;
         }
      }
      
      public function isFriend(name:String) : Boolean
      {
         var f:DictionaryData = PlayerManager.Instance.friendList;
         var _loc5_:int = 0;
         var _loc4_:* = f;
         for each(var i in f)
         {
            if(i.NickName == name)
            {
               return true;
            }
         }
         return false;
      }
      
      public function onDeleteGirlPic() : void
      {
         PlayerManager.Instance.Self.IsShow = false;
         PlayerManager.Instance.Self.ImagePath = "";
         PlayerManager.Instance.dispatchEvent(new CEvent("girl_head_photo_change",false));
      }
      
      public function girlHeadSelectedBtnClicked(isUse:Boolean) : void
      {
         GameInSocketOut.sendUseGirlPhoto(isUse);
         PlayerManager.Instance.Self.IsShow = isUse;
         PlayerManager.Instance.dispatchEvent(new CEvent("girl_head_photo_change",isUse));
      }
      
      public function createConsortiaLoader() : void
      {
         var args:* = null;
         var loader:* = null;
         if(!StringHelper.isNullOrEmpty(PathManager.CommunityFriendList()))
         {
            args = RequestVairableCreater.creatWidthKey(true);
            args["uid"] = PlayerManager.Instance.Account.Account;
            loader = LoadResourceManager.Instance.createLoader(PathManager.CommunityFriendList(),6,args,"GET",null,true,true);
            loader.analyzer = new LoadCMFriendList(setupCMFriendList);
            LoadResourceManager.Instance.startLoad(loader);
         }
      }
      
      private function setupCMFriendList(analyzer:LoadCMFriendList) : void
      {
         dispatchEvent(new Event("CMFriendComplete"));
         if(PlayerManager.Instance.Self.IsFirst == 1 && _isAddCMFriend)
         {
            cmFriendAddToFriend();
         }
      }
      
      private function cmFriendAddToFriend() : void
      {
         _isAddCMFriend = false;
         var cmFriends:DictionaryData = PlayerManager.Instance.CMFriendList;
         var friends:DictionaryData = PlayerManager.Instance.friendList;
         var _loc5_:int = 0;
         var _loc4_:* = cmFriends;
         for each(var i in cmFriends)
         {
            if(i.IsExist && !friends[i.UserId])
            {
               SocketManager.Instance.out.sendAddFriend(i.NickName,0,true);
               cmFriends.remove(i.UserName);
            }
         }
      }
      
      public function loadRecentContacts() : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["id"] = PlayerManager.Instance.Self.ID;
         args["recentContacts"] = getFullRecentContactsID();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("IMRecentContactsList.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingBuddyListFailure");
         loader.analyzer = new RecentContactsAnalyze(PlayerManager.Instance.setupRecentContacts);
         LoadResourceManager.Instance.startLoad(loader);
         _isLoadRecentContacts = false;
      }
      
      public function get recentContactsList() : Array
      {
         return _recentContactsList;
      }
      
      private function getFullRecentContactsID() : String
      {
         var _fullRecentContactsID:String = "";
         var _loc4_:int = 0;
         var _loc3_:* = _recentContactsList;
         for each(var recentContact in _recentContactsList)
         {
            if(recentContact != 0)
            {
               _fullRecentContactsID = _fullRecentContactsID + (String(recentContact) + ",");
            }
         }
         _fullRecentContactsID = _fullRecentContactsID.substr(0,_fullRecentContactsID.length - 1);
         if(_fullRecentContactsID == "")
         {
            _fullRecentContactsID = "0";
         }
         return _fullRecentContactsID;
      }
      
      public function saveRecentContactsID(ID:int = 0) : void
      {
         if(!_recentContactsList)
         {
            _recentContactsList = [];
         }
         if(ID == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         if(_recentContactsList.length < 20)
         {
            if(testIdentical(ID) != -1)
            {
               _recentContactsList.splice(testIdentical(ID),1);
            }
            _recentContactsList.unshift(ID);
         }
         else
         {
            if(testIdentical(ID) != -1)
            {
               _recentContactsList.splice(testIdentical(ID),1);
            }
            else
            {
               _recentContactsList.splice(-1,1);
            }
            _recentContactsList.unshift(ID);
         }
         SharedManager.Instance.recentContactsID[PlayerManager.Instance.Self.ID] = _recentContactsList;
         SharedManager.Instance.save();
         _isLoadRecentContacts = true;
      }
      
      public function testIdentical(id:int) : int
      {
         var i:int = 0;
         if(_recentContactsList)
         {
            for(i = 0; i < _recentContactsList.length; )
            {
               if(_recentContactsList[i] == id)
               {
                  return i;
               }
               i++;
            }
         }
         return -1;
      }
      
      public function sortAcademyPlayer(list:Array) : Array
      {
         var temp:Array = [];
         var self:SelfInfo = PlayerManager.Instance.Self;
         if(self.getMasterOrApprentices().length <= 0)
         {
            return list;
         }
         var myAcademyPlayers:DictionaryData = self.getMasterOrApprentices();
         if(self.getMasterOrApprentices().length > 0)
         {
            var _loc8_:int = 0;
            var _loc7_:* = list;
            for each(var i in list)
            {
               if(myAcademyPlayers[i.ID] && i.ID != self.ID)
               {
                  if(i.ID == self.masterID)
                  {
                     temp.unshift(i);
                  }
                  else
                  {
                     temp.push(i);
                  }
               }
            }
            var _loc10_:int = 0;
            var _loc9_:* = temp;
            for each(var j in temp)
            {
               list.splice(list.indexOf(j),1);
            }
         }
         list = temp.concat(list);
         return list;
      }
      
      public function addTransregionalblackList(name:String) : void
      {
         SharedManager.Instance.transregionalblackList[name] = name;
         SharedManager.Instance.save();
      }
      
      public function get prohibitInviteList() : DictionaryData
      {
         return _prohibitInviteList;
      }
      
      public function get existChat() : Vector.<PresentRecordInfo>
      {
         return _existChat;
      }
      
      public function get isLoadRecentContacts() : Boolean
      {
         return _isLoadRecentContacts;
      }
      
      public function set isLoadRecentContacts(value:Boolean) : void
      {
         _isLoadRecentContacts = value;
      }
   }
}
