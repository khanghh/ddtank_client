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
      
      public function GodCardRaiseMainView()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = LanguageMgr.GetTranslation("godCardRaise.title");
         autoExit = true;
         escEnable = true;
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":683,
            "y":5
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.godCardRaise.view.help",408,488);
         _divineBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseMainView.divineBtn");
         addToContent(_divineBtn);
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseMainView.exchangeBtn");
         addToContent(_exchangeBtn);
         _atlasBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseMainView.atlasBtn");
         addToContent(_atlasBtn);
         _scoreBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseMainView.scoreBtn");
         addToContent(_scoreBtn);
         _selectGroup = new SelectedButtonGroup();
         _selectGroup.addSelectItem(_divineBtn);
         _selectGroup.addSelectItem(_exchangeBtn);
         _selectGroup.addSelectItem(_atlasBtn);
         _selectGroup.addSelectItem(_scoreBtn);
         _time = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseMainView.time");
         _time.text = LanguageMgr.GetTranslation("godCardRaise.mainView.time1");
         addToContent(_time);
         _timeLabel = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseMainView.timeLabel");
         _timeLabel.text = getCurrentTimeStr();
         addToContent(_timeLabel);
         _doubleTime = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseMainView.doubelTime");
         _doubleTime.text = LanguageMgr.GetTranslation("godCardRaise.mainView.doubleTime");
         addToContent(_doubleTime);
         _doubleTimeLabel = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseMainView.doubleTimeLabel");
         _doubleTimeLabel.text = getCurrentTimeStr();
         addToContent(_doubleTimeLabel);
         _timeRemainTimer = TimerManager.getInstance().addTimerJuggler(10000);
         _timeRemainTimer.addEventListener("timer",__timeRemainHandler);
         _timeRemainTimer.start();
         if(!checkIsEndActity())
         {
            _selectGroup.selectIndex = 0;
         }
         showView();
      }
      
      private function __timeRemainHandler(evt:Event) : void
      {
         if(_timeLabel)
         {
            _timeLabel.text = getCurrentTimeStr();
         }
         if(_doubleTimeLabel)
         {
            _doubleTimeLabel.text = getCurrentDoubleTimeStr();
         }
         if(_scoreView)
         {
            _scoreView.updateTime();
         }
         if(isEndActity() && _divineBtn.enable)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("godCardRaiseMainView.endActityMsg"));
         }
         checkIsEndActity();
      }
      
      private function getCurrentDoubleTimeStr() : String
      {
         var time:Number = GodCardRaiseManager.Instance.doubleTime;
         if(time <= 0)
         {
            return "";
         }
         return int(time / 60) + 1 + LanguageMgr.GetTranslation("minute2");
      }
      
      private function getCurrentTimeStr() : String
      {
         var remainTime:Number = NaN;
         if(_timeFrame == 1)
         {
            remainTime = (GodCardRaiseManager.Instance.dataEnd.time - TimeManager.Instance.Now().time) / 1000;
         }
         else
         {
            remainTime = (GodCardRaiseManager.Instance.dataEnd.time - TimeManager.Instance.Now().time) / 1000 + 86400;
         }
         var dateArr:Array = DateUtils.dateTimeRemainArr(remainTime);
         return LanguageMgr.GetTranslation("tank.timeRemain.msg1",dateArr[0],dateArr[1],dateArr[2]);
      }
      
      private function checkIsEndActity() : Boolean
      {
         if(isEndActity())
         {
            _divineBtn.enable = false;
            if(_selectGroup.selectIndex <= 0)
            {
               _selectGroup.selectIndex = 1;
            }
            return true;
         }
         _divineBtn.enable = true;
         return false;
      }
      
      private function isEndActity() : Boolean
      {
         var tempNum:Number = GodCardRaiseManager.Instance.dataEnd.time - TimeManager.Instance.Now().time;
         return tempNum <= 0;
      }
      
      private function onSelectGroupChange(event:Event) : void
      {
         SoundManager.instance.play("008");
         if(_divineView)
         {
            _divineView.visible = false;
         }
         if(_exchangeView)
         {
            _exchangeView.visible = false;
         }
         if(_atlasView)
         {
            _atlasView.visible = false;
         }
         if(_scoreView)
         {
            _scoreView.visible = false;
         }
         showView();
      }
      
      private function showView() : void
      {
         var _loc1_:* = true;
         _timeLabel.visible = _loc1_;
         _time.visible = _loc1_;
         if(GodCardRaiseManager.Instance.doubleTime <= 0)
         {
            _loc1_ = false;
            _doubleTimeLabel.visible = _loc1_;
            _doubleTime.visible = _loc1_;
         }
         else
         {
            _loc1_ = true;
            _doubleTimeLabel.visible = _loc1_;
            _doubleTime.visible = _loc1_;
         }
         _timeFrame = 1;
         if(_selectGroup.selectIndex == 1)
         {
            _timeFrame = 2;
            if(_exchangeView)
            {
               _exchangeView.visible = true;
            }
            else
            {
               _exchangeView = new GodCardRaiseExchangeView();
               PositionUtils.setPos(_exchangeView,"godCardRaiseMainView.godCardRaiseExchangeViewPos");
               addToContent(_exchangeView);
            }
         }
         else if(_selectGroup.selectIndex == 2)
         {
            _timeFrame = 2;
            if(_atlasView)
            {
               _atlasView.visible = true;
            }
            else
            {
               _atlasView = new GodCardRaiseAtlasView();
               PositionUtils.setPos(_atlasView,"godCardRaiseMainView.godCardRaiseAtlasViewPos");
               addToContent(_atlasView);
            }
         }
         else if(_selectGroup.selectIndex == 3)
         {
            if(_scoreView)
            {
               _scoreView.visible = true;
            }
            else
            {
               _scoreView = new GodCardRaiseScoreView();
               PositionUtils.setPos(_scoreView,"godCardRaiseMainView.godCardRaiseScoreViewPos");
               addToContent(_scoreView);
            }
            _loc1_ = false;
            _timeLabel.visible = _loc1_;
            _time.visible = _loc1_;
            _loc1_ = false;
            _doubleTimeLabel.visible = _loc1_;
            _doubleTime.visible = _loc1_;
         }
         else if(_divineView)
         {
            _divineView.visible = true;
         }
         else
         {
            _divineView = new GodCardRaiseDivineView();
            _divineView.addEventListener("openCardLockChange",__openCardLockChangeHandler);
            PositionUtils.setPos(_divineView,"godCardRaiseMainView.godCardRaiseDivineViewPos");
            addToContent(_divineView);
         }
         if(_timeFrame == 1)
         {
            _time.text = LanguageMgr.GetTranslation("godCardRaise.mainView.time2");
            _loc1_ = false;
            _doubleTimeLabel.visible = _loc1_;
            _doubleTime.visible = _loc1_;
            _loc1_ = 56;
            _timeLabel.y = _loc1_;
            _time.y = _loc1_;
         }
         else
         {
            _time.text = LanguageMgr.GetTranslation("godCardRaise.mainView.time1");
            if(_doubleTime.visible)
            {
               _loc1_ = 46;
               _timeLabel.y = _loc1_;
               _time.y = _loc1_;
            }
            else
            {
               _loc1_ = 56;
               _timeLabel.y = _loc1_;
               _time.y = _loc1_;
            }
         }
         if(_timeLabel)
         {
            _timeLabel.text = getCurrentTimeStr();
         }
         if(_doubleTimeLabel)
         {
            _doubleTimeLabel.text = getCurrentDoubleTimeStr();
         }
      }
      
      private function addEvents() : void
      {
         _selectGroup.addEventListener("change",onSelectGroupChange);
         GodCardRaiseManager.Instance.addEventListener("openCard",__openCardUpdateHandler);
         GodCardRaiseManager.Instance.addEventListener("awardInfo",__awardInfoUpdateHandler);
         GodCardRaiseManager.Instance.addEventListener("operateCard",__operateCardUpdateHandler);
         GodCardRaiseManager.Instance.addEventListener("exchange",__exchangeUpdateHandler);
         addEventListener("response",__responseHandler);
      }
      
      private function __openCardUpdateHandler(event:CEvent) : void
      {
         var cards:Array = event.data as Array;
         if(_divineView)
         {
            _divineView.playCardMovie(cards);
            _divineView.updateView();
         }
         if(_atlasView)
         {
            _atlasView.updateView();
         }
         if(_exchangeView)
         {
            _exchangeView.updateView();
         }
         if(_scoreView)
         {
            _scoreView.updateView();
         }
      }
      
      private function __openCardLockChangeHandler(event:Event) : void
      {
         if(_divineView)
         {
            this.escEnable = !_divineView.openCardLock;
            this.closeButton.enable = !_divineView.openCardLock;
         }
      }
      
      private function __awardInfoUpdateHandler(event:CEvent) : void
      {
         if(_scoreView)
         {
            _scoreView.updateView();
         }
      }
      
      private function __operateCardUpdateHandler(event:CEvent) : void
      {
         if(_atlasView)
         {
            _atlasView.updateView();
         }
         if(_exchangeView)
         {
            _exchangeView.updateView();
         }
      }
      
      private function __exchangeUpdateHandler(event:CEvent) : void
      {
         if(_exchangeView)
         {
            _exchangeView.updateView();
         }
         if(_atlasView)
         {
            _atlasView.updateView();
         }
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function removeEvents() : void
      {
         _selectGroup.removeEventListener("change",onSelectGroupChange);
         GodCardRaiseManager.Instance.removeEventListener("openCard",__openCardUpdateHandler);
         GodCardRaiseManager.Instance.removeEventListener("awardInfo",__awardInfoUpdateHandler);
         GodCardRaiseManager.Instance.removeEventListener("operateCard",__operateCardUpdateHandler);
         GodCardRaiseManager.Instance.removeEventListener("exchange",__exchangeUpdateHandler);
         if(_divineView)
         {
            _divineView.removeEventListener("openCardLockChange",__openCardLockChangeHandler);
         }
         removeEventListener("response",__responseHandler);
      }
      
      override public function dispose() : void
      {
         if(_timeRemainTimer)
         {
            _timeRemainTimer.stop();
            _timeRemainTimer.removeEventListener("timer",__timeRemainHandler);
            TimerManager.getInstance().removeJugglerByTimer(_timeRemainTimer);
            _timeRemainTimer = null;
         }
         removeEvents();
         ObjectUtils.disposeAllChildren(this);
         _divineBtn = null;
         _exchangeBtn = null;
         _atlasBtn = null;
         _scoreBtn = null;
         _time = null;
         _timeLabel = null;
         _divineView = null;
         _doubleTimeLabel = null;
         _exchangeView = null;
         _atlasView = null;
         _scoreView = null;
         _btnHelp = null;
         super.dispose();
      }
   }
}
