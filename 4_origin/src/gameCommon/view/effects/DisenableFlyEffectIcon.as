package gameCommon.view.effects
{
   import gameCommon.model.Living;
   
   public class DisenableFlyEffectIcon extends BaseMirariEffectIcon
   {
       
      
      public function DisenableFlyEffectIcon()
      {
         _iconClass = "asset.game.forbidFlyAsset";
         _iconImageClass = "game_buff_forbidFlyAsset";
         super();
      }
      
      override public function get mirariType() : int
      {
         return 8;
      }
      
      override protected function excuteEffectImp(live:Living) : void
      {
         live.isLockFly = true;
         super.excuteEffectImp(live);
      }
      
      override public function unExcuteEffect(live:Living) : void
      {
         live.isLockFly = false;
      }
   }
}
