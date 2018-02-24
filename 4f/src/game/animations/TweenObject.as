package game.animations
{
   import flash.geom.Point;
   
   public dynamic class TweenObject
   {
       
      
      public var speed:uint;
      
      public var duration:uint;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _strategy:String;
      
      public function TweenObject(param1:Object = null){super();}
      
      public function set x(param1:Number) : void{}
      
      public function get x() : Number{return 0;}
      
      public function set y(param1:Number) : void{}
      
      public function get y() : Number{return 0;}
      
      public function set target(param1:Point) : void{}
      
      public function get target() : Point{return null;}
      
      public function set strategy(param1:String) : void{}
      
      public function get strategy() : String{return null;}
   }
}
