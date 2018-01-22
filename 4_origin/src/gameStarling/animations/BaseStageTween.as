package gameStarling.animations
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   
   public class BaseStageTween implements IStageTween
   {
       
      
      protected var _target:Point;
      
      protected var _prepared:Boolean = false;
      
      protected var _isFinished:Boolean;
      
      public function BaseStageTween(param1:TweenObject = null)
      {
         super();
         _isFinished = false;
         if(param1)
         {
            initData(param1);
         }
      }
      
      public function get type() : String
      {
         return "BaseStageTween";
      }
      
      public function initData(param1:TweenObject) : void
      {
         if(!param1)
         {
            return;
         }
         copyPropertyFromData(param1);
         _prepared = true;
      }
      
      public function update(param1:DisplayObject) : Point
      {
         return null;
      }
      
      public function set target(param1:Point) : void
      {
         _target = param1;
         _prepared = true;
      }
      
      public function get target() : Point
      {
         return _target;
      }
      
      public function copyPropertyFromData(param1:TweenObject) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = propertysNeed;
         for each(var _loc2_ in propertysNeed)
         {
            if(param1[_loc2_])
            {
               this[_loc2_] = param1[_loc2_];
            }
         }
      }
      
      protected function get propertysNeed() : Array
      {
         return ["target"];
      }
      
      public function get isFinished() : Boolean
      {
         return _isFinished;
      }
   }
}
