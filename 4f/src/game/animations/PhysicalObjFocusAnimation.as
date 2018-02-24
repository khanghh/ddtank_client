package game.animations
{
   import game.objects.SimpleBomb;
   import phy.object.PhysicalObj;
   
   public class PhysicalObjFocusAnimation extends BaseSetCenterAnimation
   {
       
      
      private var _phy:PhysicalObj;
      
      public function PhysicalObjFocusAnimation(param1:PhysicalObj, param2:int = 100, param3:int = 0){super(null,null,null,null);}
      
      override public function canReplace(param1:IAnimate) : Boolean{return false;}
   }
}
