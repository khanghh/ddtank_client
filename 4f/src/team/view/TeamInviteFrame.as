package team.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.SimpleAlert;   import com.pickgliss.ui.vo.AlertInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.PositionUtils;   import flash.events.MouseEvent;   import road7th.data.DictionaryData;   import uigeneral.team.TeamInviteView;      public class TeamInviteFrame extends SimpleAlert   {            private static var _notAlertTeam:DictionaryData = new DictionaryData();                   private var _teamID:int;            private var _playerID:int;            private var _selectedCheckBtn:SelectedCheckButton;            public function TeamInviteFrame() { super(); }
            public static function hasAlert(teamID:int) : Boolean { return false; }
            override protected function init() : void { }
            public function setupData(data:Object) : void { }
            override protected function onResponse(type:int) : void { }
            private function alertTeamInfoFrame() : void { }
            protected function __onSelectCheckClick(e:MouseEvent) : void { }
            override public function dispose() : void { }
   }}