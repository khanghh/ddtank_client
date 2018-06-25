package campbattle.view
{
   import campbattle.CampBattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import consortionBattle.view.ConsBatInTimer;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import times.utils.timerManager.TimerManager;
   
   public class CampBattleInTimer extends ConsBatInTimer
   {
      
      private static const PTIME:int = 60;
       
      
      public function CampBattleInTimer()
      {
         super();
      }
      
      override protected function init() : void
      {
         _promptTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.inTimerView.promptTxt");
         _promptTxt.text = LanguageMgr.GetTranslation("ddt.consortiaBattle.inTimerView.promptTxt");
         addChild(_promptTxt);
         _timeCD = ComponentFactory.Instance.creat("asset.consortiaBattle.resurrectTimeCD");
         PositionUtils.setPos(_timeCD,"consortiaBattle.timeCDPos2");
         addChild(_timeCD);
         _totalCount = CampBattleManager.instance.toEndTime;
         _totalCount = _totalCount < 0?0:_totalCount;
         _timer = TimerManager.getInstance().addTimerJuggler(1000);
         _timer.addEventListener("timer",__startCount);
         _timer.start();
      }
      
      override protected function __startCount(e:Event) : void
      {
         if(_totalCount < 0)
         {
            __timerComplete();
            return;
         }
         var str:String = setFormat(int(_totalCount / 3600)) + ":" + setFormat(int(_totalCount / 60 % 60)) + ":" + setFormat(int(_totalCount % 60));
         (_timeCD["timeHour2"] as MovieClip).gotoAndStop("num_" + str.charAt(0));
         (_timeCD["timeHour"] as MovieClip).gotoAndStop("num_" + str.charAt(1));
         (_timeCD["timeMint2"] as MovieClip).gotoAndStop("num_" + str.charAt(3));
         (_timeCD["timeMint"] as MovieClip).gotoAndStop("num_" + str.charAt(4));
         (_timeCD["timeSecond2"] as MovieClip).gotoAndStop("num_" + str.charAt(6));
         (_timeCD["timeSecond"] as MovieClip).gotoAndStop("num_" + str.charAt(7));
         var count:int = _totalCount / 60;
         if(count > 0 && count <= 5 && _totalCount % 60 == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.campBattle.onGameOver",count));
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("ddt.campBattle.onGameOver",count));
         }
         _totalCount = Number(_totalCount) - 1;
      }
   }
}
