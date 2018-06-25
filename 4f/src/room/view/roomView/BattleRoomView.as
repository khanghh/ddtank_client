package room.view.roomView{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.RoomEvent;   import ddt.manager.CheckWeaponManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.Timer;   import room.model.RoomInfo;   import room.model.RoomPlayer;   import room.view.BattleRoomRightPropView;   import room.view.RoomPlayerItem;   import room.view.bigMapInfoPanel.MatchRoomBigMapInfoPanel;   import room.view.smallMapInfoPanel.MatchRoomSmallMapInfoPanel;      public class BattleRoomView extends BaseRoomView   {                   private var _timerII:Timer;            protected var _crossZoneBtn:SelectedButton;            protected var _bg:MovieClip;            protected var _itemListBg:MovieClip;            protected var _bigMapInfoPanel:MatchRoomBigMapInfoPanel;            protected var _smallMapInfoPanel:MatchRoomSmallMapInfoPanel;            private var _playerItemContainer:SimpleTileList;            protected var _battleRoomProView:BattleRoomRightPropView;            public function BattleRoomView(info:RoomInfo) { super(null); }
            override protected function initView() : void { }
            override protected function __startHandler(evt:RoomEvent) : void { }
            override protected function updateButtons() : void { }
            override protected function initTileList() : void { }
            override protected function __addPlayer(evt:RoomEvent) : void { }
            override protected function __removePlayer(evt:RoomEvent) : void { }
            override protected function __startClick(evt:MouseEvent) : void { }
            protected function startCheckWeaponComplete(... args) : void { }
            override protected function __prepareClick(evt:MouseEvent) : void { }
            protected function checkWeaponFragment(callFun:Function) : Boolean { return false; }
            protected function proCheckWeaponComplete(... args) : void { }
            override public function dispose() : void { }
   }}