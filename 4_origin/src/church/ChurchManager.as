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
      
      public function set currentScene(param1:int) : void
      {
         if(_currentScene == param1)
         {
            return;
         }
         _currentScene = param1;
         dispatchEvent(new WeddingRoomEvent("scene change",_currentScene));
      }
      
      public function get selfRoom() : ChurchRoomInfo
      {
         return _selfRoom;
      }
      
      public function set selfRoom(param1:ChurchRoomInfo) : void
      {
         _selfRoom = param1;
      }
      
      public function set currentRoom(param1:ChurchRoomInfo) : void
      {
         if(_currentRoom == param1)
         {
            return;
         }
         _currentRoom = param1;
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
      
      protected function onMapSrcLoadedComplete(param1:LoaderEvent = null) : void
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
      
      private function __loadingIsClose(param1:Event) : void
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
      
      private function reqeustPayHander(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = param1.pkg.readByte();
         if(_loc2_ == 1)
         {
            isUnwedding = true;
            _userID = param1.pkg.readInt();
            _loc3_ = param1.pkg.readUTF();
            money = param1.pkg.readInt();
            unwedingmsg = LanguageMgr.GetTranslation("ddt.friendPay.action",_loc3_,money);
            if(!CampBattleManager.instance.isFighting)
            {
               openAlert();
            }
         }
      }
      
      public function openAlert() : void
      {
         isUnwedding = false;
         var _loc1_:ChurchAlertFrame = ComponentFactory.Instance.creat("church.view.ChurchAlertFrame");
         _loc1_.setTxt(unwedingmsg);
         LayerManager.Instance.addToLayer(_loc1_,3,true,2);
         _loc1_.addEventListener("response",reponseHander);
      }
      
      private function reponseHander(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(param1.responseCode == 2 || param1.responseCode == 3)
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
         else if(param1.responseCode == 1 || param1.responseCode == 4 || param1.responseCode == 0)
         {
            SocketManager.Instance.out.isAcceptPay(false,_userID);
         }
         var _loc2_:ChurchAlertFrame = param1.currentTarget as ChurchAlertFrame;
         _loc2_.removeEventListener("response",reponseHander);
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      private function __onSubmitRefund(param1:Event) : void
      {
         SocketManager.Instance.out.refund();
      }
      
      private function __upCivilPlayerView(param1:PkgEvent) : void
      {
         PlayerManager.Instance.Self.MarryInfoID = param1.pkg.readInt();
         var _loc2_:Boolean = param1.pkg.readBoolean();
         if(_loc2_)
         {
            PlayerManager.Instance.Self.ID = param1.pkg.readInt();
            PlayerManager.Instance.Self.IsPublishEquit = param1.pkg.readBoolean();
            PlayerManager.Instance.Self.Introduction = param1.pkg.readUTF();
         }
         dispatchEvent(new Event("civilplayerinfomodify"));
      }
      
      private function __getMarryInfo(param1:PkgEvent) : void
      {
         PlayerManager.Instance.Self.Introduction = param1.pkg.readUTF();
         PlayerManager.Instance.Self.IsPublishEquit = param1.pkg.readBoolean();
         dispatchEvent(new Event("civilselfinfochange"));
      }
      
      public function __showPropose(param1:PkgEvent) : void
      {
         var _loc3_:int = param1.pkg.readInt();
         var _loc2_:Boolean = param1.pkg.readBoolean();
         if(_loc2_)
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
            _churchProposeFrame.spouseID = _loc3_;
            _churchProposeFrame.show();
         }
      }
      
      private function churchProposeFrameClose(param1:Event) : void
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
      
      private function __marryApply(param1:PkgEvent) : void
      {
         var _loc4_:int = param1.pkg.readInt();
         var _loc5_:String = param1.pkg.readUTF();
         var _loc2_:String = param1.pkg.readUTF();
         var _loc3_:int = param1.pkg.readInt();
         if(_loc4_ == PlayerManager.Instance.Self.ID)
         {
            _churchMarryApplySuccess = ComponentFactory.Instance.creat("common.church.ChurchMarryApplySuccess");
            _churchMarryApplySuccess.addEventListener("close",churchMarryApplySuccessClose);
            _churchMarryApplySuccess.show();
            return;
         }
         if(checkMarryApplyList(_loc3_))
         {
            return;
         }
         marryApplyList.push(_loc3_);
         SoundManager.instance.play("018");
         _proposeResposeFrame = ComponentFactory.Instance.creat("common.church.ChurchProposeResponseFrame");
         _proposeResposeFrame.addEventListener("close",ProposeResposeFrameClose);
         _proposeResposeFrame.spouseID = _loc4_;
         _proposeResposeFrame.spouseName = _loc5_;
         _proposeResposeFrame.answerId = _loc3_;
         _proposeResposeFrame.love = _loc2_;
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
      
      private function checkMarryApplyList(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < marryApplyList.length)
         {
            if(param1 == marryApplyList[_loc2_])
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function churchMarryApplySuccessClose(param1:Event) : void
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
      
      private function ProposeResposeFrameClose(param1:Event) : void
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
      
      private function __marryApplyReply(param1:PkgEvent) : void
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = param1.pkg.readInt();
         var _loc2_:Boolean = param1.pkg.readBoolean();
         var _loc7_:String = param1.pkg.readUTF();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         if(_loc2_)
         {
            PlayerManager.Instance.Self.IsMarried = true;
            PlayerManager.Instance.Self.SpouseID = _loc5_;
            PlayerManager.Instance.Self.SpouseName = _loc7_;
            TaskManager.instance.onMarriaged();
            TaskManager.instance.requestCanAcceptTask();
            if(PathManager.solveExternalInterfaceEnabel())
            {
               ExternalInterfaceManager.sendToAgent(7,PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName,ServerManager.Instance.zoneName,-1,"",_loc7_);
            }
         }
         if(_loc3_)
         {
            _loc6_ = new ChatData();
            _loc4_ = "";
            if(_loc2_)
            {
               _loc6_.channel = 6;
               _loc4_ = "<" + _loc7_ + ">" + LanguageMgr.GetTranslation("tank.manager.PlayerManager.isApplicant");
               _churchDialogueAgreePropose = ComponentFactory.Instance.creat("common.church.ChurchDialogueAgreePropose");
               _churchDialogueAgreePropose.msgInfo = _loc7_;
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
               _loc6_.channel = 7;
               _loc4_ = "<" + _loc7_ + ">" + LanguageMgr.GetTranslation("tank.manager.PlayerManager.refuseMarry");
               if(_churchDialogueRejectPropose)
               {
                  _churchDialogueRejectPropose.dispose();
                  _churchDialogueRejectPropose = null;
               }
               _churchDialogueRejectPropose = ComponentFactory.Instance.creat("common.church.ChurchDialogueRejectPropose");
               _churchDialogueRejectPropose.msgInfo = _loc7_;
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
            _loc6_.msg = StringHelper.rePlaceHtmlTextField(_loc4_);
            ChatManager.Instance.chat(_loc6_);
         }
         else if(_loc2_)
         {
            _alertMarried = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.tip"),LanguageMgr.GetTranslation("tank.manager.PlayerManager.youAndOtherMarried",_loc7_),LanguageMgr.GetTranslation("ok"),"",false,false,false,0,"alertInFight");
            _alertMarried.addEventListener("response",marriedResponse);
         }
      }
      
      private function marriedResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
         ObjectUtils.disposeObject(param1.target);
      }
      
      private function churchDialogueRejectProposeClose(param1:Event) : void
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
      
      private function churchDialogueAgreeProposeClose(param1:Event) : void
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
      
      private function __divorceApply(param1:PkgEvent) : void
      {
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc2_:Boolean = param1.pkg.readBoolean();
         if(!_loc3_)
         {
            return;
         }
         PlayerManager.Instance.Self.IsMarried = false;
         PlayerManager.Instance.Self.SpouseID = 0;
         PlayerManager.Instance.Self.SpouseName = "";
         ChurchManager.instance.selfRoom = null;
         if(!_loc2_)
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
      
      private function churchDialogueUnmarriedClose(param1:Event) : void
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
      
      private function __churchInvite(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         if(InviteManager.Instance.enabled)
         {
            _loc3_ = param1.pkg;
            _loc4_ = {};
            _loc4_["inviteID"] = _loc3_.readInt();
            _loc4_["inviteName"] = _loc3_.readUTF();
            _loc4_["IsVip"] = _loc3_.readBoolean();
            _loc4_["VIPLevel"] = _loc3_.readInt();
            _loc4_["roomID"] = _loc3_.readInt();
            _loc4_["roomName"] = _loc3_.readUTF();
            _loc4_["pwd"] = _loc3_.readUTF();
            _loc4_["sceneIndex"] = _loc3_.readInt();
            if(BuriedManager.Instance.isOpening)
            {
               return;
            }
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("common.church.ChurchInviteFrame");
            _loc2_.msgInfo = _loc4_;
            _loc2_.show();
            SoundManager.instance.play("018");
         }
      }
      
      private function __marryPropGet(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         PlayerManager.Instance.Self.IsMarried = _loc4_.readBoolean();
         PlayerManager.Instance.Self.SpouseID = _loc4_.readInt();
         PlayerManager.Instance.Self.SpouseName = _loc4_.readUTF();
         var _loc2_:Boolean = _loc4_.readBoolean();
         var _loc6_:int = _loc4_.readInt();
         var _loc5_:Boolean = _loc4_.readBoolean();
         if(_loc2_)
         {
            if(!ChurchManager.instance.selfRoom)
            {
               _loc3_ = new ChurchRoomInfo();
               _loc3_.id = _loc6_;
               ChurchManager.instance.selfRoom = _loc3_;
            }
         }
         else
         {
            ChurchManager.instance.selfRoom = null;
         }
      }
      
      private function __roomLogin(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:* = null;
         var _loc4_:* = null;
         var _loc7_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _loc7_.readBoolean();
         if(!_loc3_)
         {
            _loc8_ = _loc7_.readInt();
            if(MailManager.Instance.linkChurchRoomId != -1 && (_loc8_ == 5 || _loc8_ == 6))
            {
               StateManager.setState("ddtchurchroomlist");
               MailManager.Instance.hide();
            }
            else if(_loc8_ == 7)
            {
               _loc6_ = _loc7_.readInt();
               _linkServerInfo = ServerManager.Instance.getServerInfoByID(_loc6_);
               if(_linkServerInfo)
               {
                  _loc10_ = LanguageMgr.GetTranslation("ddt.church.serverInFail",_linkServerInfo.Name,MailManager.Instance.linkChurchRoomId);
                  _loc4_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),_loc10_,"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
                  _loc4_.addEventListener("response",__tipsMarryRoomframeResponse);
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
         var _loc5_:ChurchRoomInfo = new ChurchRoomInfo();
         _loc5_.id = _loc7_.readInt();
         _loc5_.roomName = _loc7_.readUTF();
         _loc5_.mapID = _loc7_.readInt();
         _loc5_.valideTimes = _loc7_.readInt();
         _loc5_.currentNum = _loc7_.readInt();
         _loc5_.createID = _loc7_.readInt();
         _loc5_.createName = _loc7_.readUTF();
         _loc5_.groomID = _loc7_.readInt();
         _loc5_.groomName = _loc7_.readUTF();
         _loc5_.brideID = _loc7_.readInt();
         _loc5_.brideName = _loc7_.readUTF();
         _loc5_.creactTime = _loc7_.readDate();
         _loc5_.isStarted = _loc7_.readBoolean();
         var _loc9_:int = _loc7_.readByte();
         if(_loc9_ == 1)
         {
            _loc5_.status = "wedding_none";
         }
         else
         {
            _loc5_.status = "wedding_ing";
         }
         _loc5_.discription = _loc7_.readUTF();
         _loc5_.canInvite = _loc7_.readBoolean();
         var _loc2_:int = _loc7_.readInt();
         ChurchManager.instance.currentScene = _loc2_;
         _loc5_.isUsedSalute = _loc7_.readBoolean();
         seniorType = _loc7_.readInt();
         _loc5_.seniorType = seniorType;
         currentRoom = _loc5_;
         if(isAdmin(PlayerManager.Instance.Self))
         {
            selfRoom = _loc5_;
         }
      }
      
      private function __tipsMarryRoomframeResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 2 || param1.responseCode == 3)
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
         var _loc2_:Frame = Frame(param1.currentTarget);
         _loc2_.removeEventListener("response",__tipsMarryRoomframeResponse);
         ObjectUtils.disposeAllChildren(_loc2_);
         ObjectUtils.disposeObject(_loc2_);
         _loc2_ = null;
      }
      
      private function __updateSelfRoom(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         var _loc3_:Boolean = _loc4_.readBoolean();
         if(!_loc3_)
         {
            selfRoom = null;
            return;
         }
         if(selfRoom == null)
         {
            selfRoom = new ChurchRoomInfo();
         }
         selfRoom.id = _loc4_.readInt();
         selfRoom.roomName = _loc4_.readUTF();
         selfRoom.mapID = _loc4_.readInt();
         selfRoom.valideTimes = _loc4_.readInt();
         selfRoom.createID = _loc4_.readInt();
         selfRoom.groomID = _loc4_.readInt();
         selfRoom.brideID = _loc4_.readInt();
         selfRoom.creactTime = _loc4_.readDate();
         selfRoom.isUsedSalute = _loc4_.readBoolean();
         selfRoom.seniorType = _loc4_.readInt();
      }
      
      public function __removePlayer(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.clientId;
         if(_loc2_ == PlayerManager.Instance.Self.ID)
         {
            StateManager.setState("ddtchurchroomlist");
         }
      }
      
      public function isAdmin(param1:PlayerInfo) : Boolean
      {
         if(_currentRoom && param1)
         {
            return param1.ID == _currentRoom.groomID || param1.ID == _currentRoom.brideID;
         }
         return false;
      }
      
      public function sendValidateMarry(param1:BasePlayer) : void
      {
         if(PlayerManager.Instance.Self.Grade < 14)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.notLvWoo",14));
         }
         else if(param1.Grade < 14)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.notOtherLvWoo",14));
         }
         else if(PlayerManager.Instance.Self.IsMarried)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.IsMarried"));
         }
         else if(PlayerManager.Instance.Self.Sex == param1.Sex)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.notAllow"));
         }
         else if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
         }
         else
         {
            SocketManager.Instance.out.sendValidateMarry(param1.ID);
         }
      }
   }
}
