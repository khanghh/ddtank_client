package game.animations
{
   import game.objects.SimpleBomb;
   import phy.object.PhysicalObj;
   
   public class PhysicalObjFocusAnimation extends BaseSetCenterAnimation
   {
       
      
      private var _phy:PhysicalObj;
      
      public function PhysicalObjFocusAnimation(param1:PhysicalObj, param2:int = 100, param3:int = 0)
      {
         super(param1.x,param1.y + param3,param2,false);
         _phy = param1;
         _level = 1;
      }
      
      override public function canReplace(param1:IAnimate) : Boolean
      {
         var _loc2_:PhysicalObjFocusAnimation = param1 as PhysicalObjFocusAnimation;
         if(_loc2_ && _loc2_._phy != _phy)
         {
            if(_phy is SimpleBomb && _loc2_._phy is SimpleBomb)
            {
               if(!_phy.isLiving || SimpleBomb(_phy).info.Id > SimpleBomb(_loc2_._phy).info.Id)
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
