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
      
      public function WorldClock(time:Number = -1, timeScale:Number = 1)
      {
         super();
         _time = time >= 0?time:Number(getTimer() * 0.001);
         _timeScale = !!isNaN(timeScale)?1:Number(timeScale);
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
      
      public function set timeScale(value:Number) : void
      {
         if(isNaN(value) || value < 0)
         {
            value = 1;
         }
         _timeScale = value;
      }
      
      public function contains(animatable:IAnimatable) : Boolean
      {
         return _animatableList.indexOf(animatable) >= 0;
      }
      
      public function add(animatable:IAnimatable) : void
      {
         if(animatable && _animatableList.indexOf(animatable) == -1)
         {
            _animatableList.push(animatable);
         }
      }
      
      public function remove(animatable:IAnimatable) : void
      {
         var index:int = _animatableList.indexOf(animatable);
         if(index >= 0)
         {
            _animatableList[index] = null;
         }
      }
      
      public function clear() : void
      {
         _animatableList.length = 0;
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         var i:int = 0;
         var animatable:* = null;
         if(passedTime < 0)
         {
            passedTime = getTimer() * 0.001 - _time;
         }
         _time = _time + passedTime;
         passedTime = passedTime * _timeScale;
         var length:int = _animatableList.length;
         if(length == 0)
         {
            return;
         }
         var currentIndex:int = 0;
         for(i = 0; i < length; )
         {
            animatable = _animatableList[i];
            if(animatable)
            {
               if(currentIndex != i)
               {
                  _animatableList[currentIndex] = animatable;
                  _animatableList[i] = null;
               }
               animatable.advanceTime(passedTime);
               currentIndex++;
            }
            i++;
         }
         if(currentIndex != i)
         {
            length = _animatableList.length;
            while(i < length)
            {
               currentIndex++;
               i++;
               _animatableList[currentIndex] = _animatableList[i];
            }
            _animatableList.length = currentIndex;
         }
      }
   }
}
