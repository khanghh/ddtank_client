package roomList.pvpRoomList{   import LimitAward.LimitAwardButton;   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ComboBox;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.controls.list.VectorListModel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.CheckWeaponManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.utils.getTimer;   import road7th.data.DictionaryEvent;   import room.RoomManager;   import room.model.RoomInfo;   import roomList.RoomListEnumerate;   import serverlist.view.RoomListServerDropList;      public class RoomListBGView extends Sprite implements Disposeable   {            public static var PREWORD:Array = [LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreatePveRoomView.tank"),LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreatePveRoomView.go"),LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreatePveRoomView.fire")];            public static const FULL_MODE:int = 0;            public static const ATHLETICS_MODE:int = 1;            public static const CHALLENGE_MODE:int = 2;                   private var _bottom:ScaleBitmapImage;            private var _roomListBG:Bitmap;            private var _listTitle:Bitmap;            private var _nextBtn:SimpleBitmapButton;            private var _preBtn:SimpleBitmapButton;            private var _createBtn:SimpleBitmapButton;            private var _rivalshipBtn:SimpleBitmapButton;            private var _lookUpView:RoomLookUpView;            private var _encounterBtn:SimpleBitmapButton;            private var _itemList:SimpleTileList;            private var _itemArray:Array;            private var _model:RoomListModel;            private var _controller:RoomListController;            private var _limitAwardButton:LimitAwardButton;            private var _serverlist:RoomListServerDropList;            private var _tempDataList:Array;            private var _modeMenu:ComboBox;            private var _currentMode:int;            private var _isPermissionEnter:Boolean;            private var _modeArray:Array;            private var _selectItemPos:int;            private var _selectItemID:int;            private var _lastCreatTime:int = 0;            public function RoomListBGView(controller:RoomListController, model:RoomListModel) { super(); }
            private function init() : void { }
            private function initButton() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __updateItem(event:Event) : void { }
            private function __onListClick(event:ListItemEvent) : void { }
            private function getCurrentMode(value:String) : int { return 0; }
            private function addTipPanel() : void { }
            private function __clearRoom(event:DictionaryEvent) : void { }
            private function updateList() : void { }
            private function cleanItem() : void { }
            private function __itemClick(event:MouseEvent) : void { }
            private function getSelectItemPos(id:int) : int { return 0; }
            public function get currentDataList() : Array { return null; }
            private function getInfosPos(id:int) : int { return 0; }
            private function upadteItemPos() : void { }
            private function sortRooInfo(roomInfos:Array) : Array { return null; }
            private function gotoTip(type:int) : Boolean { return false; }
            public function gotoIntoRoom(info:RoomInfo) : void { }
            private function _rivalshipClick(event:MouseEvent) : void { }
            private function __updateClick(event:MouseEvent) : void { }
            private function __placeCountClick(event:MouseEvent) : void { }
            private function __hardLevelClick(event:MouseEvent) : void { }
            private function __roomModeClick(event:MouseEvent) : void { }
            private function __roomNameClick(event:MouseEvent) : void { }
            private function __idBtnClick(event:MouseEvent) : void { }
            public function sendUpdate() : void { }
            private function __createBtnClick(evt:MouseEvent) : void { }
            protected function __encounterBtnClick(event:MouseEvent) : void { }
            public function openMatch() : void { }
            public function dispose() : void { }
   }}