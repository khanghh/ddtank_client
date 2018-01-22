package gameCommon.view.effects
{
   import gameCommon.model.Living;
   
   public class LockAngleEffectIcon extends BaseMirariEffectIcon
   {
       
      
      public function LockAngleEffectIcon()
      {
         _iconClass = "asset.game.lockAngelAsset";
         _iconImageClass = "game_buff_lockAngelAsset";
         super();
      }
      
      override public function get mirariType() : int
      {
         return 3;
      }
      
      override protected function excuteEffectImp(param1:Living) : void
      {
         param1.isLockAngle = true;
         super.excuteEffectImp(param1);
      }
      
      override public function unExcuteEffect(param1:Living) : void
      {
         param1.isLockAngle = false;
      }
   }
}
