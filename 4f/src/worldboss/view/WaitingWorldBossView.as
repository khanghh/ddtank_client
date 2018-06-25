package worldboss.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChatManager;   import ddt.manager.PathManager;   import ddt.manager.StateManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.utils.Timer;   import gameCommon.GameControl;   import par.ParticleManager;   import worldboss.event.WorldBossRoomEvent;      public class WaitingWorldBossView extends Component   {                   private const WAITING_TIME:int = 20;            private var _bg:Sprite;            private var _loadingArr:Array;            private var _loadingText:FilterFrameText;            private var _timeText:FilterFrameText;            private var _waitTimer:Timer;            private var _currentCountDown:int = 20;            private var _loadingIdx:int = 0;            private var _frame:int;            public function WaitingWorldBossView() { super(); }
            private function initEvent() : void { }
            protected function __startLoading(e:Event) : void { }
            protected function __onTimerComplete(event:TimerEvent) : void { }
            protected function __onTimer(event:TimerEvent) : void { }
            private function initView() : void { }
            private function removeEvent() : void { }
            public function start() : void { }
            protected function __onEnterFrame(event:Event) : void { }
            public function stop() : void { }
            override public function dispose() : void { }
   }}