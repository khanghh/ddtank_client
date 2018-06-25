package team.view.main{   import com.pickgliss.ui.LayerManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import flash.events.TimerEvent;   import flash.utils.Timer;   import morn.core.components.Box;   import morn.core.components.Image;   import morn.core.components.Label;   import morn.core.ex.NameTextEx;   import morn.core.handlers.Handler;   import road7th.utils.DateUtils;   import team.TeamManager;   import team.event.TeamEvent;   import team.model.TeamInfo;   import team.model.TeamMemberInfo;   import team.view.mornui.TeamActiveViewUI;      public class TeamActiveView extends TeamActiveViewUI   {                   private var _timer:Timer;            public function TeamActiveView() { super(); }
            override protected function initialize() : void { }
            private function __onClickDonate() : void { }
            protected function __onTimer(event:TimerEvent) : void { }
            private function updateLoginTime(time:Number) : void { }
            private function __onClickActiveAlert() : void { }
            private function __onRenderMemeber(item:Box, index:int) : void { }
            private function __onRenderActive(item:Box, index:int) : void { }
            private function convertString(value:String) : String { return null; }
            protected function __onUpdateTeamInfo(event:TeamEvent) : void { }
            protected function __onUpdateMmeber(event:TeamEvent) : void { }
            protected function __onUpdateActive(e:TeamEvent) : void { }
            public function update() : void { }
            public function updateView() : void { }
            private function updateMemeberList() : void { }
            override public function dispose() : void { }
   }}