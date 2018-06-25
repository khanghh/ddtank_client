package yzhkof.util{   import flash.events.EventDispatcher;      public class EventProxy   {                   public function EventProxy() { super(); }
            public static function proxy(dispatcher:EventDispatcher, proxyDispatcher:EventDispatcher, event_type:Array, listenerParam:Array = null) : void { }
            public static function unProxy(dispatcher:EventDispatcher, proxyDispatcher:EventDispatcher, event_type:Array) : void { }
   }}