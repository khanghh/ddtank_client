package gameStarling.objects
{
   import ddt.events.LivingEvent;
   import gameCommon.model.TurnedLiving;
   import gameCommon.view.smallMap.SmallLiving;
   
   public class GameTurnedLiving3D extends GameLiving3D
   {
       
      
      public function GameTurnedLiving3D(param1:TurnedLiving){super(null);}
      
      public function get turnedLiving() : TurnedLiving{return null;}
      
      override protected function initListener() : void{}
      
      override protected function removeListener() : void{}
      
      protected function __attackingChanged(param1:LivingEvent) : void{}
      
      override public function die() : void{}
   }
}
