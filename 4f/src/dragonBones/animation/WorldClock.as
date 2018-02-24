package dragonBones.animation
{
   import flash.utils.getTimer;
   import starling.animation.IAnimatable;
   
   public final class WorldClock implements IAnimatable
   {
      
      public static var clock:WorldClock = new WorldClock();
       
      
      private var _animatableList:Vector.<IAnimatable>;
      
      private var _time:Number;
      
      private var _timeScale:Number;
      
      public function WorldClock(param1:Number = -1, param2:Number = 1){super();}
      
      public function get time() : Number{return 0;}
      
      public function get timeScale() : Number{return 0;}
      
      public function set timeScale(param1:Number) : void{}
      
      public function contains(param1:IAnimatable) : Boolean{return false;}
      
      public function add(param1:IAnimatable) : void{}
      
      public function remove(param1:IAnimatable) : void{}
      
      public function clear() : void{}
      
      public function advanceTime(param1:Number) : void{}
   }
}
