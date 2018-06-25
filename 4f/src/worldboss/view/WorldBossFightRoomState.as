package worldboss.view{   import com.pickgliss.ui.LayerManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.states.BaseStateView;   import ddt.view.MainToolBar;   import flash.display.Sprite;   import flash.events.TimerEvent;   import flash.utils.Timer;   import room.view.states.BaseRoomState;   import worldboss.WorldBossManager;      public class WorldBossFightRoomState extends BaseRoomState   {            public static var IsSuccessStartGame:Boolean = false;                   private var black:Sprite;            private var timer:Timer;            public function WorldBossFightRoomState() { super(); }
            override public function getType() : String { return null; }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function waitForGameStart() : void { }
            private function __gotoBack(evt:TimerEvent) : void { }
            override public function leaving(next:BaseStateView) : void { }
   }}