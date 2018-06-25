package starling.animation
{
   import starling.events.Event;
   import starling.events.EventDispatcher;
   
   public class Juggler implements IAnimatable
   {
       
      
      private var mObjects:Vector.<IAnimatable>;
      
      private var mElapsedTime:Number;
      
      public function Juggler()
      {
         super();
         mElapsedTime = 0;
         mObjects = new Vector.<IAnimatable>(0);
      }
      
      public function add(object:IAnimatable) : void
      {
         var dispatcher:* = null;
         if(object && mObjects.indexOf(object) == -1)
         {
            mObjects[mObjects.length] = object;
            dispatcher = object as EventDispatcher;
            if(dispatcher)
            {
               dispatcher.addEventListener("removeFromJuggler",onRemove);
            }
         }
      }
      
      public function contains(object:IAnimatable) : Boolean
      {
         return mObjects.indexOf(object) != -1;
      }
      
      public function remove(object:IAnimatable) : void
      {
         if(object == null)
         {
            return;
         }
         var dispatcher:EventDispatcher = object as EventDispatcher;
         if(dispatcher)
         {
            dispatcher.removeEventListener("removeFromJuggler",onRemove);
         }
         var index:int = mObjects.indexOf(object);
         if(index != -1)
         {
            mObjects[index] = null;
         }
      }
      
      public function removeTweens(target:Object) : void
      {
         var i:int = 0;
         var tween:* = null;
         if(target == null)
         {
            return;
         }
         for(i = mObjects.length - 1; i >= 0; )
         {
            tween = mObjects[i] as Tween;
            if(tween && tween.target == target)
            {
               tween.removeEventListener("removeFromJuggler",onRemove);
               mObjects[i] = null;
            }
            i--;
         }
      }
      
      public function containsTweens(target:Object) : Boolean
      {
         var i:int = 0;
         var tween:* = null;
         if(target == null)
         {
            return false;
         }
         for(i = mObjects.length - 1; i >= 0; )
         {
            tween = mObjects[i] as Tween;
            if(tween && tween.target == target)
            {
               return true;
            }
            i--;
         }
         return false;
      }
      
      public function purge() : void
      {
         var i:int = 0;
         var dispatcher:* = null;
         for(i = mObjects.length - 1; i >= 0; )
         {
            dispatcher = mObjects[i] as EventDispatcher;
            if(dispatcher)
            {
               dispatcher.removeEventListener("removeFromJuggler",onRemove);
            }
            mObjects[i] = null;
            i--;
         }
      }
      
      public function delayCall(call:Function, delay:Number, ... args) : IAnimatable
      {
         if(call == null)
         {
            return null;
         }
         var delayedCall:DelayedCall = DelayedCall.fromPool(call,delay,args);
         delayedCall.addEventListener("removeFromJuggler",onPooledDelayedCallComplete);
         add(delayedCall);
         return delayedCall;
      }
      
      public function repeatCall(call:Function, interval:Number, repeatCount:int = 0, ... args) : IAnimatable
      {
         if(call == null)
         {
            return null;
         }
         var delayedCall:DelayedCall = DelayedCall.fromPool(call,interval,args);
         delayedCall.repeatCount = repeatCount;
         delayedCall.addEventListener("removeFromJuggler",onPooledDelayedCallComplete);
         add(delayedCall);
         return delayedCall;
      }
      
      private function onPooledDelayedCallComplete(event:Event) : void
      {
         DelayedCall.toPool(event.target as DelayedCall);
      }
      
      public function tween(target:Object, time:Number, properties:Object) : IAnimatable
      {
         var value:* = null;
         if(target == null)
         {
            throw new ArgumentError("target must not be null");
         }
         var tween:Tween = Tween.fromPool(target,time);
         var _loc8_:int = 0;
         var _loc7_:* = properties;
         for(var property in properties)
         {
            value = properties[property];
            if(tween.hasOwnProperty(property))
            {
               tween[property] = value;
               continue;
            }
            if(target.hasOwnProperty(Tween.getPropertyName(property)))
            {
               tween.animate(property,value as Number);
               continue;
            }
            throw new ArgumentError("Invalid property: " + property);
         }
         tween.addEventListener("removeFromJuggler",onPooledTweenComplete);
         add(tween);
         return tween;
      }
      
      private function onPooledTweenComplete(event:Event) : void
      {
         Tween.toPool(event.target as Tween);
      }
      
      public function advanceTime(time:Number) : void
      {
         var i:int = 0;
         var object:* = null;
         var numObjects:int = mObjects.length;
         var currentIndex:int = 0;
         mElapsedTime = mElapsedTime + time;
         if(numObjects == 0)
         {
            return;
         }
         i = 0;
         while(i < numObjects)
         {
            object = mObjects[i];
            if(object)
            {
               if(currentIndex != i)
               {
                  mObjects[currentIndex] = object;
                  mObjects[i] = null;
               }
               object.advanceTime(time);
               currentIndex++;
            }
            i++;
         }
         if(currentIndex != i)
         {
            numObjects = mObjects.length;
            while(i < numObjects)
            {
               currentIndex++;
               i++;
               mObjects[int(currentIndex)] = mObjects[int(i)];
            }
            mObjects.length = currentIndex;
         }
      }
      
      private function onRemove(event:Event) : void
      {
         remove(event.target as IAnimatable);
         var tween:Tween = event.target as Tween;
         if(tween && tween.isComplete)
         {
            add(tween.nextTween);
         }
      }
      
      public function get elapsedTime() : Number
      {
         return mElapsedTime;
      }
      
      protected function get objects() : Vector.<IAnimatable>
      {
         return mObjects;
      }
   }
}
