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
      
      public function WaitingCatchInsectView()
      {
         _loadingArr = ["loading","loading.","loading..","loading..."];
         super();
         ParticleManager.initPartical(PathManager.FLASHSITE);
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         _waitTimer = TimerManager.getInstance().addTimerJuggler(1000,20);
         _waitTimer.addEventListener("timer",__onTimer);
         _waitTimer.addEventListener("timerComplete",__onTimerComplete);
      }
      
      protected function __startLoading(e:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
         _waitTimer.stop();
         this.visible = false;
      }
      
      protected function __onTimerComplete(event:Event) : void
      {
         dispatchEvent(new CatchInsectRoomEvent("enterGameTimeOut"));
      }
      
      protected function __onTimer(event:Event) : void
      {
         _currentCountDown = Number(_currentCountDown) - 1;
         _timeText.text = _currentCountDown.toString();
      }
      
      private function initView() : void
      {
         _bg = new Sprite();
         _bg.graphics.beginFill(0,0.6);
         _bg.graphics.drawRect(0,0,1000,600);
         _bg.graphics.endFill();
         _loadingText = ComponentFactory.Instance.creatComponentByStylename("catchInsect.WaitingView.loadingText");
         _loadingText.text = _loadingArr[0];
         _timeText = ComponentFactory.Instance.creatComponentByStylename("catchInsect.WaitingView.timeText");
         _timeText.text = 20.toString();
         addChild(_bg);
         addChild(_loadingText);
         addChild(_timeText);
      }
      
      private function removeEvent() : void
      {
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         _waitTimer.stop();
         _waitTimer.removeEventListener("timer",__onTimer);
         _waitTimer.removeEventListener("timerComplete",__onTimerComplete);
         TimerManager.getInstance().removeJugglerByTimer(_waitTimer);
         removeEventListener("enterFrame",__onEnterFrame);
      }
      
      public function start() : void
      {
         _waitTimer.reset();
         _waitTimer.start();
         _frame = 0;
         addEventListener("enterFrame",__onEnterFrame);
      }
      
      protected function __onEnterFrame(event:Event) : void
      {
         _frame = Number(_frame) + 1;
         if(_frame >= 10)
         {
            _loadingIdx = (_loadingIdx + 1) % _loadingArr.length;
            _loadingText.text = _loadingArr[_loadingIdx];
            _frame = 0;
         }
      }
      
      public function stop() : void
      {
         _waitTimer.stop();
         removeEventListener("enterFrame",__onEnterFrame);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _loadingText = null;
         _timeText = null;
         _waitTimer = null;
      }
   }
}
