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
      
      override protected function excuteEffectImp(param1:Living) : void
      {
         param1.isLockFly = true;
         super.excuteEffectImp(param1);
      }
      
      override public function unExcuteEffect(param1:Living) : void
      {
         param1.isLockFly = false;
      }
   }
}
