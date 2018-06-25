package morn.core.managers
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class TimerManager
   {
       
      
      private var _shape:Shape;
      
      private var _pool:Vector.<TimerHandler>;
      
      private var _handlers:Dictionary;
      
      private var _currTimer:int;
      
      private var _currFrame:int = 0;
      
      private var _count:int = 0;
      
      private var _index:uint = 0;
      
      public function TimerManager()
      {
         _shape = new Shape();
         _pool = new Vector.<TimerHandler>();
         _handlers = new Dictionary();
         _currTimer = getTimer();
         super();
         _shape.addEventListener("enterFrame",onEnterFrame);
      }
      
      private function onEnterFrame(e:Event) : void
      {
         var handler:* = null;
         var t:int = 0;
         var method:* = null;
         var args:* = null;
         _currFrame = Number(_currFrame) + 1;
         _currTimer = getTimer();
         var _loc8_:int = 0;
         var _loc7_:* = _handlers;
         for(var key in _handlers)
         {
            handler = _handlers[key];
            t = !!handler.userFrame?_currFrame:int(_currTimer);
            if(t >= handler.exeTime)
            {
               method = handler.method;
               args = handler.args;
               if(handler.repeat)
               {
                  while(t >= handler.exeTime && key in _handlers && handler.repeat)
                  {
                     handler.exeTime = handler.exeTime + handler.delay;
                     method.apply(null,args);
                  }
               }
               else
               {
                  clearTimer(key);
                  method.apply(null,args);
               }
            }
         }
      }
      
      private function create(useFrame:Boolean, repeat:Boolean, delay:int, method:Function, args:Array = null, cover:Boolean = true) : Object
      {
         var key:* = null;
         if(cover)
         {
            clearTimer(method);
            key = method;
         }
         else
         {
            _index = Number(_index) + 1;
            key = Number(_index);
         }
         if(delay < 1)
         {
            method.apply(null,args);
            return -1;
         }
         var handler:TimerHandler = _pool.length > 0?_pool.pop():new TimerHandler();
         handler.userFrame = useFrame;
         handler.repeat = repeat;
         handler.delay = delay;
         handler.method = method;
         handler.args = args;
         handler.exeTime = delay + (!!useFrame?_currFrame:int(_currTimer));
         _handlers[key] = handler;
         _count = Number(_count) + 1;
         return key;
      }
      
      public function doOnce(delay:int, method:Function, args:Array = null, cover:Boolean = true) : Object
      {
         return create(false,false,delay,method,args,cover);
      }
      
      public function doLoop(delay:int, method:Function, args:Array = null, cover:Boolean = true) : Object
      {
         return create(false,true,delay,method,args,cover);
      }
      
      public function doFrameOnce(delay:int, method:Function, args:Array = null, cover:Boolean = true) : Object
      {
         return create(true,false,delay,method,args,cover);
      }
      
      public function doFrameLoop(delay:int, method:Function, args:Array = null, cover:Boolean = true) : Object
      {
         return create(true,true,delay,method,args,cover);
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function clearTimer(method:Object) : void
      {
         var handler:TimerHandler = _handlers[method];
         if(handler != null)
         {
            delete _handlers[method];
            handler.clear();
            _pool.push(handler);
            _count = Number(_count) - 1;
         }
      }
   }
}

class TimerHandler
{
    
   
   public var delay:int;
   
   public var repeat:Boolean;
   
   public var userFrame:Boolean;
   
   public var exeTime:int;
   
   public var method:Function;
   
   public var args:Array;
   
   function TimerHandler()
   {
      super();
   }
   
   public function clear() : void
   {
      method = null;
      args = null;
   }
}
