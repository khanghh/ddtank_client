package gameStarling.objects
{
   import bones.BoneMovieFactory;
   import bones.game.ActionMovieBone;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import gameCommon.model.SimpleBoss;
   import gameStarling.actions.ChangeDirectionAction;
   import gameStarling.actions.MonsterShootBombAction;
   import starlingPhy.maps.Map3D;
   
   public class GameSimpleBoss3D extends GameTurnedLiving3D
   {
       
      
      private var bombList:Array;
      
      private var shootEvt:CrazyTankSocketEvent;
      
      private var shoots:Array;
      
      public function GameSimpleBoss3D(param1:SimpleBoss){super(null);}
      
      override protected function initView() : void{}
      
      override protected function initChatball() : void{}
      
      override protected function initFreezonRect() : void{}
      
      override protected function __forzenChanged(param1:LivingEvent) : void{}
      
      override protected function __dirChanged(param1:LivingEvent) : void{}
      
      override public function setMap(param1:Map3D) : void{}
      
      override protected function __shoot(param1:LivingEvent) : void{}
      
      override protected function __attackingChanged(param1:LivingEvent) : void{}
      
      override protected function __posChanged(param1:LivingEvent) : void{}
      
      public function get simpleBoss() : SimpleBoss{return null;}
      
      override protected function __bloodChanged(param1:LivingEvent) : void{}
      
      private function playRenewActionCompleteCall(param1:Array) : void{}
      
      override protected function __die(param1:LivingEvent) : void{}
      
      private function clearEnemy() : void{}
      
      override protected function __changeState(param1:LivingEvent) : void{}
      
      override public function dispose() : void{}
      
      private function __disposeLater(param1:Event) : void{}
   }
}
