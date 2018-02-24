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
      
      public function JugglerNative(param1:int){super();}
      
      public function set duration(param1:int) : void{}
      
      public function add(param1:MovieClipShape) : void{}
      
      public function remove(param1:MovieClipShape) : void{}
      
      public function removeAll() : void{}
      
      public function hasAdded(param1:MovieClipShape) : Boolean{return false;}
      
      public function dispose() : void{}
      
      public function stop() : void{}
      
      public function start() : void{}
      
      protected function onTimer(param1:TimerEvent) : void{}
   }
}
