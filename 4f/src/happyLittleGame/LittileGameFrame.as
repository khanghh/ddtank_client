package happyLittleGame{   import com.pickgliss.loader.QueueLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.utils.ObjectUtils;   import ddt.loader.LoaderCreate;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import flash.events.Event;   import flash.events.MouseEvent;   import happyLittleGame.bombshellGame.view.BombGameView;   import happyLittleGame.bombshellGame.view.LittleGameEntranceView;   import uiModeManager.bombUI.HappyLittleGameManager;      public class LittileGameFrame extends Frame   {                   private var _helpBtn:SimpleBitmapButton;            private var _enterView:LittleGameEntranceView;            private var _gameView:BombGameView;            public function LittileGameFrame() { super(); }
            override protected function init() : void { }
            private function LoadMapData() : void { }
            private function initEvent() : void { }
            private function __helpBtnClickHandler(evt:MouseEvent) : void { }
            private function __enterGameHandler(evt:Event) : void { }
            private function __backGameHandler(evt:Event) : void { }
            private function removeEvent() : void { }
            override protected function addChildren() : void { }
            public function show() : void { }
            override protected function onResponse(type:int) : void { }
            override public function dispose() : void { }
   }}