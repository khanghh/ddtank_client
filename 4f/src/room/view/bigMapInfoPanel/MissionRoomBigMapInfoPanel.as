package room.view.bigMapInfoPanel{   import com.pickgliss.loader.DisplayLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.map.DungeonInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.RoomEvent;   import ddt.manager.MapManager;   import ddt.manager.PathManager;   import ddt.manager.SocketManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import gameCommon.GameControl;   import room.RoomManager;   import room.model.RoomInfo;   import room.view.RoomTicketView;      public class MissionRoomBigMapInfoPanel extends Sprite implements Disposeable   {                   protected var _bg:MutipleImage;            protected var _mapShowContainer:Sprite;            protected var _dropList:DropList;            protected var _pos1:Point;            protected var _pos2:Point;            protected var _info:RoomInfo;            protected var _ticketView:RoomTicketView;            private var _loader:DisplayLoader;            public function MissionRoomBigMapInfoPanel() { super(); }
            protected function initEvents() : void { }
            private function __lastMission(event:CrazyTankSocketEvent) : void { }
            protected function removeEvents() : void { }
            protected function initView() : void { }
            protected function __onMapChanged(evt:RoomEvent) : void { }
            protected function __updateHard(evt:RoomEvent) : void { }
            protected function updateMap() : void { }
            private function __showMap(evt:LoaderEvent) : void { }
            protected function updateDropList() : void { }
            private function __dropListLarge(evt:Event) : void { }
            private function __dropListSmall(evt:Event) : void { }
            protected function solvePath() : String { return null; }
            public function dispose() : void { }
   }}