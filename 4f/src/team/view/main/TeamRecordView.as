package team.view.main{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import morn.core.components.Box;   import morn.core.components.Label;   import morn.core.ex.LevelIconEx;   import morn.core.handlers.Handler;   import team.TeamManager;   import team.event.TeamEvent;   import team.model.TeamRecordInfo;   import team.view.mornui.TeamRecordViewUI;      public class TeamRecordView extends TeamRecordViewUI   {                   private var _bg:Bitmap;            public function TeamRecordView() { super(); }
            override protected function initialize() : void { }
            public function update() : void { }
            private function __onUpdateRecord(e:TeamEvent) : void { }
            private function updateBgView() : void { }
            private function __onRenderFailList(item:Box, index:int) : void { }
            private function __onRenderWinList(item:Box, index:int) : void { }
            private function __onRenderTabList(item:Box, index:int) : void { }
            private function __onSelectTabList(index:int) : void { }
            private function __onPageSelect(index:int) : void { }
            public function updateGameInfo(value:TeamRecordInfo) : void { }
            override public function dispose() : void { }
   }}