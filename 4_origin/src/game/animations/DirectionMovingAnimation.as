package game.animations
{
   import game.view.map.MapView;
   
   public class DirectionMovingAnimation extends BaseAnimate
   {
      
      public static const UP:String = "up";
      
      public static const DOWN:String = "down";
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
       
      
      private var _dir:String;
      
      public function DirectionMovingAnimation(dir:String)
      {
         super();
         _dir = dir;
         _level = 1;
      }
      
      override public function cancel() : void
      {
         _finished = true;
      }
      
      override public function update(movie:MapView) : Boolean
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
                  movie.y = movie.y - 18;
               }
               else
               {
                  movie.y = movie.y + 18;
               }
            }
            else
            {
               movie.x = movie.x + 18;
            }
         }
         else
         {
            movie.x = movie.x - 18;
         }
         return true;
      }
   }
}
