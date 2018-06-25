package room.view.bigMapInfoPanel{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.RoomEvent;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.MainToolBar;   import ddt.view.SelectStateButton;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import room.RoomManager;   import room.model.RoomInfo;      public class MatchRoomBigMapInfoPanel extends Sprite implements Disposeable   {                   private var _bg:MutipleImage;            private var _png:Bitmap;            private var _info:RoomInfo;            private var _guildModeBtn:SelectStateButton;            private var _freeModeBtn:SelectStateButton;            private var _smallBg:Bitmap;            private var _gameModeIcon:ScaleFrameImage;            private var _matchingPic:Bitmap;            private var _timeTxt:FilterFrameText;            private var _timer:Timer;            private var _eliteGame:Bitmap;            private var _battleGame:Bitmap;            private var _eliteGameTimer:Timer;            private var _eliteTime:int;            private var _teamBattle:Bitmap;            public function MatchRoomBigMapInfoPanel() { super(); }
            protected function initView() : void { }
            private function setPngBitmap() : void { }
            public function set info(value:RoomInfo) : void { }
            private function __eliteGameTimerHandler(event:TimerEvent) : void { }
            private function __update(evt:RoomEvent) : void { }
            private function __startedHandler(evt:RoomEvent) : void { }
            private function __timer(evt:TimerEvent) : void { }
            private function updateView() : void { }
            private function updateBtns() : void { }
            private function __freeClickHandler(evt:MouseEvent) : void { }
            private function __guildClickHandler(evt:MouseEvent) : void { }
            private function removeEvents() : void { }
            public function dispose() : void { }
   }}