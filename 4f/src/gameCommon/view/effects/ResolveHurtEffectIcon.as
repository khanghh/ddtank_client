package gameCommon.view.effects
{
   import gameStarling.animations.IAnimate;
   
   public class ResolveHurtEffectIcon extends BaseMirariEffectIcon
   {
       
      
      private var _skillAnimation:IAnimate;
      
      public function ResolveHurtEffectIcon(){super();}
      
      override public function get mirariType() : int{return 0;}
   }
}
