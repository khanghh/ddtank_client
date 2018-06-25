package invite{   import bombKing.BombKingManager;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.InviteInfo;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MapManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.PositionUtils;   import ddt.view.common.LevelIcon;   import ddtBuried.BuriedManager;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.FocusEvent;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.Timer;   import road7th.data.DictionaryData;   import vip.VipController;   import wonderfulActivity.WonderfulActivityManager;      public class ResponseInviteFrame extends Frame   {            private static const InvitePool:DictionaryData = new DictionaryData(true);                   private var _levelIcon:LevelIcon;            private var _name:FilterFrameText;            private var _vipName:GradientText;            private var _powerTitle:Bitmap;            private var _powerValue:FilterFrameText;            private var _titleBmp:Bitmap;            private var _bg:Bitmap;            private var _modeLabel:FilterFrameText;            private var _mode:ScaleFrameImage;            private var _leftLabel:FilterFrameText;            private var _leftField:FilterFrameText;            private var _rightLabel:FilterFrameText;            private var _rightField:FilterFrameText;            private var _levelField:FilterFrameText;            private var _levelLabel:FilterFrameText;            private var _tipField:FilterFrameText;            private var _doButton:TextButton;            private var _cancelButton:TextButton;            private var _startTime:int = 0;            private var _elapsed:int = 0;            private var _titleString:String;            private var _timeUnit:String;            private var _prohibitSelectBtn:SelectedCheckButton;            private var _prohibitText:FilterFrameText;            private var _startupMark:Boolean = false;            private var _markTime:int = 15;            private var _visible:Boolean = true;            private var _inviteInfo:InviteInfo;            private var _resState:String;            private var _timer:Timer;            private var _uiReady:Boolean = false;            private var _attestBtn:ScaleFrameImage;            public function ResponseInviteFrame() { super(); }
            private static function removeInvite(inviteFrame:ResponseInviteFrame) : void { }
            public static function clearInviteFrame() : void { }
            public static function newInvite(info:InviteInfo) : ResponseInviteFrame { return null; }
            private function configUi() : void { }
            private function setAttestBtnInfo() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            public function show() : void { }
            private function __focusOut(evt:FocusEvent) : void { }
            private function __bodyClick(evt:MouseEvent) : void { }
            private function __toStage(evt:Event) : void { }
            private function __focusIn(evt:FocusEvent) : void { }
            private function bringToTop() : void { }
            private function enterRoom() : void { }
            private function __onInviteAccept(evt:MouseEvent) : void { }
            private function onUpdateData() : void { }
            private function __onMark(evt:TimerEvent) : void { }
            private function __onMarkComplete(evt:TimerEvent) : void { }
            override protected function __onCloseClick(event:MouseEvent) : void { }
            private function getLevelLimits(levelLimits:int) : String { return null; }
            private function getRoomHardLevel(HardLevel:int) : String { return null; }
            private function restartMark() : void { }
            private function markComplete() : void { }
            private function __onClickSelectedBtn(e:MouseEvent) : void { }
            public function close() : void { }
            public function get inviteInfo() : InviteInfo { return null; }
            public function set inviteInfo(val:InviteInfo) : void { }
            override public function dispose() : void { }
   }}