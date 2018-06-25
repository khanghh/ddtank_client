package gameStarling.objects{   import bones.BoneMovieFactory;   import bones.game.ActionMovieBone;   import com.pickgliss.utils.StarlingObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.LivingEvent;   import flash.events.Event;   import flash.geom.Rectangle;   import gameCommon.model.SimpleBoss;   import gameStarling.actions.ChangeDirectionAction;   import gameStarling.actions.MonsterShootBombAction;   import starlingPhy.maps.Map3D;      public class GameSimpleBoss3D extends GameTurnedLiving3D   {                   private var bombList:Array;            private var shootEvt:CrazyTankSocketEvent;            private var shoots:Array;            public function GameSimpleBoss3D(info:SimpleBoss) { super(null); }
            override protected function initView() : void { }
            override protected function initChatball() : void { }
            override protected function initFreezonRect() : void { }
            override protected function __forzenChanged(event:LivingEvent) : void { }
            override protected function __dirChanged(event:LivingEvent) : void { }
            override public function setMap(map:Map3D) : void { }
            override protected function __shoot(event:LivingEvent) : void { }
            override protected function __attackingChanged(event:LivingEvent) : void { }
            override protected function __posChanged(event:LivingEvent) : void { }
            public function get simpleBoss() : SimpleBoss { return null; }
            override protected function __bloodChanged(event:LivingEvent) : void { }
            private function playRenewActionCompleteCall(list:Array) : void { }
            override protected function __die(event:LivingEvent) : void { }
            private function clearEnemy() : void { }
            override protected function __changeState(evt:LivingEvent) : void { }
            override public function dispose() : void { }
            private function __disposeLater(evt:Event) : void { }
   }}