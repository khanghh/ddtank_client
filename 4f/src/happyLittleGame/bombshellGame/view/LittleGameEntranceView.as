package happyLittleGame.bombshellGame.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import funnyGames.FunnyGamesManager;   import funnyGames.cubeGame.CubeGameManager;   import funnyGames.event.FunnyGamesEvent;   import happyLittleGame.GameCardLogicView;   import happyLittleGame.LittleGameDayNewsView;   import uiModeManager.bombUI.HappyLittleGameManager;   import uiModeManager.bombUI.event.HappyLittleGameEvent;      public class LittleGameEntranceView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _promptTxt:FilterFrameText;            private var _promptTxtII:FilterFrameText;            private var _createRoomBtn:SimpleBitmapButton;            private var _enterGameBtn:SimpleBitmapButton;            private var _dayNewsView:LittleGameDayNewsView;            private var _rankView:BombGameRankView;            private var _cardlogicView:GameCardLogicView;            public function LittleGameEntranceView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function __updateView(evt:FunnyGamesEvent) : void { }
            private function __startGameHandler(pkg:PkgEvent) : void { }
            private function __refreshRankHandler(evt:Event) : void { }
            public function __enterRoomHandler(pkg:PkgEvent) : void { }
            public function refreshRank() : void { }
            private function __enterGameHandler(evt:MouseEvent) : void { }
            public function dispose() : void { }
   }}