package gameStarling.animations
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   
   public class StrStayTween extends BaseStageTween
   {
       
      
      public function StrStayTween(param1:TweenObject = null){super(null);}
      
      override public function get type() : String{return null;}
      
      override public function get isFinished() : Boolean{return false;}
      
      override public function update(param1:DisplayObject) : Point{return null;}
   }
}
