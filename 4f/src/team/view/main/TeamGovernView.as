package team.view.main{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.data.player.FriendListPlayer;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import morn.core.components.Box;   import morn.core.components.Button;   import morn.core.components.Clip;   import morn.core.components.Component;   import morn.core.components.Image;   import morn.core.components.Label;   import morn.core.ex.NameTextEx;   import morn.core.handlers.Handler;   import road7th.data.DictionaryData;   import road7th.utils.DateUtils;   import team.TeamManager;   import team.event.TeamEvent;   import team.model.TeamInfo;   import team.model.TeamInvitedMemberInfo;   import team.model.TeamMemberInfo;   import team.view.mornui.TeamGovernViewUI;      public class TeamGovernView extends TeamGovernViewUI   {                   private var _invite:DictionaryData;            public function TeamGovernView() { super(); }
            override protected function initialize() : void { }
            private function __onSelectOnline() : void { }
            private function __onUpdateFriendList(e:Event) : void { }
            private function __onRenderFriend(item:Box, index:int) : void { }
            private function __onSelectFriend(index:int) : void { }
            private function __onRenderInvite(item:Box, index:int) : void { }
            private function __onRenderMember(item:Box, index:int) : void { }
            private function __onSelectMember(index:int) : void { }
            private function __onAlertExpel(e:FrameEvent) : void { }
            protected function __onUpdateTeamInfo(event:TeamEvent) : void { }
            protected function __onUpdateMmeber(event:TeamEvent) : void { }
            protected function __onUpdateInvite(event:TeamEvent) : void { }
            public function update() : void { }
            private function updateView() : void { }
            private function updateFriendList() : void { }
            private function updateMemberList() : void { }
            override public function dispose() : void { }
   }}