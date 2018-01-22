package gameCommon.view.effects
{
   public class WeaknessEffectIcon extends BaseMirariEffectIcon
   {
      
      public static const MIRARI_TYPE:int = 4;
       
      
      public function WeaknessEffectIcon()
      {
         _iconClass = "asset.game.TargetingAsset";
         _iconImageClass = "game_buff_TargetingAsset";
         super();
      }
      
      override public function get mirariType() : int
      {
         return 4;
      }
   }
}
