package gameStarling.animations
{
   import flash.geom.Point;
   
   public dynamic class TweenObject
   {
       
      
      public var speed:uint;
      
      public var duration:uint;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _strategy:String;
      
      public function TweenObject(param1:Object = null)
      {
         super();
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for(var _loc2_ in param1)
         {
            this[_loc2_] = param1[_loc2_];
         }
      }
      
      public function set x(param1:Number) : void
      {
         _x = param1;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function set y(param1:Number) : void
      {
         _y = param1;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set target(param1:Point) : void
      {
         _x = param1.x;
         _y = param1.y;
      }
      
      public function get target() : Point
      {
         return new Point(_x,_y);
      }
      
      public function set strategy(param1:String) : void
      {
         _strategy = param1;
      }
      
      public function get strategy() : String
      {
         if(_strategy)
         {
            return _strategy;
         }
         return "default";
      }
   }
}
