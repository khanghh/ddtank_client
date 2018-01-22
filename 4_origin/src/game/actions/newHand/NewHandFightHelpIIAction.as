package game.actions.newHand
{
   import ddt.manager.PlayerManager;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   
   public class NewHandFightHelpIIAction extends BaseNewHandFightHelpAction
   {
       
      
      private var _player:LocalPlayer;
      
      private var _diffBlood:int;
      
      public function NewHandFightHelpIIAction(param1:LocalPlayer, param2:Number)
      {
         super();
         _player = param1;
         _diffBlood = param2;
      }
      
      override public function prepare() : void
      {
         super.prepare();
         if(!isInNewHandRoom)
         {
            _isFinished = true;
            return;
         }
         if(!(_gameInfo.currentLiving == _player && _player.isLiving))
         {
            _isFinished = true;
         }
      }
      
      override public function connect(param1:BaseAction) : Boolean
      {
         var _loc2_:NewHandFightHelpIIAction = param1 as NewHandFightHelpIIAction;
         if(_loc2_)
         {
            return true;
         }
         return false;
      }
      
      override public function executeAtOnce() : void
      {
         super.executeAtOnce();
         if(!_player.isLiving && !isInNewHandRoom)
         {
            return;
         }
         if(checkSelfBlood())
         {
            return;
         }
      }
      
      override public function execute() : void
      {
         super.execute();
         _player = null;
         _gameInfo = null;
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
      
      private function checkBeEnemyHurt() : Boolean
      {
         if(_player.isAttacking)
         {
            return false;
         }
         if(!_player.lockFly && _diffBlood < 0)
         {
            _player.NewHandBeEnemyHurtCounter++;
            if(_player.NewHandBeEnemyHurtCounter % 2 == 0)
            {
               showFightTip("tank.trainer.fightAction.newHandTip5");
               return true;
            }
         }
         else
         {
            _player.NewHandBeEnemyHurtCounter = 0;
         }
         return false;
      }
      
      private function checkSelfBlood() : Boolean
      {
         return false;
      }
      
      private function getPropNum() : int
      {
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(32))
         {
            return 8;
         }
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(22))
         {
            return 7;
         }
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(21))
         {
            return 4;
         }
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(20))
         {
            return 3;
         }
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(19))
         {
            return 2;
         }
         return 0;
      }
   }
}
