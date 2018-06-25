package gameStarling.animations
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   
   public class StrLinearTween extends BaseStageTween
   {
       
      
      private var _speed:int = 1;
      
      private var _duration:int = 0;
      
      public function StrLinearTween(data:TweenObject = null)
      {
         super(data);
      }
      
      override public function get type() : String
      {
         return "StrLinearTween";
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
            p.normalize(speed);
            result.x = result.x + p.x;
            result.y = result.y + p.y;
         }
         else
         {
            result = target;
         }
         return result;
      }
      
      public function set speed(value:int) : void
      {
         _speed = value;
      }
      
      public function get speed() : int
      {
         return _speed;
      }
      
      public function set duration(value:int) : void
      {
         _duration = value;
      }
      
      public function get duration() : int
      {
         return _duration;
      }
      
      override protected function get propertysNeed() : Array
      {
         return ["target","speed","duration"];
      }
   }
}
