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
      
      public function CampProgress(){super();}
      
      private function initView() : void{}
      
      protected function captureHander(param1:MapEvent) : void{}
      
      public function setCapture() : void{}
      
      protected function captureStartHander(param1:MapEvent) : void{}
      
      private function timerCompeteHander(param1:Event) : void{}
      
      private function timerHander(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
