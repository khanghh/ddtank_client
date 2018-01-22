package worldboss.view
{
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import room.view.states.BaseRoomState;
   import worldboss.WorldBossManager;
   
   public class WorldBossFightRoomState extends BaseRoomState
   {
      
      public static var IsSuccessStartGame:Boolean = false;
       
      
      private var black:Sprite;
      
      private var timer:Timer;
      
      public function WorldBossFightRoomState()
      {
         super();
      }
      
      override public function getType() : String
      {
         return "worldbossRoom";
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         MainToolBar.Instance.hide();
         LayerManager.Instance.clearnGameDynamic();
         black = new Sprite();
         black.graphics.beginFill(0,1);
         black.graphics.drawRect(0,0,1000,600);
         black.graphics.endFill();
         addChild(black);
         SocketManager.Instance.out.enterUserGuide(WorldBossManager.Instance.currentPVE_ID,14);
         if(!WorldBossManager.Instance.bossInfo.fightOver)
         {
            IsSuccessStartGame = true;
            GameInSocketOut.sendGameStart();
            SocketManager.Instance.out.sendWorldBossRoomStauts(2);
            waitForGameStart();
         }
         else
         {
            StateManager.setState("worldboss");
         }
      }
      
      private function waitForGameStart() : void
      {
         timer = new Timer(10000,1);
         timer.addEventListener("timer",__gotoBack);
         timer.start();
      }
      
      private function __gotoBack(param1:TimerEvent) : void
      {
         timer.reset();
         timer.removeEventListener("timer",__gotoBack);
         IsSuccessStartGame = false;
         StateManager.setState("worldboss");
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         if(timer && timer.running)
         {
            timer.reset();
            timer.removeEventListener("timer",__gotoBack);
         }
         if(black && black.parent)
         {
            black.parent.removeChild(black);
         }
         super.leaving(param1);
      }
   }
}
