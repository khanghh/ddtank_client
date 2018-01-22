package gameStarling.actions
{
   import ddt.command.PlayerAction;
   import ddt.data.BallInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.BallManager;
   import ddt.manager.SoundManager;
   import ddt.view.characterStarling.GameCharacter3D;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Bomb;
   import gameCommon.model.LocalPlayer;
   import gameStarling.objects.BurrowBomb3D;
   import gameStarling.objects.FenShenBomb3D;
   import gameStarling.objects.GameLocalPlayer3D;
   import gameStarling.objects.GamePlayer3D;
   import gameStarling.objects.PhantomBomb3D;
   import gameStarling.objects.SimpleBomb3D;
   import gameStarling.objects.SkillBomb3D;
   import gameStarling.objects.SpiderBomb13D;
   import gameStarling.objects.SpiderBomb23D;
   import gameStarling.objects.SpringTimerBomb3D;
   import gameStarling.objects.ThroughWallBomb3D;
   import gameStarling.objects.TotemBall3D;
   import gameStarling.objects.TowBomb3D;
   import gameStarling.objects.VerticalBomb3D;
   import gameStarling.objects.WalkBomb3D;
   import starlingPhy.bombs.BaseBomb3D;
   
   public class ShootBombAction extends BaseAction
   {
       
      
      private var _player:GamePlayer3D;
      
      private var _showAction:PlayerAction;
      
      private var _hideAction:PlayerAction;
      
      private var _bombs:Array;
      
      private var _isShoot:Boolean;
      
      private var _shootInterval:int;
      
      private var _info:BallInfo;
      
      private var _event:CrazyTankSocketEvent;
      
      public function ShootBombAction(param1:GamePlayer3D, param2:Array, param3:CrazyTankSocketEvent, param4:int){super();}
      
      override public function prepare() : void{}
      
      override public function execute() : void{}
      
      private function setSelfShootFinish() : void{}
      
      private function finish() : void{}
      
      private function executeImp(param1:Boolean) : void{}
      
      override public function executeAtOnce() : void{}
   }
}
