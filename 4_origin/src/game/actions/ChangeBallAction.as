package game.actions
{
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Player;
   
   public class ChangeBallAction extends BaseAction
   {
       
      
      private var _player:Player;
      
      private var _currentBomb:int;
      
      private var _isSpecialSkill:Boolean;
      
      public function ChangeBallAction(param1:Player, param2:Boolean, param3:int)
      {
         super();
         _player = param1;
         _currentBomb = param3;
         _isSpecialSkill = param2;
      }
      
      override public function executeAtOnce() : void
      {
         super.executeAtOnce();
         if(!_player.isExist)
         {
            return;
         }
         _player.isSpecialSkill = _isSpecialSkill;
         _player.currentBomb = _currentBomb;
         if(_player.isSpecialSkill)
         {
            _player.addState(-1);
         }
      }
   }
}
