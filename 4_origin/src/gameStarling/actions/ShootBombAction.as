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
      
      public function ShootBombAction(player:GamePlayer3D, bombs:Array, event:CrazyTankSocketEvent, interval:int)
      {
         super();
         _player = player;
         _bombs = bombs;
         _event = event;
         _shootInterval = interval;
         _event.executed = false;
      }
      
      override public function prepare() : void
      {
         if(_isPrepare)
         {
            return;
         }
         _isPrepare = true;
         if(_player == null || _player.body == null || _player.player == null)
         {
            finish();
            return;
         }
         _info = BallManager.instance.findBall(_player.player.currentBomb);
         _showAction = _info.ActionType == 0?GameCharacter3D.THROWS:GameCharacter3D.SHOT;
         _hideAction = _info.ActionType == 0?GameCharacter3D.HIDETHROWS:GameCharacter3D.HIDEGUN;
         if(_player.isLiving)
         {
            _player.body.doAction(_showAction);
            if(_player.weaponMovie)
            {
               _player.weaponMovie.asDisplay.visible = true;
               _player.setWeaponMoiveActionSyc("shot");
               _player.body.WingState = "shot";
            }
         }
      }
      
      override public function execute() : void
      {
         if(_player == null || _player.body == null || _player.body.currentAction == null)
         {
            finish();
            return;
         }
         if(_player.body.currentAction != _showAction)
         {
            if(_player.weaponMovie)
            {
               _player.weaponMovie.asDisplay.visible = false;
            }
            _player.body.WingState = "stand";
         }
         if(!_isShoot)
         {
            if(!_player.body.actionPlaying() || _player.body.currentAction != _showAction)
            {
               executeImp(false);
            }
         }
         else
         {
            _shootInterval = Number(_shootInterval) - 1;
            if(_shootInterval <= 0)
            {
               if(_player.body.currentAction == _showAction)
               {
                  if(_player.isLiving)
                  {
                     _player.body.doAction(_hideAction);
                  }
                  if(_player.weaponMovie)
                  {
                     _player.setWeaponMoiveActionSyc("end");
                  }
                  _player.body.WingState = "stand";
               }
               finish();
            }
         }
      }
      
      private function setSelfShootFinish() : void
      {
         if(!_player.isExist)
         {
            return;
         }
         if(!_player.info.isSelf)
         {
            return;
         }
         if(GameLocalPlayer3D(_player).shootOverCount >= LocalPlayer(_player.info).shootCount)
         {
            GameLocalPlayer3D(_player).shootOverCount = LocalPlayer(_player.info).shootCount;
         }
         else
         {
            GameLocalPlayer3D(_player).shootOverCount++;
         }
      }
      
      private function finish() : void
      {
         _isFinished = true;
         _event.executed = true;
         setSelfShootFinish();
      }
      
      private function executeImp(fastModel:Boolean) : void
      {
         var i:int = 0;
         var j:int = 0;
         var bomb:* = null;
         if(!_isShoot)
         {
            _isShoot = true;
            SoundManager.instance.play(_info.ShootSound);
            for(i = 0; i < _bombs.length; )
            {
               for(j = 0; j < _bombs[i].Actions.length; )
               {
                  if(_bombs[i].Actions[j].type == 5)
                  {
                     _bombs.unshift(_bombs.splice(i,1)[0]);
                     break;
                  }
                  j++;
               }
               i++;
            }
            var _loc7_:int = 0;
            var _loc6_:* = _bombs;
            for each(var b in _bombs)
            {
               if(b.Template.BombType == 4)
               {
                  bomb = new SkillBomb3D(b,_player.info);
               }
               else if(b.Template.BombType == 17)
               {
                  bomb = new PhantomBomb3D(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 18)
               {
                  bomb = new FenShenBomb3D(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 19)
               {
                  bomb = new SpringTimerBomb3D(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 20)
               {
                  bomb = new ThroughWallBomb3D(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 22)
               {
                  bomb = new VerticalBomb3D(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 23)
               {
                  bomb = new WalkBomb3D(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 24)
               {
                  bomb = new TowBomb3D(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 26)
               {
                  bomb = new SpiderBomb13D(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 27)
               {
                  bomb = new SpiderBomb23D(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 28)
               {
                  bomb = new BurrowBomb3D(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 29)
               {
                  bomb = new TotemBall3D(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else
               {
                  bomb = new SimpleBomb3D(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               _player.map.addPhysical(bomb);
               if(fastModel)
               {
                  bomb.bombAtOnce();
               }
            }
         }
      }
      
      override public function executeAtOnce() : void
      {
         super.executeAtOnce();
         executeImp(true);
      }
   }
}
