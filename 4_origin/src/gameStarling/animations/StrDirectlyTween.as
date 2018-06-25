package gameStarling.animations
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   
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
