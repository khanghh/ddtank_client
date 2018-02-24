package yzhkof.ui
{
   import flash.events.Event;
   import yzhkof.ui.event.ComponentEvent;
   
   public class ComponentContainer extends ComponentBase
   {
      
      public static const CHILD_CHANGE:String = "child_change";
       
      
      public function ComponentContainer(){super();}
      
      private function __childAdd(param1:Event) : void{}
      
      private function __childRemove(param1:Event) : void{}
      
      private function addChildEvent(param1:Object) : void{}
      
      private function removeChildEvent(param1:Object) : void{}
      
      private function __childUpdate(param1:Event) : void{}
   }
}
