package roomList.pveRoomList{   import academy.AcademyManager;   import com.pickgliss.manager.CacheSysManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.data.map.DungeonInfo;   import ddt.data.player.FriendListPlayer;   import ddt.data.player.PlayerInfo;   import ddt.events.CEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.loader.StartupResourceLoader;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MapManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.PlayerTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.manager.StatisticManager;   import ddt.view.MainToolBar;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.utils.Timer;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import room.RoomManager;   import room.model.RoomInfo;   import roomList.LookupRoomFrame;   import roomList.RoomListEnumerate;   import trainer.view.NewHandContainer;      public class DungeonListController   {            private static var _instance:DungeonListController;                   private var _model:DungeonListModel;            private var _view:DungeonListView;            private var _findRoom:LookupRoomFrame;            private var _defaluDungeonMapId_3:int;            private var _defaluDungeonMapId_4:int;            private var _buffList:DictionaryData;            private var _timer:Timer;            public function DungeonListController() { super(); }
            public static function disorder(arr:Array) : Array { return null; }
            public static function get instance() : DungeonListController { return null; }
            public function setup() : void { }
            private function __openViewHandler(event:CEvent) : void { }
            private function init() : void { }
            private function initDungeonListView(type:String = null) : void { }
            private function timerHandler(event:TimerEvent) : void { }
            private function initEvent() : void { }
            private function __addRoom(evt:CrazyTankSocketEvent) : void { }
            private function updataRoom(tempArray:Array) : void { }
            private function __addWaitingPlayer(evt:PkgEvent) : void { }
            private function __removeWaitingPlayer(evt:PkgEvent) : void { }
            public function setRoomShowMode(mode:int) : void { }
            public function enter() : void { }
            public function hide() : void { }
            public function getType() : String { return null; }
            public function sendGoIntoRoom(info:RoomInfo) : void { }
            public function showFindRoom() : void { }
            protected function __onChanllengeClick(e:Event) : void { }
            private function upMapId() : void { }
            public function dispose() : void { }
            public function getBackType() : String { return null; }
   }}