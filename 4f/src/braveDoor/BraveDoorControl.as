package braveDoor{   import BraveDoor.BraveDoorManager;   import BraveDoor.event.BraveDoorEvent;   import academy.AcademyManager;   import braveDoor.data.BraveDoorListModel;   import braveDoor.view.BraveDoorFrame;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.manager.CacheSysManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.loader.StartupResourceLoader;   import ddt.manager.GameInSocketOut;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.manager.StatisticManager;   import flash.events.EventDispatcher;   import flash.utils.setTimeout;   import road7th.comm.PackageIn;   import room.model.RoomInfo;   import roomList.LookupRoomFrame;      public class BraveDoorControl extends EventDispatcher   {            public static const ROOM:int = 1;            public static const TEM:int = 2;            private static var _instance:BraveDoorControl;                   private var _frame:BraveDoorFrame = null;            private var _model:BraveDoorListModel;            private var _findRoom:LookupRoomFrame;            private var _currentRoomType:int = 1;            private var _enterRoomType:int = 0;            private var _isLockSwitchView:Boolean = false;            public function BraveDoorControl() { super(); }
            public static function get instance() : BraveDoorControl { return null; }
            public function setup() : void { }
            public function openView_Handler(evt:CEvent) : void { }
            public function enter() : void { }
            private function init() : void { }
            private function initBraveDoorView(event:CEvent) : void { }
            private function __updateRoom(evt:CrazyTankSocketEvent) : void { }
            private function updateRoomInfo(tempArray:Array) : void { }
            public function updateRoomMap($duplicateId:int) : void { }
            private function sendSetRoom(dupId:int) : void { }
            protected function initEvents() : void { }
            private function setRoomMap(evt:BraveDoorEvent) : void { }
            protected function removeEvents() : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            public function lockSwitchView(type:int) : void { }
            public function unLockSwitchView() : void { }
            public function switchView(type:int) : void { }
            public function hide() : void { }
            public function get currentRoomType() : int { return 0; }
            public function dispose() : void { }
   }}