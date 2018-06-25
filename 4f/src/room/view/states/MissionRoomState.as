package room.view.states{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.states.BaseStateView;   import ddt.view.MainToolBar;   import room.RoomManager;   import room.view.roomView.MissionRoomView;      public class MissionRoomState extends BaseRoomState   {                   public function MissionRoomState() { super(); }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function leaveAlert() : void { }
            private function __onResponse(evt:FrameEvent) : void { }
            override public function getType() : String { return null; }
            override public function leaving(next:BaseStateView) : void { }
            override public function getBackType() : String { return null; }
   }}