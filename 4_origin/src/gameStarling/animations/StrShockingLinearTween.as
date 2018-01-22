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
      
      public function StrShockingLinearTween(param1:TweenObject = null)
      {
         super(param1);
         life = 0;
      }
      
      override public function get type() : String
      {
         return "StrShockingLinearTween";
      }
      
      override public function copyPropertyFromData(param1:TweenObject) : void
      {
         shockingX = param1.shockingX;
         shockingY = param1.shockingY;
         duration = param1.duration;
         target = param1.target;
         speed = param1.speed;
      }
      
      override public function update(param1:DisplayObject) : Point
      {
         var _loc2_:Point = super.update(param1);
         if(!_loc2_)
         {
            return null;
         }
         if(life == duration)
         {
            _isFinished = true;
            return _loc2_;
         }
         if(life == 0)
         {
            _loc2_.x = _loc2_.x + shockingX;
            shockingX = -shockingX;
            _loc2_.y = _loc2_.y + shockingY;
            shockingY = -shockingY;
         }
         life = Number(life) + 1;
         if(life % shockingFreq == 0)
         {
            _loc2_.x = _loc2_.x + shockingX * 2;
            shockingX = -shockingX;
            _loc2_.y = _loc2_.y + shockingY * 2;
            shockingY = -shockingY;
         }
         return _loc2_;
      }
      
      override protected function get propertysNeed() : Array
      {
         return ["target","speed","shockingX","shockingY","shockingFreq"];
      }
   }
}
