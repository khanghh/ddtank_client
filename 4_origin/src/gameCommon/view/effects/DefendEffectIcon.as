package gameCommon.view.effects
{
   public class DefendEffectIcon extends BaseMirariEffectIcon
   {
       
      
      public function DefendEffectIcon()
      {
         _iconClass = "asset.game.shieldAsset";
         _iconImageClass = "game_buff_shieldAsset";
         super();
      }
      
      override public function get mirariType() : int
      {
         return 6;
      }
   }
}
