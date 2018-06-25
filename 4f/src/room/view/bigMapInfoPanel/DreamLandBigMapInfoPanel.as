package room.view.bigMapInfoPanel{   import com.pickgliss.loader.DisplayLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.RoomEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.view.MainToolBar;   import ddt.view.SelectStateButton;   import dreamlandChallenge.DreamlandChallengeControl;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.TimerEvent;   import flash.utils.Timer;   import room.RoomManager;   import room.model.RoomInfo;      public class DreamLandBigMapInfoPanel extends Sprite implements Disposeable   {                   protected var _bg:MutipleImage;            protected var _smallBg:Bitmap;            protected var _titleIcon:ScaleFrameImage;            protected var _timeTxt:FilterFrameText;            protected var _timer:Timer;            protected var _info:RoomInfo;            protected var _mapShowContainer:Sprite;            protected var _loader:DisplayLoader;            protected var _modeContainer:Sprite;            protected var _freeModeBtn:SelectStateButton;            protected var _desc:FilterFrameText;            protected var _requireTxt:FilterFrameText;            public function DreamLandBigMapInfoPanel() { super(); }
            protected function initView() : void { }
            protected function __onMapChanged(evt:RoomEvent) : void { }
            protected function updateMap() : void { }
            private function __showMap(evt:LoaderEvent) : void { }
            protected function solvePath() : String { return null; }
            protected function initMode() : void { }
            protected function __startedHandler(evt:RoomEvent) : void { }
            private function updateView() : void { }
            protected function __timer(evt:TimerEvent) : void { }
            protected function removeEvents() : void { }
            public function dispose() : void { }
   }}