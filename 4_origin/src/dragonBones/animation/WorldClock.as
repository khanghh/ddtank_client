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
      
      public function WorldClock(param1:Number = -1, param2:Number = 1)
      {
         super();
         _time = param1 >= 0?param1:Number(getTimer() * 0.001);
         _timeScale = !!isNaN(param2)?1:Number(param2);
         _animatableList = new Vector.<IAnimatable>();
      }
      
      public function get time() : Number
      {
         return _time;
      }
      
      public function get timeScale() : Number
      {
         return _timeScale;
      }
      
      public function set timeScale(param1:Number) : void
      {
         if(isNaN(param1) || param1 < 0)
         {
            param1 = 1;
         }
         _timeScale = param1;
      }
      
      public function contains(param1:IAnimatable) : Boolean
      {
         return _animatableList.indexOf(param1) >= 0;
      }
      
      public function add(param1:IAnimatable) : void
      {
         if(param1 && _animatableList.indexOf(param1) == -1)
         {
            _animatableList.push(param1);
         }
      }
      
      public function remove(param1:IAnimatable) : void
      {
         var _loc2_:int = _animatableList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _animatableList[_loc2_] = null;
         }
      }
      
      public function clear() : void
      {
         _animatableList.length = 0;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         if(param1 < 0)
         {
            param1 = getTimer() * 0.001 - _time;
         }
         _time = _time + param1;
         param1 = param1 * _timeScale;
         var _loc4_:int = _animatableList.length;
         if(_loc4_ == 0)
         {
            return;
         }
         var _loc2_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _animatableList[_loc5_];
            if(_loc3_)
            {
               if(_loc2_ != _loc5_)
               {
                  _animatableList[_loc2_] = _loc3_;
                  _animatableList[_loc5_] = null;
               }
               _loc3_.advanceTime(param1);
               _loc2_++;
            }
            _loc5_++;
         }
         if(_loc2_ != _loc5_)
         {
            _loc4_ = _animatableList.length;
            while(_loc5_ < _loc4_)
            {
               _loc2_++;
               _loc5_++;
               _animatableList[_loc2_] = _animatableList[_loc5_];
            }
            _animatableList.length = _loc2_;
         }
      }
   }
}
