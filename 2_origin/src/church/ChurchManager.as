package church
{
   import baglocked.BaglockedManager;
   import campbattle.CampBattleManager;
   import church.events.WeddingRoomEvent;
   import church.view.ChurchAlertFrame;
   import com.pickgliss.action.AlertAction;
   import com.pickgliss.action.FunctionAction;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.action.FrameShowAction;
   import ddt.data.ChurchRoomInfo;
   import ddt.data.ServerInfo;
   import ddt.data.player.BasePlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.ExternalInterfaceManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.view.UIModuleSmallLoading;
   import ddt.view.chat.ChatData;
   import ddt.view.common.church.ChurchDialogueAgreePropose;
   import ddt.view.common.church.ChurchDialogueRejectPropose;
   import ddt.view.common.church.ChurchDialogueUnmarried;
   import ddt.view.common.church.ChurchInviteFrame;
   import ddt.view.common.church.ChurchMarryApplySuccess;
   import ddt.view.common.church.ChurchProposeFrame;
   import ddt.view.common.church.ChurchProposeResponseFrame;
   import ddtBuried.BuriedManager;
   import email.MailManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import invite.InviteManager;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import road7th.utils.StringHelper;
   
   public class ChurchManager extends EventDispatcher
   {
      
      public static const GENERALSCENEINDEX:int = 1;
      
      public static const ADVANCEDSCENEINDEX:int = 2;
      
      public static const COSTLYSCENEINDEX:int = 3;
      
      private static const MOON_SCENE:Boolean = true;
      
      public static const CIVIL_PLAYER_INFO_MODIFY:String = "civilplayerinfomodify";
      
      public static const CIVIL_SELFINFO_CHANGE:String = "civilselfinfochange";
      
      public static const SUBMIT_REFUND:String = "submitRefund";
      
      private static var _instance:ChurchManager;
       
      
      private var _currentScene:int = 1;
      
      private var _churchDialogueUnmarried:ChurchDialogueUnmarried;
      
      private var _churchProposeFrame:ChurchProposeFrame;
      
      private var _proposeResposeFrame:ChurchProposeResponseFrame;
      
      private var _churchMarryApplySuccess:ChurchMarryApplySuccess;
      
      private var _alertMarried:BaseAlerFrame;
      
      public var _weddingSuccessfulComplete:Boolean;
      
      public var seniorType:int;
      
      public var lastScene:int = 1;
      
      private var _selfRoom:ChurchRoomInfo;
      
      private var _currentRoom:ChurchRoomInfo;
      
      private var _mapLoader01:BaseLoader;
      
      private var _mapLoader02:BaseLoader;
      
      private var _mapLoader00:BaseLoader;
      
      private var _isRemoveLoading:Boolean = true;
      
      private var _userID:int;
      
      public var isUnwedding:Boolean;
      
      private var money:int;
      
      private var marryApplyList:Array;
      
      private var _churchDialogueAgreePropose:ChurchDialogueAgreePropose;
      
      private var _churchDialogueRejectPropose:ChurchDialogueRejectPropose;
      
      private var unwedingmsg:String;
      
      private var _linkServerInfo:ServerInfo;
      
      public function ChurchManager()
      {
         marryApplyList = [];
         super();
      }
      
      public static function get instance() : ChurchManager
      {
         if(!_instance)
         {
            _instance = new ChurchManager();
         }
         return _instance;
      }
      
      public function get currentScene() : int
      {
         return _currentScene;
      }
      
      public function set currentScene(value:int) : void
      {
         if(_currentScene == value)
         {
            return;
         }
         _currentScene = value;
         dispatchEvent(new WeddingRoomEvent("scene change",_currentScene));
      }
      
      public function get selfRoom() : ChurchRoomInfo
      {
         return _selfRoom;
      }
      
      public function set selfRoom(value:ChurchRoomInfo) : void
      {
         _selfRoom = value;
      }
      
      public function set currentRoom(value:ChurchRoomInfo) : void
      {
         if(_currentRoom == value)
         {
            return;
         }
         _currentRoom = value;
         onChurchRoomInfoChange();
      }
      
      public function get currentRoom() : ChurchRoomInfo
      {
         return _currentRoom;
      }
      
      private function onChurchRoomInfoChange() : void
      {
         if(_currentRoom != null)
         {
            loadMap();
         }
      }
      
      public function loadMap() : void
      {
         _mapLoader00 = LoadResourceManager.Instance.createLoader(PathManager.solveChurchSceneSourcePath("Map00"),4);
         _mapLoader00.addEventListener("complete",onMapSrcLoadedComplete);
         LoadResourceManager.Instance.startLoad(_mapLoader00);
         _mapLoader01 = LoadResourceManager.Instance.createLoader(PathManager.solveChurchSceneSourcePath("Map01"),4);
         _mapLoader01.addEventListener("complete",onMapSrcLoadedComplete);
         LoadResourceManager.Instance.startLoad(_mapLoader01);
         _mapLoader02 = LoadResourceManager.Instance.createLoader(PathManager.solveChurchSceneSourcePath("Map02"),4);
         _mapLoader02.addEventListener("complete",onMapSrcLoadedComplete);
         LoadResourceManager.Instance.startLoad(_mapLoader02);
      }
      
      protected function onMapSrcLoadedComplete(event:LoaderEvent = null) : void
      {
         if(_mapLoader01.isSuccess && _mapLoader02.isSuccess)
         {
            tryLoginScene();
         }
      }
      
      public function tryLoginScene() : void
      {
         if(StateManager.getState("churchRoom") == null)
         {
            _isRemoveLoading = false;
            UIModuleSmallLoading.Instance.addEventListener("close",__loadingIsClose);
         }
         StateManager.setState("churchRoom");
      }
      
      private function __loadingIsClose(event:Event) : void
      {
         _isRemoveLoading = true;
         UIModuleSmallLoading.Instance.removeEventListener("close",__loadingIsClose);
         SocketManager.Instance.out.sendExitRoom();
      }
      
      public function removeLoadingEvent() : void
      {
         if(!_isRemoveLoading)
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__loadingIsClose);
         }
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(242),__roomLogin);
         SocketManager.Instance.addEventListener(PkgEvent.format(252),__updateSelfRoom);
         SocketManager.Instance.addEventListener(PkgEvent.format(244),__removePlayer);
         SocketManager.Instance.addEventListener(PkgEvent.format(246),__showPropose);
         SocketManager.Instance.addEventListener(PkgEvent.format(247),__marryApply);
         SocketManager.Instance.addEventListener(PkgEvent.format(250),__marryApplyReply);
         SocketManager.Instance.addEventListener(PkgEvent.format(248),__divorceApply);
         SocketManager.Instance.addEventListener(PkgEvent.format(249,4),__churchInvite);
         SocketManager.Instance.addEventListener(PkgEvent.format(234),__marryPropGet);
         SocketManager.Instance.addEventListener(PkgEvent.format(239),__upCivilPlayerView);
         SocketManager.Instance.addEventListener(PkgEvent.format(235),__getMarryInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(207),reqeustPayHander);
         this.addEventListener("submitRefund",__onSubmitRefund);
      }
      
      private function reqeustPayHander(e:PkgEvent) : void
      {
         var name:* = null;
         var cmd:int = e.pkg.readByte();
         if(cmd == 1)
         {
            isUnwedding = true;
            _userID = e.pkg.readInt();
            name = e.pkg.readUTF();
            money = e.pkg.readInt();
            unwedingmsg = LanguageMgr.GetTranslation("ddt.friendPay.action",name,money);
            if(!CampBattleManager.instance.isFighting)
            {
               openAlert();
            }
         }
      }
      
      public function openAlert() : void
      {
         isUnwedding = false;
         var confirmFrame:ChurchAlertFrame = ComponentFactory.Instance.creat("church.view.ChurchAlertFrame");
         confirmFrame.setTxt(unwedingmsg);
         LayerManager.Instance.addToLayer(confirmFrame,3,true,2);
         confirmFrame.addEventListener("response",reponseHander);
      }
      
      private function reponseHander(e:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(BuriedManager.Instance.checkMoney(false,money))
            {
               return;
            }
            SocketManager.Instance.out.isAcceptPay(true,_userID);
         }
         else if(e.responseCode == 1 || e.responseCode == 4 || e.responseCode == 0)
         {
            SocketManager.Instance.out.isAcceptPay(false,_userID);
         }
         var confirmFrame:ChurchAlertFrame = e.currentTarget as ChurchAlertFrame;
         confirmFrame.removeEventListener("response",reponseHander);
         confirmFrame.dispose();
         confirmFrame = null;
      }
      
      private function __onSubmitRefund(e:Event) : void
      {
         SocketManager.Instance.out.refund();
      }
      
      private function __upCivilPlayerView(e:PkgEvent) : void
      {
         PlayerManager.Instance.Self.MarryInfoID = e.pkg.readInt();
         var note:Boolean = e.pkg.readBoolean();
         if(note)
         {
            PlayerManager.Instance.Self.ID = e.pkg.readInt();
            PlayerManager.Instance.Self.IsPublishEquit = e.pkg.readBoolean();
            PlayerManager.Instance.Self.Introduction = e.pkg.readUTF();
         }
         dispatchEvent(new Event("civilplayerinfomodify"));
      }
      
      private function __getMarryInfo(e:PkgEvent) : void
      {
         PlayerManager.Instance.Self.Introduction = e.pkg.readUTF();
         PlayerManager.Instance.Self.IsPublishEquit = e.pkg.readBoolean();
         dispatchEvent(new Event("civilselfinfochange"));
      }
      
      public function __showPropose(event:PkgEvent) : void
      {
         var spouseID:int = event.pkg.readInt();
         var isMarried:Boolean = event.pkg.readBoolean();
         if(isMarried)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.married"));
         }
         else if(PlayerManager.Instance.Self.IsMarried)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.youMarried"));
         }
         else
         {
            _churchProposeFrame = ComponentFactory.Instance.creat("common.church.ChurchProposeFrame");
            _churchProposeFrame.addEventListener("close",churchProposeFrameClose);
            _churchProposeFrame.spouseID = spouseID;
            _churchProposeFrame.show();
         }
      }
      
      private function churchProposeFrameClose(evt:Event) : void
      {
         if(_churchProposeFrame)
         {
            _churchProposeFrame.removeEventListener("close",churchProposeFrameClose);
            if(_churchProposeFrame.parent)
            {
               _churchProposeFrame.parent.removeChild(_churchProposeFrame);
            }
         }
         _churchProposeFrame = null;
      }
      
      private function __marryApply(event:PkgEvent) : void
      {
         var spouseID:int = event.pkg.readInt();
         var spouseName:String = event.pkg.readUTF();
         var str:String = event.pkg.readUTF();
         var answerId:int = event.pkg.readInt();
         if(spouseID == PlayerManager.Instance.Self.ID)
         {
            _churchMarryApplySuccess = ComponentFactory.Instance.creat("common.church.ChurchMarryApplySuccess");
            _churchMarryApplySuccess.addEventListener("close",churchMarryApplySuccessClose);
            _churchMarryApplySuccess.show();
            return;
         }
         if(checkMarryApplyList(answerId))
         {
            return;
         }
         marryApplyList.push(answerId);
         SoundManager.instance.play("018");
         _proposeResposeFrame = ComponentFactory.Instance.creat("common.church.ChurchProposeResponseFrame");
         _proposeResposeFrame.addEventListener("close",ProposeResposeFrameClose);
         _proposeResposeFrame.spouseID = spouseID;
         _proposeResposeFrame.spouseName = spouseName;
         _proposeResposeFrame.answerId = answerId;
         _proposeResposeFrame.love = str;
         if(CacheSysManager.isLock("alertInFight"))
         {
            CacheSysManager.getInstance().cache("alertInFight",new AlertAction(_proposeResposeFrame,4,1));
         }
         else if(StateManager.currentStateType == "login")
         {
            CacheSysManager.getInstance().cacheFunction("alertInHall",new FunctionAction(_proposeResposeFrame.show));
         }
         else
         {
            _proposeResposeFrame.show();
         }
      }
      
      private function checkMarryApplyList(id:int) : Boolean
      {
         var i:int = 0;
         for(i = 0; i < marryApplyList.length; )
         {
            if(id == marryApplyList[i])
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function churchMarryApplySuccessClose(evt:Event) : void
      {
         if(_churchMarryApplySuccess)
         {
            _churchMarryApplySuccess.removeEventListener("close",churchMarryApplySuccessClose);
            if(_churchMarryApplySuccess.parent)
            {
               _churchMarryApplySuccess.parent.removeChild(_churchMarryApplySuccess);
            }
            _churchMarryApplySuccess.dispose();
         }
         _churchMarryApplySuccess = null;
      }
      
      private function ProposeResposeFrameClose(evt:Event) : void
      {
         if(_proposeResposeFrame)
         {
            _proposeResposeFrame.removeEventListener("close",ProposeResposeFrameClose);
            if(_proposeResposeFrame.parent)
            {
               _proposeResposeFrame.parent.removeChild(_proposeResposeFrame);
            }
            _proposeResposeFrame.dispose();
         }
         _proposeResposeFrame = null;
      }
      
      private function __marryApplyReply(event:PkgEvent) : void
      {
         var msg:* = null;
         var msgTxt:* = null;
         var spouseID:int = event.pkg.readInt();
         var result:Boolean = event.pkg.readBoolean();
         var spouseName:String = event.pkg.readUTF();
         var isApplicant:Boolean = event.pkg.readBoolean();
         if(result)
         {
            PlayerManager.Instance.Self.IsMarried = true;
            PlayerManager.Instance.Self.SpouseID = spouseID;
            PlayerManager.Instance.Self.SpouseName = spouseName;
            TaskManager.instance.onMarriaged();
            TaskManager.instance.requestCanAcceptTask();
            if(PathManager.solveExternalInterfaceEnabel())
            {
               ExternalInterfaceManager.sendToAgent(7,PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName,ServerManager.Instance.zoneName,-1,"",spouseName);
            }
         }
         if(isApplicant)
         {
            msg = new ChatData();
            msgTxt = "";
            if(result)
            {
               msg.channel = 6;
               msgTxt = "<" + spouseName + ">" + LanguageMgr.GetTranslation("tank.manager.PlayerManager.isApplicant");
               _churchDialogueAgreePropose = ComponentFactory.Instance.creat("common.church.ChurchDialogueAgreePropose");
               _churchDialogueAgreePropose.msgInfo = spouseName;
               _churchDialogueAgreePropose.addEventListener("close",churchDialogueAgreeProposeClose);
               if(CacheSysManager.isLock("alertInFight"))
               {
                  CacheSysManager.getInstance().cache("alertInFight",new FrameShowAction(_churchDialogueAgreePropose));
               }
               else
               {
                  _churchDialogueAgreePropose.show();
               }
            }
            else
            {
               msg.channel = 7;
               msgTxt = "<" + spouseName + ">" + LanguageMgr.GetTranslation("tank.manager.PlayerManager.refuseMarry");
               if(_churchDialogueRejectPropose)
               {
                  _churchDialogueRejectPropose.dispose();
                  _churchDialogueRejectPropose = null;
               }
               _churchDialogueRejectPropose = ComponentFactory.Instance.creat("common.church.ChurchDialogueRejectPropose");
               _churchDialogueRejectPropose.msgInfo = spouseName;
               _churchDialogueRejectPropose.addEventListener("close",churchDialogueRejectProposeClose);
               if(CacheSysManager.isLock("alertInFight"))
               {
                  CacheSysManager.getInstance().cache("alertInFight",new AlertAction(_churchDialogueRejectPropose,3,1,"018",true));
               }
               else
               {
                  _churchDialogueRejectPropose.show();
               }
            }
            msg.msg = StringHelper.rePlaceHtmlTextField(msgTxt);
            ChatManager.Instance.chat(msg);
         }
         else if(result)
         {
            _alertMarried = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.tip"),LanguageMgr.GetTranslation("tank.manager.PlayerManager.youAndOtherMarried",spouseName),LanguageMgr.GetTranslation("ok"),"",false,false,false,0,"alertInFight");
            _alertMarried.addEventListener("response",marriedResponse);
         }
      }
      
      private function marriedResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               if(_alertMarried)
               {
                  if(_alertMarried.parent)
                  {
                     _alertMarried.parent.removeChild(_alertMarried);
                  }
                  _alertMarried.dispose();
               }
               _alertMarried = null;
            default:
            case 3:
            case 4:
               if(_alertMarried)
               {
                  if(_alertMarried.parent)
                  {
                     _alertMarried.parent.removeChild(_alertMarried);
                  }
                  _alertMarried.dispose();
               }
               _alertMarried = null;
         }
         ObjectUtils.disposeObject(evt.target);
      }
      
      private function churchDialogueRejectProposeClose(evt:Event) : void
      {
         if(_churchDialogueRejectPropose)
         {
            _churchDialogueRejectPropose.removeEventListener("close",churchDialogueRejectProposeClose);
            if(_churchDialogueRejectPropose.parent)
            {
               _churchDialogueRejectPropose.parent.removeChild(_churchDialogueRejectPropose);
            }
            _churchDialogueRejectPropose.dispose();
         }
         _churchDialogueRejectPropose = null;
      }
      
      private function churchDialogueAgreeProposeClose(evt:Event) : void
      {
         if(_churchDialogueAgreePropose)
         {
            _churchDialogueAgreePropose.removeEventListener("close",churchDialogueAgreeProposeClose);
            if(_churchDialogueAgreePropose.parent)
            {
               _churchDialogueAgreePropose.parent.removeChild(_churchDialogueAgreePropose);
            }
            _churchDialogueAgreePropose.dispose();
         }
         _churchDialogueAgreePropose = null;
      }
      
      private function __divorceApply(event:PkgEvent) : void
      {
         var result:Boolean = event.pkg.readBoolean();
         var isActive:Boolean = event.pkg.readBoolean();
         if(!result)
         {
            return;
         }
         PlayerManager.Instance.Self.IsMarried = false;
         PlayerManager.Instance.Self.SpouseID = 0;
         PlayerManager.Instance.Self.SpouseName = "";
         ChurchManager.instance.selfRoom = null;
         if(!isActive)
         {
            SoundManager.instance.play("018");
            _churchDialogueUnmarried = ComponentFactory.Instance.creat("ddt.common.church.ChurchDialogueUnmarried");
            if(CacheSysManager.isLock("alertInFight"))
            {
               CacheSysManager.getInstance().cache("alertInFight",new AlertAction(_churchDialogueUnmarried,3,1));
            }
            else
            {
               _churchDialogueUnmarried.show();
            }
            _churchDialogueUnmarried.addEventListener("close",churchDialogueUnmarriedClose);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.divorce"));
         }
         if(StateManager.currentStateType == "churchRoom" && (currentRoom.brideID == PlayerManager.Instance.Self.ID || currentRoom.createID == PlayerManager.Instance.Self.ID))
         {
            StateManager.setState("ddtchurchroomlist");
         }
      }
      
      private function churchDialogueUnmarriedClose(evt:Event) : void
      {
         SoundManager.instance.play("008");
         if(_churchDialogueUnmarried)
         {
            _churchDialogueUnmarried.removeEventListener("close",churchDialogueUnmarriedClose);
            if(_churchDialogueUnmarried.parent)
            {
               _churchDialogueUnmarried.parent.removeChild(_churchDialogueUnmarried);
            }
            _churchDialogueUnmarried.dispose();
         }
         _churchDialogueUnmarried = null;
      }
      
      private function __churchInvite(event:PkgEvent) : void
      {
         var pkg:* = null;
         var obj:* = null;
         var invitePanel:* = null;
         if(InviteManager.Instance.enabled)
         {
            pkg = event.pkg;
            obj = {};
            obj["inviteID"] = pkg.readInt();
            obj["inviteName"] = pkg.readUTF();
            obj["IsVip"] = pkg.readBoolean();
            obj["VIPLevel"] = pkg.readInt();
            obj["roomID"] = pkg.readInt();
            obj["roomName"] = pkg.readUTF();
            obj["pwd"] = pkg.readUTF();
            obj["sceneIndex"] = pkg.readInt();
            if(BuriedManager.Instance.isOpening)
            {
               return;
            }
            invitePanel = ComponentFactory.Instance.creatComponentByStylename("common.church.ChurchInviteFrame");
            invitePanel.msgInfo = obj;
            invitePanel.show();
            SoundManager.instance.play("018");
         }
      }
      
      private function __marryPropGet(event:PkgEvent) : void
      {
         var roomInfo:* = null;
         var pkg:PackageIn = event.pkg;
         PlayerManager.Instance.Self.IsMarried = pkg.readBoolean();
         PlayerManager.Instance.Self.SpouseID = pkg.readInt();
         PlayerManager.Instance.Self.SpouseName = pkg.readUTF();
         var isCreatedMarryRoom:Boolean = pkg.readBoolean();
         var roomID:int = pkg.readInt();
         var isGotRing:Boolean = pkg.readBoolean();
         if(isCreatedMarryRoom)
         {
            if(!ChurchManager.instance.selfRoom)
            {
               roomInfo = new ChurchRoomInfo();
               roomInfo.id = roomID;
               ChurchManager.instance.selfRoom = roomInfo;
            }
         }
         else
         {
            ChurchManager.instance.selfRoom = null;
         }
      }
      
      private function __roomLogin(event:PkgEvent) : void
      {
         var failType:int = 0;
         var roomId:int = 0;
         var msg:* = null;
         var _tipsMarryRoomframe:* = null;
         var pkg:PackageIn = event.pkg;
         var result:Boolean = pkg.readBoolean();
         if(!result)
         {
            failType = pkg.readInt();
            if(MailManager.Instance.linkChurchRoomId != -1 && (failType == 5 || failType == 6))
            {
               StateManager.setState("ddtchurchroomlist");
               MailManager.Instance.hide();
            }
            else if(failType == 7)
            {
               roomId = pkg.readInt();
               _linkServerInfo = ServerManager.Instance.getServerInfoByID(roomId);
               if(_linkServerInfo)
               {
                  msg = LanguageMgr.GetTranslation("ddt.church.serverInFail",_linkServerInfo.Name,MailManager.Instance.linkChurchRoomId);
                  _tipsMarryRoomframe = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),msg,"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
                  _tipsMarryRoomframe.addEventListener("response",__tipsMarryRoomframeResponse);
               }
               else
               {
                  MailManager.Instance.linkChurchRoomId = -1;
               }
            }
            else
            {
               MailManager.Instance.linkChurchRoomId = -1;
            }
            return;
         }
         var roomInfo:ChurchRoomInfo = new ChurchRoomInfo();
         roomInfo.id = pkg.readInt();
         roomInfo.roomName = pkg.readUTF();
         roomInfo.mapID = pkg.readInt();
         roomInfo.valideTimes = pkg.readInt();
         roomInfo.currentNum = pkg.readInt();
         roomInfo.createID = pkg.readInt();
         roomInfo.createName = pkg.readUTF();
         roomInfo.groomID = pkg.readInt();
         roomInfo.groomName = pkg.readUTF();
         roomInfo.brideID = pkg.readInt();
         roomInfo.brideName = pkg.readUTF();
         roomInfo.creactTime = pkg.readDate();
         roomInfo.isStarted = pkg.readBoolean();
         var statu:int = pkg.readByte();
         if(statu == 1)
         {
            roomInfo.status = "wedding_none";
         }
         else
         {
            roomInfo.status = "wedding_ing";
         }
         roomInfo.discription = pkg.readUTF();
         roomInfo.canInvite = pkg.readBoolean();
         var sceneIndex:int = pkg.readInt();
         ChurchManager.instance.currentScene = sceneIndex;
         roomInfo.isUsedSalute = pkg.readBoolean();
         seniorType = pkg.readInt();
         roomInfo.seniorType = seniorType;
         currentRoom = roomInfo;
         if(isAdmin(PlayerManager.Instance.Self))
         {
            selfRoom = roomInfo;
         }
      }
      
      private function __tipsMarryRoomframeResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            ServerManager.Instance.current = _linkServerInfo;
            ServerManager.Instance.connentCurrentServer();
            ServerManager.Instance.dispatchEvent(new Event("changeServer"));
         }
         else
         {
            MailManager.Instance.linkChurchRoomId = -1;
         }
         _linkServerInfo = null;
         var _tipsframe:Frame = Frame(evt.currentTarget);
         _tipsframe.removeEventListener("response",__tipsMarryRoomframeResponse);
         ObjectUtils.disposeAllChildren(_tipsframe);
         ObjectUtils.disposeObject(_tipsframe);
         _tipsframe = null;
      }
      
      private function __updateSelfRoom(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var userID:int = pkg.readInt();
         var state:Boolean = pkg.readBoolean();
         if(!state)
         {
            selfRoom = null;
            return;
         }
         if(selfRoom == null)
         {
            selfRoom = new ChurchRoomInfo();
         }
         selfRoom.id = pkg.readInt();
         selfRoom.roomName = pkg.readUTF();
         selfRoom.mapID = pkg.readInt();
         selfRoom.valideTimes = pkg.readInt();
         selfRoom.createID = pkg.readInt();
         selfRoom.groomID = pkg.readInt();
         selfRoom.brideID = pkg.readInt();
         selfRoom.creactTime = pkg.readDate();
         selfRoom.isUsedSalute = pkg.readBoolean();
         selfRoom.seniorType = pkg.readInt();
      }
      
      public function __removePlayer(event:PkgEvent) : void
      {
         var id:int = event.pkg.clientId;
         if(id == PlayerManager.Instance.Self.ID)
         {
            StateManager.setState("ddtchurchroomlist");
         }
      }
      
      public function isAdmin(info:PlayerInfo) : Boolean
      {
         if(_currentRoom && info)
         {
            return info.ID == _currentRoom.groomID || info.ID == _currentRoom.brideID;
         }
         return false;
      }
      
      public function sendValidateMarry(info:BasePlayer) : void
      {
         if(PlayerManager.Instance.Self.Grade < 14)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.notLvWoo",14));
         }
         else if(info.Grade < 14)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.notOtherLvWoo",14));
         }
         else if(PlayerManager.Instance.Self.IsMarried)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.IsMarried"));
         }
         else if(PlayerManager.Instance.Self.Sex == info.Sex)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.notAllow"));
         }
         else if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
         }
         else
         {
            SocketManager.Instance.out.sendValidateMarry(info.ID);
         }
      }
   }
}
