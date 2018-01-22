package ddt.manager
{
   import com.pickgliss.toplevel.StageReferance;
   import ddt.data.player.PlayerState;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class PlayerStateManager
   {
      
      private static const AWAY_TIME:int = 300;
      
      private static var _instance:PlayerStateManager;
       
      
      private var _timer:TimerJuggler;
      
      public function PlayerStateManager(param1:SingleTonForce)
      {
         super();
      }
      
      public static function get Instance() : PlayerStateManager
      {
         if(_instance == null)
         {
            _instance = new PlayerStateManager(new SingleTonForce());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _timer = TimerManager.getInstance().addTimerJuggler(300 * 1000);
         _timer.addEventListener("timer",timerComplete);
         _timer.start();
         StageReferance.stage.addEventListener("click",onStageClick,false,2147483647);
      }
      
      private function timerComplete(param1:Event) : void
      {
         PlayerManager.Instance.Self.playerState = new PlayerState(2);
         SocketManager.Instance.out.sendFriendState(PlayerManager.Instance.Self.playerState.StateID);
      }
      
      private function onStageClick(param1:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.playerState.StateID == 2)
         {
            PlayerManager.Instance.Self.playerState = new PlayerState(1,0);
            SocketManager.Instance.out.sendFriendState(PlayerManager.Instance.Self.playerState.StateID);
         }
         _timer.reset();
         _timer.start();
      }
   }
}

class SingleTonForce
{
    
   
   function SingleTonForce()
   {
      super();
   }
}
