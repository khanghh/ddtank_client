package gameStarling.objects
{
   import ddt.events.LivingEvent;
   import gameCommon.model.SmallEnemy;
   import gameStarling.actions.MonsterShootBombAction;
   import road7th.data.StringObject;
   import starlingPhy.maps.Map3D;
   import starlingPhy.object.PhysicalObj3D;
   
   public class GameSmallEnemy3D extends GameLiving3D
   {
       
      
      private var _bombEvent:LivingEvent;
      
      private var _noDispose:Boolean = false;
      
      private var _disposedOverTurns:Boolean = true;
      
      public function GameSmallEnemy3D(param1:SmallEnemy){super(null);}
      
      override protected function initView() : void{}
      
      override public function setMap(param1:Map3D) : void{}
      
      public function get smallEnemy() : SmallEnemy{return null;}
      
      override protected function __bloodChanged(param1:LivingEvent) : void{}
      
      override protected function __die(param1:LivingEvent) : void{}
      
      override public function collidedByObject(param1:PhysicalObj3D) : void{}
      
      private function clearEnemy() : void{}
      
      private function removeEvents(param1:Boolean = false) : void{}
      
      override protected function __shoot(param1:LivingEvent) : void{}
      
      override protected function __beginNewTurn(param1:LivingEvent) : void{}
      
      override public function dispose() : void{}
      
      override public function setProperty(param1:String, param2:String) : void{}
   }
}
