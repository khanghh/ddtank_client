package braveDoor.view{   import bagAndInfo.info.PlayerInfoViewControl;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.events.RoomEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.view.common.LevelIcon;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import room.RoomManager;   import room.events.RoomPlayerEvent;   import room.model.RoomPlayer;      public class DuplicateTemRoomItemView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _levelIcon:LevelIcon;            private var _addFriendBtn:SimpleBitmapButton;            private var _kickOutBtn:SimpleBitmapButton;            private var _playerInfoBtn:SimpleBitmapButton;            private var _fightTxt:FilterFrameText;            private var _nameTxt:FilterFrameText;            private var _readyIcon:Bitmap;            private var _hostIcon:Bitmap;            private var _info:RoomPlayer;            private var _place:int;            public function DuplicateTemRoomItemView(place:int = 0) { super(); }
            private function initView() : void { }
            public function set info(info:RoomPlayer) : void { }
            public function get info() : RoomPlayer { return null; }
            private function updateView() : void { }
            private function updateButtons() : void { }
            private function updatePlayerState() : void { }
            private function updateInfoView() : void { }
            private function __infoStateChange(evt:RoomPlayerEvent) : void { }
            private function __addFriendHandler(evt:MouseEvent) : void { }
            private function __kickOutHandler(evt:MouseEvent) : void { }
            private function __startHandler(evt:RoomEvent) : void { }
            private function __updateButton(evt:RoomPlayerEvent) : void { }
            private function initEvents() : void { }
            private function removeEvent() : void { }
            private function __playerInfoClickHandler(evt:MouseEvent) : void { }
            public function dispose() : void { }
   }}