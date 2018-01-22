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
      
      public function WeddingRoomMask(param1:ChurchRoomController){super();}
      
      private function init() : void{}
      
      private function __timerAlarm(param1:Event) : void{}
      
      private function __timerComplete(param1:Event) : void{}
      
      public function showMaskMovie() : void{}
      
      private function showAlarm(param1:uint) : void{}
      
      private function __click(param1:MouseEvent) : void{}
      
      private function __switchComplete(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
