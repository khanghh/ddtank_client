package team.view.rank{   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import morn.core.components.Component;   import morn.core.handlers.Handler;   import team.TeamManager;   import team.model.TeamRankInfo;   import team.view.mornui.Rank.TeamRankViewUI;      public class TeamRankView extends TeamRankViewUI   {                   private var _serverIndex:int;            private var _gradeIndex:int;            private var _index:int;            public function TeamRankView() { super(); }
            private function addEvent() : void { }
            protected function __selectedServer(event:Event) : void { }
            override protected function initialize() : void { }
            private function __listRankSelectRander(index:int) : void { }
            private function updateTeaminfo(index:int) : void { }
            private function __listLeftSelectRander(index:int) : void { }
            private function __listLeftRender(item:Component, index:int) : void { }
            private function __listRankRender(item:Component, index:int) : void { }
            private function updateRankList() : void { }
            private function updateSlefRank() : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}