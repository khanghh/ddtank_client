package game.actions
{
   import ddt.command.PlayerAction;
   import ddt.data.BallInfo;
   import ddt.data.EquipType;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.BallManager;
   import ddt.manager.SoundManager;
   import ddt.view.character.GameCharacter;
   import game.objects.BurrowBomb;
   import game.objects.FenShenBomb;
   import game.objects.GameLocalPlayer;
   import game.objects.GamePlayer;
   import game.objects.PhantomBomb;
   import game.objects.SimpleBomb;
   import game.objects.SkillBomb;
   import game.objects.SpiderBomb1;
   import game.objects.SpiderBomb2;
   import game.objects.SpringTimerBomb;
   import game.objects.ThroughWallBomb;
   import game.objects.TowBomb;
   import game.objects.VerticalBomb;
   import game.objects.WalkBomb;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Bomb;
   import gameCommon.model.LocalPlayer;
   import phy.bombs.BaseBomb;
   
   public class ShootBombAction extends BaseAction
   {
       
      
      private var _player:GamePlayer;
      
      private var _showAction:PlayerAction;
      
      private var _hideAction:PlayerAction;
      
      private var _bombs:Array;
      
      private var _isShoot:Boolean;
      
      private var _shootInterval:int;
      
      private var _info:BallInfo;
      
      private var _event:CrazyTankSocketEvent;
      
      public function ShootBombAction(param1:GamePlayer, param2:Array, param3:CrazyTankSocketEvent, param4:int){super();}
      
      override public function prepare() : void{}
      
      override public function execute() : void{}
      
      private function setSelfShootFinish() : void{}
      
      private function finish() : void{}
      
      private function executeImp(param1:Boolean) : void{}
      
      override public function executeAtOnce() : void{}
   }
}
