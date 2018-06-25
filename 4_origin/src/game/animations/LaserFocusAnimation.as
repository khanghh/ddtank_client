package game.animations
{
   import phy.object.PhysicalObj;
   
   public class LaserFocusAnimation extends PhysicalObjFocusAnimation
   {
       
      
      public function LaserFocusAnimation(phy:PhysicalObj, life:int = 100, offsetY:int = 0)
      {
         super(phy,life,offsetY);
      }
   }
}
