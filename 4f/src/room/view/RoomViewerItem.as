package room.view{   import bagAndInfo.info.PlayerInfoViewControl;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.RoomEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerTipManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.MainToolBar;   import ddt.view.PlayerPortraitView;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import gameCommon.GameControl;   import gameCommon.model.GameInfo;   import room.RoomManager;   import room.events.RoomPlayerEvent;   import room.model.RoomPlayer;      public class RoomViewerItem extends Sprite implements Disposeable   {            public static const LONG:uint = 186;            public static const SHORT:uint = 90;                   private var _bg:Bitmap;            private var _bgWidth:int;            private var _waitingBitmap:Bitmap;            private var _closeBitmap:Bitmap;            private var _headFigureFrame:Bitmap;            private var _info:RoomPlayer;            private var _portrait:PlayerPortraitView;            private var _kickOutBtn:SimpleBitmapButton;            private var _viewInfoBtn:SimpleBitmapButton;            private var _addFriendBtn:SimpleBitmapButton;            private var _nameTxt:FilterFrameText;            private var _place:int;            private var _opened:Boolean;            private var _loadingMode:Boolean;            public function RoomViewerItem(place:int = 8, widthType:uint = 186) { super(); }
            private function init() : void { }
            public function changeBg() : void { }
            public function set opened(value:Boolean) : void { }
            public function set loadingMode(value:Boolean) : void { }
            private function setCenterPos(display:DisplayObject) : void { }
            public function get info() : RoomPlayer { return null; }
            public function set info(info:RoomPlayer) : void { }
            private function __infoStateChange(event:RoomPlayerEvent) : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function __updateBtns(e:Event) : void { }
            private function __changePlace(event:MouseEvent) : void { }
            private function __clickHandler(e:MouseEvent) : void { }
            public function dispose() : void { }
   }}