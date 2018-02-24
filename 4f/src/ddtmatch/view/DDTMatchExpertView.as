package ddtmatch.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddtmatch.data.AwardInfo;
   import ddtmatch.data.DDTMatchQuestionInfo;
   import ddtmatch.event.DDTMatchEvent;
   import ddtmatch.manager.DDTMatchManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   
   public class DDTMatchExpertView extends Sprite implements Disposeable
   {
      
      private static var SELECT_NUM:int = 4;
       
      
      private var _bg:Bitmap;
      
      private var _winBtn:SimpleBitmapButton;
      
      private var _excludeBtn:SimpleBitmapButton;
      
      private var _doubleBtn:SimpleBitmapButton;
      
      private var _winTxt:FilterFrameText;
      
      private var _excludeTxt:FilterFrameText;
      
      private var _doubleTxt:FilterFrameText;
      
      private var _red1:Bitmap;
      
      private var _red2:Bitmap;
      
      private var _red3:Bitmap;
      
      private var _activityTimeTxt:FilterFrameText;
      
      private var _myrankTxt:FilterFrameText;
      
      private var _myscoreTxt:FilterFrameText;
      
      private var curQuesitionNum:FilterFrameText;
      
      private var curQuesitionCD:FilterFrameText;
      
      private var _question:FilterFrameText;
      
      private var _answer:FilterFrameText;
      
      private var _selectVec:Vector.<MovieImage>;
      
      private var _resultMovie:MovieClip;
      
      private var _totalQuestionNum:int;
      
      private var _doublePrice:int;
      
      private var _hitPrice:int;
      
      private var _excludePrice:int;
      
      private var _doubleFreeCount:int;
      
      private var _hitFreeCount:int;
      
      private var _excludeFreeCount:int;
      
      private var _alertAsk:DDTMatchAlertView;
      
      private var _rankVec:Vector.<DDTMatchExpertItem>;
      
      private var _timer:Timer;
      
      private var _countDownTime:Number;
      
      private var _currentQuestion:DDTMatchQuestionInfo;
      
      private var skillType:int;
      
      private var answerIndex1:int;
      
      private var answerIndex2:int;
      
      public function DDTMatchExpertView(){super();}
      
      private function initView() : void{}
      
      protected function __onSelectClick(param1:MouseEvent) : void{}
      
      private function setCDTime(param1:Date) : void{}
      
      private function __onTimer(param1:TimerEvent) : void{}
      
      private function setQuestion(param1:DDTMatchQuestionInfo) : void{}
      
      private function transSecond(param1:Number) : String{return null;}
      
      private function addEvent() : void{}
      
      protected function __onSetBtnEnable(param1:CrazyTankSocketEvent) : void{}
      
      protected function __onSetQuestionInfo(param1:CrazyTankSocketEvent) : void{}
      
      protected function __onSetRankInfo(param1:CrazyTankSocketEvent) : void{}
      
      protected function __onAnswerResult(param1:CrazyTankSocketEvent) : void{}
      
      private function setAnswerFlag(param1:int) : void{}
      
      public function setSelectBtnEnable(param1:Boolean) : void{}
      
      protected function __onEnterFrame(param1:Event) : void{}
      
      private function _btnclickHandler(param1:MouseEvent) : void{}
      
      private function payment(param1:Boolean) : Boolean{return false;}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function onResponseHander(param1:FrameEvent) : void{}
      
      private function checkMoney(param1:Boolean) : Boolean{return false;}
      
      protected function __onBuyHandle(param1:FrameEvent) : void{}
      
      protected function __onAlertSelect(param1:DDTMatchEvent) : void{}
      
      private function setBindFlag(param1:Boolean) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
