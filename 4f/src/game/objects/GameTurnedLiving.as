package game.objects
{
   import ddt.events.LivingEvent;
   import gameCommon.model.TurnedLiving;
   import gameCommon.view.smallMap.SmallLiving;
   
   public class GameTurnedLiving extends GameLiving
   {
       
      
      public function GameTurnedLiving(param1:TurnedLiving){super(null);}
      
      public function get turnedLiving() : TurnedLiving{return null;}
      
      override protected function initListener() : void{}
      
      override protected function removeListener() : void{}
      
      protected function __attackingChanged(param1:LivingEvent) : void{}
      
      override public function die() : void{}
   }
}
