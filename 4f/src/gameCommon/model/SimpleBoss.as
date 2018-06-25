package gameCommon.model{   import ddt.events.CrazyTankSocketEvent;   import ddt.events.LivingEvent;      public class SimpleBoss extends TurnedLiving   {                   public function SimpleBoss(id:int, team:int, maxBlood:int) { super(null,null,null); }
            override public function shoot(list:Array, event:CrazyTankSocketEvent) : void { }
            override public function beginNewTurn() : void { }
   }}