package floatParade.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class FloatParadeStartCountDown extends Sprite implements Disposeable
   {
       
      
      private var _mc:MovieClip;
      
      private var _timer:Timer;
      
      private var _count:int;
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      public function FloatParadeStartCountDown(param1:Function, param2:Array)
      {
         super();
         PositionUtils.setPos(this,"floatParade.gameStart.countDownViewPos");
         _func = param1;
         _funcParams = param2;
         _mc = ComponentFactory.Instance.creat("floatParade.gameStartCountDown");
         addChild(_mc);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
         _timer.start();
         _count = 1;
         refreshMc();
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         _count = Number(_count) + 1;
         if(_count > 10)
         {
            if(null != _func)
            {
               _func.apply(null,_funcParams);
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
         _funcParams = null;
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
