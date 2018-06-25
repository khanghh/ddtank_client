package game.animations
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class StrStayTween extends BaseStageTween
   {
       
      
      public function StrStayTween(data:TweenObject = null)
      {
         super(data);
      }
      
      override public function get type() : String
      {
         return "StrStay";
      }
      
      override public function get isFinished() : Boolean
      {
         return true;
      }
      
      override public function update(movie:DisplayObject) : Point
      {
         if(!_prepared)
         {
            return null;
         }
         var result:Point = new Point(movie.x,movie.y);
         return result;
      }
   }
}
