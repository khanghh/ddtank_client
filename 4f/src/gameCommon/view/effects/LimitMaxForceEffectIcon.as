package gameCommon.view.effects
{
   public class LimitMaxForceEffectIcon extends BaseMirariEffectIcon
   {
       
      
      public var force:int;
      
      public function LimitMaxForceEffectIcon(){super();}
      
      override public function get mirariType() : int{return 0;}
      
      override public function get single() : Boolean{return false;}
   }
}
