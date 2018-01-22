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
      
      public function TimerManager(){super();}
      
      private function onEnterFrame(param1:Event) : void{}
      
      private function create(param1:Boolean, param2:Boolean, param3:int, param4:Function, param5:Array = null, param6:Boolean = true) : Object{return null;}
      
      public function doOnce(param1:int, param2:Function, param3:Array = null, param4:Boolean = true) : Object{return null;}
      
      public function doLoop(param1:int, param2:Function, param3:Array = null, param4:Boolean = true) : Object{return null;}
      
      public function doFrameOnce(param1:int, param2:Function, param3:Array = null, param4:Boolean = true) : Object{return null;}
      
      public function doFrameLoop(param1:int, param2:Function, param3:Array = null, param4:Boolean = true) : Object{return null;}
      
      public function get count() : int{return 0;}
      
      public function clearTimer(param1:Object) : void{}
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
   
   function TimerHandler(){super();}
   
   public function clear() : void{}
}
