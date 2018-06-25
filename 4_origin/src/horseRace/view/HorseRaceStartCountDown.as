package horseRace.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class HorseRaceStartCountDown extends Sprite implements Disposeable
   {
       
      
      private var _mc:MovieClip;
      
      private var _timer:Timer;
      
      private var _count:int;
      
      private var _func:Function;
      
      public function HorseRaceStartCountDown($count:int, type:String = "begin", callFunction:Function = null)
      {
         super();
         PositionUtils.setPos(this,"horseRace.raceView.countDownViewPos");
         _count = $count;
         _func = callFunction;
         if(type == "begin")
         {
            _mc = ComponentFactory.Instance.creat("horseRace.raceView.gameStartCountDown");
         }
         else if(type == "end")
         {
            _mc = ComponentFactory.Instance.creat("horseRace.raceView.gameEndCountDown");
         }
         addChild(_mc);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler);
         _timer.start();
         refreshMc();
      }
      
      private function timerHandler(event:TimerEvent) : void
      {
         _count = Number(_count) + 1;
         if(_count > 10)
         {
            if(_func != null)
            {
               _func();
            }
            dispose();
            return;
         }
         refreshMc();
      }
      
      private function refreshMc() : void
      {
         _mc.gotoAndStop(_count);
      }
      
      public function dispose() : void
      {
         _func = null;
         if(_timer)
         {
            _timer.removeEventListener("timer",timerHandler);
            _timer.stop();
         }
         _timer = null;
         if(_mc && this.contains(_mc))
         {
            this.removeChild(_mc);
         }
         _mc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
