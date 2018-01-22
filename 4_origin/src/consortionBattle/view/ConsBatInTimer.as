package consortionBattle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ConsBatInTimer extends Sprite implements Disposeable
   {
       
      
      protected var _promptTxt:FilterFrameText;
      
      protected var _timeCD:MovieClip;
      
      protected var _timer:TimerJuggler;
      
      protected var _totalCount:int;
      
      public function ConsBatInTimer()
      {
         super();
         this.x = 406;
         this.y = 10;
         init();
      }
      
      protected function init() : void
      {
         _promptTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.inTimerView.promptTxt");
         _promptTxt.text = LanguageMgr.GetTranslation("ddt.consortiaBattle.inTimerView.promptTxt");
         addChild(_promptTxt);
         _timeCD = ComponentFactory.Instance.creat("asset.consortiaBattle.resurrectTimeCD");
         PositionUtils.setPos(_timeCD,"consortiaBattle.timeCDPos2");
         addChild(_timeCD);
         _totalCount = ConsortiaBattleManager.instance.toEndTime;
         _totalCount = _totalCount < 0?0:_totalCount;
         _timer = TimerManager.getInstance().addTimerJuggler(1000);
         _timer.addEventListener("timer",__startCount);
         _timer.start();
      }
      
      protected function __startCount(param1:Event) : void
      {
         if(_totalCount < 0)
         {
            __timerComplete();
            return;
         }
         var _loc2_:String = setFormat(int(_totalCount / 3600)) + ":" + setFormat(int(_totalCount / 60 % 60)) + ":" + setFormat(int(_totalCount % 60));
         (_timeCD["timeHour2"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(0));
         (_timeCD["timeHour"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(1));
         (_timeCD["timeMint2"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(3));
         (_timeCD["timeMint"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(4));
         (_timeCD["timeSecond2"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(6));
         (_timeCD["timeSecond"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(7));
         _totalCount = Number(_totalCount) - 1;
      }
      
      protected function setFormat(param1:int) : String
      {
         var _loc2_:String = param1.toString();
         if(param1 < 10)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      protected function __timerComplete(param1:Event = null) : void
      {
         dispatchEvent(new Event("complete"));
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__startCount);
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
            _timer = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            this.parent.removeChild(this);
         }
         _timeCD = null;
         _promptTxt = null;
      }
   }
}
