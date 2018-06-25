package game.objects{   import ddt.events.LivingEvent;   import gameCommon.model.TurnedLiving;   import gameCommon.view.smallMap.SmallLiving;      public class GameTurnedLiving extends GameLiving   {                   public function GameTurnedLiving(info:TurnedLiving) { super(null); }
            public function get turnedLiving() : TurnedLiving { return null; }
            override protected function initListener() : void { }
            override protected function removeListener() : void { }
            protected function __attackingChanged(event:LivingEvent) : void { }
            override public function die() : void { }
   }}