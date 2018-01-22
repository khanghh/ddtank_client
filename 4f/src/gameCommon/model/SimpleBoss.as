package gameCommon.model
{
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   
   public class SimpleBoss extends TurnedLiving
   {
       
      
      public function SimpleBoss(param1:int, param2:int, param3:int){super(null,null,null);}
      
      override public function shoot(param1:Array, param2:CrazyTankSocketEvent) : void{}
      
      override public function beginNewTurn() : void{}
   }
}
