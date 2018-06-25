package gameStarling.animations
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   
   public class StrShockingLinearTween extends StrLinearTween
   {
       
      
      protected var shockingX:int;
      
      protected var shockingY:int;
      
      protected var shockingFreq:uint = 1;
      
      protected var life:uint;
      
      public function StrShockingLinearTween(data:TweenObject = null)
      {
         super(data);
         life = 0;
      }
      
      override public function get type() : String
      {
         return "StrShockingLinearTween";
      }
      
      override public function copyPropertyFromData(data:TweenObject) : void
      {
         shockingX = data.shockingX;
         shockingY = data.shockingY;
         duration = data.duration;
         target = data.target;
         speed = data.speed;
      }
      
      override public function update(movie:DisplayObject) : Point
      {
         var result:Point = super.update(movie);
         if(!result)
         {
            return null;
         }
         if(life == duration)
         {
            _isFinished = true;
            return result;
         }
         if(life == 0)
         {
            result.x = result.x + shockingX;
            shockingX = -shockingX;
            result.y = result.y + shockingY;
            shockingY = -shockingY;
         }
         life = Number(life) + 1;
         if(life % shockingFreq == 0)
         {
            result.x = result.x + shockingX * 2;
            shockingX = -shockingX;
            result.y = result.y + shockingY * 2;
            shockingY = -shockingY;
         }
         return result;
      }
      
      override protected function get propertysNeed() : Array
      {
         return ["target","speed","shockingX","shockingY","shockingFreq"];
      }
   }
}
