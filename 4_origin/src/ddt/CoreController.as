package ddt
{
   import ddt.events.CEvent;
   
   public class CoreController
   {
       
      
      public function CoreController()
      {
         super();
      }
      
      protected final function removeEvents($evtList:Array, $manager:CoreManager) : void
      {
         var i:int = 0;
         var len:int = $evtList.length;
         for(i = 0; i < len; )
         {
            $manager.removeEventListener($evtList[i],eventsHandler);
            i++;
         }
      }
      
      protected final function addEvents($evtList:Array, $manager:CoreManager) : void
      {
         var i:int = 0;
         var len:int = $evtList.length;
         for(i = 0; i < len; )
         {
            $manager.addEventListener($evtList[i],eventsHandler);
            i++;
         }
      }
      
      protected function eventsHandler(e:CEvent) : void
      {
      }
      
      protected final function addEventsMap($evtAndHandlerList:Array, $manager:CoreManager) : void
      {
         var i:int = 0;
         var len:int = $evtAndHandlerList.length;
         for(i = 0; i < len; )
         {
            $manager.addEventListener($evtAndHandlerList[i][0],$evtAndHandlerList[i][1]);
            i++;
         }
      }
      
      protected final function removeEventsMap($evtAndHandlerList:Array, $manager:CoreManager) : void
      {
         var i:int = 0;
         var len:int = $evtAndHandlerList.length;
         for(i = 0; i < len; )
         {
            $manager.removeEventListener($evtAndHandlerList[i][0],$evtAndHandlerList[i][1]);
            i++;
         }
      }
   }
}
