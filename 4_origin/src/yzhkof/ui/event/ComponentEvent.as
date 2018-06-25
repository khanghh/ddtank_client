package yzhkof.ui.event
{
   import flash.events.Event;
   
   public class ComponentEvent extends Event
   {
      
      public static const DRAW_COMPLETE:String = "DRAW_COMPLETE";
      
      public static const SIZE_UPDATE:String = "SIZE_UPDATE";
      
      public static const COMPONENT_CHANGE:String = "COMPONENT_CHANGE";
       
      
      public function ComponentEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
