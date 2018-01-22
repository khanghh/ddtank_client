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
         this._shape = new Shape();
         this._pool = new Vector.<TimerHandler>();
         this._handlers = new Dictionary();
         this._currTimer = getTimer();
         super();
         this._shape.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:TimerHandler = null;
         var _loc4_:int = 0;
         var _loc5_:Function = null;
         var _loc6_:Array = null;
         this._currFrame++;
         this._currTimer = getTimer();
         for(_loc2_ in this._handlers)
         {
            _loc3_ = this._handlers[_loc2_];
            _loc4_ = !!_loc3_.userFrame?int(this._currFrame):int(this._currTimer);
            if(_loc4_ >= _loc3_.exeTime)
            {
               _loc5_ = _loc3_.method;
               _loc6_ = _loc3_.args;
               if(_loc3_.repeat)
               {
                  while(_loc4_ >= _loc3_.exeTime && _loc2_ in this._handlers && _loc3_.repeat)
                  {
                     _loc3_.exeTime = _loc3_.exeTime + _loc3_.delay;
                     _loc5_.apply(null,_loc6_);
                  }
               }
               else
               {
                  this.clearTimer(_loc2_);
                  _loc5_.apply(null,_loc6_);
               }
            }
         }
      }
      
      private function create(param1:Boolean, param2:Boolean, param3:int, param4:Function, param5:Array = null, param6:Boolean = true) : Object
      {
         var _loc7_:Object = null;
         if(param6)
         {
            this.clearTimer(param4);
            _loc7_ = param4;
         }
         else
         {
            _loc7_ = this._index++;
         }
         if(param3 < 1)
         {
            param4.apply(null,param5);
            return -1;
         }
         var _loc8_:TimerHandler = this._pool.length > 0?this._pool.pop():new TimerHandler();
         _loc8_.userFrame = param1;
         _loc8_.repeat = param2;
         _loc8_.delay = param3;
         _loc8_.method = param4;
         _loc8_.args = param5;
         _loc8_.exeTime = param3 + (!!param1?this._currFrame:this._currTimer);
         this._handlers[_loc7_] = _loc8_;
         this._count++;
         return _loc7_;
      }
      
      public function doOnce(param1:int, param2:Function, param3:Array = null, param4:Boolean = true) : Object
      {
         return this.create(false,false,param1,param2,param3,param4);
      }
      
      public function doLoop(param1:int, param2:Function, param3:Array = null, param4:Boolean = true) : Object
      {
         return this.create(false,true,param1,param2,param3,param4);
      }
      
      public function doFrameOnce(param1:int, param2:Function, param3:Array = null, param4:Boolean = true) : Object
      {
         return this.create(true,false,param1,param2,param3,param4);
      }
      
      public function doFrameLoop(param1:int, param2:Function, param3:Array = null, param4:Boolean = true) : Object
      {
         return this.create(true,true,param1,param2,param3,param4);
      }
      
      public function get count() : int
      {
         return this._count;
      }
      
      public function clearTimer(param1:Object) : void
      {
         var _loc2_:TimerHandler = this._handlers[param1];
         if(_loc2_ != null)
         {
            delete this._handlers[param1];
            _loc2_.clear();
            this._pool.push(_loc2_);
            this._count--;
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
      this.method = null;
      this.args = null;
   }
}
