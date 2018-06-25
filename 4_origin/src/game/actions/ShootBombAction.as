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
      
      public function ShootBombAction(player:GamePlayer, bombs:Array, event:CrazyTankSocketEvent, interval:int)
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
         _showAction = _info.ActionType == 0?GameCharacter.THROWS:GameCharacter.SHOT;
         _hideAction = _info.ActionType == 0?GameCharacter.HIDETHROWS:GameCharacter.HIDEGUN;
         if(_player.isLiving)
         {
            _player.body.doAction(_showAction);
            if(_player.weaponMovie)
            {
               _player.weaponMovie.visible = true;
               _player.setWeaponMoiveActionSyc("shot");
               _player.body.WingState = 5;
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
               _player.weaponMovie.visible = false;
            }
            _player.body.WingState = 1;
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
                  _player.body.WingState = 1;
               }
               if(EquipType.isDynamicWeapon(_player.player.playerInfo.WeaponID) && GameControl.Instance.Current.roomType != 29)
               {
                  _player.body.dynamicWeapon.gotoAndPlay("stand");
                  _player.body.dynamicWeapon.visible = true;
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
         if(GameLocalPlayer(_player).shootOverCount >= LocalPlayer(_player.info).shootCount)
         {
            GameLocalPlayer(_player).shootOverCount = LocalPlayer(_player.info).shootCount;
         }
         else
         {
            GameLocalPlayer(_player).shootOverCount++;
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
                  bomb = new SkillBomb(b,_player.info);
               }
               else if(b.Template.BombType == 17)
               {
                  bomb = new PhantomBomb(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 18)
               {
                  bomb = new FenShenBomb(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 19)
               {
                  bomb = new SpringTimerBomb(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 20)
               {
                  bomb = new ThroughWallBomb(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 22)
               {
                  bomb = new VerticalBomb(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 23)
               {
                  bomb = new WalkBomb(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 24)
               {
                  bomb = new TowBomb(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 26)
               {
                  bomb = new SpiderBomb1(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 27)
               {
                  bomb = new SpiderBomb2(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(b.Template.BombType == 28)
               {
                  bomb = new BurrowBomb(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else
               {
                  bomb = new SimpleBomb(b,_player.info,_player.player.currentWeapInfo.refineryLevel);
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
