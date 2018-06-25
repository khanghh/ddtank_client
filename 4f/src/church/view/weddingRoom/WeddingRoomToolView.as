package church.view.weddingRoom{   import baglocked.BaglockedManager;   import church.ChurchManager;   import church.controller.ChurchRoomController;   import church.events.WeddingRoomEvent;   import church.model.ChurchRoomModel;   import church.view.churchFire.ChurchFireView;   import church.view.invite.ChurchInviteController;   import church.view.weddingRoom.frame.WeddingRoomConfigView;   import church.view.weddingRoom.frame.WeddingRoomContinuationView;   import church.view.weddingRoom.frame.WeddingRoomGiftFrameForGuest;   import church.view.weddingRoom.frame.WeddingRoomGuestListView;   import com.greensock.TweenLite;   import com.greensock.easing.Sine;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.view.chat.ChatData;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import giftSystem.GiftManager;      public class WeddingRoomToolView extends Sprite implements Disposeable   {            private static const LEAST_GIFT_MONEY:int = 100;                   private var _controller:ChurchRoomController;            private var _model:ChurchRoomModel;            private var _churchRoomControler:ChurchRoomController;            private var _toolBg:Bitmap;            private var _toolSwitchBg:BaseButton;            private var _toolSwitch:Bitmap;            private var _switchEnable:Boolean = true;            private var _toolBtnRoomAdmin:BaseButton;            private var _toolBtnInviteGuest:BaseButton;            private var _toolBtnGift:BaseButton;            private var _toolBtnFire:BaseButton;            private var _toolBtnFill:BaseButton;            private var _toolBtnExit:BaseButton;            private var _toolBtnBack:BaseButton;            private var _alertExit:BaseAlerFrame;            private var _alertStartWedding:BaseAlerFrame;            private var _fireLoader:BaseLoader;            private var _churchFireView:ChurchFireView;            private var _toolAdminBg:Bitmap;            private var _startWeddingTip:Bitmap;            private var _startWeddingTip2:Bitmap;            private var _toolBtnStartWedding:BaseButton;            private var _toolBtnAdminInviteGuest:BaseButton;            private var _toolBtnGuestList:BaseButton;            private var _toolBtnContinuation:BaseButton;            private var _toolBtnModify:BaseButton;            private var _adminToolVisible:Boolean = true;            private var _sendGifeToolVisible:Boolean = false;            private var _weddingRoomGiftFrameViewForGuest:WeddingRoomGiftFrameForGuest;            private var _weddingRoomConfigView:WeddingRoomConfigView;            private var _weddingRoomContinuationView:WeddingRoomContinuationView;            private var _weddingRoomGuestListView:WeddingRoomGuestListView;            private var _churchInviteController:ChurchInviteController;            private var _startTipTween:TweenLite;            private var _switchTween:TweenLite;            private var _sendGiftToolBg:Bitmap;            private var _toolSendGiftBtn:BaseButton;            public var _toolSendCashBtn:BaseButton;            public var _toolSendCashBtnForGuest:BaseButton;            private var _isplayerStartTipMovieState:int = 0;            public function WeddingRoomToolView() { super(); }
            public function get controller() : ChurchRoomController { return null; }
            public function set controller(value:ChurchRoomController) : void { }
            public function set churchRoomModel(value:ChurchRoomModel) : void { }
            public function set churchRoomControler(value:ChurchRoomController) : void { }
            public function set inventBtnEnabled(value:Boolean) : void { }
            private function initialize() : void { }
            private function setView() : void { }
            private function setEvent() : void { }
            public function resetView() : void { }
            private function __weddingStatusChange(event:WeddingRoomEvent) : void { }
            private function __updateBtn(evt:WeddingRoomEvent) : void { }
            private function showAdminToolView() : void { }
            private function set adminToolVisible(value:Boolean) : void { }
            private function showGiftToolView() : void { }
            private function set GiftToolVisible(value:Boolean) : void { }
            private function playerStartTipMovie() : void { }
            private function isGuest() : Boolean { return false; }
            private function onToolMenuClick(evt:MouseEvent) : void { }
            public function giftViewForGuest() : void { }
            public function giftView() : void { }
            private function exitResponse(evt:FrameEvent) : void { }
            private function exitRoom() : void { }
            private function toolSwitch(evt:MouseEvent) : void { }
            public function loadFire() : void { }
            private function get isFireLoaded() : Boolean { return false; }
            private function openFireList() : void { }
            private function openRoomConfig() : void { }
            private function openRoomContinuation() : void { }
            private function openGuestList() : void { }
            private function openInviteGuest() : void { }
            private function openStartWedding() : void { }
            private function startWeddingResponse(evt:FrameEvent) : void { }
            private function closeStartWedding() : void { }
            private function closeFireList() : void { }
            private function closeRoomGift(evt:Event = null) : void { }
            private function closeRoomConfig(evt:Event = null) : void { }
            private function closeRoomContinuation(evt:Event = null) : void { }
            private function closeRoomGuestList(evt:Event = null) : void { }
            private function closeInviteGuest(evt:Event = null) : void { }
            private function removeView() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}