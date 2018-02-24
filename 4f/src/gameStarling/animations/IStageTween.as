package gameStarling.animations
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   
   public interface IStageTween
   {
       
      
      function initData(param1:TweenObject) : void;
      
      function update(param1:DisplayObject) : Point;
   }
}
