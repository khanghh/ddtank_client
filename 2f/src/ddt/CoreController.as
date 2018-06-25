package ddt{   import ddt.events.CEvent;      public class CoreController   {                   public function CoreController() { super(); }
            protected final function removeEvents($evtList:Array, $manager:CoreManager) : void { }
            protected final function addEvents($evtList:Array, $manager:CoreManager) : void { }
            protected function eventsHandler(e:CEvent) : void { }
            protected final function addEventsMap($evtAndHandlerList:Array, $manager:CoreManager) : void { }
            protected final function removeEventsMap($evtAndHandlerList:Array, $manager:CoreManager) : void { }
   }}