package church{   import baglocked.BaglockedManager;   import campbattle.CampBattleManager;   import church.events.WeddingRoomEvent;   import church.view.ChurchAlertFrame;   import com.pickgliss.action.AlertAction;   import com.pickgliss.action.FunctionAction;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.manager.CacheSysManager;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.action.FrameShowAction;   import ddt.data.ChurchRoomInfo;   import ddt.data.ServerInfo;   import ddt.data.player.BasePlayer;   import ddt.data.player.PlayerInfo;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.ExternalInterfaceManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.view.UIModuleSmallLoading;   import ddt.view.chat.ChatData;   import ddt.view.common.church.ChurchDialogueAgreePropose;   import ddt.view.common.church.ChurchDialogueRejectPropose;   import ddt.view.common.church.ChurchDialogueUnmarried;   import ddt.view.common.church.ChurchInviteFrame;   import ddt.view.common.church.ChurchMarryApplySuccess;   import ddt.view.common.church.ChurchProposeFrame;   import ddt.view.common.church.ChurchProposeResponseFrame;   import ddtBuried.BuriedManager;   import email.MailManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import invite.InviteManager;   import quest.TaskManager;   import road7th.comm.PackageIn;   import road7th.utils.StringHelper;      public class ChurchManager extends EventDispatcher   {            public static const GENERALSCENEINDEX:int = 1;            public static const ADVANCEDSCENEINDEX:int = 2;            public static const COSTLYSCENEINDEX:int = 3;            private static const MOON_SCENE:Boolean = true;            public static const CIVIL_PLAYER_INFO_MODIFY:String = "civilplayerinfomodify";            public static const CIVIL_SELFINFO_CHANGE:String = "civilselfinfochange";            public static const SUBMIT_REFUND:String = "submitRefund";            private static var _instance:ChurchManager;                   private var _currentScene:int = 1;            private var _churchDialogueUnmarried:ChurchDialogueUnmarried;            private var _churchProposeFrame:ChurchProposeFrame;            private var _proposeResposeFrame:ChurchProposeResponseFrame;            private var _churchMarryApplySuccess:ChurchMarryApplySuccess;            private var _alertMarried:BaseAlerFrame;            public var _weddingSuccessfulComplete:Boolean;            public var seniorType:int;            public var lastScene:int = 1;            private var _selfRoom:ChurchRoomInfo;            private var _currentRoom:ChurchRoomInfo;            private var _mapLoader01:BaseLoader;            private var _mapLoader02:BaseLoader;            private var _mapLoader00:BaseLoader;            private var _isRemoveLoading:Boolean = true;            private var _userID:int;            public var isUnwedding:Boolean;            private var money:int;            private var marryApplyList:Array;            private var _churchDialogueAgreePropose:ChurchDialogueAgreePropose;            private var _churchDialogueRejectPropose:ChurchDialogueRejectPropose;            private var unwedingmsg:String;            private var _linkServerInfo:ServerInfo;            public function ChurchManager() { super(); }
            public static function get instance() : ChurchManager { return null; }
            public function get currentScene() : int { return 0; }
            public function set currentScene(value:int) : void { }
            public function get selfRoom() : ChurchRoomInfo { return null; }
            public function set selfRoom(value:ChurchRoomInfo) : void { }
            public function set currentRoom(value:ChurchRoomInfo) : void { }
            public function get currentRoom() : ChurchRoomInfo { return null; }
            private function onChurchRoomInfoChange() : void { }
            public function loadMap() : void { }
            protected function onMapSrcLoadedComplete(event:LoaderEvent = null) : void { }
            public function tryLoginScene() : void { }
            private function __loadingIsClose(event:Event) : void { }
            public function removeLoadingEvent() : void { }
            public function setup() : void { }
            private function reqeustPayHander(e:PkgEvent) : void { }
            public function openAlert() : void { }
            private function reponseHander(e:FrameEvent) : void { }
            private function __onSubmitRefund(e:Event) : void { }
            private function __upCivilPlayerView(e:PkgEvent) : void { }
            private function __getMarryInfo(e:PkgEvent) : void { }
            public function __showPropose(event:PkgEvent) : void { }
            private function churchProposeFrameClose(evt:Event) : void { }
            private function __marryApply(event:PkgEvent) : void { }
            private function checkMarryApplyList(id:int) : Boolean { return false; }
            private function churchMarryApplySuccessClose(evt:Event) : void { }
            private function ProposeResposeFrameClose(evt:Event) : void { }
            private function __marryApplyReply(event:PkgEvent) : void { }
            private function marriedResponse(evt:FrameEvent) : void { }
            private function churchDialogueRejectProposeClose(evt:Event) : void { }
            private function churchDialogueAgreeProposeClose(evt:Event) : void { }
            private function __divorceApply(event:PkgEvent) : void { }
            private function churchDialogueUnmarriedClose(evt:Event) : void { }
            private function __churchInvite(event:PkgEvent) : void { }
            private function __marryPropGet(event:PkgEvent) : void { }
            private function __roomLogin(event:PkgEvent) : void { }
            private function __tipsMarryRoomframeResponse(evt:FrameEvent) : void { }
            private function __updateSelfRoom(event:PkgEvent) : void { }
            public function __removePlayer(event:PkgEvent) : void { }
            public function isAdmin(info:PlayerInfo) : Boolean { return false; }
            public function sendValidateMarry(info:BasePlayer) : void { }
   }}