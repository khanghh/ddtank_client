package store.view.exalt{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.greensock.TweenMax;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.QuickBuyAlertBase;   import ddt.command.QuickBuyFrame;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.utils.Dictionary;   import flash.utils.Timer;   import flash.utils.getTimer;   import flash.utils.setTimeout;   import store.IStoreViewBG;   import store.StoneCell;   import store.StoreCell;   import store.StoreDragInArea;   import store.StrengthDataManager;   import store.data.StoreEquipExperience;   import store.events.StoreIIEvent;   import store.view.strength.StrengthStone;      public class StoreExaltBG extends Sprite implements IStoreViewBG   {            public static const INTERVAL:int = 1400;                   private var _titleBG:Bitmap;            private var _buyBtn:SimpleBitmapButton;            private var _exaltBtn:BaseButton;            private var _progressBar:StoreExaltProgressBar;            private var _equipmentCellBg:Image;            private var _goodCellBg:Bitmap;            private var _equipmentCellText:FilterFrameText;            private var _rockText:FilterFrameText;            private var _pointArray:Vector.<Point>;            private var _area:StoreDragInArea;            private var _items:Array;            private var _quick:QuickBuyFrame;            private var _continuous:SelectedCheckButton;            private var _timer:Timer;            private var _helpBtn:BaseButton;            private var _movieI:MovieClip;            private var _movieII:MovieClip;            private var _luckyText:FilterFrameText;            private var _restoreBtn:SimpleBitmapButton;            private var _price:int;            private var _lastExaltTime:int = 0;            private var _aler:ExaltSelectNumAlertFrame;            public function StoreExaltBG() { super(); }
            private function init() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            protected function __exaltFinish(event:StoreIIEvent) : void { }
            private function __onRestoreClick(e:MouseEvent) : void { }
            private function __onRestoreResponse(e:FrameEvent) : void { }
            protected function __exaltFail(event:StoreIIEvent) : void { }
            private function onComplete() : void { }
            protected function __frameEvent(event:FrameEvent) : void { }
            protected function __continuousClick(event:MouseEvent) : void { }
            private function disposeTimer() : void { }
            protected function __onRepeatCount(event:TimerEvent) : void { }
            protected function __onBuyClick(event:MouseEvent) : void { }
            protected function __onExaltClick(event:MouseEvent) : void { }
            private function sendContinuousExalt() : void { }
            private function sendExalt() : void { }
            private function isExalt() : Boolean { return false; }
            private function getCellsPoint() : void { }
            protected function __itemInfoChange(event:Event) : void { }
            private function showSuccessMovie() : void { }
            private function __onSuccessMovieComplete(e:Event) : void { }
            private function disposeSuccessMovie() : void { }
            private function showExaltMovie() : void { }
            private function disposeExaltMovie() : void { }
            private function __onExaltMovieIIComplete(e:Event) : void { }
            private function buyRock() : void { }
            public function dragDrop(source:BagCell) : void { }
            private function showNumAlert(info:InventoryItemInfo, index:int) : void { }
            private function sellFunction(_nowNum:int, goodsinfo:InventoryItemInfo, index:int) : void { }
            private function notSellFunction() : void { }
            private function isAdaptToStone(info:InventoryItemInfo) : Boolean { return false; }
            private function equipisAdapt(info:InventoryItemInfo) : Boolean { return false; }
            public function refreshData(items:Dictionary) : void { }
            public function updateData() : void { }
            public function hide() : void { }
            public function show() : void { }
            public function dispose() : void { }
   }}