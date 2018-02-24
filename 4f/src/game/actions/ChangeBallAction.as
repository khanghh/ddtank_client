package game.actions
{
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Player;
   
   public class ChangeBallAction extends BaseAction
   {
       
      
      private var _player:Player;
      
      private var _currentBomb:int;
      
      private var _isSpecialSkill:Boolean;
      
      public function ChangeBallAction(param1:Player, param2:Boolean, param3:int){super();}
      
      override public function executeAtOnce() : void{}
   }
}
