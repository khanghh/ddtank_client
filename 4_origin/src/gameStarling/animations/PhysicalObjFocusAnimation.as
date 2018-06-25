package gameStarling.animations
{
   import gameStarling.objects.SimpleBomb3D;
   import starlingPhy.object.PhysicalObj3D;
   
   public class PhysicalObjFocusAnimation extends BaseSetCenterAnimation
   {
       
      
      private var _phy:PhysicalObj3D;
      
      public function PhysicalObjFocusAnimation(phy:PhysicalObj3D, life:int = 100, offsetY:int = 0)
      {
         super(phy.x,phy.y + offsetY,life,false);
         _phy = phy;
         _level = 1;
      }
      
      override public function canReplace(anit:IAnimate) : Boolean
      {
         var at:PhysicalObjFocusAnimation = anit as PhysicalObjFocusAnimation;
         if(at && at._phy != _phy)
         {
            if(_phy is SimpleBomb3D && at._phy is SimpleBomb3D)
            {
               if(!_phy.isLiving || SimpleBomb3D(_phy).info.Id > SimpleBomb3D(at._phy).info.Id)
               {
                  return true;
               }
               return false;
            }
         }
         return true;
      }
   }
}
