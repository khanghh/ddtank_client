package dragonBones.animation{   import flash.utils.getTimer;   import starling.animation.IAnimatable;      public final class WorldClock implements IAnimatable   {            public static var clock:WorldClock = new WorldClock();                   private var _animatableList:Vector.<IAnimatable>;            private var _time:Number;            private var _timeScale:Number;            public function WorldClock(time:Number = -1, timeScale:Number = 1) { super(); }
            public function get time() : Number { return 0; }
            public function get timeScale() : Number { return 0; }
            public function set timeScale(value:Number) : void { }
            public function contains(animatable:IAnimatable) : Boolean { return false; }
            public function add(animatable:IAnimatable) : void { }
            public function remove(animatable:IAnimatable) : void { }
            public function clear() : void { }
            public function advanceTime(passedTime:Number) : void { }
   }}