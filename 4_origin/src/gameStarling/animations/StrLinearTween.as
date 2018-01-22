package gameStarling.animations
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   
   public class StrLinearTween extends BaseStageTween
   {
       
      
      private var _speed:int = 1;
      
      private var _duration:int = 0;
      
      public function StrLinearTween(param1:TweenObject = null)
      {
         super(param1);
      }
      
      override public function get type() : String
      {
         return "StrLinearTween";
      }
      
      override public function update(param1:DisplayObject) : Point
      {
         if(!_prepared)
         {
            return null;
         }
         var _loc2_:Point = new Point(param1.x,param1.y);
         var _loc3_:Point = new Point(target.x - param1.x,target.y - param1.y);
         if(_loc3_.length >= speed)
         {
            _loc3_.normalize(speed);
            _loc2_.x = _loc2_.x + _loc3_.x;
            _loc2_.y = _loc2_.y + _loc3_.y;
         }
         else
         {
            _loc2_ = target;
         }
         return _loc2_;
      }
      
      public function set speed(param1:int) : void
      {
         _speed = param1;
      }
      
      public function get speed() : int
      {
         return _speed;
      }
      
      public function set duration(param1:int) : void
      {
         _duration = param1;
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
