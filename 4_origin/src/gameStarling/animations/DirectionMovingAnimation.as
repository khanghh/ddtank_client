package gameStarling.animations
{
   import gameStarling.view.map.MapView3D;
   
   public class DirectionMovingAnimation extends BaseAnimate
   {
      
      public static const UP:String = "up";
      
      public static const DOWN:String = "down";
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
       
      
      private var _dir:String;
      
      public function DirectionMovingAnimation(param1:String)
      {
         super();
         _dir = param1;
         _level = 1;
      }
      
      override public function cancel() : void
      {
         _finished = true;
      }
      
      override public function update(param1:MapView3D) : Boolean
      {
         var _loc2_:* = _dir;
         if("right" !== _loc2_)
         {
            if("left" !== _loc2_)
            {
               if("up" !== _loc2_)
               {
                  if("down" !== _loc2_)
                  {
                     return false;
                  }
                  param1.y = param1.y - 18;
               }
               else
               {
                  param1.y = param1.y + 18;
               }
            }
            else
            {
               param1.x = param1.x + 18;
            }
         }
         else
         {
            param1.x = param1.x - 18;
         }
         return true;
      }
   }
}
