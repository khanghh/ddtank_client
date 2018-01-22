package yzhkof.util
{
   import flash.events.EventDispatcher;
   
   public class EventProxy
   {
       
      
      public function EventProxy()
      {
         super();
      }
      
      public static function proxy(param1:EventDispatcher, param2:EventDispatcher, param3:Array, param4:Array = null) : void
      {
         var _loc5_:String = null;
         if(param4 == null)
         {
            param4 = new Array();
         }
         for each(_loc5_ in param3)
         {
            if(_loc5_ != null)
            {
               param1.addEventListener(_loc5_,param2.dispatchEvent,param4[0] == undefined?false:Boolean(param4[0]),param4[1] == undefined?0:int(param4[1]),param4[2] == undefined?false:Boolean(param4[2]));
            }
         }
      }
      
      public static function unProxy(param1:EventDispatcher, param2:EventDispatcher, param3:Array) : void
      {
         var _loc4_:String = null;
         for each(_loc4_ in param3)
         {
            param1.removeEventListener(_loc4_,param2.dispatchEvent);
         }
      }
   }
}
