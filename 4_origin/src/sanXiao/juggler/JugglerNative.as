package sanXiao.juggler
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class JugglerNative
   {
      
      private static var _inited:Boolean = false;
       
      
      private var _movieClipBitmap:Vector.<MovieClipShape>;
      
      private var _timer:Timer;
      
      private var _duration:Number;
      
      public function JugglerNative(param1:int)
      {
         super();
         if(_inited)
         {
            throw "More than one instance of class JugglerNative is not allowed.";
         }
         _inited = true;
         _movieClipBitmap = new Vector.<MovieClipShape>();
         _duration = 1000 / param1;
         trace("duration of JugglerNative is (ms)" + _duration);
         _timer = new Timer(_duration);
      }
      
      public function set duration(param1:int) : void
      {
         _duration = 1000 / param1;
         _timer.delay = _duration;
         _timer.reset();
         _timer.start();
      }
      
      public function add(param1:MovieClipShape) : void
      {
         _movieClipBitmap.push(param1);
      }
      
      public function remove(param1:MovieClipShape) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _movieClipBitmap.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_movieClipBitmap[_loc3_] == param1)
            {
               _movieClipBitmap.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
      }
      
      public function removeAll() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _movieClipBitmap;
         for each(var _loc1_ in _movieClipBitmap)
         {
            _loc1_.parent && _loc1_.parent.removeChild(_loc1_);
            _loc1_.reset();
            _loc1_.dispose();
         }
      }
      
      public function hasAdded(param1:MovieClipShape) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = _movieClipBitmap;
         for each(var _loc2_ in _movieClipBitmap)
         {
            if(param1 === _loc2_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            stop();
         }
         if(_movieClipBitmap)
         {
            _movieClipBitmap.length = 0;
            _movieClipBitmap = null;
         }
      }
      
      public function stop() : void
      {
         _timer.stop();
         _timer.removeEventListener("timer",onTimer);
         _timer = null;
      }
      
      public function start() : void
      {
         if(_timer == null)
         {
            _timer = new Timer(_duration);
         }
         _timer.addEventListener("timer",onTimer);
         _timer.start();
      }
      
      protected function onTimer(param1:TimerEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _movieClipBitmap.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc3_ < _movieClipBitmap.length && _movieClipBitmap[_loc3_].advance(_duration);
            _loc3_++;
         }
      }
   }
}
