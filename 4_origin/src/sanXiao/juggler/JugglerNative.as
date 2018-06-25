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
      
      public function JugglerNative(frameRate:int)
      {
         super();
         if(_inited)
         {
            throw "More than one instance of class JugglerNative is not allowed.";
         }
         _inited = true;
         _movieClipBitmap = new Vector.<MovieClipShape>();
         _duration = 1000 / frameRate;
         trace("duration of JugglerNative is (ms)" + _duration);
         _timer = new Timer(_duration);
      }
      
      public function set duration(frameRate:int) : void
      {
         _duration = 1000 / frameRate;
         _timer.delay = _duration;
         _timer.reset();
         _timer.start();
      }
      
      public function add(movieClipBitmap:MovieClipShape) : void
      {
         _movieClipBitmap.push(movieClipBitmap);
      }
      
      public function remove(bitmapClip:MovieClipShape) : void
      {
         var i:int = 0;
         var len:int = _movieClipBitmap.length;
         for(i = 0; i < len; )
         {
            if(_movieClipBitmap[i] == bitmapClip)
            {
               _movieClipBitmap.splice(i,1);
               break;
            }
            i++;
         }
      }
      
      public function removeAll() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _movieClipBitmap;
         for each(var bit in _movieClipBitmap)
         {
            bit.parent && bit.parent.removeChild(bit);
            bit.reset();
            bit.dispose();
         }
      }
      
      public function hasAdded(mcs:MovieClipShape) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = _movieClipBitmap;
         for each(var bit in _movieClipBitmap)
         {
            if(mcs === bit)
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
      
      protected function onTimer(event:TimerEvent) : void
      {
         var i:int = 0;
         var l:int = _movieClipBitmap.length;
         for(i = 0; i < l; )
         {
            i < _movieClipBitmap.length && _movieClipBitmap[i].advance(_duration);
            i++;
         }
      }
   }
}
