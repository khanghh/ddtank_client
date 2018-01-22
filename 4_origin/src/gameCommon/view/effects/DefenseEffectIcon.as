package gameCommon.view.effects
{
   public class DefenseEffectIcon extends BaseMirariEffectIcon
   {
       
      
      public function DefenseEffectIcon()
      {
         _iconClass = "asset.game.buff.defense";
         _iconImageClass = "game_buff_defense";
         super();
      }
      
      override public function get mirariType() : int
      {
         return 14;
      }
   }
}
