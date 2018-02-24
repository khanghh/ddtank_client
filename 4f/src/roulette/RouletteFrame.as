package roulette
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.view.roulette.TurnSoundControl;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import wonderfulActivity.WonderfulActivityManager;
   
   public class RouletteFrame extends Sprite implements Disposeable
   {
      
      public static const TYPE_SPEED_UP:int = 1;
      
      public static const TYPE_SPEED_UNCHANGE:int = 2;
      
      public static const TYPE_SPEED_DOWN:int = 3;
      
      public static const SHADOW_NUMBER:int = 1;
      
      public static const DOWN_SUB_SHADOW_BOL:int = 3;
      
      public static const GLINT_ONE_TIME:int = 3000;
      
      public static const SPEEDUP_RATE:int = -70;
      
      public static const SPEEDDOWN_RATE:int = 40;
      
      public static const MINTIME_PLAY_SOUNDONESTEP:int = 30;
      
      public static const PLAY_SOUNDTHREESTEP_NUMBER:int = 14;
      
      private static const ESCkeyCode:int = 27;
       
      
      private var _rouletteBG:Bitmap;
      
      private var _rechargeableBG:Bitmap;
      
      private var _recurBG:Bitmap;
      
      private var _goodsList:Vector.<RouletteCell>;
      
      private var _glintView:LeftRouletteGlintView;
      
      private var _pointArray:Array;
      
      private var _pointNumArr:Array;
      
      private var _isStopTurn:Boolean = false;
      
      private var _turnSlectedNumber:int;
      
      private var _timer:Timer;
      
      private var _moderationNumber:int = 0;
      
      private var _nowDelayTime:int = 1000;
      
      private var _turnType:int = 1;
      
      private var _delay:Array;
      
      private var _moveTime:Array;
      
      private var _selectedGoodsNumber:int = 0;
      
      private var _turnTypeTimeSum:int = 0;
      
      private var _stepTime:int = 0;
      
      private var _startModerationNumber:int = 0;
      
      private var _arrNum:Array;
      
      private var _close:SelectedButton;
      
      private var _help:SelectedButton;
      
      private var _start:SelectedButton;
      
      private var _exchange:SelectedButton;
      
      private var _numbmpVec:Vector.<Bitmap>;
      
      private var _pointLength:Array;
      
      private var _sound:TurnSoundControl;
      
      private var _mask:Sprite;
      
      private var _endDayBg:Bitmap;
      
      private var _endDayTitle:Bitmap;
      
      private var _endDayTxt:FilterFrameText;
      
      private var _endDayTimer:Timer;
      
      private var _isSend:Boolean;
      
      private var _sparkleNumber:int = 0;
      
      public function RouletteFrame(){super();}
      
      private function initView() : void{}
      
      private function updateServerTime(param1:TimerEvent = null) : void{}
      
      private function initEvent() : void{}
      
      private function __keyDownHandler(param1:KeyboardEvent) : void{}
      
      private function getAllGoodsPoint() : void{}
      
      private function getAllNumPoint() : void{}
      
      private function test(param1:int, param2:String) : void{}
      
      private function _getItem(param1:PkgEvent) : void{}
      
      public function addMask() : void{}
      
      public function removeMask() : void{}
      
      private function onMaskClick(param1:MouseEvent) : void{}
      
      private function isSendNotice(param1:String) : Boolean{return false;}
      
      private function _timeComplete(param1:TimerEvent) : void{}
      
      private function __startHandler(param1:MouseEvent) : void{}
      
      private function __exchangeHandler(param1:MouseEvent) : void{}
      
      private function __closeHandler(param1:MouseEvent) : void{}
      
      private function updateTurnType(param1:int) : void{}
      
      private function startTimer(param1:int) : void{}
      
      private function nextNode() : void{}
      
      private function turnPlate(param1:int, param2:int = 1) : void{}
      
      private function startTurn() : void{}
      
      private function stopTurn() : void{}
      
      private function _turnComplete() : void{}
      
      private function clearPrevSelct(param1:int, param2:int) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
      
      public function get turnSlectedNumber() : int{return 0;}
      
      public function set turnSlectedNumber(param1:int) : void{}
      
      public function set sparkleNumber(param1:int) : void{}
      
      public function get sparkleNumber() : int{return 0;}
      
      public function set nowDelayTime(param1:int) : void{}
      
      public function get nowDelayTime() : int{return 0;}
      
      public function set turnType(param1:int) : void{}
      
      public function get turnType() : int{return 0;}
      
      public function set selectedGoodsNumber(param1:int) : void{}
      
      private function get prevSelected() : int{return 0;}
   }
}
