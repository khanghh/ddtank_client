package godCardRaise.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.ComboBox;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.list.VectorListModel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.ConfirmAlertData;   import ddt.utils.ConfirmAlertHelper;   import ddt.utils.HelperBuyAlert;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.FocusEvent;   import flash.events.MouseEvent;   import godCardRaise.GodCardRaiseManager;   import godCardRaise.info.GodCardListInfo;      public class GodCardRaiseDivineView extends Sprite implements Disposeable   {            public static const OPENCARDLOCK_CHANGE:String = "openCardLockChange";            public static const MAX_INPUT:int = 999;            public static const MIN_INPUT:int = 1;                   private var _bg:MutipleImage;            private var _divineBtn:BaseButton;            private var _manyDivineBtn:BaseButton;            private var _freeCountBg:Bitmap;            private var _freeCountTxt:FilterFrameText;            private var _buyCount:int = 1;            private var _buyMoney:int = 0;            private var _openCardsMovie:MovieClip;            private var _cardsLoader:GodCardRaiseDivineCardsLoader;            private var _openCardLock:Boolean = false;            private var _selectedBtn:SelectedCheckButton;            protected var _selectedCB:ComboBox;            private var godcardLevels:Array;            public var continueOpen:int = 0;            private var _inputSelectedBtn:SelectedCheckButton;            private var _inputBg:Bitmap;            private var _inputText:FilterFrameText;            private var _inputValue:String;            private var _isContinuous:Boolean;            private var _isContinuousBind:Boolean;            private var needMoney:int;            private var _currentCards:Array;            private var _card1:MovieClip;            private var _card2:MovieClip;            private var _card3:MovieClip;            private var _card4:MovieClip;            private var _card5:MovieClip;            public function GodCardRaiseDivineView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function __selectedClickHandler(pEvent:Event) : void { }
            private function setButtonFrame($btn:BaseButton, $frameIndex:int) : void { }
            private function getButtonCurrentFrame($btn:BaseButton) : int { return 0; }
            private function __onListClicked(e:ListItemEvent) : void { }
            private function showFreeCount() : void { }
            private function get freeCount() : int { return 0; }
            private function __divineClickHandler(event:MouseEvent) : void { }
            private function selectedContinuous(num:int) : void { }
            private function __onContinuous(e:FrameEvent) : void { }
            private function isMoney(num:int) : Boolean { return false; }
            private function __manyDivineClickHandler(event:MouseEvent) : void { }
            private function buyAlert() : void { }
            private function sendOpenCard(buyCount:int, isBind:Boolean, isSpecial:Boolean = false) : void { }
            public function set openCardLock(value:Boolean) : void { }
            public function get openCardLock() : Boolean { return false; }
            public function playCardMovie($cards:Array) : void { }
            private function playEndMovie() : void { }
            private function showNoMoeny() : void { }
            protected function __onNoMoeny(event:FrameEvent) : void { }
            private function loaderCardsComplete() : void { }
            private function exeScriptHandler() : void { }
            private function cardScript1() : void { }
            private function cardScript2() : void { }
            private function cardScript3() : void { }
            private function cardScript4() : void { }
            private function cardScript5() : void { }
            private function clearMovie($movie:MovieClip) : void { }
            private function addCardToMovie($movie:MovieClip, $cardId:int) : void { }
            public function updateView() : void { }
            private function __clickInput(e:MouseEvent) : void { }
            protected function __inputTextFousIn(event:FocusEvent) : void { }
            protected function __inputTextFousOut(event:FocusEvent) : void { }
            private function __inputChange(event:Event) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}