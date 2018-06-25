package gameStarling.objects{   import ddt.events.LivingEvent;   import gameCommon.model.TurnedLiving;   import gameCommon.view.smallMap.SmallLiving;      public class GameTurnedLiving3D extends GameLiving3D   {                   public function GameTurnedLiving3D(info:TurnedLiving) { super(null); }
            public function get turnedLiving() : TurnedLiving { return null; }
            override protected function initListener() : void { }
            override protected function removeListener() : void { }
            protected function __attackingChanged(event:LivingEvent) : void { }
            override public function die() : void { }
   }}