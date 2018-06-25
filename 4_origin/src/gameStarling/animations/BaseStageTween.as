package gameStarling.animations
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   
   public class BaseStageTween implements IStageTween
   {
       
      
      protected var _target:Point;
      
      protected var _prepared:Boolean = false;
      
      protected var _isFinished:Boolean;
      
      public function BaseStageTween(data:TweenObject = null)
      {
         super();
         _isFinished = false;
         if(data)
         {
            initData(data);
         }
      }
      
      public function get type() : String
      {
         return "BaseStageTween";
      }
      
      public function initData(data:TweenObject) : void
      {
         if(!data)
         {
            return;
         }
         copyPropertyFromData(data);
         _prepared = true;
      }
      
      public function update(movie:DisplayObject) : Point
      {
         return null;
      }
      
      public function set target(value:Point) : void
      {
         _target = value;
         _prepared = true;
      }
      
      public function get target() : Point
      {
         return _target;
      }
      
      public function copyPropertyFromData(data:TweenObject) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = propertysNeed;
         for each(var prop in propertysNeed)
         {
            if(data[prop])
            {
               this[prop] = data[prop];
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
