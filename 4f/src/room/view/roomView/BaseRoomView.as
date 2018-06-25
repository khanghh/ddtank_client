package room.view.roomView{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.events.PkgEvent;   import ddt.events.RoomEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.ChatManager;   import ddt.manager.CheckWeaponManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.PositionUtils;   import ddt.view.MainToolBar;   import email.MailManager;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import hall.event.NewHallEvent;   import invite.InviteFrame;   import quest.TaskManager;   import road7th.comm.PackageIn;   import room.RoomManager;   import room.model.RoomInfo;   import room.model.RoomPlayer;   import room.view.RoomPlayerItem;   import room.view.RoomRightPropView;   import room.view.RoomViewerItem;   import trainer.view.NewHandContainer;      public class BaseRoomView extends Sprite implements Disposeable   {            protected static const HURRY_UP_TIME:int = 30;            protected static const KICK_TIME:int = 60;            protected static const KICK_TIMEII:int = 300;            protected static const KICK_TIMEIII:int = 1200;            protected static const ACTIVITY_MINGRADE:int = 25;                   protected var _hostTimer:Timer;            protected var _normalTimer:Timer;            protected var _info:RoomInfo;            protected var _roomPropView:RoomRightPropView;            protected var _btnBg:Bitmap;            protected var _startBtn:MovieClip;            protected var _prepareBtn:MovieClip;            protected var _cancelBtn:SimpleBitmapButton;            protected var _inviteBtn:SimpleBitmapButton;            protected var _inviteFrame:InviteFrame;            protected var _startInvite:Boolean = false;            protected var _playerItems:Array;            protected var _viewerItems:Vector.<RoomViewerItem>;            protected var _emailBtn:MovieImage;            protected var _taskIconBtn:MovieImage;            public function BaseRoomView(info:RoomInfo) { super(); }
            protected function initView() : void { }
            private function showEmailEffect(show:Boolean) : void { }
            private function showTaskEffect(show:Boolean) : void { }
            private function initTimer() : void { }
            protected function updateButtons() : void { }
            protected function initTileList() : void { }
            protected function get isViewerRoom() : Boolean { return false; }
            protected function initPlayerItems() : void { }
            protected function initEvents() : void { }
            protected function __changeRoomborden(e:PkgEvent) : void { }
            protected function __useRoomborden(e:PkgEvent) : void { }
            protected function __onMailClick(event:MouseEvent) : void { }
            protected function __updateEmail(event:Event) : void { }
            protected function __onSetEmailShine(event:NewHallEvent) : void { }
            protected function __onTaskClick(event:MouseEvent) : void { }
            protected function __showTaskHightLight(event:Event) : void { }
            protected function __hideTaskHightLight(event:Event) : void { }
            private function __switchClickEnabled(event:RoomEvent) : void { }
            private function __loadWeakGuild(evt:Event) : void { }
            protected function __inviteClick(evt:MouseEvent) : void { }
            protected function startInvite() : void { }
            private function loadInviteRes() : void { }
            private function __onInviteResComplete() : void { }
            private function __onInviteComplete(evt:Event) : void { }
            private function __onInviteResError(evt:UIModuleEvent) : void { }
            protected function removeEvents() : void { }
            protected function updateTimer() : void { }
            protected function __updatePlayerItems(evt:RoomEvent) : void { }
            protected function __updateState(evt:RoomEvent) : void { }
            protected function __addPlayer(evt:RoomEvent) : void { }
            protected function __removePlayer(evt:RoomEvent) : void { }
            protected function __startClick(evt:MouseEvent) : void { }
            protected function __prepareClick(evt:MouseEvent) : void { }
            protected function prepareGame() : void { }
            protected function startGame() : void { }
            protected function __cancelClick(evt:MouseEvent) : void { }
            protected function checkCanStartGame() : Boolean { return false; }
            protected function academyDungeonAllow() : Boolean { return false; }
            protected function activityDungeonAllow() : Boolean { return false; }
            protected function __startHandler(evt:RoomEvent) : void { }
            protected function startHostTimer() : void { }
            protected function startNormalTimer() : void { }
            protected function stopHostTimer() : void { }
            protected function stopNormalTimer() : void { }
            protected function resetHostTimer() : void { }
            protected function resetNormalTimer() : void { }
            protected function __onTimerII(evt:TimerEvent) : void { }
            protected function __onHostTimer(evt:TimerEvent) : void { }
            protected function kickHandler() : void { }
            public function dispose() : void { }
   }}