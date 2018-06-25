package game.animations
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class StrDirectlyTween extends BaseStageTween
   {
       
      
      public function StrDirectlyTween(data:TweenObject = null)
      {
         super(data);
      }
      
      override public function get type() : String
      {
         return "StrDirectlyTween";
      }
      
      override public function update(movie:DisplayObject) : Point
      {
         _isFinished = true;
         return target;
      }
      
      override protected function get propertysNeed() : Array
      {
         return ["target"];
      }
   }
}
