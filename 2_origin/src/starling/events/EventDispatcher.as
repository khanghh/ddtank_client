package starling.events
{
   import flash.utils.Dictionary;
   import starling.display.DisplayObject;
   
   public class EventDispatcher
   {
      
      private static var sBubbleChains:Array = [];
       
      
      private var mEventListeners:Dictionary;
      
      public function EventDispatcher()
      {
         super();
      }
      
      public function addEventListener(type:String, listener:Function) : void
      {
         if(mEventListeners == null)
         {
            mEventListeners = new Dictionary();
         }
         var listeners:Vector.<Function> = mEventListeners[type] as Vector.<Function>;
         if(listeners == null)
         {
            mEventListeners[type] = new <Function>[listener];
         }
         else if(listeners.indexOf(listener) == -1)
         {
            listeners[listeners.length] = listener;
         }
      }
      
      public function removeEventListener(type:String, listener:Function) : void
      {
         var listeners:* = undefined;
         var numListeners:int = 0;
         var index:int = 0;
         var restListeners:* = undefined;
         var i:int = 0;
         var otherListener:* = null;
         if(mEventListeners)
         {
            listeners = mEventListeners[type] as Vector.<Function>;
            numListeners = !!listeners?listeners.length:0;
            if(numListeners > 0)
            {
               index = 0;
               restListeners = new Vector.<Function>(numListeners - 1);
               for(i = 0; i < numListeners; )
               {
                  otherListener = listeners[i];
                  if(otherListener != listener)
                  {
                     index++;
                     restListeners[int(index)] = otherListener;
                  }
                  i++;
               }
               mEventListeners[type] = restListeners;
            }
         }
      }
      
      public function removeEventListeners(type:String = null) : void
      {
         if(type && mEventListeners)
         {
            delete mEventListeners[type];
         }
         else
         {
            mEventListeners = null;
         }
      }
      
      public function dispatchEvent(event:Event) : void
      {
         var bubbles:Boolean = event.bubbles;
         if(!bubbles && (mEventListeners == null || !(event.type in mEventListeners)))
         {
            return;
         }
         var previousTarget:EventDispatcher = event.target;
         event.setTarget(this);
         if(bubbles && this is DisplayObject)
         {
            bubbleEvent(event);
         }
         else
         {
            invokeEvent(event);
         }
         if(previousTarget)
         {
            event.setTarget(previousTarget);
         }
      }
      
      function invokeEvent(event:Event) : Boolean
      {
         var i:int = 0;
         var listener:* = null;
         var numArgs:int = 0;
         var listeners:Vector.<Function> = !!mEventListeners?mEventListeners[event.type] as Vector.<Function>:null;
         var numListeners:int = listeners == null?0:listeners.length;
         if(numListeners)
         {
            event.setCurrentTarget(this);
            for(i = 0; i < numListeners; )
            {
               listener = listeners[i] as Function;
               numArgs = listener.length;
               if(numArgs == 0)
               {
                  listener();
               }
               else if(numArgs == 1)
               {
                  listener(event);
               }
               else
               {
                  listener(event,event.data);
               }
               if(event.stopsImmediatePropagation)
               {
                  return true;
               }
               i++;
            }
            return event.stopsPropagation;
         }
         return false;
      }
      
      function bubbleEvent(event:Event) : void
      {
         var chain:* = undefined;
         var i:int = 0;
         var stopPropagation:Boolean = false;
         var element:DisplayObject = this as DisplayObject;
         var length:int = 1;
         if(sBubbleChains.length > 0)
         {
            chain = sBubbleChains.pop();
            chain[0] = element;
         }
         else
         {
            chain = new <EventDispatcher>[element];
         }
         while(true)
         {
            element = element.parent;
            if(element.parent == null)
            {
               break;
            }
            length++;
            chain[int(length)] = element;
         }
         for(i = 0; i < length; )
         {
            stopPropagation = chain[i].invokeEvent(event);
            if(!stopPropagation)
            {
               i++;
               continue;
            }
            break;
         }
         chain.length = 0;
         sBubbleChains[sBubbleChains.length] = chain;
      }
      
      public function dispatchEventWith(type:String, bubbles:Boolean = false, data:Object = null) : void
      {
         var event:* = null;
         if(bubbles || hasEventListener(type))
         {
            event = Event.fromPool(type,bubbles,data);
            dispatchEvent(event);
            Event.toPool(event);
         }
      }
      
      public function hasEventListener(type:String) : Boolean
      {
         var listeners:Vector.<Function> = !!mEventListeners?mEventListeners[type]:null;
         return !!listeners?listeners.length != 0:false;
      }
   }
}
