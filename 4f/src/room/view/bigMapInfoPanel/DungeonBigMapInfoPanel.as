package room.view.bigMapInfoPanel{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.events.RoomEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.view.MainToolBar;   import flash.events.MouseEvent;   import room.RoomManager;   import room.view.chooseMap.DungeonChooseMapFrame;      public class DungeonBigMapInfoPanel extends MissionRoomBigMapInfoPanel   {                   private var _chooseBtn:SimpleBitmapButton;            public function DungeonBigMapInfoPanel() { super(); }
            override protected function initEvents() : void { }
            private function __clickHandler(event:MouseEvent) : void { }
            private function __outHandler(event:MouseEvent) : void { }
            private function __overHandler(event:MouseEvent) : void { }
            override protected function removeEvents() : void { }
            override protected function initView() : void { }
            private function leaveAlert() : void { }
            private function showAlert() : void { }
            private function __onResponse(evt:FrameEvent) : void { }
            private function __onGameStarted(evt:RoomEvent) : void { }
            override protected function __onMapChanged(evt:RoomEvent) : void { }
            private function __playerStateChange(evt:RoomEvent) : void { }
            private function __openBossChange(evt:RoomEvent) : void { }
            override protected function updateMap() : void { }
            override protected function solvePath() : String { return null; }
            override public function dispose() : void { }
   }}