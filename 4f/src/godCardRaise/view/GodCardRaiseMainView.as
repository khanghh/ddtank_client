package godCardRaise.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import godCardRaise.GodCardRaiseManager;
   import road7th.utils.DateUtils;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class GodCardRaiseMainView extends Frame
   {
       
      
      private var _selectGroup:SelectedButtonGroup;
      
      private var _divineBtn:SelectedButton;
      
      private var _exchangeBtn:SelectedButton;
      
      private var _atlasBtn:SelectedButton;
      
      private var _scoreBtn:SelectedButton;
      
      private var _time:FilterFrameText;
      
      private var _doubleTime:FilterFrameText;
      
      private var _timeLabel:FilterFrameText;
      
      private var _doubleTimeLabel:FilterFrameText;
      
      private var _divineView:GodCardRaiseDivineView;
      
      private var _exchangeView:GodCardRaiseExchangeView;
      
      private var _atlasView:GodCardRaiseAtlasView;
      
      private var _scoreView:GodCardRaiseScoreView;
      
      private var _timeFrame:int = 1;
      
      private var _timeRemainTimer:TimerJuggler;
      
      private var _btnHelp:BaseButton;
      
      public function GodCardRaiseMainView(){super();}
      
      override protected function init() : void{}
      
      private function initView() : void{}
      
      private function __timeRemainHandler(param1:Event) : void{}
      
      private function getCurrentDoubleTimeStr() : String{return null;}
      
      private function getCurrentTimeStr() : String{return null;}
      
      private function checkIsEndActity() : Boolean{return false;}
      
      private function isEndActity() : Boolean{return false;}
      
      private function onSelectGroupChange(param1:Event) : void{}
      
      private function showView() : void{}
      
      private function addEvents() : void{}
      
      private function __openCardUpdateHandler(param1:CEvent) : void{}
      
      private function __openCardLockChangeHandler(param1:Event) : void{}
      
      private function __awardInfoUpdateHandler(param1:CEvent) : void{}
      
      private function __operateCardUpdateHandler(param1:CEvent) : void{}
      
      private function __exchangeUpdateHandler(param1:CEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvents() : void{}
      
      override public function dispose() : void{}
   }
}
