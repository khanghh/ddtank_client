package game.actions
{
   import flash.events.Event;
   import game.objects.GamePlayer;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   
   public class WeaponShootAction extends BaseAction
   {
       
      
      private var _player:GamePlayer;
      
      public function WeaponShootAction(param1:GamePlayer)
      {
         super();
         _player = param1;
      }
      
      override public function prepare() : void
      {
         if(GameControl.Instance.Current.roomType == 29)
         {
            _isFinished = true;
            return;
         }
         _player.body.dynamicWeapon.addEventListener("complete",__onPlayComplete);
         _player.body.dynamicWeapon.gotoAndPlay("end");
      }
      
      private function __onPlayComplete(param1:Event) : void
      {
         _player.body.dynamicWeapon.removeEventListener("complete",__onPlayComplete);
         _player.body.dynamicWeapon.stop();
         _player.body.dynamicWeapon.visible = false;
         _isFinished = true;
      }
      
      override public function execute() : void
      {
      }
   }
}
