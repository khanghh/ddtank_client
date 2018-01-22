package gameStarling.animations
{
   import gameStarling.objects.SimpleBomb3D;
   import starlingPhy.object.PhysicalObj3D;
   
   public class PhysicalObjFocusAnimation extends BaseSetCenterAnimation
   {
       
      
      private var _phy:PhysicalObj3D;
      
      public function PhysicalObjFocusAnimation(param1:PhysicalObj3D, param2:int = 100, param3:int = 0)
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
            if(_phy is SimpleBomb3D && _loc2_._phy is SimpleBomb3D)
            {
               if(!_phy.isLiving || SimpleBomb3D(_phy).info.Id > SimpleBomb3D(_loc2_._phy).info.Id)
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
