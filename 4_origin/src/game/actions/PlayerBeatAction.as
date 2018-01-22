package game.actions
{
   import ddt.view.character.GameCharacter;
   import game.objects.GameLocalPlayer;
   import game.objects.GamePlayer;
   import gameCommon.actions.BaseAction;
   
   public class PlayerBeatAction extends BaseAction
   {
       
      
      private var _player:GamePlayer;
      
      private var _count:int;
      
      public function PlayerBeatAction(param1:GamePlayer)
      {
         super();
         _player = param1;
         _count = 0;
      }
      
      override public function prepare() : void
      {
         _player.body.doAction(GameCharacter.HIT);
         _player.map.setTopPhysical(_player);
         if(_player is GameLocalPlayer)
         {
            GameLocalPlayer(_player).aim.visible = false;
         }
      }
      
      override public function execute() : void
      {
         _count = Number(_count) + 1;
         if(_count >= 50)
         {
            if(_player is GameLocalPlayer)
            {
               GameLocalPlayer(_player).aim.visible = true;
            }
            _isFinished = true;
         }
      }
   }
}
