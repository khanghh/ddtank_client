package accumulativeLogin.view{   import accumulativeLogin.AccumulativeManager;   import accumulativeLogin.data.AccumulativeLoginRewardData;   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.filters.ColorMatrixFilter;   import flash.utils.Dictionary;      public class AccumulativeLoginView extends Sprite   {                   private var _back:Bitmap;            private var _progressBarBack:Bitmap;            private var _progressBar:Bitmap;            private var _progressBarItemArr:Array;            private var _clickSpriteArr:Array;            private var _progressCompleteItem:MovieClip;            private var _dayTxtArr:Array;            private var _loginDayTxt:FilterFrameText;            private var _loginDayNum:int;            private var _awardDayNum:int;            private var _hBox:HBox;            private var _dataDic:Dictionary;            private var _selectedDay:int;            private var _selectedFiveWeaponId:int;            private var _dayGiftPackDic:Dictionary;            private var _fiveWeaponArr:Array;            private var _bagCellBgArr:Array;            private var _filter:ColorMatrixFilter;            private var _movieStringArr:Array;            private var _movieVector:Vector.<AccumulativeMovieSprite>;            private var _getButton:SimpleBitmapButton;            public function AccumulativeLoginView() { super(); }
            public function setState(type:int, id:int) : void { }
            public function init() : void { }
            private function createFilter() : void { }
            public function initEvent() : void { }
            protected function __refreshAward(event:Event) : void { }
            private function initView() : void { }
            protected function __showAwardHandler(event:MouseEvent) : void { }
            protected function __onClickHandler(event:MouseEvent) : void { }
            protected function __onOverHandler(event:MouseEvent) : void { }
            private function checkMovieCanClick() : void { }
            private function initData() : void { }
            private function initViewWithData() : void { }
            private function __getAward(event:MouseEvent) : void { }
            private function set selectedDay(value:int) : void { }
            private function graySp(sp:Sprite) : void { }
            private function get selectedDay() : int { return 0; }
            private function createBagCellSp(data:AccumulativeLoginRewardData, index:int) : Sprite { return null; }
            public function content() : Sprite { return null; }
            public function dispose() : void { }
   }}