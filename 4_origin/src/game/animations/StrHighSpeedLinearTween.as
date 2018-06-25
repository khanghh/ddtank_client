package game.animations
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class StrHighSpeedLinearTween extends BaseStageTween
   {
       
      
      private var _speed:int = 8;
      
      public function StrHighSpeedLinearTween(data:TweenObject = null)
      {
         super(data);
      }
      
      override public function update(movie:DisplayObject) : Point
      {
         if(!_prepared)
         {
            return null;
         }
         var result:Point = new Point(movie.x,movie.y);
         var p:Point = new Point(target.x - movie.x,target.y - movie.y);
         if(p.length >= _speed)
         {
            p.normalize(_speed);
            result.x = result.x + p.x;
            result.y = result.y + p.y;
         }
         else
         {
            result = target;
            _isFinished = true;
         }
         return result;
      }
      
      override protected function get propertysNeed() : Array
      {
         return ["target","speed"];
      }
   }
}
