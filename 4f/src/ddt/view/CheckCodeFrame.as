package ddt.view
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.CheckCodeData;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.FilterWordManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class CheckCodeFrame extends BaseAlerFrame
   {
      
      private static var _instance:CheckCodeFrame;
       
      
      private const BACK_GOUND_GAPE:int = 3;
      
      private var _time:int;
      
      private var _bgI:Bitmap;
      
      private var _bgII:Scale9CornerImage;
      
      private var _isShowed:Boolean = true;
      
      private var _inputArr:Array;
      
      private var _input:String;
      
      private var _countDownTxt:FilterFrameText;
      
      private var _secondTxt:FilterFrameText;
      
      private var coutTimer:Timer;
      
      private var coutTimer_1:Timer;
      
      private var checkCount:int = 0;
      
      private var _alertInfo:AlertInfo;
      
      private var okBtn:BaseButton;
      
      private var clearBtn:BaseButton;
      
      private var _numberArr:Array;
      
      private var _numViewArr:Array;
      
      private var _NOBtnIsOver:Boolean = false;
      
      private var _cheatTime:uint = 0;
      
      private var speed:Number = 10;
      
      private var currentPic:Bitmap;
      
      private var _showTimer:Timer;
      
      private var count:int;
      
      public function CheckCodeFrame(){super();}
      
      public static function get Instance() : CheckCodeFrame{return null;}
      
      private function __LoadCore2Complete(param1:UIModuleEvent) : void{}
      
      private function __LoadCore2Error(param1:UIModuleEvent) : void{}
      
      private function initCheckCodeFrame() : void{}
      
      public function get time() : int{return 0;}
      
      public function set time(param1:int) : void{}
      
      private function clicknumSp(param1:MouseEvent) : void{}
      
      private function overnumSp(param1:MouseEvent) : void{}
      
      private function outnumSp(param1:MouseEvent) : void{}
      
      private function setnumViewCoord() : void{}
      
      private function math_z(param1:Object) : void{}
      
      private function inFrameStart(param1:Event) : void{}
      
      public function set data(param1:CheckCodeData) : void{}
      
      private function __onTimeComplete(param1:TimerEvent) : void{}
      
      private function __onTimeComplete_1(param1:TimerEvent) : void{}
      
      private function textChange() : void{}
      
      private function haveValidText() : Boolean{return false;}
      
      private function isValidText() : Boolean{return false;}
      
      public function set tip(param1:String) : void{}
      
      public function show() : void{}
      
      private function __show(param1:TimerEvent) : void{}
      
      private function popup() : void{}
      
      public function close() : void{}
      
      override protected function __onAddToStage(param1:Event) : void{}
      
      private function __okBtnClick(param1:MouseEvent) : void{}
      
      private function __clearBtnClick(param1:MouseEvent) : void{}
      
      private function __resposeHandler(param1:KeyboardEvent) : void{}
      
      private function sendSelected() : void{}
      
      private function restartTimer() : void{}
      
      public function get isShowed() : Boolean{return false;}
      
      public function set isShowed(param1:Boolean) : void{}
   }
}
