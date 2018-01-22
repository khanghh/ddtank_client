package yzhkof.ui
{
   import flash.events.Event;
   import yzhkof.ui.event.ComponentEvent;
   
   public class ComponentContainer extends ComponentBase
   {
      
      public static const CHILD_CHANGE:String = "child_change";
       
      
      public function ComponentContainer()
      {
         super();
         addEventListener(Event.ADDED,this.__childAdd);
         addEventListener(Event.REMOVED,this.__childRemove);
      }
      
      private function __childAdd(param1:Event) : void
      {
         commitChage(CHILD_CHANGE);
         this.addChildEvent(param1.target);
      }
      
      private function __childRemove(param1:Event) : void
      {
         commitChage(CHILD_CHANGE);
         this.removeChildEvent(param1.target);
      }
      
      private function addChildEvent(param1:Object) : void
      {
         if(!(param1 is ComponentBase))
         {
            return;
         }
         var _loc2_:ComponentBase = param1 as ComponentBase;
         _loc2_.addEventListener(ComponentEvent.COMPONENT_CHANGE,this.__childUpdate);
      }
      
      private function removeChildEvent(param1:Object) : void
      {
         if(!(param1 is ComponentBase))
         {
            return;
         }
         var _loc2_:ComponentBase = param1 as ComponentBase;
         _loc2_.removeEventListener(ComponentEvent.COMPONENT_CHANGE,this.__childUpdate);
      }
      
      private function __childUpdate(param1:Event) : void
      {
      }
   }
}
