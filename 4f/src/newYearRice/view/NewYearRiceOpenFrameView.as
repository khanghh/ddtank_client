package newYearRice.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.BossBoxManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.UIModuleSmallLoading;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.MouseEvent;   import invite.InviteFrame;   import invite.InviteManager;   import newYearRice.NewYearRiceController;   import newYearRice.NewYearRiceManager;   import road7th.comm.PackageIn;   import room.RoomManager;      public class NewYearRiceOpenFrameView extends Frame   {                   private var _main:MovieClip;            private var _openBtn:BaseButton;            private var _inviteBtn:BaseButton;            private var _playerItems:Vector.<PlayerCell>;            private var _startInvite:Boolean = false;            private var _inviteFrame:InviteFrame;            private var _bg:Bitmap;            private var _playerID:int;            private var _isRoomPlayer:Boolean;            private var _nameID:int;            private var _alert1:BaseAlerFrame;            private var _roomPlayerID:int;            public function NewYearRiceOpenFrameView() { super(); }
            private function initView() : void { }
            private function __cellClick(e:MouseEvent) : void { }
            private function __quitPlayer(e:FrameEvent) : void { }
            public function roomPlayerItem(id:int) : void { }
            public function updatePlayerItem(players:Array) : void { }
            private function addEvents() : void { }
            private function removeEvents() : void { }
            private function __quitYearFoodRoom(event:CrazyTankSocketEvent) : void { }
            private function __updateView(e:Event) : void { }
            public function setBtnEnter() : void { }
            private function __exitYearFoodRoom(event:CrazyTankSocketEvent) : void { }
            public function setViewFrame(index:int) : void { }
            private function __openBtnHandler(evt:MouseEvent) : void { }
            private function __inviteBtnHandler(evt:MouseEvent) : void { }
            protected function startInvite() : void { }
            private function loadInviteRes() : void { }
            private function __onClose(event:Event) : void { }
            private function __onInviteResComplete(evt:UIModuleEvent) : void { }
            private function __onInviteComplete(evt:Event) : void { }
            private function __onInviteResError(evt:UIModuleEvent) : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            override public function dispose() : void { }
   }}