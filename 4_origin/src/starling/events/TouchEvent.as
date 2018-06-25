package starling.events
{
   import starling.display.DisplayObject;
   
   public class TouchEvent extends Event
   {
      
      public static const TOUCH:String = "touch";
      
      private static var sTouches:Vector.<Touch> = new Vector.<Touch>(0);
       
      
      private var mShiftKey:Boolean;
      
      private var mCtrlKey:Boolean;
      
      private var mTimestamp:Number;
      
      private var mVisitedObjects:Vector.<EventDispatcher>;
      
      public function TouchEvent(type:String, touches:Vector.<Touch>, shiftKey:Boolean = false, ctrlKey:Boolean = false, bubbles:Boolean = true)
      {
         var i:int = 0;
         super(type,bubbles,touches);
         mShiftKey = shiftKey;
         mCtrlKey = ctrlKey;
         mTimestamp = -1;
         mVisitedObjects = new Vector.<EventDispatcher>(0);
         var numTouches:int = touches.length;
         for(i = 0; i < numTouches; )
         {
            if(touches[i].timestamp > mTimestamp)
            {
               mTimestamp = touches[i].timestamp;
            }
            i++;
         }
      }
      
      public function getTouches(target:DisplayObject, phase:String = null, result:Vector.<Touch> = null) : Vector.<Touch>
      {
         var i:int = 0;
         var touch:* = null;
         var correctTarget:Boolean = false;
         var correctPhase:Boolean = false;
         if(result == null)
         {
            result = new Vector.<Touch>(0);
         }
         var allTouches:Vector.<Touch> = data as Vector.<Touch>;
         var numTouches:int = allTouches.length;
         for(i = 0; i < numTouches; )
         {
            touch = allTouches[i];
            correctTarget = touch.isTouching(target);
            correctPhase = phase == null || phase == touch.phase;
            if(correctTarget && correctPhase)
            {
               result[result.length] = touch;
            }
            i++;
         }
         return result;
      }
      
      public function getTouch(target:DisplayObject, phase:String = null, id:int = -1) : Touch
      {
         var touch:* = null;
         var i:int = 0;
         getTouches(target,phase,sTouches);
         var numTouches:int = sTouches.length;
         if(numTouches > 0)
         {
            touch = null;
            if(id < 0)
            {
               touch = sTouches[0];
            }
            else
            {
               i = 0;
               while(i < numTouches)
               {
                  if(sTouches[i].id == id)
                  {
                     touch = sTouches[i];
                     break;
                  }
                  i++;
               }
            }
            sTouches.length = 0;
            return touch;
         }
         return null;
      }
      
      public function interactsWith(target:DisplayObject) : Boolean
      {
         var i:int = 0;
         var result:Boolean = false;
         getTouches(target,null,sTouches);
         for(i = sTouches.length - 1; i >= 0; )
         {
            if(sTouches[i].phase != "ended")
            {
               result = true;
               break;
            }
            i--;
         }
         sTouches.length = 0;
         return result;
      }
      
      function dispatch(chain:Vector.<EventDispatcher>) : void
      {
         var chainLength:int = 0;
         var previousTarget:* = null;
         var i:int = 0;
         var chainElement:* = null;
         var stopPropagation:Boolean = false;
         if(chain && chain.length)
         {
            chainLength = !!bubbles?chain.length:1;
            previousTarget = target;
            setTarget(chain[0] as EventDispatcher);
            for(i = 0; i < chainLength; )
            {
               chainElement = chain[i] as EventDispatcher;
               if(mVisitedObjects.indexOf(chainElement) == -1)
               {
                  stopPropagation = chainElement.invokeEvent(this);
                  mVisitedObjects[mVisitedObjects.length] = chainElement;
                  if(stopPropagation)
                  {
                     break;
                  }
               }
               i++;
            }
            setTarget(previousTarget);
         }
      }
      
      public function get timestamp() : Number
      {
         return mTimestamp;
      }
      
      public function get touches() : Vector.<Touch>
      {
         return (data as Vector.<Touch>).concat();
      }
      
      public function get shiftKey() : Boolean
      {
         return mShiftKey;
      }
      
      public function get ctrlKey() : Boolean
      {
         return mCtrlKey;
      }
   }
}
