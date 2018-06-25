package game.objects
{
   import ddt.events.LivingEvent;
   import gameCommon.model.TurnedLiving;
   import gameCommon.view.smallMap.SmallLiving;
   
   public class GameTurnedLiving extends GameLiving
   {
       
      
      public function GameTurnedLiving(info:TurnedLiving)
      {
         super(info);
      }
      
      public function get turnedLiving() : TurnedLiving
      {
         return _info as TurnedLiving;
      }
      
      override protected function initListener() : void
      {
         super.initListener();
         turnedLiving.addEventListener("attackingChanged",__attackingChanged);
      }
      
      override protected function removeListener() : void
      {
         super.removeListener();
         if(turnedLiving)
         {
            turnedLiving.removeEventListener("attackingChanged",__attackingChanged);
         }
      }
      
      protected function __attackingChanged(event:LivingEvent) : void
      {
         if(_smallView)
         {
            SmallLiving(_smallView).isAttacking = turnedLiving.isAttacking;
         }
      }
      
      override public function die() : void
      {
         turnedLiving.isAttacking = false;
         super.die();
      }
   }
}
