package labyrinth.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.CheckWeaponManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import ddtBuried.BuriedManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import labyrinth.LabyrinthManager;   import labyrinth.model.LabyrinthModel;   import shop.view.BuySingleGoodsView;   import trainer.view.NewHandContainer;      public class LabyrinthFrame extends BaseAlerFrame   {                   private var _bg:ScaleBitmapImage;            private var _rightBg:Bitmap;            private var _leftBg:ScaleFrameImage;            private var _btnGroup:SelectedButtonGroup;            private var _warriorBtn:SelectedButton;            private var _nightmareBtn:SelectedButton;            private var _content:Sprite;            private var _startGameBtn:SimpleBitmapButton;            private var _continueBtn:SimpleBitmapButton;            private var _cleanOutBtn:SimpleBitmapButton;            private var _continueCleanOutBtn:SimpleBitmapButton;            private var _resetBtn:SimpleBitmapButton;            private var _rankingBtn:SimpleBitmapButton;            private var _shopBtn:SimpleBitmapButton;            private var _helpBtn:SimpleBitmapButton;            private var _myRanking:Bitmap;            private var _myRankingText:FilterFrameText;            private var _myProgress:Bitmap;            private var _myProgressText:FilterFrameText;            private var _titleList:SimpleTileList;            private var _doubleAward:SelectedCheckButton;            private var _todayNum:Bitmap;            private var _todayNumText:FilterFrameText;            private var _explain:FilterFrameText;            private var _explainII:FilterFrameText;            private var _currentFloor:FilterFrameText;            private var _currentFloorNum:FilterFrameText;            private var _accumulateExp:FilterFrameText;            private var _accumulateExpNum:FilterFrameText;            private var _buySingleGoodsView:BuySingleGoodsView;            private var _isDoubleAward:Boolean = true;            private var _cleanOutContainer:Sprite;            private var _startContainer:Sprite;            private var _serverDoubleIcon:Bitmap;            private var _clickDate:Number = 0;            public function LabyrinthFrame() { super(); }
            override protected function init() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function creatBox() : void { }
            protected function __updateInfo(event:Event) : void { }
            private function updataState() : void { }
            protected function openShop() : void { }
            protected function openRanking() : void { }
            protected function __frameEvent(event:FrameEvent) : void { }
            protected function set btnState(value:Boolean) : void { }
            protected function startGame() : void { }
            protected function continueGame() : void { }
            private function openCleanOutFrame() : void { }
            protected function cleanOut() : void { }
            protected function continueCleanOut() : void { }
            protected function doubleChange() : void { }
            private function buy() : void { }
            protected function reset() : void { }
            protected function __onAlertResponse(event:FrameEvent) : void { }
            protected function __onBtnClick(event:MouseEvent) : void { }
            public function show() : void { }
            private function __changeHandler(event:Event) : void { }
            private function isNightmare() : Boolean { return false; }
            private function __helpClick(event:MouseEvent) : void { }
            override public function dispose() : void { }
   }}