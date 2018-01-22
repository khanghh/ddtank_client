package gameStarling.animations
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   
   public class StrHighSpeedLinearTween extends BaseStageTween
   {
       
      
      private var _speed:int = 8;
      
      public function StrHighSpeedLinearTween(param1:TweenObject = null){super(null);}
      
      override public function update(param1:DisplayObject) : Point{return null;}
      
      override protected function get propertysNeed() : Array{return null;}
   }
}
