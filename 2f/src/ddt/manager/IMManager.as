package ddt.manager{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.BitmapLoader;   import com.pickgliss.loader.DisplayLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.bagStore.BagStore;   import ddt.data.CMFriendInfo;   import ddt.data.InviteInfo;   import ddt.data.analyze.LoadCMFriendList;   import ddt.data.analyze.RecentContactsAnalyze;   import ddt.data.player.FriendListPlayer;   import ddt.data.player.PlayerInfo;   import ddt.data.player.SelfInfo;   import ddt.events.CEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.utils.AssetModuleLoader;   import ddt.utils.FilterWordManager;   import ddt.utils.RequestVairableCreater;   import ddt.view.im.FriendGroupFrame;   import ddt.view.im.MessageBox;   import ddt.view.im.PrivateChatFrame;   import ddtBuried.BuriedManager;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.InteractiveObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.net.URLVariables;   import flash.text.TextField;   import flash.utils.Timer;   import game.GameManager;   import gypsyShop.ctrl.GypsyShopManager;   import im.IMEvent;   import im.PresentRecordInfo;   import invite.InviteManager;   import newYearRice.NewYearRiceManager;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import road7th.utils.StringHelper;   import room.RoomManager;   import roomList.RoomListEnumerate;   import wonderfulActivity.WonderfulActivityManager;      public class IMManager extends EventDispatcher   {            public static const CMFRIEND_COMPLETE:String = "CMFriendComplete";            public static const HAS_NEW_MESSAGE:String = "hasNewMessage";            public static const NO_MESSAGE:String = "nomessage";            public static const ALERT_MESSAGE:String = "alertMessage";            public static const MAX_MESSAGE_IN_BOX:int = 10;            public static var IS_SHOW_SUB:Boolean;            public static var isInIM:Boolean = false;            public static const ISFUBLISH:String = "isFublish";            private static var _instance:IMManager;                   private var _existChat:Vector.<PresentRecordInfo>;            private var _name:String;            private var _baseAlerFrame:BaseAlerFrame;            private var _recentContactsList:Array;            private var _isLoadRecentContacts:Boolean;            private var _loader:DisplayLoader;            private var _talkTimer:Timer;            public var isLoadComplete:Boolean = false;            public var privateChatFocus:Boolean;            public var changeID:int;            public var cancelflashState:Boolean;            private var _teamChatFrame:Object;            private var _lastTeamId:int;            private var _privateFrame:PrivateChatFrame;            private var _lastId:int;            private var _changeInfo:PlayerInfo;            private var _messageBox:MessageBox;            private var _timer:Timer;            private var _groupFrame:FriendGroupFrame;            private var _tempLock:Boolean;            private var _id:int;            private var _groupId:int;            private var _groupName:String;            private var _deleteRecentContact:int;            private var _isAddCMFriend:Boolean = true;            private var _prohibitInviteList:DictionaryData;            public function IMManager() { super(); }
            public static function get Instance() : IMManager { return null; }
            public function setup() : void { }
            private function __yearFoodRoomInvite(event:CrazyTankSocketEvent) : void { }
            private function __inviteNewYearRice(e:FrameEvent) : void { }
            protected function __onChanllengeClick(e:Event) : void { }
            private function __privateTalkHandler(event:PkgEvent) : void { }
            private function __stopTalkTime(event:TimerEvent) : void { }
            public function setExist(id:int, exist:int, isTeamChat:Boolean = false) : void { }
            private function TeamSaveShared(tempInfo:PresentRecordInfo) : void { }
            private function saveInShared(tempInfo:PresentRecordInfo) : void { }
            private function __teamTalkHandler(e:PkgEvent) : void { }
            public function alertTeamChatFrame(id:int = 0) : void { }
            public function alertPrivateFrame(id:int = 0) : void { }
            public function cancelFlash() : void { }
            public function hasUnreadMessage() : Boolean { return false; }
            protected function __IDChange(event:PlayerPropertyEvent) : void { }
            public function hidePrivateFrame(id:int) : void { }
            public function hideTeamChatFrame(id:int) : void { }
            private function createPresentRecordInfo(id:int, isTeamChat:Boolean = false) : void { }
            public function disposeTeamChatFrame() : void { }
            public function disposePrivateFrame(id:int) : void { }
            public function removeTeamMessage(id:int) : void { }
            public function removePrivateMessage(id:int) : void { }
            public function showMessageBox(obj:DisplayObject) : void { }
            public function getMessage() : Vector.<PresentRecordInfo> { return null; }
            protected function __timerHandler(event:TimerEvent) : void { }
            public function hideMessageBox() : void { }
            public function setupRecentContactsList() : void { }
            public function show() : void { }
            private function dispatchShow() : void { }
            public function get icon() : Bitmap { return null; }
            private function loadIcon() : void { }
            private function __friendResponse(evt:PkgEvent) : void { }
            private function __receiveInvite(evt:PkgEvent) : void { }
            private function startReceiveInvite(info:InviteInfo) : void { }
            private function getInviteState() : Boolean { return false; }
            public function addFriend(name:String) : void { }
            public function isMaxFriend() : Boolean { return false; }
            private function alertGroupFrame(name:String) : void { }
            public function clearGroupFrame() : void { }
            private function __close(event:FrameEvent) : void { }
            public function addBlackList(name:String) : void { }
            private function __closeII(event:FrameEvent) : void { }
            private function __frameEvent(evt:FrameEvent) : void { }
            private function __frameEventII(evt:FrameEvent) : void { }
            private function __addBlack() : void { }
            private function checkBlackListExit(s:String) : Boolean { return false; }
            private function checkFriendExist(s:String) : Boolean { return false; }
            public function deleteFriend(id:int, isDeleteBlack:Boolean = false) : void { }
            public function deleteGroup(groupId:int, groupName:String) : void { }
            private function __deleteGroupEvent(event:FrameEvent) : void { }
            private function __frameEventIII(evt:FrameEvent) : void { }
            private function disposeAlert() : void { }
            public function deleteRecentContacts(ID:int = 0) : void { }
            private function __deleteRecentContact(event:FrameEvent) : void { }
            public function isFriend(name:String) : Boolean { return false; }
            public function onDeleteGirlPic() : void { }
            public function girlHeadSelectedBtnClicked(isUse:Boolean) : void { }
            public function createConsortiaLoader() : void { }
            private function setupCMFriendList(analyzer:LoadCMFriendList) : void { }
            private function cmFriendAddToFriend() : void { }
            public function loadRecentContacts() : void { }
            public function get recentContactsList() : Array { return null; }
            private function getFullRecentContactsID() : String { return null; }
            public function saveRecentContactsID(ID:int = 0) : void { }
            public function testIdentical(id:int) : int { return 0; }
            public function sortAcademyPlayer(list:Array) : Array { return null; }
            public function addTransregionalblackList(name:String) : void { }
            public function get prohibitInviteList() : DictionaryData { return null; }
            public function get existChat() : Vector.<PresentRecordInfo> { return null; }
            public function get isLoadRecentContacts() : Boolean { return false; }
            public function set isLoadRecentContacts(value:Boolean) : void { }
   }}