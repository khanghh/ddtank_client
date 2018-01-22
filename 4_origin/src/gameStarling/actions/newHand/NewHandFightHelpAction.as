package gameStarling.actions.newHand
{
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   import gameStarling.view.map.MapView3D;
   
   public class NewHandFightHelpAction extends BaseNewHandFightHelpAction
   {
       
      
      private var _player:LocalPlayer;
      
      private var _enemyPlayer:Player;
      
      private var _bombs:Array;
      
      private var _shootOverCount:int;
      
      private var _map:MapView3D;
      
      public function NewHandFightHelpAction(param1:LocalPlayer, param2:int, param3:MapView3D)
      {
         super();
         _player = param1;
         _bombs = _player.lastFireBombs;
         _shootOverCount = param2;
         _map = param3;
      }
      
      override public function prepare() : void
      {
         super.prepare();
         if(!isInNewHandRoom)
         {
            _isFinished = true;
            return;
         }
         _enemyPlayer = getNewHandEnemy();
         if(!_enemyPlayer || !_player.isLiving || !_gameInfo)
         {
            _isFinished = true;
         }
         else if(_gameInfo.currentLiving != _player && _shootOverCount > 0)
         {
            _isFinished = false;
         }
         else if(_gameInfo.currentLiving == _player)
         {
            _player.NewHandEnemyBlood = _enemyPlayer.blood;
            _player.NewHandEnemyIsFrozen = _enemyPlayer.isFrozen;
            _player.NewHandSelfBlood = _player.blood;
            _isFinished = true;
         }
         else
         {
            _isFinished = true;
         }
      }
      
      override public function executeAtOnce() : void
      {
         super.executeAtOnce();
         if(!_player || !_gameInfo || !_map || !_enemyPlayer)
         {
            return;
         }
         if(checkShootDirection())
         {
            return;
         }
         if(checkShootOutMap())
         {
            return;
         }
         if(checkHurtEnemy())
         {
            return;
         }
      }
      
      override public function execute() : void
      {
         super.execute();
         _player = null;
         _bombs = null;
         _gameInfo = null;
         _map = null;
         _enemyPlayer = null;
      }
      
      private function getNewHandEnemy() : Player
      {
         var _loc3_:int = 0;
         var _loc2_:* = GameControl.Instance.Current.livings;
         for each(var _loc1_ in GameControl.Instance.Current.livings)
         {
            if(_loc1_.isPlayer() && _loc1_.isLiving && _loc1_ != _player)
            {
               return _loc1_ as Player;
            }
         }
         return null;
      }
      
      private function checkShootDirection() : Boolean
      {
         var _loc1_:Bomb = getRecentBomb();
         if(_loc1_ == null || _loc1_.Template.ID == 3)
         {
            return false;
         }
         var _loc2_:int = _enemyPlayer.pos.x > _player.pos.x?1:-1;
         var _loc3_:int = _loc1_.target.x >= _loc1_.X?1:-1;
         if(_loc2_ != _loc3_)
         {
            showFightTip("tank.trainer.fightAction.newHandTip1");
            return true;
         }
         return false;
      }
      
      private function checkShootOutMap() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _bombs;
         for each(var _loc1_ in _bombs)
         {
            if(_loc1_.Template.ID != 64 && _map.IsOutMap(_loc1_.target.x,_loc1_.target.y))
            {
               _player.NewHandHurtEnemyCounter++;
               checkHurtEnemy(false);
               showFightTip("tank.trainer.fightAction.newHandTip2");
               return true;
            }
         }
         return false;
      }
      
      private function checkHurtSelf() : Boolean
      {
         var _loc1_:int = _player.NewHandSelfBlood > 0?_player.NewHandSelfBlood:int(_player.maxBlood);
         if(_loc1_ > _player.blood)
         {
            _player.NewHandHurtSelfCounter++;
            if(_player.NewHandHurtSelfCounter > 0)
            {
               showFightTip("tank.trainer.fightAction.newHandTip4");
               return true;
            }
         }
         else
         {
            _player.NewHandHurtSelfCounter = 0;
         }
         return false;
      }
      
      private function getRecentBomb() : Bomb
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = -1;
         var _loc6_:int = 0;
         var _loc5_:* = _bombs;
         for each(var _loc2_ in _bombs)
         {
            _loc3_ = _loc2_.Template.ID;
            if(_loc2_ && (_loc3_ != 64 && _loc3_ != 3 && _loc3_ != 1) && (_loc4_ == -1 || Math.abs(_loc2_.target.x - _enemyPlayer.pos.x) < _loc4_))
            {
               _loc4_ = Math.abs(_loc2_.target.x - _enemyPlayer.pos.x);
               _loc1_ = _loc2_;
            }
         }
         return _loc1_;
      }
      
      private function checkHurtEnemy(param1:Boolean = true) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_player.NewHandEnemyBlood != _enemyPlayer.blood || _player.NewHandEnemyIsFrozen && !_enemyPlayer.isFrozen)
         {
            _player.NewHandHurtEnemyCounter = 0;
         }
         else
         {
            _loc2_ = getRecentBomb();
            if(_loc2_ == null)
            {
               return false;
            }
            _player.NewHandHurtEnemyCounter++;
            if(_player.NewHandHurtEnemyCounter > 1)
            {
               _loc3_ = _enemyPlayer.pos.x > _player.pos.x?1:-1;
               _loc4_ = _loc2_.target.x > _enemyPlayer.pos.x?1:-1;
               if(param1)
               {
                  showFightTip("tank.trainer.fightAction.newHandTip3" + (_loc3_ == _loc4_?"Small":"Large"));
               }
               return true;
            }
         }
         return false;
      }
   }
}
