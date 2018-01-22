package gameCommon.view.effects
{
   public class NoHoleEffectIcon extends BaseMirariEffectIcon
   {
       
      
      public function NoHoleEffectIcon()
      {
         _iconClass = "asset.game.notDigAsset";
         _iconImageClass = "game_buff_notDigAsset";
         super();
      }
      
      override public function get mirariType() : int
      {
         return 5;
      }
   }
}
