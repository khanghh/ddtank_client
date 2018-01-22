package gameCommon.view.effects
{
   public class TargetingEffectIcon extends BaseMirariEffectIcon
   {
       
      
      public function TargetingEffectIcon()
      {
         _iconClass = "asset.game.TargetingAsset";
         _iconImageClass = "game_buff_TargetingAsset";
         super();
      }
      
      override public function get mirariType() : int
      {
         return 7;
      }
   }
}
