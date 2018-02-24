package gameStarling.animations
{
   import gameStarling.objects.SimpleBomb3D;
   import starlingPhy.object.PhysicalObj3D;
   
   public class PhysicalObjFocusAnimation extends BaseSetCenterAnimation
   {
       
      
      private var _phy:PhysicalObj3D;
      
      public function PhysicalObjFocusAnimation(param1:PhysicalObj3D, param2:int = 100, param3:int = 0){super(null,null,null,null);}
      
      override public function canReplace(param1:IAnimate) : Boolean{return false;}
   }
}
