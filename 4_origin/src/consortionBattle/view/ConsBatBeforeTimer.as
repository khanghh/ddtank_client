package consortionBattle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ConsBatBeforeTimer extends Sprite implements Disposeable
   {
       
      
      private var _timerMc:MovieClip;
      
      private var _timerMc_1:MovieClip;
      
      private var _timerMc_2:MovieClip;
      
      private var _timerMc_3:MovieClip;
      
      private var _timerMc_4:MovieClip;
      
      private var _total:int;
      
      private var _timer:TimerJuggler;
      
      public function ConsBatBeforeTimer(total:int)
      {
         super();
         _total = total;
         initView();
         refreshView(_total);
         _timer = TimerManager.getInstance().addTimerJuggler(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
         _timer.start();
      }
      
      private function initView() : void
      {
         _timerMc = ComponentFactory.Instance.creat("asset.consortiaBattle.beforeTimer");
         _timerMc_1 = _timerMc["timer_1"];
         _timerMc_2 = _timerMc["timer_2"];
         _timerMc_3 = _timerMc["timer_3"];
         _timerMc_4 = _timerMc["timer_4"];
         _timerMc_1.gotoAndStop(10);
         _timerMc_2.gotoAndStop(10);
         _timerMc_3.gotoAndStop(10);
         _timerMc_4.gotoAndStop(10);
         addChild(_timerMc);
      }
      
      private function timerHandler(event:Event) : void
      {
         _total = Number(_total) - 1;
         if(_total <= 0)
         {
            dispose();
            return;
         }
         refreshView(_total);
      }
      
      private function refreshView(remain:int) : void
      {
         var countMin:int = remain / (60000 / 1000);
         var tenthMin:int = countMin / 10;
         _timerMc_1.gotoAndStop(tenthMin == 0?10:tenthMin);
         var unitMin:int = countMin % 10;
         _timerMc_2.gotoAndStop(unitMin == 0?10:unitMin);
         var countSecond:int = remain % (60000 / 1000);
         var tenthSecond:int = countSecond / 10;
         _timerMc_3.gotoAndStop(tenthSecond == 0?10:tenthSecond);
         var unitSecond:int = countSecond % 10;
         _timerMc_4.gotoAndStop(unitSecond == 0?10:unitSecond);
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",timerHandler);
            _timer.stop();
            TimerManager.getInstance().removeJugglerByTimer(_timer);
         }
         _timer = null;
         ObjectUtils.disposeObject(_timerMc);
         _timerMc = null;
         _timerMc_1 = null;
         _timerMc_2 = null;
         _timerMc_3 = null;
         _timerMc_4 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
