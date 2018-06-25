package game.actions.newHand
{
   import game.view.map.MapView;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   
   public class NewHandFightHelpAction extends BaseNewHandFightHelpAction
   {
       
      
      private var _player:LocalPlayer;
      
      private var _enemyPlayer:Player;
      
      private var _bombs:Array;
      
      private var _shootOverCount:int;
      
      private var _map:MapView;
      
      public function NewHandFightHelpAction(player:LocalPlayer, shootOverCount:int, map:MapView)
      {
         super();
         _player = player;
         _bombs = _player.lastFireBombs;
         _shootOverCount = shootOverCount;
         _map = map;
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
         for each(var p in GameControl.Instance.Current.livings)
         {
            if(p.isPlayer() && p.isLiving && p != _player)
            {
               return p as Player;
            }
         }
         return null;
      }
      
      private function checkShootDirection() : Boolean
      {
         var bomb:Bomb = getRecentBomb();
         if(bomb == null || bomb.Template.ID == 3)
         {
            return false;
         }
         var dic1:int = _enemyPlayer.pos.x > _player.pos.x?1:-1;
         var dic2:int = bomb.target.x >= bomb.X?1:-1;
         if(dic1 != dic2)
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
         for each(var bomb in _bombs)
         {
            if(bomb.Template.ID != 64 && _map.IsOutMap(bomb.target.x,bomb.target.y))
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
         var blood:int = _player.NewHandSelfBlood > 0?_player.NewHandSelfBlood:int(_player.maxBlood);
         if(blood > _player.blood)
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
         var result:* = null;
         var TemplateID:int = 0;
         var inst:int = -1;
         var _loc6_:int = 0;
         var _loc5_:* = _bombs;
         for each(var bomb in _bombs)
         {
            TemplateID = bomb.Template.ID;
            if(bomb && (TemplateID != 64 && TemplateID != 3 && TemplateID != 1) && (inst == -1 || Math.abs(bomb.target.x - _enemyPlayer.pos.x) < inst))
            {
               inst = Math.abs(bomb.target.x - _enemyPlayer.pos.x);
               result = bomb;
            }
         }
         return result;
      }
      
      private function checkHurtEnemy(showTip:Boolean = true) : Boolean
      {
         var bomb:* = null;
         var dic1:int = 0;
         var dic2:int = 0;
         if(_player.NewHandEnemyBlood != _enemyPlayer.blood || _player.NewHandEnemyIsFrozen && !_enemyPlayer.isFrozen)
         {
            _player.NewHandHurtEnemyCounter = 0;
         }
         else
         {
            bomb = getRecentBomb();
            if(bomb == null)
            {
               return false;
            }
            _player.NewHandHurtEnemyCounter++;
            if(_player.NewHandHurtEnemyCounter > 1)
            {
               dic1 = _enemyPlayer.pos.x > _player.pos.x?1:-1;
               dic2 = bomb.target.x > _enemyPlayer.pos.x?1:-1;
               if(showTip)
               {
                  showFightTip("tank.trainer.fightAction.newHandTip3" + (dic1 == dic2?"Small":"Large"));
               }
               return true;
            }
         }
         return false;
      }
   }
}
