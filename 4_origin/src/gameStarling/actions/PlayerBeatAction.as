package gameStarling.actions
{
   import ddt.view.characterStarling.GameCharacter3D;
   import gameCommon.actions.BaseAction;
   import gameStarling.objects.GameLocalPlayer3D;
   import gameStarling.objects.GamePlayer3D;
   
   public class PlayerBeatAction extends BaseAction
   {
       
      
      private var _player:GamePlayer3D;
      
      private var _count:int;
      
      public function PlayerBeatAction(player:GamePlayer3D)
      {
         super();
         _player = player;
         _count = 0;
      }
      
      override public function prepare() : void
      {
         _player.body.doAction(GameCharacter3D.HIT);
         _player.map.setTopPhysical(_player);
         if(_player is GameLocalPlayer3D)
         {
            GameLocalPlayer3D(_player).aim.visible = false;
         }
      }
      
      override public function execute() : void
      {
         _count = Number(_count) + 1;
         if(_count >= 50)
         {
            if(_player is GameLocalPlayer3D)
            {
               GameLocalPlayer3D(_player).aim.visible = true;
            }
            _isFinished = true;
         }
      }
   }
}
