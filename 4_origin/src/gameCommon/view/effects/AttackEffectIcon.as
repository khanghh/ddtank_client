package gameCommon.view.effects
{
   public class AttackEffectIcon extends BaseMirariEffectIcon
   {
       
      
      public function AttackEffectIcon()
      {
         _iconClass = "asset.game.buff.attack";
         _iconImageClass = "game_buff_attack";
         super();
      }
      
      override public function get mirariType() : int
      {
         return 13;
      }
   }
}
