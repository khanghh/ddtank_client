package game.animations
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class StrStayTween extends BaseStageTween
   {
       
      
      public function StrStayTween(param1:TweenObject = null){super(null);}
      
      override public function get type() : String{return null;}
      
      override public function get isFinished() : Boolean{return false;}
      
      override public function update(param1:DisplayObject) : Point{return null;}
   }
}
