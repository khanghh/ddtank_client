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
      
      override protected function excuteEffectImp(live:Living) : void
      {
         live.isLockAngle = true;
         super.excuteEffectImp(live);
      }
      
      override public function unExcuteEffect(live:Living) : void
      {
         live.isLockAngle = false;
      }
   }
}
