package treasureRoom.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import mark.MarkMgr;   import mark.event.MarkEvent;   import treasureRoom.mornui.TreasureRoomViewUI;      public class TreasureRoomView extends TreasureRoomViewUI   {                   private var _freeTimeNum:Number;            private var _time:Timer;            private var _btnHelp:BaseButton;            private var _redEgg:MovieClip;            private var _blueEgg:MovieClip;            private var _fireballEgg:MovieClip;            private var _rewardView:TreasureRoomRewardView;            private var _index:int;            private var _mask:Sprite;            private var _configArr:Array;            private var _totalFreeNum:int;            private var _freeArr:Array;            public function TreasureRoomView() { super(); }
            private function initView() : void { }
            private function addTimer() : void { }
            protected function __onUpdateCountDown(event:TimerEvent) : void { }
            private function transSecond(num:Number) : String { return null; }
            private function addEvent() : void { }
            private function showRewardViewHandler(evt:MarkEvent) : void { }
            protected function __onMovieFrame(event:Event) : void { }
            protected function __rewardClose(event:Event) : void { }
            private function updateTimerHandler(evt:MarkEvent) : void { }
            protected function __onClickHandler(event:MouseEvent) : void { }
            private function __alertAllBack(event:FrameEvent) : void { }
            private function __alertAllBack2(event:FrameEvent) : void { }
            private function removeEvent() : void { }
            protected function disposeView(event:Event) : void { }
            override public function dispose() : void { }
   }}