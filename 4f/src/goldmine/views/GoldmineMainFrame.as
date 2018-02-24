package goldmine.views
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import goldmine.GoldmineManager;
   import goldmine.model.GoldmineModel;
   import road7th.utils.MovieClipWrapper;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class GoldmineMainFrame extends Frame
   {
       
      
      private var _dateStartMonth1:NumberImage;
      
      private var _dateStartMonth2:NumberImage;
      
      private var _datePoint1:Bitmap;
      
      private var _dateStartDay1:NumberImage;
      
      private var _dateStartDay2:NumberImage;
      
      private var _dateIcon:Bitmap;
      
      private var _dateEndMonth1:NumberImage;
      
      private var _dateEndMonth2:NumberImage;
      
      private var _datePoint2:Bitmap;
      
      private var _dateEndDay1:NumberImage;
      
      private var _dateEndDay2:NumberImage;
      
      private var _infoText:Bitmap;
      
      private var _infoWord:FilterFrameText;
      
      private var _mineBtn:BaseButton;
      
      private var _mineTimesText:FilterFrameText;
      
      private var _nextScoreLeft:GradientText;
      
      private var _nextScoreRight:GradientText;
      
      private var _nextScoreText:FilterFrameText;
      
      private var _blackBg:Bitmap;
      
      private var _smallMine:MovieClip;
      
      private var _middleMine:MovieClip;
      
      private var _bigMine:MovieClip;
      
      private var _mineTextList:Vector.<NumberImage>;
      
      private var _smallMineText:NumberImage;
      
      private var _middleMineText:NumberImage;
      
      private var _bigMineText:NumberImage;
      
      private var _mineLight:Bitmap;
      
      private var _mineBaseBtm:Bitmap;
      
      private var _shineMc:MovieClip;
      
      private var _timeRemainTimer:TimerJuggler;
      
      private var _model:GoldmineModel;
      
      private var _lightPos:Vector.<Point>;
      
      private var _shinePos:Vector.<Point>;
      
      private var _btmPos:Vector.<Point>;
      
      private var _mineMc:Vector.<MovieClip>;
      
      private var _index:int = -1;
      
      private var _lastScore:int = 0;
      
      private var _clickNum:Number = 0;
      
      private var currentIndex:int = 0;
      
      private var _filter:Array;
      
      public function GoldmineMainFrame(){super();}
      
      override protected function init() : void{}
      
      private function initData() : void{}
      
      private function initView() : void{}
      
      public function updateView() : void{}
      
      private function addEvent() : void{}
      
      private function __onClickMineBtn(param1:MouseEvent) : void{}
      
      private function __onMineResponse(param1:FrameEvent) : void{}
      
      private function __timeRemainHandler(param1:Event) : void{}
      
      private function __timeComHandler(param1:Event) : void{}
      
      private function __onMineHandler(param1:Event) : void{}
      
      private function __onPlayActionComplete(param1:Event) : void{}
      
      private function __poorManResponse(param1:FrameEvent) : void{}
      
      private function __onMouseRollout(param1:MouseEvent) : void{}
      
      private function __onMouseRollover(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __onUseGoldmine(param1:CEvent) : void{}
      
      private function __response(param1:FrameEvent) : void{}
      
      override protected function onResponse(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
