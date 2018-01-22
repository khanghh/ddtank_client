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
      
      public function IMManager(){super();}
      
      public static function get Instance() : IMManager{return null;}
      
      public function setup() : void{}
      
      private function __yearFoodRoomInvite(param1:CrazyTankSocketEvent) : void{}
      
      private function __inviteNewYearRice(param1:FrameEvent) : void{}
      
      protected function __onChanllengeClick(param1:Event) : void{}
      
      private function __privateTalkHandler(param1:PkgEvent) : void{}
      
      private function __stopTalkTime(param1:TimerEvent) : void{}
      
      public function setExist(param1:int, param2:int, param3:Boolean = false) : void{}
      
      private function TeamSaveShared(param1:PresentRecordInfo) : void{}
      
      private function saveInShared(param1:PresentRecordInfo) : void{}
      
      private function __teamTalkHandler(param1:PkgEvent) : void{}
      
      public function alertTeamChatFrame(param1:int = 0) : void{}
      
      public function alertPrivateFrame(param1:int = 0) : void{}
      
      public function cancelFlash() : void{}
      
      public function hasUnreadMessage() : Boolean{return false;}
      
      protected function __IDChange(param1:PlayerPropertyEvent) : void{}
      
      public function hidePrivateFrame(param1:int) : void{}
      
      public function hideTeamChatFrame(param1:int) : void{}
      
      private function createPresentRecordInfo(param1:int, param2:Boolean = false) : void{}
      
      public function disposeTeamChatFrame() : void{}
      
      public function disposePrivateFrame(param1:int) : void{}
      
      public function removeTeamMessage(param1:int) : void{}
      
      public function removePrivateMessage(param1:int) : void{}
      
      public function showMessageBox(param1:DisplayObject) : void{}
      
      public function getMessage() : Vector.<PresentRecordInfo>{return null;}
      
      protected function __timerHandler(param1:TimerEvent) : void{}
      
      public function hideMessageBox() : void{}
      
      public function setupRecentContactsList() : void{}
      
      public function show() : void{}
      
      private function dispatchShow() : void{}
      
      public function get icon() : Bitmap{return null;}
      
      private function loadIcon() : void{}
      
      private function __friendResponse(param1:PkgEvent) : void{}
      
      private function __receiveInvite(param1:PkgEvent) : void{}
      
      private function startReceiveInvite(param1:InviteInfo) : void{}
      
      private function getInviteState() : Boolean{return false;}
      
      public function addFriend(param1:String) : void{}
      
      public function isMaxFriend() : Boolean{return false;}
      
      private function alertGroupFrame(param1:String) : void{}
      
      public function clearGroupFrame() : void{}
      
      private function __close(param1:FrameEvent) : void{}
      
      public function addBlackList(param1:String) : void{}
      
      private function __closeII(param1:FrameEvent) : void{}
      
      private function __frameEvent(param1:FrameEvent) : void{}
      
      private function __frameEventII(param1:FrameEvent) : void{}
      
      private function __addBlack() : void{}
      
      private function checkBlackListExit(param1:String) : Boolean{return false;}
      
      private function checkFriendExist(param1:String) : Boolean{return false;}
      
      public function deleteFriend(param1:int, param2:Boolean = false) : void{}
      
      public function deleteGroup(param1:int, param2:String) : void{}
      
      private function __deleteGroupEvent(param1:FrameEvent) : void{}
      
      private function __frameEventIII(param1:FrameEvent) : void{}
      
      private function disposeAlert() : void{}
      
      public function deleteRecentContacts(param1:int = 0) : void{}
      
      private function __deleteRecentContact(param1:FrameEvent) : void{}
      
      public function isFriend(param1:String) : Boolean{return false;}
      
      public function onDeleteGirlPic() : void{}
      
      public function girlHeadSelectedBtnClicked(param1:Boolean) : void{}
      
      public function createConsortiaLoader() : void{}
      
      private function setupCMFriendList(param1:LoadCMFriendList) : void{}
      
      private function cmFriendAddToFriend() : void{}
      
      public function loadRecentContacts() : void{}
      
      public function get recentContactsList() : Array{return null;}
      
      private function getFullRecentContactsID() : String{return null;}
      
      public function saveRecentContactsID(param1:int = 0) : void{}
      
      public function testIdentical(param1:int) : int{return 0;}
      
      public function sortAcademyPlayer(param1:Array) : Array{return null;}
      
      public function addTransregionalblackList(param1:String) : void{}
      
      public function get prohibitInviteList() : DictionaryData{return null;}
      
      public function get existChat() : Vector.<PresentRecordInfo>{return null;}
      
      public function get isLoadRecentContacts() : Boolean{return false;}
      
      public function set isLoadRecentContacts(param1:Boolean) : void{}
   }
}
