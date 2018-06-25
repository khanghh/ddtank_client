package game.animations
{
   import game.objects.SimpleBomb;
   import phy.object.PhysicalObj;
   
   public class PhysicalObjFocusAnimation extends BaseSetCenterAnimation
   {
       
      
      private var _phy:PhysicalObj;
      
      public function PhysicalObjFocusAnimation(phy:PhysicalObj, life:int = 100, offsetY:int = 0)
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
            if(_phy is SimpleBomb && at._phy is SimpleBomb)
            {
               if(!_phy.isLiving || SimpleBomb(_phy).info.Id > SimpleBomb(at._phy).info.Id)
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
