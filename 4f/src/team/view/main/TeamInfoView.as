package team.view.main{   import com.pickgliss.ui.LayerManager;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import morn.core.components.Box;   import morn.core.components.Image;   import morn.core.components.Label;   import morn.core.ex.NameTextEx;   import morn.core.handlers.Handler;   import road7th.utils.DateUtils;   import team.TeamManager;   import team.event.TeamEvent;   import team.model.TeamBattleSegmentInfo;   import team.model.TeamInfo;   import team.model.TeamLevelInfo;   import team.model.TeamMemberInfo;   import team.view.mornui.TeamInfoViewUI;      public class TeamInfoView extends TeamInfoViewUI   {                   public function TeamInfoView() { super(); }
            override protected function initialize() : void { }
            private function createHelpTips() : void { }
            protected function __onUpdateTeamInfo(event:TeamEvent) : void { }
            protected function __onUpdateMmeber(event:TeamEvent) : void { }
            private function updateMemberLit() : void { }
            private function __onClickCaptainTransfer() : void { }
            private function __onRenderMemeber(item:Box, index:int) : void { }
            protected function __onClickExit() : void { }
            protected function __onClickFight() : void { }
            protected function __onClickChat() : void { }
            public function update() : void { }
            override public function dispose() : void { }
   }}