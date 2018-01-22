package ddt
{
   import ddt.events.CEvent;
   
   public class CoreController
   {
       
      
      public function CoreController()
      {
         super();
      }
      
      protected final function removeEvents(param1:Array, param2:CoreManager) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            param2.removeEventListener(param1[_loc4_],eventsHandler);
            _loc4_++;
         }
      }
      
      protected final function addEvents(param1:Array, param2:CoreManager) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            param2.addEventListener(param1[_loc4_],eventsHandler);
            _loc4_++;
         }
      }
      
      protected function eventsHandler(param1:CEvent) : void
      {
      }
      
      protected final function addEventsMap(param1:Array, param2:CoreManager) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            param2.addEventListener(param1[_loc4_][0],param1[_loc4_][1]);
            _loc4_++;
         }
      }
      
      protected final function removeEventsMap(param1:Array, param2:CoreManager) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            param2.removeEventListener(param1[_loc4_][0],param1[_loc4_][1]);
            _loc4_++;
         }
      }
   }
}
