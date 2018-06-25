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
      
      public function TweenObject(data:Object = null)
      {
         super();
         var _loc4_:int = 0;
         var _loc3_:* = data;
         for(var prop in data)
         {
            this[prop] = data[prop];
         }
      }
      
      public function set x(value:Number) : void
      {
         _x = value;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function set y(value:Number) : void
      {
         _y = value;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set target(value:Point) : void
      {
         _x = value.x;
         _y = value.y;
      }
      
      public function get target() : Point
      {
         return new Point(_x,_y);
      }
      
      public function set strategy(value:String) : void
      {
         _strategy = value;
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
