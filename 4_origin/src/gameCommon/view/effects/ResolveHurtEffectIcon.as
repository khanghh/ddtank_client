package gameCommon.view.effects
{
   import gameStarling.animations.IAnimate;
   
   public class ResolveHurtEffectIcon extends BaseMirariEffectIcon
   {
       
      
      private var _skillAnimation:IAnimate;
      
      public function ResolveHurtEffectIcon()
      {
         _iconClass = "asset.game.resolveHurtAsset";
         _iconImageClass = "game_buff_resolveHurtAsset";
         super();
      }
      
      override public function get mirariType() : int
      {
         return 10;
      }
   }
}
