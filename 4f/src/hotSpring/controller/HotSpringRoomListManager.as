package hotSpring.controller{   import ddt.data.HotSpringRoomInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.manager.SocketManager;   import ddt.states.BaseStateView;   import ddt.view.MainToolBar;   import hotSpring.model.HotSpringRoomListModel;   import hotSpring.view.HotSpringMainView;   import road7th.comm.PackageIn;      public class HotSpringRoomListManager extends BaseStateView   {                   private var _view:HotSpringMainView;            private var _model:HotSpringRoomListModel;            public function HotSpringRoomListManager() { super(); }
            override public function prepare() : void { }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function setEvent() : void { }
            private function removeEvent() : void { }
            private function roomAddOrUpdate(event:CrazyTankSocketEvent) : void { }
            public function hotSpringEnter() : void { }
            private function roomCreateSucceed(event:CrazyTankSocketEvent) : void { }
            private function roomListGet(event:CrazyTankSocketEvent) : void { }
            private function roomRemove(event:CrazyTankSocketEvent) : void { }
            public function roomEnterConfirm(roomID:int) : void { }
            public function roomEnter(roomID:int, inputPassword:String) : void { }
            public function quickEnterRoom() : void { }
            public function roomCreate(roomVO:HotSpringRoomInfo) : void { }
            override public function leaving(next:BaseStateView) : void { }
            override public function getBackType() : String { return null; }
            override public function getType() : String { return null; }
            override public function dispose() : void { }
   }}