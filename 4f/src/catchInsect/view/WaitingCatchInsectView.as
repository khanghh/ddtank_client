package catchInsect.view
{
   import catchInsect.event.CatchInsectRoomEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.PathManager;
   import ddt.manager.StateManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import gameCommon.GameControl;
   import par.ParticleManager;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class WaitingCatchInsectView extends Component
   {
       
      
      private const WAITING_TIME:int = 20;
      
      private var _bg:Sprite;
      
      private var _loadingArr:Array;
      
      private var _loadingText:FilterFrameText;
      
      private var _timeText:FilterFrameText;
      
      private var _waitTimer:TimerJuggler;
      
      private var _currentCountDown:int = 20;
      
      private var _loadingIdx:int = 0;
      
      private var _frame:int;
      
      public function WaitingCatchInsectView(){super();}
      
      private function initEvent() : void{}
      
      protected function __startLoading(param1:Event) : void{}
      
      protected function __onTimerComplete(param1:Event) : void{}
      
      protected function __onTimer(param1:Event) : void{}
      
      private function initView() : void{}
      
      private function removeEvent() : void{}
      
      public function start() : void{}
      
      protected function __onEnterFrame(param1:Event) : void{}
      
      public function stop() : void{}
      
      override public function dispose() : void{}
   }
}
