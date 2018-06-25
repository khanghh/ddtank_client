package roulette{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.HelpFrameUtils;   import ddt.view.roulette.TurnSoundControl;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.utils.Timer;   import road7th.comm.PackageIn;   import wonderfulActivity.WonderfulActivityManager;      public class RouletteFrame extends Sprite implements Disposeable   {            public static const TYPE_SPEED_UP:int = 1;            public static const TYPE_SPEED_UNCHANGE:int = 2;            public static const TYPE_SPEED_DOWN:int = 3;            public static const SHADOW_NUMBER:int = 1;            public static const DOWN_SUB_SHADOW_BOL:int = 3;            public static const GLINT_ONE_TIME:int = 3000;            public static const SPEEDUP_RATE:int = -70;            public static const SPEEDDOWN_RATE:int = 40;            public static const MINTIME_PLAY_SOUNDONESTEP:int = 30;            public static const PLAY_SOUNDTHREESTEP_NUMBER:int = 14;            private static const ESCkeyCode:int = 27;                   private var _rouletteBG:Bitmap;            private var _rechargeableBG:Bitmap;            private var _recurBG:Bitmap;            private var _goodsList:Vector.<RouletteCell>;            private var _glintView:LeftRouletteGlintView;            private var _pointArray:Array;            private var _pointNumArr:Array;            private var _isStopTurn:Boolean = false;            private var _turnSlectedNumber:int;            private var _timer:Timer;            private var _moderationNumber:int = 0;            private var _nowDelayTime:int = 1000;            private var _turnType:int = 1;            private var _delay:Array;            private var _moveTime:Array;            private var _selectedGoodsNumber:int = 0;            private var _turnTypeTimeSum:int = 0;            private var _stepTime:int = 0;            private var _startModerationNumber:int = 0;            private var _arrNum:Array;            private var _close:SelectedButton;            private var _help:SelectedButton;            private var _start:SelectedButton;            private var _exchange:SelectedButton;            private var _numbmpVec:Vector.<Bitmap>;            private var _pointLength:Array;            private var _sound:TurnSoundControl;            private var _mask:Sprite;            private var _endDayBg:Bitmap;            private var _endDayTitle:Bitmap;            private var _endDayTxt:FilterFrameText;            private var _endDayTimer:Timer;            private var _isSend:Boolean;            private var _sparkleNumber:int = 0;            public function RouletteFrame() { super(); }
            private function initView() : void { }
            private function updateServerTime(evt:TimerEvent = null) : void { }
            private function initEvent() : void { }
            private function __keyDownHandler(event:KeyboardEvent) : void { }
            private function getAllGoodsPoint() : void { }
            private function getAllNumPoint() : void { }
            private function test(num:int, str:String) : void { }
            private function _getItem(event:PkgEvent) : void { }
            public function addMask() : void { }
            public function removeMask() : void { }
            private function onMaskClick(event:MouseEvent) : void { }
            private function isSendNotice(str:String) : Boolean { return false; }
            private function _timeComplete(e:TimerEvent) : void { }
            private function __startHandler(event:MouseEvent) : void { }
            private function __exchangeHandler(event:MouseEvent) : void { }
            private function __closeHandler(event:MouseEvent) : void { }
            private function updateTurnType(value:int) : void { }
            private function startTimer(time:int) : void { }
            private function nextNode() : void { }
            private function turnPlate(_select:int, type:int = 1) : void { }
            private function startTurn() : void { }
            private function stopTurn() : void { }
            private function _turnComplete() : void { }
            private function clearPrevSelct(now:int, prev:int) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
            public function get turnSlectedNumber() : int { return 0; }
            public function set turnSlectedNumber(value:int) : void { }
            public function set sparkleNumber(value:int) : void { }
            public function get sparkleNumber() : int { return 0; }
            public function set nowDelayTime(value:int) : void { }
            public function get nowDelayTime() : int { return 0; }
            public function set turnType(value:int) : void { }
            public function get turnType() : int { return 0; }
            public function set selectedGoodsNumber(value:int) : void { }
            private function get prevSelected() : int { return 0; }
   }}