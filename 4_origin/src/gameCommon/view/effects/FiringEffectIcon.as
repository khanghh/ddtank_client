package gameCommon.view.effects
{
   public class FiringEffectIcon extends BaseMirariEffectIcon
   {
      
      public static const MIRARI_TYPE:int = 2;
       
      
      public function FiringEffectIcon()
      {
         _iconClass = "asset.game.fireAsset";
         _iconImageClass = "game_buff_fireAsset";
         super();
      }
      
      override public function get mirariType() : int
      {
         return 2;
      }
   }
}
