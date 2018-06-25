package happyLittleGame.bombshellGame.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import uiModeManager.bombUI.HappyLittleGameManager;      public class BombGameRankView extends Sprite implements Disposeable   {                   private var _bgBottom:ScaleBitmapImage;            private var _selectDayRank:SelectedButton;            private var _selectTotalRank:SelectedButton;            private var _fixRankView:BombGameFixRank;            private var _randomRankView:BombGameRandomRank;            private var _myTotalRank:FilterFrameText;            private var _myDayRank:FilterFrameText;            private var _HistoryMaxPoints:FilterFrameText;            private var _dayMaxPoints:FilterFrameText;            private var _rankBtn:SimpleBitmapButton;            private var _currentSelectRank:int = 2;            public function BombGameRankView() { super(); }
            private function initView() : void { }
            public function setRankData() : void { }
            private function initEvent() : void { }
            private function onRankClick(evt:MouseEvent) : void { }
            public function reFreshRank() : void { }
            private function removeEvent() : void { }
            private function __dayclickhandler(evt:MouseEvent) : void { }
            private function __totalclickhandler(evt:MouseEvent) : void { }
            public function dispose() : void { }
   }}