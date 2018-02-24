package campbattle.view
{
   import campbattle.CampBattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import consortionBattle.view.ConsBatInTimer;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import times.utils.timerManager.TimerManager;
   
   public class CampBattleInTimer extends ConsBatInTimer
   {
      
      private static const PTIME:int = 60;
       
      
      public function CampBattleInTimer(){super();}
      
      override protected function init() : void{}
      
      override protected function __startCount(param1:Event) : void{}
   }
}
