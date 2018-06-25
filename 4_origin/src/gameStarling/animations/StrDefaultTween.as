package gameStarling.animations
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   
   public class StrDefaultTween extends BaseStageTween
   {
       
      
      protected var speed:int = 4;
      
      public function StrDefaultTween(data:TweenObject = null)
      {
         super(data);
      }
      
      override public function get type() : String
      {
         return "StrDefaultTween";
      }
      
      override public function copyPropertyFromData(data:TweenObject) : void
      {
         if(data.target)
         {
            target = data.target;
         }
         if(data.speed)
         {
            speed = data.speed;
         }
      }
      
      override public function update(movie:DisplayObject) : Point
      {
         if(!_prepared)
         {
            return null;
         }
         var result:Point = new Point(movie.x,movie.y);
         var p:Point = new Point(target.x - movie.x,target.y - movie.y);
         if(p.length >= speed)
         {
            p.normalize(p.length / 16 * speed);
            result.x = result.x + p.x;
            result.y = result.y + p.y;
         }
         else
         {
            result.x = result.x + p.x;
            result.y = result.y + p.y;
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
