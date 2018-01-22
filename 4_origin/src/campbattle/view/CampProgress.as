package campbattle.view
{
   import campbattle.CampBattleControl;
   import campbattle.event.MapEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SocketManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class CampProgress extends Sprite implements Disposeable
   {
       
      
      private var _mc:MovieClip;
      
      private var _timer:TimerJuggler;
      
      private var _index:int = 1;
      
      public function CampProgress()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _mc = ComponentFactory.Instance.creat("asset.campbattle.progress.bar");
         _mc.stop();
         _mc.visible = false;
         addChild(_mc);
         _timer = TimerManager.getInstance().addTimerJuggler(1000,3);
         CampBattleControl.instance.addEventListener("capture_start",captureStartHander);
         CampBattleControl.instance.addEventListener("capture_over",captureHander);
      }
      
      protected function captureHander(param1:MapEvent) : void
      {
         _mc.visible = CampBattleControl.instance.model.isCapture;
         if(!CampBattleControl.instance.model.isCapture)
         {
            _mc.gotoAndStop(1);
         }
         else
         {
            _mc.gotoAndStop(4);
         }
      }
      
      public function setCapture() : void
      {
         _mc.visible = true;
         _mc.gotoAndStop(4);
      }
      
      protected function captureStartHander(param1:MapEvent) : void
      {
         _index = 1;
         _timer.reset();
         _mc.visible = true;
         _timer.addEventListener("timer",timerHander);
         _timer.addEventListener("timerComplete",timerCompeteHander);
         _timer.start();
         _mc.gotoAndStop(1);
      }
      
      private function timerCompeteHander(param1:Event) : void
      {
         _timer.removeEventListener("timer",timerHander);
         _timer.removeEventListener("timerComplete",timerCompeteHander);
         SocketManager.Instance.out.captureMap(true);
         setCapture();
      }
      
      private function timerHander(param1:Event) : void
      {
         _index = Number(_index) + 1;
         _mc.gotoAndStop(_index);
      }
      
      public function dispose() : void
      {
         CampBattleControl.instance.removeEventListener("capture_over",captureHander);
         CampBattleControl.instance.removeEventListener("capture_start",captureStartHander);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timerHander);
            _timer.removeEventListener("timerComplete",timerCompeteHander);
            TimerManager.getInstance().removeJugglerByTimer(_timer);
         }
         _timer = null;
         if(_mc)
         {
            _mc.stop();
            while(_mc.numChildren)
            {
               ObjectUtils.disposeObject(_mc.getChildAt(0));
            }
         }
         ObjectUtils.disposeObject(_mc);
         _mc = null;
      }
   }
}
