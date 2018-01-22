package gameCommon.view.effects
{
   public class TiredEffectIcon extends BaseMirariEffectIcon
   {
       
      
      public function TiredEffectIcon()
      {
         _iconClass = "asset.game.tiredAsset";
         _iconImageClass = "game_buff_tiredAsset";
         super();
      }
      
      override public function get mirariType() : int
      {
         return 1;
      }
   }
}
