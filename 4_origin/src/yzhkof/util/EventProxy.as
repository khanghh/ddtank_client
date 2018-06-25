package yzhkof.util
{
   import flash.events.EventDispatcher;
   
   public class EventProxy
   {
       
      
      public function EventProxy()
      {
         super();
      }
      
      public static function proxy(dispatcher:EventDispatcher, proxyDispatcher:EventDispatcher, event_type:Array, listenerParam:Array = null) : void
      {
         var i:String = null;
         if(listenerParam == null)
         {
            listenerParam = new Array();
         }
         for each(i in event_type)
         {
            if(i != null)
            {
               dispatcher.addEventListener(i,proxyDispatcher.dispatchEvent,listenerParam[0] == undefined?false:Boolean(listenerParam[0]),listenerParam[1] == undefined?0:int(listenerParam[1]),listenerParam[2] == undefined?false:Boolean(listenerParam[2]));
            }
         }
      }
      
      public static function unProxy(dispatcher:EventDispatcher, proxyDispatcher:EventDispatcher, event_type:Array) : void
      {
         var i:String = null;
         for each(i in event_type)
         {
            dispatcher.removeEventListener(i,proxyDispatcher.dispatchEvent);
         }
      }
   }
}
