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
      
      public function ShootBombAction(param1:GamePlayer, param2:Array, param3:CrazyTankSocketEvent, param4:int)
      {
         super();
         _player = param1;
         _bombs = param2;
         _event = param3;
         _shootInterval = param4;
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
      
      private function executeImp(param1:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         if(!_isShoot)
         {
            _isShoot = true;
            SoundManager.instance.play(_info.ShootSound);
            _loc5_ = 0;
            while(_loc5_ < _bombs.length)
            {
               _loc4_ = 0;
               while(_loc4_ < _bombs[_loc5_].Actions.length)
               {
                  if(_bombs[_loc5_].Actions[_loc4_].type == 5)
                  {
                     _bombs.unshift(_bombs.splice(_loc5_,1)[0]);
                     break;
                  }
                  _loc4_++;
               }
               _loc5_++;
            }
            var _loc7_:int = 0;
            var _loc6_:* = _bombs;
            for each(var _loc2_ in _bombs)
            {
               if(_loc2_.Template.BombType == 4)
               {
                  _loc3_ = new SkillBomb(_loc2_,_player.info);
               }
               else if(_loc2_.Template.BombType == 17)
               {
                  _loc3_ = new PhantomBomb(_loc2_,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(_loc2_.Template.BombType == 18)
               {
                  _loc3_ = new FenShenBomb(_loc2_,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(_loc2_.Template.BombType == 19)
               {
                  _loc3_ = new SpringTimerBomb(_loc2_,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(_loc2_.Template.BombType == 20)
               {
                  _loc3_ = new ThroughWallBomb(_loc2_,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(_loc2_.Template.BombType == 22)
               {
                  _loc3_ = new VerticalBomb(_loc2_,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(_loc2_.Template.BombType == 23)
               {
                  _loc3_ = new WalkBomb(_loc2_,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(_loc2_.Template.BombType == 24)
               {
                  _loc3_ = new TowBomb(_loc2_,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(_loc2_.Template.BombType == 26)
               {
                  _loc3_ = new SpiderBomb1(_loc2_,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(_loc2_.Template.BombType == 27)
               {
                  _loc3_ = new SpiderBomb2(_loc2_,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else if(_loc2_.Template.BombType == 28)
               {
                  _loc3_ = new BurrowBomb(_loc2_,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               else
               {
                  _loc3_ = new SimpleBomb(_loc2_,_player.info,_player.player.currentWeapInfo.refineryLevel);
               }
               _player.map.addPhysical(_loc3_);
               if(param1)
               {
                  _loc3_.bombAtOnce();
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
