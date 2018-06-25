package game.objects{   import com.pickgliss.ui.ComponentFactory;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.LivingEvent;   import ddt.view.chat.chatBall.ChatBallBoss;   import flash.display.MovieClip;   import flash.events.Event;   import flash.geom.Rectangle;   import game.actions.ChangeDirectionAction;   import game.actions.MonsterShootBombAction;   import gameCommon.model.SimpleBoss;   import phy.maps.Map;      public class GameSimpleBoss extends GameTurnedLiving   {                   private var bombList:Array;            private var shootEvt:CrazyTankSocketEvent;            private var shoots:Array;            public function GameSimpleBoss(info:SimpleBoss) { super(null); }
            override protected function initView() : void { }
            override protected function initChatball() : void { }
            override protected function initFreezonRect() : void { }
            override protected function __forzenChanged(event:LivingEvent) : void { }
            override protected function __dirChanged(event:LivingEvent) : void { }
            override public function setMap(map:Map) : void { }
            override protected function __shoot(event:LivingEvent) : void { }
            override protected function __attackingChanged(event:LivingEvent) : void { }
            override protected function __posChanged(event:LivingEvent) : void { }
            public function get simpleBoss() : SimpleBoss { return null; }
            override protected function __bloodChanged(event:LivingEvent) : void { }
            override protected function __die(event:LivingEvent) : void { }
            private function clearEnemy() : void { }
            override protected function __changeState(evt:LivingEvent) : void { }
            override public function dispose() : void { }
            private function __disposeLater(evt:Event) : void { }
   }}