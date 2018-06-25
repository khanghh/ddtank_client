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
      
      private function __childAdd(e:Event) : void
      {
         commitChage(CHILD_CHANGE);
         this.addChildEvent(e.target);
      }
      
      private function __childRemove(e:Event) : void
      {
         commitChage(CHILD_CHANGE);
         this.removeChildEvent(e.target);
      }
      
      private function addChildEvent(child:Object) : void
      {
         if(!(child is ComponentBase))
         {
            return;
         }
         var comp:ComponentBase = child as ComponentBase;
         comp.addEventListener(ComponentEvent.COMPONENT_CHANGE,this.__childUpdate);
      }
      
      private function removeChildEvent(child:Object) : void
      {
         if(!(child is ComponentBase))
         {
            return;
         }
         var comp:ComponentBase = child as ComponentBase;
         comp.removeEventListener(ComponentEvent.COMPONENT_CHANGE,this.__childUpdate);
      }
      
      private function __childUpdate(e:Event) : void
      {
      }
   }
}
