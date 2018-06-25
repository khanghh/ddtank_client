package gameCommon.model
{
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   
   public class SimpleBoss extends TurnedLiving
   {
       
      
      public function SimpleBoss(id:int, team:int, maxBlood:int)
      {
         super(id,team,maxBlood);
      }
      
      override public function shoot(list:Array, event:CrazyTankSocketEvent) : void
      {
         dispatchEvent(new LivingEvent("shoot",0,0,list,event));
      }
      
      override public function beginNewTurn() : void
      {
         isAttacking = false;
      }
   }
}
