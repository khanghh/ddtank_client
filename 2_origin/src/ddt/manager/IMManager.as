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
      
      private function __yearFoodRoomInvite(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         NewYearRiceManager.instance.model.playerID = _loc3_.readInt();
         NewYearRiceManager.instance.model.playerName = _loc3_.readUTF();
         var _loc4_:Boolean = _loc3_.readBoolean();
         if(getInviteState() && InviteManager.Instance.enabled && !_loc4_)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("NewYearRiceMainView.view.Invite",NewYearRiceManager.instance.model.playerName),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            _loc2_.addEventListener("response",__inviteNewYearRice);
         }
         else
         {
            dispatchEvent(new Event("isFublish"));
         }
      }
      
      private function __inviteNewYearRice(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__inviteNewYearRice);
         _loc2_.disposeChildren = true;
         _loc2_.dispose();
         _loc2_ = null;
         if(param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendInviteYearFoodRoom(true,NewYearRiceManager.instance.model.playerID);
         }
      }
      
      protected function __onChanllengeClick(param1:Event) : void
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
         var _loc2_:int = Math.random() * RoomListEnumerate.PREWORD.length;
         GameInSocketOut.sendCreateRoom(RoomListEnumerate.PREWORD[_loc2_],1,2,"");
         RoomManager.Instance.tempInventPlayerID = PlayerTipManager.instance.info.ID;
      }
      
      private function __privateTalkHandler(param1:PkgEvent) : void
      {
         var _loc6_:* = null;
         var _loc11_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc8_:PackageIn = param1.pkg;
         var _loc5_:int = _loc8_.readInt();
         var _loc4_:String = _loc8_.readUTF();
         var _loc10_:Date = _loc8_.readDate();
         var _loc2_:String = _loc8_.readUTF();
         var _loc9_:Boolean = _loc8_.readBoolean();
         _loc11_ = 0;
         while(_loc11_ < _existChat.length)
         {
            if(_existChat[_loc11_].id == _loc5_)
            {
               _loc6_ = _existChat[_loc11_];
               _loc6_.addMessage(_loc4_,_loc10_,_loc2_);
               if(_loc4_ != PlayerManager.Instance.Self.NickName)
               {
                  if(!_talkTimer.running && _privateFrame != null)
                  {
                     SoundManager.instance.play("200");
                     _talkTimer.start();
                     _talkTimer.addEventListener("timer",__stopTalkTime);
                  }
                  _existChat.splice(_loc11_,1);
                  _existChat.unshift(_loc6_);
               }
               break;
            }
            _loc11_++;
         }
         if(_loc6_ == null)
         {
            _loc6_ = new PresentRecordInfo();
            _loc6_.id = _loc5_;
            _loc6_.addMessage(_loc4_,_loc10_,_loc2_);
            _existChat.unshift(_loc6_);
         }
         saveInShared(_loc6_);
         getMessage();
         saveRecentContactsID(_loc6_.id);
         if(_privateFrame != null && _privateFrame.parent && _privateFrame.playerInfo.ID == _loc5_)
         {
            _loc7_ = 0;
            while(_loc7_ < _existChat.length)
            {
               if(_existChat[_loc7_].id == _loc5_)
               {
                  _privateFrame.addMessage(_existChat[_loc7_].lastMessage);
                  _existChat[_loc7_].exist = 0;
                  break;
               }
               _loc7_++;
            }
         }
         else
         {
            setExist(_loc5_,2);
            changeID = _loc5_;
            cancelflashState = false;
            dispatchEvent(new Event("hasNewMessage"));
         }
         if(PlayerManager.Instance.Self.playerState.AutoReply != "" && _loc4_ != PlayerManager.Instance.Self.NickName && !_loc9_)
         {
            _loc3_ = PlayerManager.Instance.findPlayer(_loc5_) as PlayerInfo;
            if(_loc3_ && _loc3_.playerState.StateID == 1)
            {
               SocketManager.Instance.out.sendOneOnOneTalk(_loc5_,FilterWordManager.filterWrod(PlayerManager.Instance.Self.playerState.AutoReply),true);
            }
         }
      }
      
      private function __stopTalkTime(param1:TimerEvent) : void
      {
         _talkTimer.stop();
         _talkTimer.removeEventListener("timer",__stopTalkTime);
      }
      
      public function setExist(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param3)
         {
            _loc5_ = 0;
            while(_loc5_ < _existChat.length)
            {
               if(_existChat[_loc5_].teamId == param1)
               {
                  _existChat[_loc5_].exist = param2;
                  break;
               }
               _loc5_++;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < _existChat.length)
            {
               if(_existChat[_loc4_].id == param1)
               {
                  _existChat[_loc4_].exist = param2;
                  break;
               }
               _loc4_++;
            }
         }
      }
      
      private function TeamSaveShared(param1:PresentRecordInfo) : void
      {
         var _loc2_:* = undefined;
         if(SharedManager.Instance.teamChatRecord[param1.teamId] == null)
         {
            SharedManager.Instance.teamChatRecord[param1.teamId] = param1.recordMessage;
         }
         else
         {
            _loc2_ = SharedManager.Instance.teamChatRecord[param1.teamId];
            if(_loc2_ != param1.recordMessage)
            {
               _loc2_.push(param1.lastRecordMessage);
            }
            SharedManager.Instance.teamChatRecord[param1.teamId] = _loc2_;
         }
         SharedManager.Instance.save();
      }
      
      private function saveInShared(param1:PresentRecordInfo) : void
      {
         var _loc2_:* = undefined;
         if(SharedManager.Instance.privateChatRecord[param1.id] == null)
         {
            SharedManager.Instance.privateChatRecord[param1.id] = param1.recordMessage;
         }
         else
         {
            _loc2_ = SharedManager.Instance.privateChatRecord[param1.id];
            if(_loc2_ != param1.recordMessage)
            {
               _loc2_.push(param1.lastRecordMessage);
            }
            SharedManager.Instance.privateChatRecord[param1.id] = _loc2_;
         }
         SharedManager.Instance.save();
      }
      
      private function __teamTalkHandler(param1:PkgEvent) : void
      {
         var _loc4_:* = null;
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.pkg;
         var _loc8_:int = _loc6_.readInt();
         var _loc3_:String = _loc6_.readUTF();
         var _loc7_:Date = _loc6_.readDate();
         var _loc2_:String = _loc6_.readUTF();
         _loc9_ = 0;
         while(_loc9_ < _existChat.length)
         {
            if(_existChat[_loc9_].teamId == _loc8_)
            {
               _loc4_ = _existChat[_loc9_];
               _loc4_.addMessage(_loc3_,_loc7_,_loc2_);
               if(_loc3_ != PlayerManager.Instance.Self.NickName)
               {
                  _existChat.splice(_loc9_,1);
                  _existChat.unshift(_loc4_);
               }
               break;
            }
            _loc9_++;
         }
         if(_loc4_ == null)
         {
            _loc4_ = new PresentRecordInfo();
            _loc4_.teamId = _loc8_;
            _loc4_.addMessage(_loc3_,_loc7_,_loc2_);
            _existChat.unshift(_loc4_);
         }
         TeamSaveShared(_loc4_);
         getMessage();
         if(_teamChatFrame != null && _teamChatFrame.parent)
         {
            _loc5_ = 0;
            while(_loc5_ < _existChat.length)
            {
               if(_existChat[_loc5_].teamId == _loc8_)
               {
                  _teamChatFrame.addMessage(_existChat[_loc5_].lastMessage);
                  _existChat[_loc5_].exist = 0;
                  break;
               }
               _loc5_++;
            }
         }
         else
         {
            setExist(_loc8_,2,true);
            changeID = _loc8_;
            cancelflashState = false;
            dispatchEvent(new Event("hasNewMessage"));
         }
      }
      
      public function alertTeamChatFrame(param1:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = undefined;
         var _loc2_:* = null;
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
         if(param1 != 0)
         {
            _lastTeamId = param1;
         }
         else
         {
            _lastTeamId = _existChat[0].id;
         }
         _loc4_ = 0;
         while(_loc4_ < _existChat.length)
         {
            if(_existChat[_loc4_].teamId == param1)
            {
               _existChat[_loc4_].exist = 0;
               _loc3_ = _existChat[_loc4_].messages;
               _teamChatFrame.addAllMessage(_loc3_);
               _loc2_ = _existChat[_loc4_];
               dispatchEvent(new Event("alertMessage"));
               _existChat.splice(_loc4_,1);
               _existChat.push(_loc2_);
               break;
            }
            _loc4_++;
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
      
      public function alertPrivateFrame(param1:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = undefined;
         var _loc2_:* = null;
         if(_privateFrame == null)
         {
            _privateFrame = ComponentFactory.Instance.creatComponentByStylename("privateChatFrame");
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(27))
         {
            return;
         }
         if(param1 == 0 && (_existChat.length == 0 || _existChat.length == 1 && _privateFrame.parent))
         {
            return;
         }
         if(param1 != 0 && _lastId == param1)
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
         if(param1 != 0)
         {
            _changeInfo = PlayerManager.Instance.findPlayer(param1);
            _lastId = param1;
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
         _loc4_ = 0;
         while(_loc4_ < _existChat.length)
         {
            if(_existChat[_loc4_].id == _lastId)
            {
               _existChat[_loc4_].exist = 0;
               _loc3_ = _existChat[_loc4_].messages;
               _privateFrame.addAllMessage(_loc3_);
               _loc2_ = _existChat[_loc4_];
               changeID = _existChat[_loc4_].id;
               dispatchEvent(new Event("alertMessage"));
               _existChat.splice(_loc4_,1);
               _existChat.push(_loc2_);
               break;
            }
            _loc4_++;
         }
         if(!hasUnreadMessage())
         {
            dispatchEvent(new Event("nomessage"));
         }
         getMessage();
         saveRecentContactsID(param1);
         LayerManager.Instance.addToLayer(_privateFrame,2,true);
      }
      
      public function cancelFlash() : void
      {
         cancelflashState = true;
         dispatchEvent(new Event("nomessage"));
      }
      
      public function hasUnreadMessage() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _existChat.length)
         {
            if(_existChat[_loc1_].exist == 2)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function __IDChange(param1:PlayerPropertyEvent) : void
      {
         _changeInfo.removeEventListener("propertychange",__IDChange);
         _privateFrame.playerInfo = _changeInfo;
      }
      
      public function hidePrivateFrame(param1:int) : void
      {
         var _loc2_:int = 0;
         StageReferance.stage.focus = StageReferance.stage;
         _loc2_ = 0;
         while(_loc2_ < _existChat.length)
         {
            if(param1 != _existChat[_loc2_].id)
            {
               if(_loc2_ == _existChat.length - 1)
               {
                  createPresentRecordInfo(param1);
               }
               _loc2_++;
               continue;
            }
            break;
         }
         if(_existChat.length == 0)
         {
            createPresentRecordInfo(param1);
         }
         _lastId = 0;
         if(_privateFrame.parent)
         {
            _privateFrame.parent.removeChild(_privateFrame);
         }
         setExist(param1,1);
      }
      
      public function hideTeamChatFrame(param1:int) : void
      {
         var _loc2_:int = 0;
         StageReferance.stage.focus = StageReferance.stage;
         _loc2_ = 0;
         while(_loc2_ < _existChat.length)
         {
            if(param1 != _existChat[_loc2_].teamId)
            {
               if(_loc2_ == _existChat.length - 1)
               {
                  createPresentRecordInfo(param1,true);
               }
               _loc2_++;
               continue;
            }
            break;
         }
         if(_existChat.length == 0)
         {
            createPresentRecordInfo(param1,true);
         }
         _lastId = 0;
         if(_teamChatFrame.parent)
         {
            _teamChatFrame.parent.removeChild(_teamChatFrame);
         }
         setExist(param1,1,true);
      }
      
      private function createPresentRecordInfo(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:* = null;
         _loc3_ = new PresentRecordInfo();
         if(param2)
         {
            _loc3_.teamId = param1;
         }
         else
         {
            _loc3_.id = param1;
         }
         _loc3_.exist = 1;
         _existChat.push(_loc3_);
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
      
      public function disposePrivateFrame(param1:int) : void
      {
         StageReferance.stage.focus = StageReferance.stage;
         _lastId = 0;
         if(_privateFrame.parent)
         {
            _privateFrame.parent.removeChild(_privateFrame);
         }
         removePrivateMessage(param1);
      }
      
      public function removeTeamMessage(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _existChat.length)
         {
            if(_existChat[_loc2_].teamId == param1)
            {
               _existChat.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      public function removePrivateMessage(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _existChat.length)
         {
            if(_existChat[_loc2_].id == param1)
            {
               changeID = param1;
               dispatchEvent(new Event("alertMessage"));
               _existChat.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
         if(!hasUnreadMessage())
         {
            dispatchEvent(new Event("nomessage"));
         }
      }
      
      public function showMessageBox(param1:DisplayObject) : void
      {
         var _loc2_:* = null;
         if(_messageBox == null)
         {
            _messageBox = new MessageBox();
            _timer = new Timer(200);
            _timer.addEventListener("timer",__timerHandler);
         }
         if(getMessage().length > 0)
         {
            LayerManager.Instance.addToLayer(_messageBox,2);
            _loc2_ = param1.localToGlobal(new Point(0,0));
            _messageBox.y = _loc2_.y - _messageBox.height;
            _messageBox.x = _loc2_.x - _messageBox.width / 2 + param1.width / 2;
            if(_messageBox.x + _messageBox.width > StageReferance.stageWidth)
            {
               _messageBox.x = StageReferance.stageWidth - _messageBox.width - 10;
            }
         }
         _timer.stop();
      }
      
      public function getMessage() : Vector.<PresentRecordInfo>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<PresentRecordInfo> = new Vector.<PresentRecordInfo>();
         if(_messageBox)
         {
            _loc2_ = 0;
            while(_loc2_ < _existChat.length)
            {
               if(_existChat[_loc2_].exist != 0)
               {
                  _loc1_.push(_existChat[_loc2_]);
               }
               if(_loc1_.length != 10)
               {
                  _loc2_++;
                  continue;
               }
               break;
            }
            _messageBox.message = _loc1_;
         }
         return _loc1_;
      }
      
      protected function __timerHandler(param1:TimerEvent) : void
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
      
      private function __friendResponse(param1:PkgEvent) : void
      {
         var _loc6_:* = null;
         var _loc2_:int = param1.pkg.clientId;
         var _loc3_:int = param1.pkg.readInt();
         var _loc5_:String = param1.pkg.readUTF();
         var _loc4_:Boolean = param1.pkg.readBoolean();
         if(_loc4_)
         {
            _loc6_ = LanguageMgr.GetTranslation("tank.view.im.IMController.sameCityfriend");
            _loc6_ = _loc6_.replace(/r/g,"[" + _loc5_ + "]");
         }
         else
         {
            _loc6_ = "[" + _loc5_ + "]" + LanguageMgr.GetTranslation("tank.view.im.IMController.friend");
         }
         ChatManager.Instance.sysChatYellow(_loc6_);
      }
      
      private function __receiveInvite(param1:PkgEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
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
            _loc2_ = param1.pkg;
            _loc3_ = new InviteInfo();
            _loc3_.playerid = _loc2_.readInt();
            _loc3_.roomid = _loc2_.readInt();
            _loc3_.mapid = _loc2_.readInt();
            _loc3_.secondType = _loc2_.readByte();
            _loc3_.gameMode = _loc2_.readByte();
            _loc3_.hardLevel = _loc2_.readByte();
            _loc3_.levelLimits = _loc2_.readByte();
            _loc3_.nickname = _loc2_.readUTF();
            _loc3_.isAttest = _loc2_.readBoolean();
            _loc3_.typeVIP = _loc2_.readByte();
            _loc3_.VIPLevel = _loc2_.readInt();
            _loc3_.RN = _loc2_.readUTF();
            _loc3_.password = _loc2_.readUTF();
            _loc3_.barrierNum = _loc2_.readInt();
            _loc3_.isOpenBoss = _loc2_.readBoolean();
            _loc3_.power = _loc2_.readInt();
            _loc3_.level = _loc2_.readInt();
            _loc3_.isOld = _loc2_.readBoolean();
            if(_loc3_.gameMode > 2 && PlayerManager.Instance.Self.Grade < GameManager.MinLevelDuplicate)
            {
               return;
            }
            if(WonderfulActivityManager.Instance.frameFlag || BuriedManager.Instance.isOpening)
            {
               return;
            }
            startReceiveInvite(_loc3_);
         }
      }
      
      private function startReceiveInvite(param1:InviteInfo) : void
      {
         if(_prohibitInviteList[param1.nickname])
         {
            return;
         }
         SoundManager.instance.play("018");
         var _loc2_:InteractiveObject = StageReferance.stage.focus;
         InviteManager.Instance.showResponseInviteFrame(param1);
         if(_loc2_ is TextField)
         {
            if(TextField(_loc2_).type == "input")
            {
               StageReferance.stage.focus = _loc2_;
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
               addr27:
               return true;
            }
            addr26:
            §§goto(addr27);
         }
         §§goto(addr26);
      }
      
      public function addFriend(param1:String) : void
      {
         if(isMaxFriend())
         {
            return;
         }
         _name = param1;
         if(!checkFriendExist(_name))
         {
            alertGroupFrame(_name);
         }
      }
      
      public function isMaxFriend() : Boolean
      {
         var _loc1_:int = 0;
         if(PlayerManager.Instance.Self.IsVIP)
         {
            _loc1_ = PlayerManager.Instance.Self.VIPLevel + 2;
         }
         if(PlayerManager.Instance.friendList.length >= 200 + _loc1_ * 50)
         {
            _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.im.IMController.addFriend",200 + _loc1_ * 50),"","",false,false,false,2);
            _baseAlerFrame.addEventListener("response",__close);
            return true;
         }
         return false;
      }
      
      private function alertGroupFrame(param1:String) : void
      {
         if(_groupFrame == null)
         {
            _groupFrame = ComponentFactory.Instance.creatComponentByStylename("friendGroupFrame");
            _groupFrame.nickName = param1;
         }
         LayerManager.Instance.addToLayer(_groupFrame,1,true,1);
         _tempLock = ChatManager.Instance.lock;
         StageReferance.stage.focus = _groupFrame;
      }
      
      public function clearGroupFrame() : void
      {
         _groupFrame = null;
      }
      
      private function __close(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__close);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
      }
      
      public function addBlackList(param1:String) : void
      {
         if(PlayerManager.Instance.blackList.length >= 100)
         {
            _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.im.IMController.addBlackList"),"","",false,false,false,2);
            _baseAlerFrame.addEventListener("response",__closeII);
            return;
         }
         _name = param1;
         if(!checkBlackListExit(param1))
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
      
      private function __closeII(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__closeII);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
      }
      
      private function __frameEvent(param1:FrameEvent) : void
      {
         if(StateManager.currentStateType == "main")
         {
            ChatManager.Instance.lock = _tempLock;
         }
         switch(int(param1.responseCode))
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
      
      private function __frameEventII(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(StateManager.currentStateType == "main")
         {
            ChatManager.Instance.lock = _tempLock;
         }
         switch(int(param1.responseCode))
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
      
      private function checkBlackListExit(param1:String) : Boolean
      {
         if(param1 == PlayerManager.Instance.Self.NickName)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.im.IMController.cannot"));
            return true;
         }
         var _loc2_:DictionaryData = PlayerManager.Instance.blackList;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.NickName == param1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.im.IMController.thisplayer"));
               return true;
            }
         }
         return false;
      }
      
      private function checkFriendExist(param1:String) : Boolean
      {
         if(!param1)
         {
            return true;
         }
         if(param1.toLowerCase() == PlayerManager.Instance.Self.NickName.toLowerCase())
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.im.IMController.cannotAddSelfFriend"));
            return true;
         }
         var _loc2_:DictionaryData = PlayerManager.Instance.friendList;
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(var _loc5_ in _loc2_)
         {
            if(_loc5_.NickName == param1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.im.IMController.chongfu"));
               return true;
            }
         }
         var _loc3_:DictionaryData = PlayerManager.Instance.blackList;
         var _loc9_:int = 0;
         var _loc8_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_.NickName == param1)
            {
               _name = param1;
               _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.im.IMController.thisone"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               _baseAlerFrame.addEventListener("response",__frameEventII);
               return true;
            }
         }
         return false;
      }
      
      public function deleteFriend(param1:int, param2:Boolean = false) : void
      {
         _id = param1;
         disposeAlert();
         if(!param2)
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
      
      public function deleteGroup(param1:int, param2:String) : void
      {
         _groupId = param1;
         _groupName = param2;
         disposeAlert();
         _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.im.IMGourp.sure",param2),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
         _baseAlerFrame.addEventListener("response",__deleteGroupEvent);
      }
      
      private function __deleteGroupEvent(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
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
      
      private function __frameEventIII(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
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
      
      public function deleteRecentContacts(param1:int = 0) : void
      {
         if(!_recentContactsList)
         {
            return;
         }
         _deleteRecentContact = param1;
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__deleteRecentContact);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
         _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("im.IMController.deleteRecentContactsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
         _baseAlerFrame.addEventListener("response",__deleteRecentContact);
      }
      
      private function __deleteRecentContact(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
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
      
      public function isFriend(param1:String) : Boolean
      {
         var _loc2_:DictionaryData = PlayerManager.Instance.friendList;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.NickName == param1)
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
      
      public function girlHeadSelectedBtnClicked(param1:Boolean) : void
      {
         GameInSocketOut.sendUseGirlPhoto(param1);
         PlayerManager.Instance.Self.IsShow = param1;
         PlayerManager.Instance.dispatchEvent(new CEvent("girl_head_photo_change",param1));
      }
      
      public function createConsortiaLoader() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(!StringHelper.isNullOrEmpty(PathManager.CommunityFriendList()))
         {
            _loc2_ = RequestVairableCreater.creatWidthKey(true);
            _loc2_["uid"] = PlayerManager.Instance.Account.Account;
            _loc1_ = LoadResourceManager.Instance.createLoader(PathManager.CommunityFriendList(),6,_loc2_,"GET",null,true,true);
            _loc1_.analyzer = new LoadCMFriendList(setupCMFriendList);
            LoadResourceManager.Instance.startLoad(_loc1_);
         }
      }
      
      private function setupCMFriendList(param1:LoadCMFriendList) : void
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
         var _loc3_:DictionaryData = PlayerManager.Instance.CMFriendList;
         var _loc1_:DictionaryData = PlayerManager.Instance.friendList;
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            if(_loc2_.IsExist && !_loc1_[_loc2_.UserId])
            {
               SocketManager.Instance.out.sendAddFriend(_loc2_.NickName,0,true);
               _loc3_.remove(_loc2_.UserName);
            }
         }
      }
      
      public function loadRecentContacts() : void
      {
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc2_["id"] = PlayerManager.Instance.Self.ID;
         _loc2_["recentContacts"] = getFullRecentContactsID();
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("IMRecentContactsList.ashx"),6,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingBuddyListFailure");
         _loc1_.analyzer = new RecentContactsAnalyze(PlayerManager.Instance.setupRecentContacts);
         LoadResourceManager.Instance.startLoad(_loc1_);
         _isLoadRecentContacts = false;
      }
      
      public function get recentContactsList() : Array
      {
         return _recentContactsList;
      }
      
      private function getFullRecentContactsID() : String
      {
         var _loc1_:String = "";
         var _loc4_:int = 0;
         var _loc3_:* = _recentContactsList;
         for each(var _loc2_ in _recentContactsList)
         {
            if(_loc2_ != 0)
            {
               _loc1_ = _loc1_ + (String(_loc2_) + ",");
            }
         }
         _loc1_ = _loc1_.substr(0,_loc1_.length - 1);
         if(_loc1_ == "")
         {
            _loc1_ = "0";
         }
         return _loc1_;
      }
      
      public function saveRecentContactsID(param1:int = 0) : void
      {
         if(!_recentContactsList)
         {
            _recentContactsList = [];
         }
         if(param1 == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         if(_recentContactsList.length < 20)
         {
            if(testIdentical(param1) != -1)
            {
               _recentContactsList.splice(testIdentical(param1),1);
            }
            _recentContactsList.unshift(param1);
         }
         else
         {
            if(testIdentical(param1) != -1)
            {
               _recentContactsList.splice(testIdentical(param1),1);
            }
            else
            {
               _recentContactsList.splice(-1,1);
            }
            _recentContactsList.unshift(param1);
         }
         SharedManager.Instance.recentContactsID[PlayerManager.Instance.Self.ID] = _recentContactsList;
         SharedManager.Instance.save();
         _isLoadRecentContacts = true;
      }
      
      public function testIdentical(param1:int) : int
      {
         var _loc2_:int = 0;
         if(_recentContactsList)
         {
            _loc2_ = 0;
            while(_loc2_ < _recentContactsList.length)
            {
               if(_recentContactsList[_loc2_] == param1)
               {
                  return _loc2_;
               }
               _loc2_++;
            }
         }
         return -1;
      }
      
      public function sortAcademyPlayer(param1:Array) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:SelfInfo = PlayerManager.Instance.Self;
         if(_loc4_.getMasterOrApprentices().length <= 0)
         {
            return param1;
         }
         var _loc2_:DictionaryData = _loc4_.getMasterOrApprentices();
         if(_loc4_.getMasterOrApprentices().length > 0)
         {
            var _loc8_:int = 0;
            var _loc7_:* = param1;
            for each(var _loc6_ in param1)
            {
               if(_loc2_[_loc6_.ID] && _loc6_.ID != _loc4_.ID)
               {
                  if(_loc6_.ID == _loc4_.masterID)
                  {
                     _loc3_.unshift(_loc6_);
                  }
                  else
                  {
                     _loc3_.push(_loc6_);
                  }
               }
            }
            var _loc10_:int = 0;
            var _loc9_:* = _loc3_;
            for each(var _loc5_ in _loc3_)
            {
               param1.splice(param1.indexOf(_loc5_),1);
            }
         }
         param1 = _loc3_.concat(param1);
         return param1;
      }
      
      public function addTransregionalblackList(param1:String) : void
      {
         SharedManager.Instance.transregionalblackList[param1] = param1;
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
      
      public function set isLoadRecentContacts(param1:Boolean) : void
      {
         _isLoadRecentContacts = param1;
      }
   }
}
