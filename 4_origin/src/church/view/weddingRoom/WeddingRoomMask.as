package church.view.weddingRoom
{
   import church.controller.ChurchRoomController;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.view.chat.ChatData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class WeddingRoomMask extends Sprite
   {
       
      
      private var _controller:ChurchRoomController;
      
      private var _timer:TimerJuggler;
      
      private var _totalTimes:int = 10;
      
      private var countDownMovie:ScaleFrameImage;
      
      private var switchMovie:WeddingRoomSwitchMovie;
      
      private var _chatMsg:ChatData;
      
      public function WeddingRoomMask(param1:ChurchRoomController)
      {
         super();
         this._controller = param1;
         init();
      }
      
      private function init() : void
      {
         countDownMovie = ComponentFactory.Instance.creat("church.room.startWeddingCountDownAsset");
         countDownMovie.setFrame(1);
         LayerManager.Instance.addToLayer(countDownMovie,2);
         _timer = TimerManager.getInstance().addTimerJuggler(1000,11);
         _timer.addEventListener("timer",__timerAlarm);
         _timer.addEventListener("timerComplete",__timerComplete);
         _timer.start();
      }
      
      private function __timerAlarm(param1:Event) : void
      {
         _totalTimes = Number(_totalTimes) - 1;
         if(_totalTimes % 2 && _totalTimes >= 0)
         {
            SoundManager.instance.play("050");
         }
         countDownMovie.setFrame(countDownMovie.getFrame + 1);
      }
      
      private function __timerComplete(param1:Event) : void
      {
         SoundManager.instance.playMusic("3001");
         _timer.removeEventListener("timer",__timerAlarm);
         _timer.removeEventListener("timerComplete",__timerComplete);
         switchMovie = new WeddingRoomSwitchMovie(false);
         switchMovie.addEventListener("click",__click);
         switchMovie.addEventListener("switch complete",__switchComplete);
         addChild(switchMovie);
         switchMovie.playMovie();
         if(countDownMovie && countDownMovie.parent)
         {
            countDownMovie.parent.removeChild(countDownMovie);
         }
      }
      
      public function showMaskMovie() : void
      {
         if(switchMovie != null)
         {
            switchMovie.playMovie();
         }
      }
      
      private function showAlarm(param1:uint) : void
      {
         _chatMsg = new ChatData();
         _chatMsg.channel = 6;
         _chatMsg.msg = LanguageMgr.GetTranslation("church.churchScene.SceneMask.chatMsg.msg") + param1;
         ChatManager.Instance.chat(_chatMsg);
      }
      
      private function __click(param1:MouseEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.SceneMask.click"));
      }
      
      private function __switchComplete(param1:Event) : void
      {
         dispatchEvent(new Event("switch complete"));
      }
      
      public function dispose() : void
      {
         removeEventListener("click",__click);
         _chatMsg = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerAlarm);
            _timer.removeEventListener("timerComplete",__timerComplete);
            TimerManager.getInstance().removeJugglerByTimer(_timer);
         }
         _timer = null;
         if(switchMovie)
         {
            switchMovie.removeEventListener("click",__click);
            switchMovie.removeEventListener("switch complete",__switchComplete);
            switchMovie.dispose();
         }
         switchMovie = null;
         if(countDownMovie)
         {
            if(countDownMovie.parent)
            {
               countDownMovie.parent.removeChild(countDownMovie);
            }
            countDownMovie.dispose();
         }
         countDownMovie = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
